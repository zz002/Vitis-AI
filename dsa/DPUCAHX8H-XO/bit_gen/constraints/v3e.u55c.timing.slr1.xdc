create_generated_clock -name ACLK1 [get_pins "level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/dpu_clock_gen_inst/u_dpu_mmcm/inst/mmcme4_adv_inst/CLKOUT1"]
create_generated_clock -name ACLK_DR1 [get_pins "level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/dpu_clock_gen_inst/u_dpu_mmcm/inst/mmcme4_adv_inst/CLKOUT0"]
create_generated_clock -name ACLK_REG1 [get_pins "level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/dpu_clock_gen_inst/u_dpu_mmcm/inst/mmcme4_adv_inst/CLKOUT2"]
#group_path -name ACLK_DR -weight 2
#set_property CLOCK_DELAY_GROUP DPU_CLK_CLKGROUP "[get_nets -of [get_pins " \ 
#level0_i/ulp/dpu_1/inst/v3e_bd_i/bufgce_div_0/inst/BUFGCE_DIV_1/O \
#level0_i/ulp/dpu_1/inst/v3e_bd_i/bufgce_div_0/inst/BUFGCE_DIV_2/O \
#"]]"
#
#set_property USER_CLOCK_ROOT [get_clock_regions X3Y5] "[get_nets -of [get_pins " \ 
#level0_i/ulp/dpu_1/inst/v3e_bd_i/bufgce_div_0/inst/BUFGCE_DIV_1/O \
#level0_i/ulp/dpu_1/inst/v3e_bd_i/bufgce_div_0/inst/BUFGCE_DIV_2/O \
#"]]"
#
#set_property CLOCK_REGION [get_clock_regions X4Y6] "[get_cells "level0_i/ulp/dpu_1/inst/v3e_bd_i/bufgce_div_0/inst/BUFGCE_DIV_1"]"
#set_property CLOCK_REGION [get_clock_regions X4Y6] "[get_cells "level0_i/ulp/dpu_1/inst/v3e_bd_i/bufgce_div_0/inst/BUFGCE_DIV_2"]"


#set_property CLOCK_DELAY_GROUP CGRP_SLR1 [get_nets "level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/ACLK_B level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/ACLK_C level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/ACLK_C_DR level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/ACLK_F level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/ACLK_LI level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/ACLK_LW level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/ACLK_M level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/ACLK_S level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/ACLK_SW"]
#set_property CLOCK_DELAY_GROUP CGRP_SLR1 [get_nets "level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/ACLK_B level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/ACLK_C level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/ACLK_C_DR level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/ACLK_CS level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/ACLK_OUT level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/ACLK_LI level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/ACLK_LW level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/ACLK_M level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/ACLK_S level0_i/ulp/dpu_1/inst/v3e_bd_i/dpu_top_0/inst/ACLK_SW"]
