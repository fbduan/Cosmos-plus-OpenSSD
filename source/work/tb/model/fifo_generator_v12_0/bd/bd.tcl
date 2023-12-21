###############################################################################
##
## (c) Copyright 2012-2013 Xilinx, Inc. All rights reserved.
##
## This file contains confidential and proprietary information
## of Xilinx, Inc. and is protected under U.S. and
## international copyright and other intellectual property
## laws.
##
## DISCLAIMER
## This disclaimer is not a license and does not grant any
## rights to the materials distributed herewith. Except as
## otherwise provided in a valid license issued to you by
## Xilinx, and to the maximum extent permitted by applicable
## law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
## WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
## AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
## BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
## INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
## (2) Xilinx shall not be liable (whether in contract or tort,
## including negligence, or under any other theory of
## liability) for any loss or damage of any kind or nature
## related to, arising under or in connection with these
## materials, including for any direct, or any indirect,
## special, incidental, or consequential loss or damage
## (including loss of data, profits, goodwill, or any type of
## loss or damage suffered as a result of any action brought
## by a third party) even if such damage or loss was
## reasonably foreseeable or Xilinx had been advised of the
## possibility of the same.
##
## CRITICAL APPLICATIONS
## Xilinx products are not designed or intended to be fail-
## safe, or for use in any application requiring fail-safe
## performance, such as life-support or safety devices or
## systems, Class III medical devices, nuclear facilities,
## applications related to the deployment of airbags, or any
## other applications that could lead to death, personal
## injury, or severe property or environmental damage
## (individually and collectively, "Critical
## Applications"). Customer assumes the sole risk and
## liability of any use of Xilinx products in Critical
## Applications, subject only to applicable laws and
## regulations governing limitations on product liability.
##
## THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
## PART OF THIS FILE AT ALL TIMES.
##

source [::bd::get_vlnv_dir xilinx.com:ip:axi_infrastructure:1.1]/bd/axi_common_propagator.tcl

proc init { cell_name undefined_params } {
  set ip [get_bd_cells $cell_name]
  set intf_type [get_property CONFIG.INTERFACE_TYPE $ip]
##if {$intf_type == "AXI_MEMORY_MAPPED"} {
##set_property BD_ATTRIBUTE.TYPE interior [get_bd_intf_pins  $cell_name/S_AXI]
##
##}
}
proc post_config_ip {cellpath otherInfo } {
  set ip [get_bd_cells $cellpath]
  set intf_type [get_property CONFIG.INTERFACE_TYPE $ip]
  set clk_type [get_property CONFIG.Clock_Type_AXI $ip]
  set clkobj [get_bd_pins $cellpath/s_aclk]
  
  ::bd::send_msg -of $cellpath -type info -msg_id 5968 -text "Executing the post_config_ip from bd"

  if {$intf_type != "Native" && $clk_type == "Common_Clock"} {
    set_property CONFIG.ASSOCIATED_BUSIF {M_AXIS:M_AXI:S_AXIS:S_AXI} $clkobj
  } elseif {$intf_type != "Native" && $clk_type  == "Independent_Clock"} {
    set_property CONFIG.ASSOCIATED_BUSIF {S_AXIS:S_AXI} $clkobj
    set_property CONFIG.ASSOCIATED_BUSIF {M_AXIS:M_AXI} [get_bd_pins $cellpath/m_aclk]
  }
}
