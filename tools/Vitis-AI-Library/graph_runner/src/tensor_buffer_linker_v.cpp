/*
 * Copyright 2019 Xilinx Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#include "./tensor_buffer_linker_v.hpp"

#include <glog/logging.h>

#include <map>
#include <memory>
#include <sstream>
#include <vart/batch_tensor_buffer_view.hpp>

#include "./tensor_buffer_shared.hpp"
#include "vitis/ai/collection_helper.hpp"
#include "vitis/ai/env_config.hpp"
DEF_ENV_PARAM(DEBUG_GRAPH_RUNNER, "0");
TensorBufferLinkerHostVirt::TensorBufferLinkerHostVirt(
    std::unique_ptr<vart::TensorBuffer>* master)
    : TensorBufferLinker{master} {}

TensorBufferLinkerHostVirt::~TensorBufferLinkerHostVirt() {}

void TensorBufferLinkerHostVirt::finalize() {
  static constexpr int HOST_PHY = 0;   // select one of them and keep others
  static constexpr int HOST_VIRT = 1;  // remove
  static constexpr int DEVICE = 2;     // keep

  //---------------------
  auto kind = [](std::unique_ptr<vart::TensorBuffer>* s) {
    auto ret = DEVICE;
    if ((*s)->get_location() == vart::TensorBuffer::location_t::HOST_PHY) {
      ret = HOST_PHY;
    } else if ((*s)->get_location() ==
               vart::TensorBuffer::location_t::HOST_VIRT) {
      ret = HOST_VIRT;
    } else {
      ret = DEVICE;
    }
    return ret;
  };
  //---------------------
  // -- build the map ---
  std::map<int, std::vector<std::unique_ptr<vart::TensorBuffer>*>> orders;
  for (auto s : slaves_) {
    orders[kind(s)].push_back(s);
  }
  // -- build `replacement_`
  CHECK(!orders.empty()) << "orders.size=" << orders.size();
  auto top = orders.begin();
  CHECK(!top->second.empty());
  replacement_ = top->second.front();
  // `replacement` is destroyed and transfer ownership to `real`
  auto real = std::shared_ptr<vart::TensorBuffer>(std::move(*replacement_));
  // `replacement` is restored and could be potentially shared by others.
  *replacement_ =
      std::make_unique<vart::TensorBufferShared>(real, real->get_tensor());
  auto decide = [this, kind](std::unique_ptr<vart::TensorBuffer>* s) {
    int ret = REPLACE;
    if (s == replacement_) {
      ret = THE_SELECTED;
    } else {
      switch (kind(s)) {
        case HOST_PHY:
        case DEVICE:
          ret = KEEP;
          break;
        case HOST_VIRT:
        default:
          ret = REPLACE;
      }
    }
    return ret;
  };
  // ---------------------------
  // -- replace others
  auto replace = [real](std::unique_ptr<vart::TensorBuffer>* x) {
    // be careful about the ownership of the tensor
    auto tensor = xir::Tensor::clone((*x)->get_tensor());
    *x = std::make_unique<vart::TensorBufferShared>(real, tensor.get());
  };
  // -- replace master_ anyway, because master_ is HOST_VIRT
  replace(master_);
  int index = 0;
  linker_decisions_ = vitis::ai::vec_map(slaves_, decide);
  for (auto s : slaves_) {
    switch (linker_decisions_[index]) {
      case REPLACE:
        replace(s);
        break;
      case THE_SELECTED:
      case KEEP:
      default:
        // do nothing
        break;
    }
    index++;
  }
}

void TensorBufferLinkerHostVirt::after_invoke_runner(
    const xir::Subgraph* subgraph) {
  int index = 0;
  for (auto s : slaves_) {
    if (linker_decisions_[index] == KEEP) {
      LOG_IF(INFO, ENV_PARAM(DEBUG_GRAPH_RUNNER))
          << " copy tensor buffer \n\tfrom " << replacement_->get()->to_string()
          << " \n\tto   " << s->get()->to_string();
      vart::TensorBuffer::copy_tensor_buffer(replacement_->get(), s->get());
    }
    index++;
  }
  return;
}
