# Copyright 2019 Xilinx Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


class Yolov3VOCConfig(object):

    def __init__(self):
        self.input_node = ["input_1"]
        self.output_node = ["conv2d_59/BiasAdd",
                            "conv2d_67/BiasAdd", "conv2d_75/BiasAdd"]
        self.height = 416
        self.width = 416
        self.anchors = [[10, 13], [16, 30], [33, 23], [30, 61], [
            62, 45], [59, 119], [116, 90], [156, 198], [373, 326]]
        self.score_thresh = 0.005
        self.nms_thresh = 0.45
        self.classes = ["aeroplane", "bicycle", "bird", "boat", "bottle", "bus", "car", "cat", "chair", "cow",
                        "diningtable", "dog", "horse", "motorbike", "person", "pottedplant", "sheep", "sofa", "train", "tvmonitor"]
