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

source [::bd::get_vlnv_dir xilinx.com:ip:ifx_util:1.1]/bd/ifx_common_debug_util.tcl
source [::bd::get_vlnv_dir xilinx.com:ip:ifx_util:1.1]/bd/ifx_common_ipi_util.tcl
source [::bd::get_vlnv_dir xilinx.com:ip:axi_infrastructure:1.1]/bd/axi_common_propagator.tcl

proc init { cell_name undefined_params } {
  set ip [get_bd_cells $cell_name]
  set_property CONFIG.ASSOCIATED_BUSIF {S_AXI:M_AXI} [get_bd_pins $cell_name/ACLK]
}

proc post_config_ip { cell_name args } {
  set ip [get_bd_cells $cell_name]
  set si [get_bd_intf_pins $ip/S_AXI]
  set mi [get_bd_intf_pins $ip/M_AXI]
  set axiport {ADDR_WIDTH DATA_WIDTH ID_WIDTH AWUSER_WIDTH ARUSER_WIDTH WUSER_WIDTH RUSER_WIDTH BUSER_WIDTH READ_WRITE_MODE PROTOCOL WUSER_BITS_PER_BYTE RUSER_BITS_PER_BYTE SUPPORTS_NARROW HAS_BURST HAS_CACHE HAS_REGION HAS_PROT HAS_QOS HAS_WSTRB HAS_BRESP HAS_RRESP HAS_LOCK}
  set axiport_n {ADDR_WIDTH DATA_WIDTH ID_WIDTH AWUSER_WIDTH ARUSER_WIDTH WUSER_WIDTH RUSER_WIDTH BUSER_WIDTH READ_WRITE_MODE PROTOCOL WUSER_BITS_PER_BYTE RUSER_BITS_PER_BYTE HAS_BURST HAS_CACHE HAS_REGION HAS_PROT HAS_QOS HAS_WSTRB HAS_BRESP HAS_RRESP HAS_LOCK}

  ifx_puts "----------------------------------------------------------------------"
  ifx_puts "[info level [info level]]"
  if {[get_property CONFIG.HAS_ARESETN $ip] == 1} {
    set_property CONFIG.ASSOCIATED_RESET {ARESETN} [get_bd_pins $cell_name/ACLK]
    set_property CONFIG.TYPE INTERCONNECT [get_bd_pins $cell_name/ARESETN]
    set_property CONFIG.POLARITY.VALUE_SRC CONSTANT [get_bd_pins $cell_name/ARESETN]
  } 

  if {[get_property CONFIG.INTERFACE_MODE $ip] == "SLAVE"  }  {
    bd::mark_propagate_overrideable [get_bd_cells $cell_name] {ADDR_WIDTH DATA_WIDTH ID_WIDTH AWUSER_WIDTH ARUSER_WIDTH WUSER_WIDTH RUSER_WIDTH BUSER_WIDTH READ_WRITE_MODE PROTOCOL USER_BITS_PER_BYTE RUSER_BITS_PER_BYTE SUPPORTS_NARROW HAS_BURST HAS_CACHE HAS_REGION HAS_PROT HAS_QOS HAS_WSTRB HAS_BRESP HAS_RRESP HAS_LOCK} 
  } elseif {[get_property CONFIG.INTERFACE_MODE $ip] == "PASS_THROUGH" } {
    bd::mark_propagate_overrideable [get_bd_cells $cell_name] {ADDR_WIDTH DATA_WIDTH ID_WIDTH AWUSER_WIDTH ARUSER_WIDTH WUSER_WIDTH RUSER_WIDTH BUSER_WIDTH READ_WRITE_MODE PROTOCOL WUSER_BITS_PER_BYTE RUSER_BITS_PER_BYTE SUPPORTS_NARROW HAS_BURST HAS_CACHE HAS_REGION HAS_PROT HAS_QOS HAS_WSTRB HAS_BRESP HAS_RRESP HAS_LOCK}
    foreach p $axiport {
      if {[get_property CONFIG.$p.VALUE_SRC $ip] == "USER" } {
        puts "WARNING: AXI VIP is in passthrough mode and all user parameters are in propogate mode. Change of $p will be ignored in validation"
      }  
    }  
  } else {
    bd::mark_user [get_bd_cells $cell_name] $axiport
    set_property CONFIG.SUPPORTS_NARROW.VALUE_SRC USER $ip
    set_property CONFIG.SUPPORTS_NARROW_BURST.VALUE_SRC USER $mi
    set val [get_property CONFIG.SUPPORTS_NARROW $ip]
    set_property CONFIG.SUPPORTS_NARROW_BURST $val $mi
    foreach p $axiport_n {
      set val [get_property CONFIG.$p $ip]
      set_property CONFIG.$p $val $mi
      set_property -quiet CONFIG.$p.VALUE_SRC USER $ip
      set_property CONFIG.$p.VALUE_SRC USER $mi
    }  
  }

  if {[get_property CONFIG.INTERFACE_MODE $ip] =="PASS_THROUGH" } {
    set_property BRIDGES {M_AXI} [get_bd_intf_pins $cell_name/S_AXI]
  } 
  if {[get_property CONFIG.INTERFACE_MODE $ip] == "MASTER" } {
    foreach i $mi { set_property BD_ATTRIBUTE.TYPE END_POINT $i } 
  } elseif { [get_property CONFIG.INTERFACE_MODE $ip] == "SLAVE"  } {
    foreach i $si { set_property BD_ATTRIBUTE.TYPE END_POINT $i }
    set_property BRIDGES {} [get_bd_intf_pins $cell_name/S_AXI]
  } else {
    foreach i [get_bd_intf_pins -of_objects [get_bd_cells $cell_name]] { set_property BD_ATTRIBUTE.TYPE INTERIOR $i }
  } 
}

proc pre_propagate { cell_name otherParams } {
  set ip [get_bd_cells $cell_name]
  set si [get_bd_intf_pins $ip/S_AXI]
  set mi [get_bd_intf_pins $ip/M_AXI]
  set axiport {ADDR_WIDTH DATA_WIDTH ID_WIDTH AWUSER_WIDTH ARUSER_WIDTH WUSER_WIDTH RUSER_WIDTH BUSER_WIDTH READ_WRITE_MODE PROTOCOL WUSER_BITS_PER_BYTE RUSER_BITS_PER_BYTE SUPPORTS_NARROW HAS_BURST HAS_CACHE HAS_REGION HAS_PROT HAS_QOS HAS_WSTRB HAS_BRESP HAS_RRESP HAS_LOCK}
  set axiport_n {ADDR_WIDTH DATA_WIDTH ID_WIDTH AWUSER_WIDTH ARUSER_WIDTH WUSER_BITS_PER_BYTE RUSER_BITS_PER_BYTE WUSER_WIDTH RUSER_WIDTH BUSER_WIDTH READ_WRITE_MODE PROTOCOL HAS_BURST HAS_CACHE HAS_REGION HAS_PROT HAS_QOS HAS_WSTRB HAS_BRESP HAS_RRESP HAS_LOCK}
  set flow_prop {NUM_READ_OUTSTANDING NUM_WRITE_OUTSTANDING MAX_BURST_LENGTH NUM_READ_THREADS NUM_WRITE_THREADS}

   if {[get_property CONFIG.INTERFACE_MODE $ip] == "PASS_THROUGH" } {
     set wuser_bits_per_byte [get_property CONFIG.WUSER_BITS_PER_BYTE $si]
     set ruser_bits_per_byte [get_property CONFIG.RUSER_BITS_PER_BYTE $si]
     set wuser_width [get_property CONFIG.WUSER_WIDTH $si]
     set ruser_width [get_property CONFIG.RUSER_WIDTH $si]
     if { ($wuser_bits_per_byte > 0 && $ruser_bits_per_byte ==0 && $ruser_width >0 ) || ($ruser_bits_per_byte > 0 && $wuser_bits_per_byte ==0 && $wuser_width >0 ) } {
       puts " WARNING: WUSRE_BITS_PER_BYTE $wuser_bits_per_byte and RUSER_BITS_PER_BYTE $ruser_bits_per_byte are assymetric,propagation of WUSER_WIDTH and RUSER_WIDTH will fail"
    } else {
       set_property CONFIG.HAS_USER_BITS_PER_BYTE.VALUE_SRC DEFAULT $ip
       set_property -quiet CONFIG.HAS_USER_BITS_PER_BYTE 0 $ip
       set_property CONFIG.WUSER_WIDTH.VALUE_SRC DEFAULT $ip
       set_property CONFIG.RUSER_WIDTH.VALUE_SRC DEFAULT $ip
    }  
    set_property CONFIG.SUPPORTS_NARROW.VALUE_SRC DEFAULT $ip
    set_property CONFIG.SUPPORTS_NARROW_BURST.VALUE_SRC DEFAULT $mi
    set_property CONFIG.SUPPORTS_NARROW_BURST.VALUE_SRC DEFAULT $si
    set_property -quiet CONFIG.SUPPORTS_NARROW [get_property CONFIG.SUPPORTS_NARROW_BURST $si] $ip
    set_property CONFIG.SUPPORTS_NARROW_BURST [get_property CONFIG.SUPPORTS_NARROW_BURST $si] $mi
    foreach p $axiport_n {
      set_property CONFIG.$p.VALUE_SRC DEFAULT $ip
      set_property CONFIG.$p.VALUE_SRC DEFAULT $mi
      set_property CONFIG.$p.VALUE_SRC DEFAULT $si
    }
    foreach p $flow_prop {
      set_property CONFIG.$p.VALUE_SRC DEFAULT $mi
      set_property CONFIG.$p.VALUE_SRC DEFAULT $si
    }   
  } 
  if {[get_property CONFIG.INTERFACE_MODE $ip] == "SLAVE"  } {
     set wuser_bits_per_byte [get_property CONFIG.WUSER_BITS_PER_BYTE $si]
     set ruser_bits_per_byte [get_property CONFIG.RUSER_BITS_PER_BYTE $si]
     set wuser_width [get_property CONFIG.WUSER_WIDTH $si]
     set ruser_width [get_property CONFIG.RUSER_WIDTH $si]
     if { ($wuser_bits_per_byte > 0 && $ruser_bits_per_byte ==0 && $ruser_width >0 ) || ($ruser_bits_per_byte > 0 && $wuser_bits_per_byte ==0 && $wuser_width >0 ) } {
       puts " WARNING: WUSRE_BITS_PER_BYTE $wuser_bits_per_byte and RUSER_BITS_PER_BYTE $ruser_bits_per_byte are assymetric,propagation of WUSER_WIDTH and RUSER_WIDTH will fail"
    } else {
       set_property CONFIG.HAS_USER_BITS_PER_BYTE.VALUE_SRC DEFAULT $ip
       set_property -quiet CONFIG.HAS_USER_BITS_PER_BYTE 0 $ip
       set_property CONFIG.WUSER_WIDTH.VALUE_SRC DEFAULT $ip
       set_property CONFIG.RUSER_WIDTH.VALUE_SRC DEFAULT $ip
    }  
    foreach p {ADDR_WIDTH DATA_WIDTH PROTOCOL READ_WRITE_MODE} { 
      if {[get_property CONFIG.$p.VALUE_SRC $ip] != "USER" } {
          set_property CONFIG.$p.VALUE_SRC DEFAULT $si
      } 
    }
    set_property -quiet CONFIG.SUPPORTS_NARROW [get_property CONFIG.SUPPORTS_NARROW_BURST $si] $ip
    foreach p {ID_WIDTH AWUSER_WIDTH ARUSER_WIDTH WUSER_BITS_PER_BYTE RUSER_BITS_PER_BYTE  WUSER_WIDTH RUSER_WIDTH BUSER_WIDTH HAS_BURST HAS_CACHE HAS_REGION HAS_PROT HAS_QOS HAS_WSTRB HAS_BRESP HAS_RRESP HAS_LOCK} {
      set_property CONFIG.$p.VALUE_SRC DEFAULT $si
      set_property CONFIG.$p.VALUE_SRC DEFAULT $ip
    }   
  }  
}

proc propagate { cell_name prop_info } {
  set ip [get_bd_cells $cell_name]
  set si [get_bd_intf_pins $ip/S_AXI]
  set mi [get_bd_intf_pins $ip/M_AXI]
  set axiport {ADDR_WIDTH DATA_WIDTH ID_WIDTH AWUSER_WIDTH ARUSER_WIDTH WUSER_WIDTH RUSER_WIDTH BUSER_WIDTH READ_WRITE_MODE PROTOCOL WUSER_BITS_PER_BYTE RUSER_BITS_PER_BYTE SUPPORTS_NARROW HAS_BURST HAS_CACHE HAS_REGION HAS_PROT HAS_QOS HAS_WSTRB HAS_BRESP HAS_RRESP HAS_LOCK}
  set axiport_n {ADDR_WIDTH DATA_WIDTH ID_WIDTH AWUSER_WIDTH ARUSER_WIDTH BUSER_WIDTH READ_WRITE_MODE PROTOCOL HAS_BURST HAS_CACHE HAS_REGION HAS_PROT HAS_QOS HAS_WSTRB HAS_BRESP HAS_RRESP HAS_LOCK}
  set axiport_flow {ID_WIDTH AWUSER_WIDTH ARUSER_WIDTH BUSER_WIDTH  HAS_BURST HAS_CACHE HAS_REGION HAS_PROT HAS_QOS HAS_WSTRB HAS_BRESP HAS_RRESP HAS_LOCK}
  set axiport_bi {ADDR_WIDTH DATA_WIDTH READ_WRITE_MODE PROTOCOL}
  set flow_pss {MAX_BURST_LENGTH NUM_READ_THREADS NUM_WRITE_THREADS}
  ifx_puts "----------------------------------------------------------------------"
  ifx_puts "[info level [info level]]"
  ifx_validate_axi_interfaces $cell_name
  if {[get_property CONFIG.INTERFACE_MODE $ip] == "PASS_THROUGH"  } { 
    ifx_common_propagate $cell_name $axiport_bi
    ifx_common_propagate $cell_name {NUM_READ_OUTSTANDING NUM_WRITE_OUTSTANDING} {} {si mi} {mi si}
    # one direction
    set val [get_property CONFIG.SUPPORTS_NARROW_BURST $si]
    set_property -quiet CONFIG.SUPPORTS_NARROW $val $ip
    set_property CONFIG.SUPPORTS_NARROW_BURST $val $mi
    foreach p $axiport_flow {
      set val [get_property CONFIG.$p $si]
      set_property -quiet CONFIG.$p $val $ip
      set_property CONFIG.$p $val $mi
    }
    foreach p $flow_pss {
      set val [get_property CONFIG.$p $si]
      set_property CONFIG.$p $val $mi
    }
    ifx_puts  "---------------------------------------------BEFORE -------------------"
    ifx_dump_properties $cell_name $axiport
    set wuser_bits_per_byte [get_property CONFIG.WUSER_BITS_PER_BYTE $si]
    set ruser_bits_per_byte [get_property CONFIG.RUSER_BITS_PER_BYTE $si]
    set ruser [get_property CONFIG.RUSER_WIDTH $si]
    set wuser [get_property CONFIG.WUSER_WIDTH $si]
    set data [get_property CONFIG.DATA_WIDTH $si]
    set val [expr $wuser*8/$data]
    set val2 [expr $ruser*8/$data]
    set mod [expr $wuser*8%$data]
    if { $mod ==0 } {
      if {$val >32 || $val2 >32 } {
      set_property -quiet CONFIG.HAS_USER_BITS_PER_BYTE 0 $ip
      set_property -quiet CONFIG.WUSER_WIDTH $wuser $ip
      set_property -quiet CONFIG.RUSER_WIDTH $ruser $ip
      set_property  CONFIG.WUSER_WIDTH $wuser $mi
      set_property  CONFIG.RUSER_WIDTH $ruser $mi
      } else {  
      set_property -quiet CONFIG.HAS_USER_BITS_PER_BYTE 1 $ip
      set_property -quiet CONFIG.WUSER_BITS_PER_BYTE $val $ip
      set_property -quiet CONFIG.RUSER_BITS_PER_BYTE $val2 $ip
      set_property CONFIG.WUSER_BITS_PER_BYTE $val $mi
      set_property CONFIG.RUSER_BITS_PER_BYTE $val2 $mi
      }
    } else {
      set_property -quiet CONFIG.HAS_USER_BITS_PER_BYTE 0 $ip
      set_property -quiet CONFIG.WUSER_WIDTH $wuser $ip
      set_property -quiet CONFIG.RUSER_WIDTH $ruser $ip
      set_property  CONFIG.WUSER_WIDTH $wuser $mi
      set_property  CONFIG.RUSER_WIDTH $ruser $mi
    }

    ifx_puts  "--------------------------------------------------------------------"
    ifx_dump_properties $cell_name $axiport
  } elseif {[get_property CONFIG.INTERFACE_MODE $ip] == "SLAVE" } {
    ifx_common_propagate $cell_name $axiport_bi {} {si ip} {ip}
    set val [get_property CONFIG.SUPPORTS_NARROW_BURST $si]
    set_property CONFIG.SUPPORTS_NARROW.VALUE_SRC DEFAULT $ip
    set_property -quiet CONFIG.SUPPORTS_NARROW $val $ip
    foreach p $axiport_flow {
      set val [get_property CONFIG.$p $si]
      set_property -quiet CONFIG.$p $val $ip
    }
    ifx_puts  "---------------------------------------------BEFORE -------------------"
    ifx_dump_properties $cell_name $axiport {} {si ip} 
    set wuser_bits_per_byte [get_property CONFIG.WUSER_BITS_PER_BYTE $si]
    set ruser_bits_per_byte [get_property CONFIG.RUSER_BITS_PER_BYTE $si]
    set ruser [get_property CONFIG.RUSER_WIDTH $si]
    set wuser [get_property CONFIG.WUSER_WIDTH $si]
    set data [get_property CONFIG.DATA_WIDTH $si]
    set val [expr $wuser*8/$data]
    set val2 [expr $ruser*8/$data]
    set mod [expr $wuser*8%$data]
    if { $mod ==0 } {
      if {$val >32 || $val2 >32 } {
      set_property -quiet CONFIG.HAS_USER_BITS_PER_BYTE 0 $ip
      set_property -quiet CONFIG.WUSER_WIDTH $wuser $ip
      set_property -quiet CONFIG.RUSER_WIDTH $ruser $ip
      } else {  
      set aa [get_property CONFIG.WUSER_BITS_PER_BYTE.VALUE_SRC $ip]
      set bb [get_property CONFIG.HAS_USER_BITS_PER_BYTE.VALUE_SRC $ip]
      set_property -quiet CONFIG.HAS_USER_BITS_PER_BYTE 1 $ip
      set_property -quiet CONFIG.WUSER_BITS_PER_BYTE $val $ip
      set_property -quiet CONFIG.RUSER_BITS_PER_BYTE $val2 $ip
      }
    } else {
      set_property  -quiet CONFIG.HAS_USER_BITS_PER_BYTE 0 $ip
      set_property  -quiet CONFIG.WUSER_WIDTH $wuser $ip
      set_property  -quiet CONFIG.RUSER_WIDTH $ruser $ip
    }
    ifx_puts  "--------------------------------------------------------------------"
    ifx_dump_properties $cell_name $axiport {} {si ip} 
  } else {
   ifx_common_propagate $cell_name $axiport {} {mi ip} {ip}
  } 
}

ifx_debug_trace_setup


