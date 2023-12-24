###############################################################################
##
## (c) Copyright 2012-2016 Xilinx, Inc. All rights reserved.
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

source_subcore_ipfile xilinx.com:ip:ifx_util:1.1 xgui/ifx_common_xgui_util.tcl

proc create_common_axi_view { IPINST parent {substitutions {}} } {
  set axi_widgets { 
    INTERFACE_MODE  comboBox {This defines Which AXI mode is selected}
    PROTOCOL        comboBox {This defines which AXI protocol is implemented}
    READ_WRITE_MODE comboBox {This controls which AXI channels are enabled} 
    ADDR_WIDTH      textEdit {Defines the width(in bits) of the AXI AWADDR and ARADDR signals}
    DATA_WIDTH      comboBox {Defines the width(in bits) of the AXI WDATA and RDATA signals}
    ID_WIDTH        comboBox {Defines the width(in bits) of the AXI ID signals}
  }

  foreach {param sub} $substitutions {
    set pos [lsearch $axi_widgets $param]
    set axi_widgets [lreplace $axi_widgets $pos [expr $pos + 2]]
    if {$sub != ""} {
      set axi_widgets [linsert  $axi_widgets $pos {*}$sub]
    }
  }

  add_widgets $IPINST $parent $axi_widgets
}

proc create_axi_user_view { IPINST page } {
  set user_group [ipgui::add_group $IPINST -parent $page -name {User signal widths} -layout vertical] 
  set user_widgets {
    AWUSER_WIDTH             textEdit {Defines the width of the AXI AWUSER signal of the master and slave interface} 
    ARUSER_WIDTH             textEdit {Defines the width of the AXI ARUSER signal of the master and slave interface} 
    HAS_USER_BITS_PER_BYTE   comboBox {Defines USER BITS PER BYTE or PER TRANSFER} 
    WUSER_BITS_PER_BYTE      textEdit {Defines the size of the AXI WUSER signal of the master and slave interface} 
    RUSER_BITS_PER_BYTE      textEdit {Defines the size of the AXI RUSER signal of the master and slave interface} 
    WUSER_WIDTH              textEdit {Defines the width of the AXI WUSER signal of the master and slave interface} 
    RUSER_WIDTH              textEdit {Defines the width of the AXI RUSER signal of the master and slave interface} 
    BUSER_WIDTH              textEdit {Defines the width of the AXI BUSER signal of the master and slave interface} 
  }
  add_widgets $IPINST $user_group $user_widgets
}

proc create_axi_option_view {IPINST page } {
    set option_group [ipgui::add_group $IPINST -parent $page -name {optional choice} -layout vertical] 
  set option_widgets { 
    SUPPORTS_NARROW   comboBox {This controls enablement of AxSIZE ports}
    HAS_SIZE          comboBox {This controls enablement of AxSIZE ports}
    HAS_BURST         comboBox {This controls enablement of AxBURST ports}
    HAS_LOCK          comboBox {This controls enablement of AxLOCK ports}
    HAS_CACHE         comboBox {This controls enablement of AxCACHE ports}
    HAS_REGION        comboBox {This controls enablement of AxREGION ports}
    HAS_PROT          comboBox {This controls enablement of AxPROT ports}
    HAS_QOS           comboBox {This controls enablement of AxQOS ports}
    HAS_WSTRB         comboBox {This controls enablement of AxWSTRB ports}
    HAS_BRESP         comboBox {This controls enablement of AxBRESP ports}
    HAS_RRESP         comboBox {This controls enablement of AxPRESP ports}
    HAS_ACLKEN        comboBox {This controls enablement of AxACLKEN ports}
    HAS_ARESETN       comboBox {This controls enablement of AxARESETN ports}
  }
  add_widgets $IPINST $option_group $option_widgets
}

set direct_model_params {  
  PARAM_VALUE.ADDR_WIDTH       MODELPARAM_VALUE.C_AXI_ADDR_WIDTH
  PARAM_VALUE.ID_WIDTH         MODELPARAM_VALUE.C_AXI_WID_WIDTH  
  PARAM_VALUE.ID_WIDTH         MODELPARAM_VALUE.C_AXI_RID_WIDTH  
  PARAM_VALUE.DATA_WIDTH       MODELPARAM_VALUE.C_AXI_WDATA_WIDTH  
  PARAM_VALUE.DATA_WIDTH       MODELPARAM_VALUE.C_AXI_RDATA_WIDTH  
  PARAM_VALUE.AWUSER_WIDTH     MODELPARAM_VALUE.C_AXI_AWUSER_WIDTH  
  PARAM_VALUE.ARUSER_WIDTH     MODELPARAM_VALUE.C_AXI_ARUSER_WIDTH
  PARAM_VALUE.WUSER_WIDTH      MODELPARAM_VALUE.C_AXI_WUSER_WIDTH  
  PARAM_VALUE.RUSER_WIDTH      MODELPARAM_VALUE.C_AXI_RUSER_WIDTH
  PARAM_VALUE.BUSER_WIDTH      MODELPARAM_VALUE.C_AXI_BUSER_WIDTH
  PARAM_VALUE.SUPPORTS_NARROW  MODELPARAM_VALUE.C_AXI_SUPPORTS_NARROW
  PARAM_VALUE.HAS_SIZE         MODELPARAM_VALUE.C_AXI_HAS_SIZE
  PARAM_VALUE.HAS_BURST        MODELPARAM_VALUE.C_AXI_HAS_BURST
  PARAM_VALUE.HAS_LOCK         MODELPARAM_VALUE.C_AXI_HAS_LOCK
  PARAM_VALUE.HAS_CACHE        MODELPARAM_VALUE.C_AXI_HAS_CACHE
  PARAM_VALUE.HAS_REGION       MODELPARAM_VALUE.C_AXI_HAS_REGION
  PARAM_VALUE.HAS_PROT         MODELPARAM_VALUE.C_AXI_HAS_PROT
  PARAM_VALUE.HAS_QOS          MODELPARAM_VALUE.C_AXI_HAS_QOS
  PARAM_VALUE.HAS_WSTRB        MODELPARAM_VALUE.C_AXI_HAS_WSTRB
  PARAM_VALUE.HAS_BRESP        MODELPARAM_VALUE.C_AXI_HAS_BRESP
  PARAM_VALUE.HAS_RRESP        MODELPARAM_VALUE.C_AXI_HAS_RRESP   
  PARAM_VALUE.HAS_ARESETN      MODELPARAM_VALUE.C_AXI_HAS_ARESETN
}
generate_direct_model_procs $direct_model_params

generate_map_model_procs {
  PARAM_VALUE.PROTOCOL         MODELPARAM_VALUE.C_AXI_PROTOCOL {AXI4 0 AXI3 1 AXI4LITE 2}
  PARAM_VALUE.INTERFACE_MODE   MODELPARAM_VALUE.C_AXI_INTERFACE_MODE {MASTER 0 PASS_THROUGH 1 SLAVE 2}
}

proc init_gui { IPINST } {
  set Component_Name [ ipgui::add_param  $IPINST  -parent $IPINST -name Component_Name ]
  set Page0 [ ipgui::add_page $IPINST  -name "Basic Settings" -layout vertical]
  set Page1 [ ipgui::add_page $IPINST  -name "Advanced Settings" -layout vertical]
  create_common_axi_view $IPINST $Page0
  create_axi_user_view $IPINST $Page0
  create_axi_option_view $IPINST $Page1
  set has_lock [get_property value [ipgui::get_paramspec HAS_LOCK -of $IPINST]]
  set has_size [get_property value [ipgui::get_paramspec HAS_SIZE -of $IPINST]]
  set read_write [get_property value [ipgui::get_paramspec READ_WRITE_MODE -of $IPINST]]
  set supports_narrow [get_property value [ipgui::get_paramspec SUPPORTS_NARROW -of $IPINST]]
  if {$read_write == "READ_ONLY" } {
    set_property enabled false [ipgui::get_paramspec HAS_BRESP -of $IPINST]
  } else {
    set_property enabled true [ipgui::get_paramspec HAS_BRESP -of $IPINST]
  } 
   if {$read_write == "WRITE_ONLY" } {
    set_property enabled false [ipgui::get_paramspec HAS_RRESP -of $IPINST]
  } else {
    set_property enabled true [ipgui::get_paramspec HAS_RRESP -of $IPINST]
  } 
  if {$read_write == "READ_ONLY" } {
    set_property enabled false [ipgui::get_paramspec HAS_WSTRB -of $IPINST]
  } else {
    set_property enabled true [ipgui::get_paramspec HAS_WSTRB -of $IPINST]
  }

  set has_user_bits_per_byte [get_property value [ipgui::get_paramspec HAS_USER_BITS_PER_BYTE -of $IPINST]]
  if {$has_user_bits_per_byte ==0} {
    set_property enabled false [ipgui::get_paramspec WUSER_BITS_PER_BYTE -of $IPINST]
    set_property enabled false [ipgui::get_paramspec RUSER_BITS_PER_BYTE -of $IPINST]
  } else {
    if {$read_write == "READ_ONLY" } {
      set_property enabled true [ipgui::get_paramspec RUSER_BITS_PER_BYTE -of $IPINST]
      set_property enabled false [ipgui::get_paramspec WUSER_BITS_PER_BYTE -of $IPINST]
    } else {  
      set_property enabled true [ipgui::get_paramspec RUSER_BITS_PER_BYTE -of $IPINST]
      set_property enabled false [ipgui::get_paramspec WUSER_BITS_PER_BYTE -of $IPINST]
    }  
  }
    ipgui::add_static_text $IPINST -has_hypertext true -display_border true -parent $Page0 -name ICT_STATIC_TEXT -text {<html><h3><font color=red>The AXI Verification IP can only act as a protocol checker when contained within a VHDL hierarchy.<br> In order to use the virtual part of the AXI Verification IP, it must be in Verilog hierarchy.<br>In order to use the virtual part of this IP,Please refer PG267 section about "Useful Coding Guidelines and Examples " <br> <h3></html>}
 
   ipgui::add_static_text $IPINST -has_hypertext true -display_border true -parent $Page0 -name ICT_STATIC_TEXT -text {<html><h3><font color = Blue>The API for the virtual part of this IP can be found:  <a href="https://www.xilinx.com/support/answers/68234.html">https://www.xilinx.com/support/answers/68234.html</a><h3></html>}

}

proc update_PARAM_VALUE.Component_Name {PARAM_VALUE.Component_Name } {
  set value [get_property value ${PARAM_VALUE.Component_Name}]
  set Component_Name ${PARAM_VALUE.Component_Name}
}

proc update_PARAM_VALUE.DATA_WIDTH {PARAM_VALUE.PROTOCOL PARAM_VALUE.DATA_WIDTH} {
  set protocol [get_property value ${PARAM_VALUE.PROTOCOL}]
  set DATA_WIDTH ${PARAM_VALUE.DATA_WIDTH}
  if {$protocol == "AXI4LITE" } {
    set_property range 32,64 $DATA_WIDTH
  } else {
    set_property range 32,64,128,256,512,1024 $DATA_WIDTH
  }
}

proc update_PARAM_VALUE.ID_WIDTH {PARAM_VALUE.PROTOCOL PARAM_VALUE.ID_WIDTH} {
  set protocol [get_property value ${PARAM_VALUE.PROTOCOL}]
  set ID_WIDTH ${PARAM_VALUE.ID_WIDTH}
  if {$protocol == "AXI4LITE" } {
    set_property range 0,0 $ID_WIDTH
    set_property enabled false $ID_WIDTH
  } else {
    set_property range 0,32 $ID_WIDTH
    set_property enabled true $ID_WIDTH
  }
}

proc update_PARAM_VALUE.AWUSER_WIDTH {PARAM_VALUE.PROTOCOL PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.AWUSER_WIDTH} {
  set protocol [get_property value ${PARAM_VALUE.PROTOCOL}]
  set rwm [get_property value ${PARAM_VALUE.READ_WRITE_MODE}]
  set AWUSER_WIDTH ${PARAM_VALUE.AWUSER_WIDTH}
  if { $rwm == "READ_ONLY"  || $protocol == "AXI4LITE"  } {
    set_property range 0,0 $AWUSER_WIDTH
    set_property enabled false $AWUSER_WIDTH
  } else {
    set_property range 0,1024 $AWUSER_WIDTH
    set_property enabled true $AWUSER_WIDTH
  }
}

proc update_PARAM_VALUE.ARUSER_WIDTH {PARAM_VALUE.PROTOCOL PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.ARUSER_WIDTH} {
  set protocol [get_property value ${PARAM_VALUE.PROTOCOL}]
  set rwm [get_property value ${PARAM_VALUE.READ_WRITE_MODE}]
  set ARUSER_WIDTH ${PARAM_VALUE.ARUSER_WIDTH}
  if {$rwm == "WRITE_ONLY"  || $protocol == "AXI4LITE"   } {
    set_property range 0,0 $ARUSER_WIDTH
    set_property enabled false $ARUSER_WIDTH
  } else {
    set_property range 0,1024 $ARUSER_WIDTH
    set_property enabled true $ARUSER_WIDTH
  }
}

proc update_PARAM_VALUE.HAS_USER_BITS_PER_BYTE {PARAM_VALUE.PROTOCOL PARAM_VALUE.HAS_USER_BITS_PER_BYTE } {
  set protocol [get_property value ${PARAM_VALUE.PROTOCOL}]
  set HAS_USER_BITS_PER_BYTE ${PARAM_VALUE.HAS_USER_BITS_PER_BYTE}
  if {$protocol == "AXI4LITE"   }  {
    set_property range 0,0 $HAS_USER_BITS_PER_BYTE
    set_property enabled false $HAS_USER_BITS_PER_BYTE
  } else {
    set_property range 0,1 $HAS_USER_BITS_PER_BYTE
    set_property enabled true $HAS_USER_BITS_PER_BYTE
  }
}

proc update_PARAM_VALUE.WUSER_WIDTH {PARAM_VALUE.PROTOCOL PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.DATA_WIDTH PARAM_VALUE.HAS_USER_BITS_PER_BYTE PARAM_VALUE.WUSER_BITS_PER_BYTE PARAM_VALUE.WUSER_WIDTH} {
  set protocol [get_property value ${PARAM_VALUE.PROTOCOL}]
  set rwm [get_property value ${PARAM_VALUE.READ_WRITE_MODE}]
  set databits [get_property value ${PARAM_VALUE.DATA_WIDTH}]
  set has_user_bits_per_bit [get_property value ${PARAM_VALUE.HAS_USER_BITS_PER_BYTE}]
  set user_bits_per_byte [get_property value ${PARAM_VALUE.WUSER_BITS_PER_BYTE}]
  set userwidth [expr ($databits/8)*$user_bits_per_byte]
  set WUSER_WIDTH ${PARAM_VALUE.WUSER_WIDTH}
  if {$rwm == "READ_ONLY"  || $protocol == "AXI4LITE"   } {
    set_property range 0,0 $WUSER_WIDTH
    set_property enabled false $WUSER_WIDTH
  } else {
    if { $has_user_bits_per_bit > 0 } {
      set_property range 0,1024 $WUSER_WIDTH 
      set_property value $userwidth $WUSER_WIDTH 
      set_property enabled false $WUSER_WIDTH
    } else {
      set_property range 0,1024 $WUSER_WIDTH
      set_property enabled true $WUSER_WIDTH
    }
  }  
}

proc update_PARAM_VALUE.RUSER_WIDTH {PARAM_VALUE.PROTOCOL PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.DATA_WIDTH PARAM_VALUE.HAS_USER_BITS_PER_BYTE PARAM_VALUE.RUSER_BITS_PER_BYTE PARAM_VALUE.RUSER_WIDTH} {
  set protocol [get_property value ${PARAM_VALUE.PROTOCOL}]
  set rwm [get_property value ${PARAM_VALUE.READ_WRITE_MODE}]
  set databits [get_property value ${PARAM_VALUE.DATA_WIDTH}]
  set has_user_bits_per_bit [get_property value ${PARAM_VALUE.HAS_USER_BITS_PER_BYTE}]
  set user_bits_per_byte [get_property value ${PARAM_VALUE.RUSER_BITS_PER_BYTE}]
  set userwidth [expr ($databits/8)*$user_bits_per_byte]
  set RUSER_WIDTH ${PARAM_VALUE.RUSER_WIDTH}
  if {$rwm == "WRITE_ONLY"  || $protocol == "AXI4LITE"   } {
    set_property range 0,0 $RUSER_WIDTH
    set_property enabled false $RUSER_WIDTH
  } else {
    if { $has_user_bits_per_bit > 0 } {
      set_property range 0,1024 $RUSER_WIDTH 
      set_property value $userwidth $RUSER_WIDTH 
      set_property enabled false $RUSER_WIDTH
    } else {
      set_property range 0,1024 $RUSER_WIDTH
      set_property enabled true $RUSER_WIDTH
    }
  }  
}

proc update_PARAM_VALUE.BUSER_WIDTH {PARAM_VALUE.PROTOCOL PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.BUSER_WIDTH} {
  set protocol [get_property value ${PARAM_VALUE.PROTOCOL}]
  set rwm [get_property value ${PARAM_VALUE.READ_WRITE_MODE}]
  set BUSER_WIDTH ${PARAM_VALUE.BUSER_WIDTH}
  if {$rwm == "READ_ONLY"  || $protocol == "AXI4LITE"   } {
    set_property range 0,0 $BUSER_WIDTH
    set_property enabled false $BUSER_WIDTH
  } else {
    set_property range 0,1024 $BUSER_WIDTH
    set_property enabled true $BUSER_WIDTH
  }
}


proc update_PARAM_VALUE.SUPPORTS_NARROW {PARAM_VALUE.PROTOCOL PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.SUPPORTS_NARROW PARAM_VALUE.HAS_WSTRB} {
  set protocol [get_property value ${PARAM_VALUE.PROTOCOL}]
  set has_wstrb [get_property value ${PARAM_VALUE.HAS_WSTRB}]
  set SUPPORTS_NARROW ${PARAM_VALUE.SUPPORTS_NARROW}
  if {$protocol == "AXI4LITE"  || $has_wstrb == 0  } {
    set_property value 0 $SUPPORTS_NARROW
    set_property enabled false $SUPPORTS_NARROW
  } else {
    set_property range 0,1 $SUPPORTS_NARROW
    set_property enabled true $SUPPORTS_NARROW
  }
}

proc update_PARAM_VALUE.HAS_BURST {PARAM_VALUE.PROTOCOL PARAM_VALUE.HAS_BURST} {
  set protocol [get_property value ${PARAM_VALUE.PROTOCOL}]
  set HAS_BURST ${PARAM_VALUE.HAS_BURST}
  if {$protocol == "AXI4LITE"   } {
    set_property value 0 $HAS_BURST
    set_property enabled false $HAS_BURST
  } else {
    set_property range 0,1 $HAS_BURST
    set_property enabled true $HAS_BURST
  }
}

proc update_PARAM_VALUE.HAS_SIZE {PARAM_VALUE.PROTOCOL PARAM_VALUE.HAS_SIZE} {
  set protocol [get_property value ${PARAM_VALUE.PROTOCOL}]
  set HAS_SIZE ${PARAM_VALUE.HAS_SIZE}
  if {$protocol == "AXI4LITE"   } {
    set_property value 0 $HAS_SIZE
    set_property enabled false $HAS_SIZE
  } else {
    set_property range 0,1 $HAS_SIZE
    set_property enabled true $HAS_SIZE
  }
}

proc update_PARAM_VALUE.HAS_LOCK {PARAM_VALUE.PROTOCOL PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.HAS_BRESP PARAM_VALUE.HAS_RRESP PARAM_VALUE.HAS_LOCK } {
  set protocol [get_property value ${PARAM_VALUE.PROTOCOL}]
  set rwm [get_property value ${PARAM_VALUE.READ_WRITE_MODE}]
  set has_bresp [get_property value ${PARAM_VALUE.HAS_BRESP}]
  set has_rresp [get_property value ${PARAM_VALUE.HAS_RRESP}]
  set HAS_LOCK ${PARAM_VALUE.HAS_LOCK}
  if {$protocol == "AXI4LITE" || $rwm !="READ_WRITE" || $has_bresp ==0 || $has_rresp ==0  } {
    set_property value 0 $HAS_LOCK
    set_property enabled false $HAS_LOCK
  } else {
    set_property range 0,1 $HAS_LOCK
    set_property enabled true $HAS_LOCK
  }
}

proc update_PARAM_VALUE.HAS_CACHE {PARAM_VALUE.PROTOCOL PARAM_VALUE.HAS_CACHE} {
  set protocol [get_property value ${PARAM_VALUE.PROTOCOL}]
  set HAS_CACHE ${PARAM_VALUE.HAS_CACHE}
  if {$protocol == "AXI4LITE"   } {
    set_property value 0 $HAS_CACHE
    set_property enabled false $HAS_CACHE
  } else {
    set_property range 0,1 $HAS_CACHE
    set_property enabled true $HAS_CACHE
  }  
}

proc update_PARAM_VALUE.HAS_REGION {PARAM_VALUE.PROTOCOL PARAM_VALUE.HAS_REGION} {
  set protocol [get_property value ${PARAM_VALUE.PROTOCOL}]
  set HAS_REGION ${PARAM_VALUE.HAS_REGION}
  if {$protocol == "AXI4LITE"   } {
    set_property value 0 $HAS_REGION
    set_property enabled false $HAS_REGION
  } else {
    set_property range 0,1 $HAS_REGION
    set_property enabled true $HAS_REGION
  }
}

proc update_PARAM_VALUE.HAS_QOS {PARAM_VALUE.PROTOCOL PARAM_VALUE.HAS_QOS} {
  set protocol [get_property value ${PARAM_VALUE.PROTOCOL}]
  set HAS_QOS ${PARAM_VALUE.HAS_QOS}
  if {$protocol == "AXI4LITE"   } {
    set_property value 0 $HAS_QOS
    set_property enabled false $HAS_QOS
  } else {
    set_property range 0,1 $HAS_QOS
    set_property enabled true $HAS_QOS
  }
}

proc update_PARAM_VALUE.HAS_WSTRB {PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.HAS_WSTRB} {
  set rwm [get_property value ${PARAM_VALUE.READ_WRITE_MODE}]
  set HAS_WSTRB ${PARAM_VALUE.HAS_WSTRB}
  if {$rwm == "READ_ONLY"} {
    set_property value 0 $HAS_WSTRB
    set_property enabled false $HAS_WSTRB
  } else {
    set_property range 0,1 $HAS_WSTRB
    set_property enabled true $HAS_WSTRB
  }
}

proc update_PARAM_VALUE.HAS_BRESP {PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.HAS_BRESP} {
  set HAS_BRESP ${PARAM_VALUE.HAS_BRESP}
  set rwm [get_property value ${PARAM_VALUE.READ_WRITE_MODE}]
  if {$rwm == "READ_ONLY"} {
    set_property value 0 $HAS_BRESP
    set_property enabled false $HAS_BRESP
  } else {
    set_property range 0,1 $HAS_BRESP
    set_property enabled true $HAS_BRESP
  }   
}  

proc update_PARAM_VALUE.HAS_RRESP { PARAM_VALUE.HAS_RRESP PARAM_VALUE.READ_WRITE_MODE} {
  set HAS_RRESP ${PARAM_VALUE.HAS_RRESP}
  set rwm [get_property value ${PARAM_VALUE.READ_WRITE_MODE}]
  if {$rwm == "WRITE_ONLY"} {
    set_property value 0 $HAS_RRESP
    set_property enabled false $HAS_RRESP
  } else {
    set_property range 0,1 $HAS_RRESP
    set_property enabled true $HAS_RRESP
  } 
}

proc update_PARAM_VALUE.WUSER_BITS_PER_BYTE {PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.HAS_USER_BITS_PER_BYTE PARAM_VALUE.WUSER_BITS_PER_BYTE } {
  set has_user_bits_per_bit [get_property value ${PARAM_VALUE.HAS_USER_BITS_PER_BYTE}]
  set rwm [get_property value ${PARAM_VALUE.READ_WRITE_MODE}]
  set WUSER_BITS_PER_BYTE ${PARAM_VALUE.WUSER_BITS_PER_BYTE} 
  if { $has_user_bits_per_bit > 0 && $rwm !="READ_ONLY"  } {
    set_property range 0,32 $WUSER_BITS_PER_BYTE 
    set_property enabled true $WUSER_BITS_PER_BYTE
   } else {
    set_property range 0,0 $WUSER_BITS_PER_BYTE 
    set_property enabled false $WUSER_BITS_PER_BYTE
   }
}  

proc update_PARAM_VALUE.RUSER_BITS_PER_BYTE {PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.HAS_USER_BITS_PER_BYTE PARAM_VALUE.RUSER_BITS_PER_BYTE } {
  set has_user_bits_per_bit [get_property value ${PARAM_VALUE.HAS_USER_BITS_PER_BYTE}]
  set rwm [get_property value ${PARAM_VALUE.READ_WRITE_MODE}]
  set RUSER_BITS_PER_BYTE ${PARAM_VALUE.RUSER_BITS_PER_BYTE} 
  if { $has_user_bits_per_bit > 0 && $rwm !="WRITE_ONLY" } {
    set_property range 0,32 $RUSER_BITS_PER_BYTE 
    set_property enabled true $RUSER_BITS_PER_BYTE
   } else {
    set_property range 0,0 $RUSER_BITS_PER_BYTE 
    set_property enabled false $RUSER_BITS_PER_BYTE
   }
}  

proc update_MODELPARAM_VALUE.C_AXI_Component_Name {MODELPARAM_VALUE.C_AXI_Component_Name PARAM_VALUE.Component_Name } {
  set val [get_property value ${PARAM_VALUE.Component_Name}]
  set_property value $val ${MODELPARAM_VALUE.C_AXI_Component_Name}
}

proc update_MODELPARAM_VALUE.C_AXI_PROTOCOL {MODELPARAM_VALUE.C_AXI_PROTOCOL PARAM_VALUE.PROTOCOL} {
  set val [get_property value ${PARAM_VALUE.PROTOCOL}]
  if {$val == "AXI4" } {
    set mval 0
  } elseif {$val == "AXI3" } {
    set mval 1
  } else {
    set mval 2
  }
  set_property value $mval ${MODELPARAM_VALUE.C_AXI_PROTOCOL}
}

proc update_MODELPARAM_VALUE.C_AXI_INTERFACE_MODE {MODELPARAM_VALUE.C_AXI_INTERFACE_MODE PARAM_VALUE.INTERFACE_MODE} {
  set val [get_property value ${PARAM_VALUE.INTERFACE_MODE}]
  if {$val == "MASTER" } {
    set mval 0
  } elseif {$val == "PASS_THROUGH" } {
    set mval 1
  } else {
    set mval 2
  }
  set_property value $mval ${MODELPARAM_VALUE.C_AXI_INTERFACE_MODE}
}

proc update_MODELPARAM_VALUE.C_AXI_ADDR_WIDTH {MODELPARAM_VALUE.C_AXI_ADDR_WIDTH PARAM_VALUE.ADDR_WIDTH} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.ADDR_WIDTH}]
  set_property value $value ${MODELPARAM_VALUE.C_AXI_ADDR_WIDTH}
  return true
}

proc update_MODELPARAM_VALUE.C_AXI_WID_WIDTH {MODELPARAM_VALUE.C_AXI_WID_WIDTH PARAM_VALUE.ID_WIDTH} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.ID_WIDTH}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_WID_WIDTH}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_RID_WIDTH {MODELPARAM_VALUE.C_AXI_RID_WIDTH PARAM_VALUE.ID_WIDTH} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.ID_WIDTH}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_RID_WIDTH}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_WDATA_WIDTH {MODELPARAM_VALUE.C_AXI_WDATA_WIDTH PARAM_VALUE.DATA_WIDTH} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.DATA_WIDTH}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_WDATA_WIDTH}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_RDATA_WIDTH {MODELPARAM_VALUE.C_AXI_RDATA_WIDTH PARAM_VALUE.DATA_WIDTH} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.DATA_WIDTH}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_RDATA_WIDTH}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_AWUSER_WIDTH {MODELPARAM_VALUE.C_AXI_AWUSER_WIDTH PARAM_VALUE.AWUSER_WIDTH} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.AWUSER_WIDTH}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_AWUSER_WIDTH}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_ARUSER_WIDTH {MODELPARAM_VALUE.C_AXI_ARUSER_WIDTH PARAM_VALUE.ARUSER_WIDTH} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.ARUSER_WIDTH}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_ARUSER_WIDTH}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_WUSER_WIDTH {MODELPARAM_VALUE.C_AXI_WUSER_WIDTH PARAM_VALUE.WUSER_WIDTH} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.WUSER_WIDTH}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_WUSER_WIDTH}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_RUSER_WIDTH {MODELPARAM_VALUE.C_AXI_RUSER_WIDTH PARAM_VALUE.RUSER_WIDTH} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.RUSER_WIDTH}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_RUSER_WIDTH}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_BUSER_WIDTH {MODELPARAM_VALUE.C_AXI_BUSER_WIDTH PARAM_VALUE.BUSER_WIDTH} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.BUSER_WIDTH}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_BUSER_WIDTH}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_SUPPORTS_NARROW {MODELPARAM_VALUE.C_AXI_SUPPORTS_NARROW PARAM_VALUE.SUPPORTS_NARROW } {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.SUPPORTS_NARROW}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_SUPPORTS_NARROW}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_HAS_BURST {MODELPARAM_VALUE.C_AXI_HAS_BURST PARAM_VALUE.HAS_BURST } {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.HAS_BURST}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_HAS_BURST}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_HAS_SIZE {MODELPARAM_VALUE.C_AXI_HAS_LOCK PARAM_VALUE.HAS_SIZE } {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.HAS_SIZE}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_HAS_SIZE}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_HAS_LOCK {MODELPARAM_VALUE.C_AXI_HAS_LOCK PARAM_VALUE.HAS_LOCK } {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.HAS_LOCK}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_HAS_LOCK}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_HAS_CACHE {MODELPARAM_VALUE.C_AXI_HAS_CACHE PARAM_VALUE.HAS_CACHE } {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.HAS_CACHE}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_HAS_CACHE}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_HAS_REGION {MODELPARAM_VALUE.C_AXI_HAS_REGION PARAM_VALUE.HAS_REGION } {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.HAS_REGION}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_HAS_REGION}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_HAS_PROT {MODELPARAM_VALUE.C_AXI_HAS_PROT PARAM_VALUE.HAS_PROT } {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.HAS_PROT}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_HAS_PROT}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_HAS_QOS {MODELPARAM_VALUE.C_AXI_HAS_QOS PARAM_VALUE.HAS_QOS } {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.HAS_QOS}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_HAS_QOS}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_HAS_WSTRB {MODELPARAM_VALUE.C_AXI_HAS_WSTRB PARAM_VALUE.HAS_WSTRB } {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.HAS_WSTRB}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_HAS_WSTRB}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_HAS_BRESP {MODELPARAM_VALUE.C_AXI_HAS_BRESP PARAM_VALUE.HAS_BRESP } {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.HAS_BRESP}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_HAS_BRESP}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_HAS_RRESP {MODELPARAM_VALUE.C_AXI_HAS_RRESP PARAM_VALUE.HAS_RRESP } {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.HAS_RRESP}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_HAS_RRESP}

  return true
}

proc update_MODELPARAM_VALUE.C_AXI_HAS_ARESETN {MODELPARAM_VALUE.C_AXI_HAS_ARESETN PARAM_VALUE.HAS_ARESETN } {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
  set value [get_property value ${PARAM_VALUE.HAS_ARESETN}]

  set_property value $value ${MODELPARAM_VALUE.C_AXI_HAS_ARESETN}

  return true
}



