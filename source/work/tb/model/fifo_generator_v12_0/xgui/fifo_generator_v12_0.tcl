source_subcore_ipfile xilinx.com:ip:blk_mem_gen:8.2 "xgui/blk_mem_gen_v8_2_utils.tcl" 
source_ipfile  "xgui/fifo_generator_v12_0_utils.tcl" 

proc EvalSubstituting {parameters procedure {numlevels 1}} {
      set paramlist {}
      if {[string index $numlevels 0]!="#"} {
         set numlevels [expr $numlevels+1]
      }
      foreach parameter $parameters {
         upvar 1 $parameter $parameter\_value
         tcl::lappend paramlist \$$parameter [set $parameter\_value]
      }
      uplevel $numlevels [string map $paramlist $procedure]
}

proc getParentDeviceName {c_family} {
	set c_family [string tolower $c_family]
	if { [string equal -nocase $c_family "artix7"] 
			|| [string equal -nocase $c_family "artix7l"]
			 || [string equal -nocase $c_family "qartix7l"]
			 || [string equal -nocase $c_family "qartix7"]
			 || [string equal -nocase $c_family "aartix7"]} {
		set c_family "artix7"
	} elseif {  [string equal -nocase $c_family "kintex7"] 
			 || [string equal -nocase $c_family "kintex7l"]
			 || [string equal -nocase $c_family "qkintex7l"]
			 || [string equal -nocase $c_family "qkintex7"]} {
	   set c_family "kintex7"
	}  elseif {  [string equal -nocase $c_family "virtex7"] 
			 || [string equal -nocase $c_family "virtex7l"]
			 || [string equal -nocase $c_family "qvirtex7l"]
			 || [string equal -nocase $c_family "qvirtex7"]} {
	   set c_family "virtex7"
	} elseif {  [string equal -nocase $c_family "zynq"] 
			 || [string equal -nocase $c_family "azynq"]
			 || [string equal -nocase $c_family "qzynq"]
			 } {
	   set c_family "zynq"
	} elseif {  [string equal -nocase $c_family "virtexu"] 
			 || [string equal -nocase $c_family "kintexu"]
			 || [string equal -nocase $c_family "artixu"]
			 } {
	   set c_family "virtexu"
	}
	return $c_family
}
#get_Actual_Input_Fifo_Depth Family Fifo_Implementation Performance_Options Read_Faster Input_Width Input_Depth Output_Depth Enable_ECC Output_Width"
proc getfifo_channels_incl_axis {} {
	return { "axis" "wach" "wdch" "wrch" "rach" "rdch" }
}

set num_fifo_channels_incl_axis 6
set fifo_channels_incl_axis [getfifo_channels_incl_axis]

proc init_meta_params {IPINST} {
	add_meta_param $IPINST -name Calculated_Width_axis -type string
	add_meta_param $IPINST -name Calculated_Width_wach -type string
	add_meta_param $IPINST -name Calculated_Width_wdch -type string
	add_meta_param $IPINST -name Calculated_Width_wrch -type string
	add_meta_param $IPINST -name Calculated_Width_rach -type string
	add_meta_param $IPINST -name Calculated_Width_rdch -type string
	add_meta_param $IPINST -name read_write_data_count_width -type list -value [list "false" "0"]
}

proc init_gui {IPINST PROJECT_PARAM.ARCHITECTURE} { 
#set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
#send_msg INFO 
	ipgui::add_param  $IPINST -parent $IPINST -name Component_Name 
	set page [ipgui::add_page $IPINST -parent $IPINST -name page -layout vertical]
	set_property display_name "Basic" $page
	set INTERFACE_TYPE [ipgui::add_param  $IPINST -parent $page -name INTERFACE_TYPE -layout horizontal ]
	set_property display_name "Interface Type" $INTERFACE_TYPE
	set Fifo_Implementation [ipgui::add_param  $IPINST -parent $page -name Fifo_Implementation ]
	set synchronization_stages [ipgui::add_param $IPINST -parent $page -name synchronization_stages -widget comboBox]
	set_property display_name "Synchronization Stages" $synchronization_stages
	set Fifo_Implementation_Options [ipgui::add_group $IPINST -parent $page -name "Fifo Implementation Options" ]
	set_property display_name "FIFO Implementation Options" $Fifo_Implementation_Options
	set LabelFifotext1 [ipgui::add_static_text  $IPINST -name LabelFifotext1 -parent  $Fifo_Implementation_Options -text "\t\t\t\t Supported Features\t"] 
	set table [ipgui::add_table $IPINST  -name "table" -rows "9" -columns "9" -parent $Fifo_Implementation_Options]
	set LabelFifotext2 [ipgui::add_static_text  $IPINST -name LabelFifotext2 -parent  $table -text "<b>        Read/Write\n       Clock Domains" -center_align true] 
	set LabelFifotext3 [ipgui::add_static_text  $IPINST -name LabelFifotext3 -parent  $table -text "<b>   Memory\n     Type" -center_align true] 
	set LabelFifotext4 [ipgui::add_static_text  $IPINST -name LabelFifotext4 -parent  $table -text "<b>\n       (1)" -center_align true] 
	set LabelFifotext5 [ipgui::add_static_text  $IPINST -name LabelFifotext5 -parent  $table -text "<b>\n       (2)" -center_align true] 
	set LabelFifotext6 [ipgui::add_static_text  $IPINST -name LabelFifotext6 -parent  $table -text "<b>\n       (3)" -center_align true] 
	set LabelFifotext7 [ipgui::add_static_text  $IPINST -name LabelFifotext7 -parent  $table -text "<b>\n       (4)" -center_align true] 
	set LabelFifotext8 [ipgui::add_static_text  $IPINST -name LabelFifotext8 -parent  $table -text "<b>\n       (5)" -center_align true] 
	set LabelFifotext9 [ipgui::add_dynamic_text  $IPINST -name LabelFifotext9 -parent  $table -tclproc updateOfLabelFifotext9  ]
	set LabelFifotext9a [ipgui::add_dynamic_text  $IPINST -name LabelFifotext9a -parent  $table -tclproc updateOfLabelFifotext9a ]
	set LabelFifotext9b [ipgui::add_dynamic_text  $IPINST -name LabelFifotext9b -parent  $table -tclproc updateOfLabelFifotext9b ]
	set LabelFifotext9c [ipgui::add_dynamic_text  $IPINST -name LabelFifotext9c -parent  $table -tclproc updateOfLabelFifotext9c ]
	set LabelFifotext10 [ipgui::add_dynamic_text  $IPINST -name LabelFifotext10 -parent  $table -tclproc updateOfLabelFifotext10 ]
	set LabelFifotext10a [ipgui::add_dynamic_text  $IPINST -name LabelFifotext10a -parent  $table -tclproc updateOfLabelFifotext10a ]
	set LabelFifotext10b [ipgui::add_dynamic_text  $IPINST -name LabelFifotext10b -parent  $table -tclproc updateOfLabelFifotext10b ]
	set LabelFifotext11 [ipgui::add_dynamic_text  $IPINST -name LabelFifotext11 -parent  $table  -tclproc updateOfLabelFifotext11]
	set LabelFifotext11a [ipgui::add_dynamic_text  $IPINST -name LabelFifotext11a -parent  $table  -tclproc updateOfLabelFifotext11a]
	set LabelFifotext12 [ipgui::add_dynamic_text  $IPINST -name LabelFifotext12 -parent  $table  -tclproc updateOfLabelFifotext12]
	set LabelFifotext12a [ipgui::add_dynamic_text  $IPINST -name LabelFifotext12a -parent  $table  -tclproc updateOfLabelFifotext12a]
	set LabelFifotext13 [ipgui::add_dynamic_text  $IPINST -name LabelFifotext13 -parent  $table  -tclproc updateOfLabelFifotext13]
	set LabelFifotext14 [ipgui::add_dynamic_text  $IPINST -name LabelFifotext14 -parent  $table -tclproc  updateOfLabelFifotext14]
	set LabelFifotext14a [ipgui::add_dynamic_text  $IPINST -name LabelFifotext14a -parent  $table -tclproc  updateOfLabelFifotext14a]
	set Independent_Clocks_Builtin_FIFO1 [ipgui::add_image  $IPINST -name Independent_Clocks_Builtin_FIFO1 -parent  $table -width 12 -height 12]
	set Common_Clock_Builtin_FIFO1 [ipgui::add_image  $IPINST -name Common_Clock_Builtin_FIFO1 -parent  $table -width 12 -height 12]
	set Independent_Clocks_Block_RAM1 [ipgui::add_image  $IPINST -name Independent_Clocks_Block_RAM1 -parent  $table -width 14 -height 14 ]
	set Common_Clock_Block_RAM1 [ipgui::add_image  $IPINST -name Common_Clock_Block_RAM1 -parent  $table -width 12 -height 12]
	set Common_Clock_Block_RAM2 [ipgui::add_image  $IPINST -name Common_Clock_Block_RAM2 -parent  $table -width 12 -height 12]
	set Common_Clock_Distributed_RAM2 [ipgui::add_image  $IPINST -name Common_Clock_Distributed_RAM2 -parent  $table -width 12 -height 12]
	set Common_Clock_Builtin_FIFO2 [ipgui::add_image  $IPINST -name Common_Clock_Builtin_FIFO2 -parent  $table -width 12 -height 12]
	set Independent_Clocks_Block_RAM2 [ipgui::add_image  $IPINST -name Independent_Clocks_Block_RAM2 -parent  $table -width 12 -height 12]
	set Independent_Clocks_Distributed_RAM2 [ipgui::add_image  $IPINST -name Independent_Clocks_Distributed_RAM2 -parent  $table -width 12 -height 12]
	set Independent_Clocks_Builtin_FIFO2 [ipgui::add_image  $IPINST -name Independent_Clocks_Builtin_FIFO2 -parent  $table -width 12 -height 12]
	set Common_Clock_Builtin_FIFO3 [ipgui::add_image  $IPINST -name Common_Clock_Builtin_FIFO3 -parent  $table -width 12 -height 12]
	set Independent_Clocks_Builtin_FIFO3 [ipgui::add_image  $IPINST -name Independent_Clocks_Builtin_FIFO3 -parent  $table -width 12 -height 12]
	set Common_Clock_Block_RAM4 [ipgui::add_image  $IPINST -name Common_Clock_Block_RAM4 -parent  $table -width 12 -height 12]
	set Common_Clock_Builtin_FIFO4 [ipgui::add_image  $IPINST -name Common_Clock_Builtin_FIFO4 -parent  $table -width 12 -height 12]
	set Independent_Clocks_Block_RAM4 [ipgui::add_image  $IPINST -name Independent_Clocks_Block_RAM4 -parent  $table -width 12 -height 12]
	set Independent_Clocks_Builtin_FIFO4 [ipgui::add_image  $IPINST -name Independent_Clocks_Builtin_FIFO4 -parent  $table -width 12 -height 12]
	set Common_Clock_Block_RAM5 [ipgui::add_image  $IPINST -name Common_Clock_Block_RAM5 -parent  $table -width 12 -height 12]
	set Common_Clock_Builtin_FIFO5 [ipgui::add_image  $IPINST -name Common_Clock_Builtin_FIFO5 -parent  $table -width 12 -height 12]
	set Independent_Clocks_Block_RAM5 [ipgui::add_image  $IPINST -name Independent_Clocks_Block_RAM5 -parent  $table -width 12 -height 12]
	set Independent_Clocks_Builtin_FIFO5 [ipgui::add_image  $IPINST -name Independent_Clocks_Builtin_FIFO5 -parent  $table -width 12 -height 12]
	foreach val {Independent_Clocks_Block_RAM1 Common_Clock_Block_RAM2 Common_Clock_Distributed_RAM2 Common_Clock_Builtin_FIFO2 
				Independent_Clocks_Block_RAM2 Independent_Clocks_Distributed_RAM2 Independent_Clocks_Builtin_FIFO2 
				Common_Clock_Builtin_FIFO3 Independent_Clocks_Builtin_FIFO3 Common_Clock_Block_RAM4 Common_Clock_Builtin_FIFO4
				Independent_Clocks_Block_RAM4 Independent_Clocks_Builtin_FIFO4 Common_Clock_Block_RAM5 Common_Clock_Builtin_FIFO5
				Independent_Clocks_Block_RAM5 Independent_Clocks_Builtin_FIFO5} {
		set_property load_image "xgui/CheckmarkGrey.png" [set $val]
	}
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
#send_msg INFO 911 "fam : $c_family "
	if { $c_family == "virtexu" } {
	
		set_property cell_location "0,0,1,2"  $LabelFifotext2 
		set_property cell_location "0,3,1,3"  $LabelFifotext3 
		set_property cell_location "0,4,1,4"  $LabelFifotext4 
		set_property cell_location "0,5,1,5"  $LabelFifotext5 
		set_property cell_location "0,6,1,6"  $LabelFifotext6 
		set_property cell_location "0,7,1,7"  $LabelFifotext7 
		set_property cell_location "0,8,1,8"  $LabelFifotext8 
		set_property cell_location "3,0,3,2"  $LabelFifotext9 
		set_property cell_location "4,0,4,2"  $LabelFifotext9a 
		set_property cell_location "5,0,5,2"  $LabelFifotext9b 
		set_property cell_location "2,0,2,2"  $LabelFifotext9c 
		set_property cell_location "7,0,7,2"  $LabelFifotext10 
		set_property cell_location "8,0,8,2"  $LabelFifotext10a 
		set_property cell_location "6,0,6,2"  $LabelFifotext10b 
		set_property cell_location "3,3"  $LabelFifotext11 
		set_property cell_location "4,3"  $LabelFifotext12
		set_property cell_location "5,3"  $LabelFifotext13
		set_property cell_location "2,3"  $LabelFifotext14
		set_property cell_location "7,3"  $LabelFifotext11a
		set_property cell_location "8,3"  $LabelFifotext12a
		set_property cell_location "6,3"  $LabelFifotext14a
		set_property cell_location "3,4"  $Common_Clock_Block_RAM2
		set_property cell_location "7,4"  $Independent_Clocks_Block_RAM1
		set_property cell_location "2,4"  $Common_Clock_Builtin_FIFO1
		set_property cell_location "6,4"  $Independent_Clocks_Builtin_FIFO1
		set_property cell_location "3,5"  $Common_Clock_Block_RAM2
		set_property cell_location "4,5"  $Common_Clock_Distributed_RAM2
		set_property cell_location "2,5"  $Common_Clock_Builtin_FIFO2
		set_property cell_location "7,5"  $Independent_Clocks_Block_RAM2
		set_property cell_location "8,5"  $Independent_Clocks_Distributed_RAM2
		set_property cell_location "6,5"  $Independent_Clocks_Builtin_FIFO2
		set_property cell_location "2,6"  $Common_Clock_Builtin_FIFO3
		set_property cell_location "6,6"  $Independent_Clocks_Builtin_FIFO3
		set_property cell_location "3,7"  $Common_Clock_Block_RAM4
		set_property cell_location "2,7"  $Common_Clock_Builtin_FIFO4
		set_property cell_location "7,7"  $Independent_Clocks_Block_RAM4
		set_property cell_location "6,7"  $Independent_Clocks_Builtin_FIFO4
		set_property cell_location "3,8"  $Common_Clock_Block_RAM5
		set_property cell_location "2,8"  $Common_Clock_Builtin_FIFO5
		set_property cell_location "7,8"  $Independent_Clocks_Block_RAM5
		set_property cell_location "6,8"  $Independent_Clocks_Builtin_FIFO5
	} else {
		set_property cell_location "0,0,1,2"  $LabelFifotext2 
		set_property cell_location "0,3,1,3"  $LabelFifotext3 
		set_property cell_location "0,4,1,4"  $LabelFifotext4 
		set_property cell_location "0,5,1,5"  $LabelFifotext5 
		set_property cell_location "0,6,1,6"  $LabelFifotext6 
		set_property cell_location "0,7,1,7"  $LabelFifotext7 
		set_property cell_location "0,8,1,8"  $LabelFifotext8 
		set_property cell_location "2,0,2,2"  $LabelFifotext9 
		set_property cell_location "3,0,3,2"  $LabelFifotext9a 
		set_property cell_location "4,0,4,2"  $LabelFifotext9b 
		set_property cell_location "5,0,5,2"  $LabelFifotext9c 
		set_property cell_location "6,0,6,2"  $LabelFifotext10 
		set_property cell_location "7,0,7,2"  $LabelFifotext10a 
		set_property cell_location "8,0,8,2"  $LabelFifotext10b 
		set_property cell_location "2,3"  $LabelFifotext11 
		set_property cell_location "3,3"  $LabelFifotext12
		set_property cell_location "4,3"  $LabelFifotext13
		set_property cell_location "5,3"  $LabelFifotext14
		set_property cell_location "6,3"  $LabelFifotext11a
		set_property cell_location "7,3"  $LabelFifotext12a
		set_property cell_location "8,3"  $LabelFifotext14a
		set_property cell_location "2,4"  $Common_Clock_Block_RAM1
		set_property cell_location "6,4"  $Independent_Clocks_Block_RAM1
		set_property cell_location "8,4"  $Independent_Clocks_Builtin_FIFO1
		set_property cell_location "5,4"  $Common_Clock_Builtin_FIFO1
		set_property cell_location "2,5"  $Common_Clock_Block_RAM2
		set_property cell_location "3,5"  $Common_Clock_Distributed_RAM2
		set_property cell_location "5,5"  $Common_Clock_Builtin_FIFO2
		set_property cell_location "6,5"  $Independent_Clocks_Block_RAM2
		set_property cell_location "7,5"  $Independent_Clocks_Distributed_RAM2
		set_property cell_location "8,5"  $Independent_Clocks_Builtin_FIFO2
		set_property cell_location "5,6"  $Common_Clock_Builtin_FIFO3
		set_property cell_location "8,6"  $Independent_Clocks_Builtin_FIFO3
		set_property cell_location "2,7"  $Common_Clock_Block_RAM4
		set_property cell_location "5,7"  $Common_Clock_Builtin_FIFO4
		set_property cell_location "6,7"  $Independent_Clocks_Block_RAM4
		set_property cell_location "8,7"  $Independent_Clocks_Builtin_FIFO4
		set_property cell_location "2,8"  $Common_Clock_Block_RAM5
		set_property cell_location "5,8"  $Common_Clock_Builtin_FIFO5
		set_property cell_location "6,8"  $Independent_Clocks_Block_RAM5
		set_property cell_location "8,8"  $Independent_Clocks_Builtin_FIFO5
	}
	ipgui::add_row $IPINST -parent $Fifo_Implementation_Options
	ipgui::add_row $IPINST -parent $Fifo_Implementation_Options
	ipgui::add_row $IPINST -parent $Fifo_Implementation_Options
	ipgui::add_static_text  $IPINST -name LabelFifo_ImplementationComment1 -parent  $Fifo_Implementation_Options -text "(1) Non-symmetric aspect ratios (different read and write data widths)"
	ipgui::add_static_text  $IPINST -name LabelFifo_ImplementationComment2 -parent  $Fifo_Implementation_Options -text "(2) First-Word Fall-Through"
	ipgui::add_static_text  $IPINST -name LabelFifo_ImplementationComment3 -parent  $Fifo_Implementation_Options -text "(3) Uses Built-in FIFO primitives"
	ipgui::add_static_text  $IPINST -name LabelFifo_ImplementationComment4 -parent  $Fifo_Implementation_Options -text "(4) ECC support"
	ipgui::add_static_text  $IPINST -name LabelFifo_ImplementationComment5 -parent  $Fifo_Implementation_Options -text "(5) Dynamic Error Injection"
	set_property visible false [ipgui::get_textspec LabelFifotext2 -of $IPINST]
	
	set Native_axi [ipgui::add_page $IPINST -parent $IPINST -name "Native Ports" -layout vertical]
	ipgui::add_param  $IPINST -parent $Native_axi -name Performance_Options -layout horizontal
	# set fifo_group [ipgui::add_group $IPINST -parent $Native_axi -name "Built-in FIFO Options" -layout vertical]
	# ipgui::add_static_text  $IPINST -name fifotext -parent  $fifo_group -text "The frequency relationship of WR_CLK and RD_CLK MUST be specified\nto generate the correct implementation"
	# ipgui::add_param  $IPINST -parent $Native_axi -name C_WR_FREQ
	# ipgui::add_param  $IPINST -parent $Native_axi -name C_RD_FREQ
	
	set Data_Port_Parameters [ipgui::add_group $IPINST -parent $Native_axi -name "Data Port Parameters" -layout horizontal]
	set asymmetric_port_width [ipgui::add_param $IPINST -name asymmetric_port_width -parent $Data_Port_Parameters ]
	set_property display_name "Asymmetric Port Width" $asymmetric_port_width
	set enable_low_latency [ipgui::add_param $IPINST -name enable_low_latency -parent $Data_Port_Parameters ]
	set_property display_name "	Low Latency " $enable_low_latency
	set use_dout_register [ipgui::add_param $IPINST -name use_dout_register -parent $Data_Port_Parameters ]
	set_property display_name " Output Register " $use_dout_register
	
	set_property tooltip "Selecting this option provides the use of asymmetric port width" $asymmetric_port_width
	if { $c_family == "virtexu" } {
	set_property visible true [ipgui::get_guiparamspec asymmetric_port_width -of $IPINST ]
	} else {
	set_property visible false [ipgui::get_guiparamspec asymmetric_port_width -of $IPINST ]
	 }
	ipgui::add_row $IPINST -parent $Data_Port_Parameters
	ipgui::add_static_text  $IPINST -name LabelInput_Data_Width -parent  $Data_Port_Parameters -text "Write Width"
	ipgui::add_param  $IPINST -parent $Data_Port_Parameters -name Input_Data_Width -show_label false
	ipgui::add_dynamic_text  $IPINST -name RangeInput_Data_Width -parent  $Data_Port_Parameters -tclproc "input_data_width_updated" 
	ipgui::add_row $IPINST -parent $Data_Port_Parameters
	ipgui::add_param  $IPINST -parent $Data_Port_Parameters -name Input_Depth
	ipgui::add_static_text  $IPINST -name LabelFifotext21 -parent  $Data_Port_Parameters -text "Actual Write Depth:"
	ipgui::add_dynamic_text $IPINST -name Actual_Write_Depth -parent $Data_Port_Parameters -tclproc "Actual_Write_Depth_updated"
	ipgui::add_row $IPINST -parent $Data_Port_Parameters
	ipgui::add_param  $IPINST -parent $Data_Port_Parameters -name Output_Data_Width -widget comboBox
	ipgui::add_row $IPINST -parent $Data_Port_Parameters
	set LabelOutput_Depth [ipgui::add_static_text  $IPINST -name LabelOutput_Depth -parent  $Data_Port_Parameters -text "Read Depth"]
	set_property enabled false $LabelOutput_Depth
	set Output_Depth [ipgui::add_param  $IPINST -parent $Data_Port_Parameters -name Output_Depth  -show_label false]
	ipgui::add_static_text  $IPINST -name LabelFifotext22 -parent  $Data_Port_Parameters -text "Actual Read Depth:"
	ipgui::add_dynamic_text $IPINST -name Actual_Read_Depth -parent $Data_Port_Parameters -tclproc "Actual_Read_Depth_updated"
	set Error_Injection [ipgui::add_group $IPINST -parent $Native_axi -name "Error Injection" -layout horizontal]
	set_property display_name "ECC, Output Register and Power Gating Options" $Error_Injection
	ipgui::add_param  $IPINST -parent $Error_Injection -name Enable_ECC
	ipgui::add_param  $IPINST -parent $Error_Injection -name Inject_Sbit_Error
	ipgui::add_param  $IPINST -parent $Error_Injection -name Inject_Dbit_Error
	ipgui::add_row $IPINST -parent $Error_Injection
	set ecc_pipeline_reg [ipgui::add_param  $IPINST -parent $Error_Injection -name ecc_pipeline_reg]
	set_property display_name "ECC Pipeline Reg" $ecc_pipeline_reg
	set dynamic_power_saving [ipgui::add_param $IPINST -parent $Error_Injection -name dynamic_power_saving]
	set_property display_name "Dynamic Power Gating" $dynamic_power_saving
	
	set uerPanel [ipgui::add_panel $IPINST -parent $Error_Injection -name uerPanel ]
	ipgui::add_param  $IPINST -parent $uerPanel -name Use_Embedded_Registers
	
	set Initialization [ipgui::add_group $IPINST -parent $Native_axi -name "Initialization" -layout horizontal]
	ipgui::add_param  $IPINST -parent $Initialization -name Reset_Pin
	ipgui::add_param  $IPINST -parent $Initialization -name Enable_Reset_Synchronization
	ipgui::add_row $IPINST -parent $Initialization
	set Reset_Type [ipgui::add_param  $IPINST -parent $Initialization -name Reset_Type -widget comboBox] 
#	if { $c_family == "virtexu" } {
#		set_property visible false $Reset_Type
#	} else {
#		set_property visible true $Reset_Type
#	}
	ipgui::add_row $IPINST -parent $Initialization
	ipgui::add_param  $IPINST -parent $Initialization -name Full_Flags_Reset_Value -widget comboBox
	ipgui::add_row $IPINST -parent $Initialization
	set Use_Dout_Reset [ipgui::add_param  $IPINST -parent $Initialization -name Use_Dout_Reset]
	set_property display_name "Dout Reset Value" $Use_Dout_Reset
	ipgui::add_param  $IPINST -parent $Initialization -name Dout_Reset_Value -show_label false
	ipgui::add_static_text  $IPINST -name LabelFifotext24 -parent  $Initialization -text "(Hex)" 
	ipgui::add_static_text  $IPINST -name Labelprevious24 -parent  $Initialization -text "Previous dout Value" -display_border true
	ipgui::add_dynamic_text $IPINST -name Latency2 -parent $Native_axi -tclproc "Latency2_updated"

	
	
	set page1_AXI_FIFO $page
	set AXI4_Interface_Options [ipgui::add_group $IPINST -parent $page1_AXI_FIFO -name "AXI Memory Mapped Interface Options" -layout horizontal]
	ipgui::add_param  $IPINST -parent $AXI4_Interface_Options -name PROTOCOL -layout horizontal
	ipgui::add_row $IPINST -parent $AXI4_Interface_Options
	ipgui::add_param  $IPINST -parent $AXI4_Interface_Options -name READ_WRITE_MODE -layout horizontal
	set Clock [ipgui::add_group $IPINST -parent $page1_AXI_FIFO -name "Clocking Options" -layout horizontal]
	ipgui::add_param  $IPINST -parent $Clock -name Clock_Type_AXI -layout horizontal
	ipgui::add_row $IPINST -parent $Clock
	set HAS_ACLKEN [ipgui::add_param  $IPINST -parent $Clock -name HAS_ACLKEN ]
	set_property display_name "HAS ACLKEN" $HAS_ACLKEN
	#set_property visible false $HAS_ACLKEN
	ipgui::add_row $IPINST -parent $Clock
	set Clock_Enable_Type [ipgui::add_param  $IPINST -parent $Clock -name Clock_Enable_Type -layout horizontal ]
	#set_property visible false $Clock_Enable_Type
	# set Synchronizer_Option_axi [ipgui::add_group $IPINST -parent $page1_AXI_FIFO -name "Synchronizer_Option_axi" ]
	# set_property display_name "Synchronizer Option" $Synchronizer_Option_axi
	set synchronization_stages_axi [ipgui::add_param $IPINST -parent $page1_AXI_FIFO -name synchronization_stages_axi -widget comboBox]
	set_property display_name "Synchronization Stages across Cross Clock Domain Logic" $synchronization_stages_axi
	
	set page4_FIFO [ipgui::add_page $IPINST -parent $IPINST -name page4_FIFO -layout vertical]
	set_property display_name "Status Flags" $page4_FIFO
	set Optional_Flags [ipgui::add_group $IPINST -parent $page4_FIFO -name "Optional Flags" -layout horizontal ]
	ipgui::add_param  $IPINST -parent $Optional_Flags -name Almost_Full_Flag
	ipgui::add_param  $IPINST -parent $Optional_Flags -name Almost_Empty_Flag
	set groupboxBuilt_in [ipgui::add_group $IPINST -parent $page4_FIFO -name "Built-in FIFO Options" ]
	ipgui::add_dynamic_text $IPINST -name LabelRead_Clock_FrequencyDescription -parent $groupboxBuilt_in -tclproc "LabelRead_Clock_FrequencyDescription_updated"
	ipgui::add_param  $IPINST -parent $groupboxBuilt_in -name Read_Clock_Frequency
	ipgui::add_param  $IPINST -parent $groupboxBuilt_in -name Write_Clock_Frequency
	# set_property visible false $groupboxBuilt_in
	# set builtin_fifo_faster_clock [ipgui::add_param  $IPINST -parent $page4_FIFO -name builtin_fifo_faster_clock -layout horizontal]
	# set_property display_name "Built-in FIFO Option" $builtin_fifo_faster_clock
	# set_property description "The frequency relationship of WR_CLK and RD_CLK MUST be specified to generate the\ncorrect implementation" $builtin_fifo_faster_clock
	
	set Handshaking_Options [ipgui::add_group $IPINST -parent $page4_FIFO -name "Handshaking Options"]
	set Write_Port_Handshaking [ipgui::add_group $IPINST -parent $Handshaking_Options -name "Write Port Handshaking" -layout horizontal ]
	set Write_Acknowledge_Flag [ipgui::add_param  $IPINST -parent $Write_Port_Handshaking -name Write_Acknowledge_Flag]
	set_property display_name "Write Acknowledge" $Write_Acknowledge_Flag
	ipgui::add_param  $IPINST -parent $Write_Port_Handshaking -name Write_Acknowledge_Sense -show_label false -widget comboBox
	set Overflow_Flag [ipgui::add_param  $IPINST -parent $Write_Port_Handshaking -name Overflow_Flag ]
	set_property display_name "Overflow" $Overflow_Flag
	ipgui::add_param  $IPINST -parent $Write_Port_Handshaking -name Overflow_Sense 	-show_label false -widget comboBox

	set Read_Port_Handshaking [ipgui::add_group $IPINST -parent $Handshaking_Options -name "Read Port Handshaking" -layout horizontal ]
	set Valid_Flag [ipgui::add_param  $IPINST -parent $Read_Port_Handshaking -name Valid_Flag]
	ipgui::add_param  $IPINST -parent $Read_Port_Handshaking -name Valid_Sense -show_label false -widget comboBox
	ipgui::add_param  $IPINST -parent $Read_Port_Handshaking -name Underflow_Flag
	ipgui::add_param  $IPINST -parent $Read_Port_Handshaking -name Underflow_Sense -show_label false -widget comboBox
	
	
	set Programmable_Flags [ipgui::add_group $IPINST -parent $page4_FIFO -name "Programmable Flags" ]
	ipgui::add_param  $IPINST -parent $Programmable_Flags -name Programmable_Full_Type -widget comboBox
	ipgui::add_param  $IPINST -parent $Programmable_Flags -name Full_Threshold_Assert_Value 
	set Full_Threshold_Negate_Value [ipgui::add_param  $IPINST -parent $Programmable_Flags -name Full_Threshold_Negate_Value]
	set_property display_name "Full Threshold Negate Value" $Full_Threshold_Negate_Value 
	ipgui::add_row $IPINST -parent $Programmable_Flags
	ipgui::add_param  $IPINST -parent $Programmable_Flags -name Programmable_Empty_Type -widget comboBox
	ipgui::add_param  $IPINST -parent $Programmable_Flags -name Empty_Threshold_Assert_Value
	ipgui::add_param  $IPINST -parent $Programmable_Flags -name Empty_Threshold_Negate_Value
	
	
	
	set page6_FIFO [ipgui::add_page $IPINST -parent $IPINST -name page6_FIFO -layout vertical]
	set_property display_name "Data Counts" $page6_FIFO
	set Data_Count_Options [ipgui::add_group $IPINST -parent $page6_FIFO -name "Data Count Options"]
	ipgui::add_param  $IPINST -parent $Data_Count_Options -name Use_Extra_Logic
	ipgui::add_param  $IPINST -parent $Data_Count_Options -name Data_Count
	ipgui::add_param  $IPINST -parent $Data_Count_Options -name Data_Count_Width
	ipgui::add_param  $IPINST -parent $Data_Count_Options -name Write_Data_Count
	ipgui::add_param  $IPINST -parent $Data_Count_Options -name Write_Data_Count_Width
	ipgui::add_param  $IPINST -parent $Data_Count_Options -name Read_Data_Count
	ipgui::add_param  $IPINST -parent $Data_Count_Options -name Read_Data_Count_Width
	
	set SimulationGroupBox [ipgui::add_group $IPINST -parent $page6_FIFO -name "Simulation Options"]
	ipgui::add_param  $IPINST -parent $SimulationGroupBox -name Disable_Timing_Violations
	set_property visible false $SimulationGroupBox
	
	
	page_page1_AXI_FULL_LITE $IPINST
	page_page1_AXI_STREAMING_FIFO $IPINST
	page_AXI_Pages $IPINST
	page_page3_AXI_FIFO $IPINST
	page_page7_FIFO $IPINST
	page_page3_AXI_STREAMING_FIFO $IPINST
	page_page4_AXI_FIFO $IPINST
	page_page5_AXI_FIFO $IPINST
	
	set XPG_LeftCanvas [ipgui::get_canvasspec -of $IPINST ]
	set_property hide_disabled_pins true $XPG_LeftCanvas
	
	
	#################################################################
	#
	# parameters set depending of the family
	#
	#################################################################
	
	setToolTips $IPINST
	setDisplayNames $IPINST
	device_parameters_settings $IPINST $c_family
	
}


	
proc setToolTips {IPINST} {
set_property tooltip "Defines the number of synchronizer stages across the cross clock domain logic" [ipgui::get_guiparamspec synchronization_stages -of $IPINST]	  
set_property tooltip "Defines the number of synchronizer stages across the cross clock domain logic" [ipgui::get_guiparamspec synchronization_stages_axi -of $IPINST]	  
set_property tooltip "Indicates the component name of the generated FIFO core" [ipgui::get_guiparamspec Component_Name               -of $IPINST] 
set_property tooltip "Select FIFO Implementation Type based on desired feature set." [ipgui::get_guiparamspec Fifo_Implementation          -of $IPINST] 
set_property tooltip "Suggested selection for best performance, power and area is:Shift Register for shallow (&lt;=32) depth with common clock,Distributed RAM for Shallow (&lt;= 128) depth,Built-in FIFO for Deep (&gt;128) depths" [ipgui::get_tablespec table -of $IPINST]
set_property tooltip "The standard read mode provides the user data on the cycle after it was requested.  The First-Word-Fall-Through read mode provides the user data on the same cycle in which it is requested." [ipgui::get_guiparamspec Performance_Options          -of $IPINST] 
set_property tooltip "Depending on the clock frequencies, the most optimal implementation is generated. If an incorrect value is entered, the core flags may not behave correctly." [ipgui::get_guiparamspec Read_Clock_Frequency  -of $IPINST] 
set_property tooltip "Depending on the clock frequencies, the most optimal implementation is generated. If an incorrect value is entered, the core flags may not behave correctly." [ipgui::get_guiparamspec Write_Clock_Frequency  -of $IPINST] 
set_property tooltip  "Select width of the Input/Write data port." [ipgui::get_guiparamspec Input_Data_Width             -of $IPINST] 
set_property tooltip  "Select memory depth of the Input/Write data port. See the summary page for actual input depth, which may differ from this value." [ipgui::get_guiparamspec Input_Depth                  -of $IPINST] 
set_property tooltip "Select width of the Output/Read data port (only selectable when using Independent Clock/Block RAM implementation)." [ipgui::get_guiparamspec Output_Data_Width            -of $IPINST] 
set_property tooltip "Auto-calculated memory depth of the Output/Read data port. See the summary page for actual output depth, which may differ from this value." [ipgui::get_guiparamspec Output_Depth                 -of $IPINST] 
set_property tooltip "Potential Collision Issue for ECC Mode, refer \"Conflict Avoidance\" section in 7 Series FPGAs Memory Resources user guide (ug473)" [ipgui::get_guiparamspec Enable_ECC                   -of $IPINST] 
set_property tooltip "Enabling this feature will add a pipeline register to the DOUT and VALID port of the FIFO (Standard Block RAM FIFOs and all Built-in FIFOs)" [ipgui::get_guiparamspec Use_Embedded_Registers       -of $IPINST] 
set_property tooltip "Disable timing violation messages on cross clock domain registers when enabled.  Turn off setup and hold time violations.  Only applicable to non built-in, independent clock FIFOs and when using asynchronous resets" [ipgui::get_guiparamspec Disable_Timing_Violations    -of $IPINST] 
set_property tooltip "Flag indicating 1 word from full" [ipgui::get_guiparamspec Almost_Full_Flag             -of $IPINST] 
set_property tooltip "Flag indicating 1 word from empty" [ipgui::get_guiparamspec Almost_Empty_Flag            -of $IPINST] 
set_property tooltip "Flag indicating valid data on DOUT bus" [ipgui::get_guiparamspec Valid_Flag                   -of $IPINST] 
set_property tooltip "Flag indicating an invalid read operation (underflow)" [ipgui::get_guiparamspec Underflow_Flag               -of $IPINST] 
set_property tooltip "Flag indicating a successful write operation" [ipgui::get_guiparamspec Write_Acknowledge_Flag       -of $IPINST] 
set_property tooltip "Flag indicating an invalid write operation (overflow)" [ipgui::get_guiparamspec Overflow_Flag                -of $IPINST] 
set_property tooltip "Injects a single bit error in memory cell during a write operation" [ipgui::get_guiparamspec Inject_Sbit_Error            -of $IPINST] 
set_property tooltip "Injects a double bit error in memory cell during a write operation" [ipgui::get_guiparamspec Inject_Dbit_Error            -of $IPINST] 
set_property tooltip "Asynchronous or Synchronous reset that initializes all internal pointers, flags and output" [ipgui::get_guiparamspec Reset_Pin                    -of $IPINST] 
set_property tooltip "Determines whether to use reset synchronization or not. If set, RST is synchronized inside the core with respective clock domains and used" [ipgui::get_guiparamspec Enable_Reset_Synchronization -of $IPINST] 
set_property tooltip "Asynchronous reset is available for all Common Clock and Independent Clock FIFOs. Synchronous reset is available only for Common Clock Block RAM/Distributed RAM/Shift RAM FIFOs." [ipgui::get_guiparamspec Reset_Type                   -of $IPINST] 
set_property tooltip "User-programmable full flag" [ipgui::get_guiparamspec Programmable_Full_Type       -of $IPINST] 
set_property tooltip "Programmable Full will assert when number of words in the FIFO is greater than or equal to this value" [ipgui::get_guiparamspec Full_Threshold_Assert_Value  -of $IPINST] 
set_property tooltip "Programmable Full will only deassert if number of words in the FIFO is less than this value" [ipgui::get_guiparamspec Full_Threshold_Negate_Value  -of $IPINST] 
set_property tooltip "User-programmable empty flag" [ipgui::get_guiparamspec Programmable_Empty_Type      -of $IPINST] 
set_property tooltip "Programmable Empty will assert when number of words in the FIFO is less than or equal to this value" [ipgui::get_guiparamspec Empty_Threshold_Assert_Value -of $IPINST] 
set_property tooltip "Programmable Empty will only deassert if number of words in the FIFO is greater than this value" [ipgui::get_guiparamspec Empty_Threshold_Negate_Value -of $IPINST] 
set_property tooltip "Produces a more precise data count (DATA_COUNT/RD_DATA_COUNT/ WR_DATA_COUNT) when First-Word-Fall-Through (Read Latency 0) is selected.  For more detail, see Data Count section in the Product Guide" [ipgui::get_guiparamspec Use_Extra_Logic              -of $IPINST] 
set_property tooltip "Provides the number of words in the FIFO (Fullness)" [ipgui::get_guiparamspec Data_Count                   -of $IPINST] 
set_property tooltip "Width of the DATA_COUNT port.  If the width specified is smaller than the maximum allowable width, the bus is truncated with the lower bits removed.  By trimming the width, users can generate quarter full, half full and three-quarter full flags.  See Data Count section in Product Guide."  [ipgui::get_guiparamspec Data_Count_Width             -of $IPINST] 
set_property tooltip "Provides an estimate of the number of words in the FIFO (Fullness).  From this value, the user can gauge the number of empty FIFO slots that can be written to.  Write Data Count is guaranteed to never under-report" [ipgui::get_guiparamspec Write_Data_Count             -of $IPINST] 
set_property tooltip "Width of WR_DATA_COUNT.  If the width specified is smaller than the maximum allowable width, the bus is truncated with the lower bits removed.  By trimming the width, users can generate quarter full, half full and three-quarter full flags.  See Data Count section in Product Guide"  [ipgui::get_guiparamspec Write_Data_Count_Width       -of $IPINST] 
set_property tooltip "Provides an estimate of the number of words in the FIFO (Fullness) available for reading.  Read Data Count is guaranteed to never over-report"  [ipgui::get_guiparamspec Read_Data_Count              -of $IPINST] 
set_property tooltip "Width of RD_DATA_COUNT.  If the width specified is smaller than the maximum allowable width, the bus is truncated with the lower bits removed.  By trimming the width, users can generate quarter empty, half empty and three-quarter empty flags.  See Data Count section in Product Guide."  [ipgui::get_guiparamspec Read_Data_Count_Width        -of $IPINST] 
set_property tooltip "When feature is available, it sets the value on the DOUT bus during reset.  When feature is disabled, DOUT value during reset is undetermined.The width of the value specified should not be greater than Read Width"  [ipgui::get_guiparamspec Dout_Reset_Value             -of $IPINST] 
set_property tooltip "Sets the value of FULL, ALMOST_FULL and PROG_FULL on assertion of reset."  [ipgui::get_guiparamspec Full_Flags_Reset_Value       -of $IPINST] 
set_property tooltip "Determines whether DOUT resets to the Dout Reset Value when reset is asserted."  [ipgui::get_guiparamspec Use_Dout_Reset               -of $IPINST] 
set_property tooltip "Width is determined by aggregating\nall of the Channel Information Signals\nin a particular Channel. Channel\nInformation includes all signals in the\nrespective Channel excluding VALID\nand READY handshake signals"  [ipgui::get_guiparamspec ID_WIDTH               -of $IPINST] 
set_property tooltip "Width is determined by aggregating\nall of the Channel Information Signals\nin a particular Channel. Channel\nInformation includes all signals in the\nrespective Channel excluding VALID\nand READY handshake signals"  [ipgui::get_guiparamspec ADDRESS_WIDTH               -of $IPINST] 
set_property tooltip "Width is determined by aggregating\nall of the Channel Information Signals\nin a particular Channel. Channel\nInformation includes all signals in the\nrespective Channel excluding VALID\nand READY handshake signals"  [ipgui::get_guiparamspec DATA_WIDTH               -of $IPINST] 
set_property tooltip "Width is determined by aggregating\nall of the Channel Information Signals\nin a particular Channel. Channel\nInformation includes all signals in the\nrespective Channel excluding VALID\nand READY handshake signals"  [ipgui::get_guiparamspec AWUSER_Width               -of $IPINST] 
set_property tooltip "Width is determined by aggregating\nall of the Channel Information Signals\nin a particular Channel. Channel\nInformation includes all signals in the\nrespective Channel excluding VALID\nand READY handshake signals"  [ipgui::get_guiparamspec WUSER_Width               -of $IPINST] 
set_property tooltip "Width is determined by aggregating\nall of the Channel Information Signals\nin a particular Channel. Channel\nInformation includes all signals in the\nrespective Channel excluding VALID\nand READY handshake signals"  [ipgui::get_guiparamspec BUSER_Width               -of $IPINST] 
set_property tooltip "Width is determined by aggregating\nall of the Channel Information Signals\nin a particular Channel. Channel\nInformation includes all signals in the\nrespective Channel excluding VALID\nand READY handshake signals"  [ipgui::get_guiparamspec ARUSER_Width               -of $IPINST] 
set_property tooltip "Width is determined by aggregating\nall of the Channel Information Signals\nin a particular Channel. Channel\nInformation includes all signals in the\nrespective Channel excluding VALID\nand READY handshake signals"  [ipgui::get_guiparamspec RUSER_Width               -of $IPINST] 
set_property tooltip "Width is determined by aggregating\nall of the Channel Information Signals\nfor AXI4-Stream Interface. Channel\nInformation includes all AXI4-Stream\nsignals excluding TVALID and TREADY\nhandshake signals"  [ipgui::get_guiparamspec TDATA_NUM_BYTES               -of $IPINST] 
set_property tooltip "Width is determined by aggregating\nall of the Channel Information Signals\nfor AXI4-Stream Interface. Channel\nInformation includes all AXI4-Stream\nsignals excluding TVALID and TREADY\nhandshake signals"  [ipgui::get_guiparamspec TID_WIDTH               -of $IPINST] 
set_property tooltip "Width is determined by aggregating\nall of the Channel Information Signals\nfor AXI4-Stream Interface. Channel\nInformation includes all AXI4-Stream\nsignals excluding TVALID and TREADY\nhandshake signals"  [ipgui::get_guiparamspec TDEST_WIDTH               -of $IPINST] 
set_property tooltip "Width is determined by aggregating\nall of the Channel Information Signals\nfor AXI4-Stream Interface. Channel\nInformation includes all AXI4-Stream\nsignals excluding TVALID and TREADY\nhandshake signals"  [ipgui::get_guiparamspec TUSER_WIDTH               -of $IPINST] 
set_property tooltip "Width is determined by aggregating\nall of the Channel Information Signals\nfor AXI4-Stream Interface. Channel\nInformation includes all AXI4-Stream\nsignals excluding TVALID and TREADY\nhandshake signals"  [ipgui::get_guiparamspec TSTRB_WIDTH               -of $IPINST] 
set_property tooltip "Width is determined by aggregating\nall of the Channel Information Signals\nfor AXI4-Stream Interface. Channel\nInformation includes all AXI4-Stream\nsignals excluding TVALID and TREADY\nhandshake signals"  [ipgui::get_guiparamspec TKEEP_WIDTH               -of $IPINST] 
set_property tooltip "Width is determined by aggregating\nall of the Channel Information Signals\nfor AXI4-Stream Interface. Channel\nInformation includes all AXI4-Stream\nsignals excluding TVALID and TREADY\nhandshake signals"  [ipgui::get_guiparamspec Enable_TREADY               -of $IPINST] 
set_property tooltip "Width is determined by aggregating\nall of the Channel Information Signals\nfor AXI4-Stream Interface. Channel\nInformation includes all AXI4-Stream\nsignals excluding TVALID and TREADY\nhandshake signals"  [ipgui::get_guiparamspec Enable_TLAST               -of $IPINST] 
set_property tooltip "Width is determined by aggregating\nall of the Channel Information Signals\nfor AXI4-Stream Interface. Channel\nInformation includes all AXI4-Stream\nsignals excluding TVALID and TREADY\nhandshake signals"  [ipgui::get_guiparamspec HAS_TSTRB               -of $IPINST] 
set_property tooltip "Width is determined by aggregating\nall of the Channel Information Signals\nfor AXI4-Stream Interface. Channel\nInformation includes all AXI4-Stream\nsignals excluding TVALID and TREADY\nhandshake signals"  [ipgui::get_guiparamspec HAS_TKEEP               -of $IPINST] 
set_property tooltip "Determines if the core uses Clock Enable. Clock enable is ANDed with VALID on slave side and ANDed with READY on master side, and then used inside the core"  [ipgui::get_guiparamspec HAS_ACLKEN              -of $IPINST] 
set_property tooltip "Determines if the core uses Slave Clock Enable or Master Clock Enable"  [ipgui::get_guiparamspec Clock_Enable_Type       -of $IPINST] 
set_property tooltip "Select the type of FIFO needed (Synchronous or Asynchronous FIFO)"  [ipgui::get_guiparamspec Clock_Type_AXI       -of $IPINST] 
set_property tooltip "Select the required Memory Mapped Protocol"  [ipgui::get_guiparamspec PROTOCOL       -of $IPINST] 
set_property tooltip "Select the required AXI Channel; Write Only Channels (AW, W and B) or Read Only Channels (AR and R) or Both Write and Read Channels (AW. W, B, AR and R)"  [ipgui::get_guiparamspec READ_WRITE_MODE -of $IPINST] 
set_property tooltip "Selecting this option adds a pipeline register in the ECC path."  [ipgui::get_guiparamspec ecc_pipeline_reg -of $IPINST] 
set_property tooltip "Selecting this option provides the use of dynamic power saving in BRAM/Built-in FIFO."  [ipgui::get_guiparamspec dynamic_power_saving -of $IPINST] 
set_property tooltip "Selecting this option reduces the latency to be one primitive level and the Programmable Full/Empty options are not available."  [ipgui::get_guiparamspec enable_low_latency -of $IPINST] 
set_property tooltip "Selecting this option improves the performance. However, it increases the slice count approximately by Read Width/2."  [ipgui::get_guiparamspec use_dout_register -of $IPINST] 
}

proc setDisplayNames {IPINST} {
	set fifo_channels_incl_axis [getfifo_channels_incl_axis]
	
	set_property display_name "Read Mode" [ipgui::get_guiparamspec Performance_Options -of $IPINST]
	set_property display_name "Underflow Flag" [ipgui::get_guiparamspec Underflow_Flag_AXI -of $IPINST]
	set_property tooltip "Flag indicating an invalid read operation" [ipgui::get_guiparamspec Underflow_Flag_AXI -of $IPINST]
	set_property display_name "Underflow (Read Error)" [ipgui::get_guiparamspec Underflow_Sense_AXI -of $IPINST]
	set_property display_name "Underflow (Read Error)" [ipgui::get_guiparamspec Underflow_Sense -of $IPINST]
	set_property display_name "Overflow Flag" [ipgui::get_guiparamspec Overflow_Flag_AXI -of $IPINST]
	set_property tooltip "Flag indicating an invalid write operation" [ipgui::get_guiparamspec Overflow_Flag_AXI -of $IPINST]
	set_property display_name "Overflow (Write Error)" [ipgui::get_guiparamspec Overflow_Sense_AXI -of $IPINST]
	set_property display_name "Overflow (Write Error)" [ipgui::get_guiparamspec Overflow_Sense -of $IPINST]
	set_property display_name "Valid (Read Acknowledge)" [ipgui::get_guiparamspec Valid_Sense -of $IPINST]
	set_property display_name "Single Bit Error Injection" [ipgui::get_guiparamspec Inject_Sbit_Error -of $IPINST]
	set_property display_name "Double Bit Error Injection" [ipgui::get_guiparamspec Inject_Dbit_Error -of $IPINST]
	set_property display_name "More Accurate Data Counts" [ipgui::get_guiparamspec Use_Extra_Logic -of $IPINST]
	set_property display_name "Data Count" [ipgui::get_guiparamspec Data_Count -of $IPINST]
	set_property display_name "Write Data Count (Synchronized with Write Clk)" [ipgui::get_guiparamspec Write_Data_Count -of $IPINST]
	set_property display_name "Read Data Count (Synchronized with Read Clk)" [ipgui::get_guiparamspec Read_Data_Count -of $IPINST]
	set_property display_name "Disable timing violations on cross clock domain registers" [ipgui::get_guiparamspec Disable_Timing_Violations -of $IPINST]
	set_property display_name "Disable timing violations on cross clock domain registers" [ipgui::get_guiparamspec Disable_Timing_Violations_AXI -of $IPINST]
	set_property display_name "Address Width" [ipgui::get_guiparamspec ADDRESS_WIDTH -of $IPINST]
	set_property display_name "Data Width" [ipgui::get_guiparamspec DATA_WIDTH -of $IPINST]
	set_property display_name "HAS TKEEP" [ipgui::get_guiparamspec HAS_TKEEP -of $IPINST]
	set_property display_name "TREADY" [ipgui::get_guiparamspec Enable_TREADY -of $IPINST]
	set_property display_name "TLAST" [ipgui::get_guiparamspec Enable_TLAST -of $IPINST]
	set_property display_name "Embedded Registers" [ipgui::get_guiparamspec Use_Embedded_Registers -of $IPINST]
	set_property display_name "ECC" [ipgui::get_guiparamspec Enable_ECC -of $IPINST]
	set_property display_name "Write Depth" [ipgui::get_guiparamspec Input_Depth -of $IPINST]
	set_property display_name "Read Width" [ipgui::get_guiparamspec Output_Data_Width -of $IPINST]
	set_property display_name "Write Acknowledge" [ipgui::get_guiparamspec Write_Acknowledge_Sense -of $IPINST]
	set_property display_name "Dout Reset Value" [ipgui::get_guiparamspec Dout_Reset_Value -of $IPINST]
	set_property display_name "Read Write Mode" [ipgui::get_guiparamspec READ_WRITE_MODE -of $IPINST]
	
	set_property display_name "Read Clock Frequency (MHz)" [ipgui::get_guiparamspec Read_Clock_Frequency -of $IPINST]
	set_property display_name "Write Clock Frequency (MHz)" [ipgui::get_guiparamspec Write_Clock_Frequency -of $IPINST]
	
	foreach fifotype $fifo_channels_incl_axis {
		set_property display_name "Configuration Options" [ipgui::get_guiparamspec "${fifotype}_type" -of $IPINST]
		set_property tooltip "Select the required configuration option from the available choices (FIFO, Register Slice or Pass Through Wire). For more information, refer PG057" [ipgui::get_guiparamspec "${fifotype}_type" -of $IPINST]
		set_property display_name "FIFO Implementation Type" [ipgui::get_guiparamspec "FIFO_Implementation_${fifotype}" -of $IPINST]
		set_property tooltip "Select the type of FIFO to be built with (Block RAM based FIFO or Distributed RAM based FIFO)" [ipgui::get_guiparamspec "FIFO_Implementation_${fifotype}" -of $IPINST]
		set_property display_name "FIFO Application Type" [ipgui::get_guiparamspec "FIFO_Application_Type_${fifotype}" -of $IPINST]
		set_property tooltip "Select the required FIFO Application type from the available choices (Data FIFO or Low Latency FIFO or Packet FIFO) For more information, refer PG057" [ipgui::get_guiparamspec "FIFO_Application_Type_${fifotype}" -of $IPINST]
		set_property display_name "ECC" [ipgui::get_guiparamspec "Enable_ECC_${fifotype}" -of $IPINST]
		set_property tooltip "Provides the ECC sideband signals. ECC option available only for Block RAM based FIFO" [ipgui::get_guiparamspec "Enable_ECC_${fifotype}" -of $IPINST]
		set_property display_name "Single Bit Error Injection" [ipgui::get_guiparamspec "Inject_Sbit_Error_${fifotype}" -of $IPINST]
		set_property display_name "Double Bit Error Injection" [ipgui::get_guiparamspec "Inject_Dbit_Error_${fifotype}" -of $IPINST]
		set_property display_name "FIFO Depth" [ipgui::get_guiparamspec "Input_Depth_${fifotype}" -of $IPINST]
		set_property tooltip "Select the required FIFO Depth. Actual FIFO depth increases by 1 or 2 depending on the Clocking Options. For more information, refer PG057" [ipgui::get_guiparamspec "Input_Depth_${fifotype}" -of $IPINST]
		set_property display_name "Provide FIFO Occupancy Data Counts" [ipgui::get_guiparamspec "Enable_Data_Counts_${fifotype}" -of $IPINST]
		set_property tooltip "Provides the FIFO Occupancy information" [ipgui::get_guiparamspec "Enable_Data_Counts_${fifotype}" -of $IPINST]
		set_property display_name "Programmable Full Type" [ipgui::get_guiparamspec "Programmable_Full_Type_${fifotype}" -of $IPINST]
		set_property tooltip "Provides the PROG_FULL sideband signal. Determines is the flag is using the constant threshold value or input threshold value. For more information, refer PG057" [ipgui::get_guiparamspec "Programmable_Full_Type_${fifotype}" -of $IPINST]
		set_property display_name "Full Threshold Assert Value" [ipgui::get_guiparamspec "Full_Threshold_Assert_Value_${fifotype}" -of $IPINST]
		set_property tooltip "Determines at which threshold value the PROG_FULL flag should be asserted" [ipgui::get_guiparamspec "Full_Threshold_Assert_Value_${fifotype}" -of $IPINST]
		set_property display_name "Programmable Empty Type" [ipgui::get_guiparamspec "Programmable_Empty_Type_${fifotype}" -of $IPINST]
		set_property tooltip "Provides the PROG_EMPTY sideband signal. Determines is the flag is using the constant threshold value or input threshold value. For more information, refer PG057" [ipgui::get_guiparamspec "Programmable_Empty_Type_${fifotype}" -of $IPINST]
		set_property display_name "Empty Threshold Assert Value" [ipgui::get_guiparamspec "Empty_Threshold_Assert_Value_${fifotype}" -of $IPINST]
		set_property tooltip "Determines at which threshold value the PROG_EMPTY flag should be asserted" [ipgui::get_guiparamspec "Empty_Threshold_Assert_Value_${fifotype}" -of $IPINST]
		set_property display_name "Register Slice Options" [ipgui::get_guiparamspec "Register_Slice_Mode_${fifotype}" -of $IPINST]
		set_property tooltip "Fully Registered: two stage pipeline register\nLight Weight: one stage pipeline register" [ipgui::get_guiparamspec "Register_Slice_Mode_${fifotype}" -of $IPINST]
	}
	
}

proc page_page1_AXI_FULL_LITE {IPINST} {

	set page1_AXI_FULL_LITE [ipgui::add_page $IPINST -parent $IPINST -name page1_AXI_FULL_LITE -layout vertical]
	set FIFO_Width_FULL_LITE $page1_AXI_FULL_LITE
	set Common_Width_Configuration_Options [ipgui::add_group $IPINST -parent $FIFO_Width_FULL_LITE -name "Common Width Configuration Options" -layout horizontal]
	set ID_WIDTH [ipgui::add_param  $IPINST -parent $Common_Width_Configuration_Options -name ID_WIDTH -show_label true]
	set_property display_name "ID Width" $ID_WIDTH
	ipgui::add_row $IPINST -parent $Common_Width_Configuration_Options
	ipgui::add_param  $IPINST -parent $Common_Width_Configuration_Options -name ADDRESS_WIDTH -show_label true
	ipgui::add_row $IPINST -parent $Common_Width_Configuration_Options
	ipgui::add_param  $IPINST -parent $Common_Width_Configuration_Options -name DATA_WIDTH -show_label true
	ipgui::add_dynamic_text $IPINST -name LabelDATA_WIDTHRange -parent $Common_Width_Configuration_Options -tclproc "LabelDATA_WIDTHRange_updated"
	ipgui::add_row $IPINST -parent $Common_Width_Configuration_Options
	set Write_Channel_Group [ipgui::add_group $IPINST -parent $FIFO_Width_FULL_LITE -name Write_Channel_Group -layout horizontal]
	set WACH_Group $Write_Channel_Group
	ipgui::add_param  $IPINST -parent $WACH_Group -name AWUSER_Width
	ipgui::add_dynamic_text $IPINST -name Calculated_AWUSER_Width -parent $WACH_Group -tclproc "Calculated_AWUSER_Width_updated"
	ipgui::add_row $IPINST -parent $Write_Channel_Group
	set WDCH_Group $Write_Channel_Group
	ipgui::add_param  $IPINST -parent $WDCH_Group -name WUSER_Width 
	ipgui::add_dynamic_text $IPINST -name Calculated_WUSER_Width -parent $WDCH_Group -tclproc "Calculated_WUSER_Width_updated"
	ipgui::add_row $IPINST -parent $Write_Channel_Group
	set WRCH_Group $Write_Channel_Group
	ipgui::add_param  $IPINST -parent $WRCH_Group -name BUSER_Width 
	ipgui::add_dynamic_text $IPINST -name Calculated_BUSER_Width -parent $WRCH_Group -tclproc "Calculated_BUSER_Width_updated"
	set Read_Channel_Group [ipgui::add_group $IPINST -parent $FIFO_Width_FULL_LITE -name Read_Channel_Group -layout horizontal]
	set RACH_Group $Read_Channel_Group
	ipgui::add_param  $IPINST -parent $RACH_Group -name ARUSER_Width 
	ipgui::add_dynamic_text $IPINST -name Calculated_ARUSER_Width -parent $RACH_Group -tclproc "Calculated_ARUSER_Width_updated"
	ipgui::add_row $IPINST -parent $Read_Channel_Group
	set RDCH_Group $Read_Channel_Group
	ipgui::add_param  $IPINST -parent $RDCH_Group -name RUSER_Width 
	ipgui::add_dynamic_text $IPINST -name Calculated_RUSER_Width -parent $RDCH_Group -tclproc "Calculated_RUSER_Width_updated"
	
	set_property display_name "Write Channels" [ipgui::get_groupspec Write_Channel_Group -of $IPINST]
	set_property display_name "Read Channels" [ipgui::get_groupspec Read_Channel_Group -of $IPINST]
}

proc page_page1_AXI_STREAMING_FIFO {IPINST} {
	set page1_AXI_STREAMING_FIFO [ipgui::add_page $IPINST -parent $IPINST -name page1_AXI_STREAMING_FIFO -layout horizontal]
	set_property display_name "AXI4 Stream Ports" $page1_AXI_STREAMING_FIFO
	set FIFO_Width_Streaming $page1_AXI_STREAMING_FIFO
	ipgui::add_param  $IPINST -parent $FIFO_Width_Streaming -name TDATA_NUM_BYTES
	ipgui::add_dynamic_text $IPINST -name LabelTDATA_WidthRange -parent $FIFO_Width_Streaming -tclproc "TDATA_NUM_BYTES_Range_updated"
	ipgui::add_row $IPINST -parent $FIFO_Width_Streaming
	ipgui::add_param  $IPINST -parent $FIFO_Width_Streaming -name TID_WIDTH 
	ipgui::add_row $IPINST -parent $FIFO_Width_Streaming
	ipgui::add_param  $IPINST -parent $FIFO_Width_Streaming -name TDEST_WIDTH 
	ipgui::add_row $IPINST -parent $FIFO_Width_Streaming
	ipgui::add_param  $IPINST -parent $FIFO_Width_Streaming -name TUSER_WIDTH 
	ipgui::add_row $IPINST -parent $FIFO_Width_Streaming
	ipgui::add_param  $IPINST -parent $FIFO_Width_Streaming -name HAS_TSTRB
	ipgui::add_param  $IPINST -parent $FIFO_Width_Streaming -name TSTRB_WIDTH 
	ipgui::add_row $IPINST -parent $FIFO_Width_Streaming
	ipgui::add_param  $IPINST -parent $FIFO_Width_Streaming -name HAS_TKEEP
	ipgui::add_param  $IPINST -parent $FIFO_Width_Streaming -name TKEEP_WIDTH 
	#ipgui::add_indent $IPINST -parent $FIFO_Width_Streaming
	ipgui::add_row $IPINST -parent $FIFO_Width_Streaming
	ipgui::add_param  $IPINST -parent $FIFO_Width_Streaming -name Enable_TREADY
	ipgui::add_row $IPINST -parent $FIFO_Width_Streaming
	ipgui::add_param  $IPINST -parent $FIFO_Width_Streaming -name Enable_TLAST
	ipgui::add_row $IPINST -parent $FIFO_Width_Streaming
	set panel_calculatedWidth [ipgui::add_panel $IPINST -name panel_calculatedWidth -parent $FIFO_Width_Streaming]
	ipgui::add_dynamic_text $IPINST -name Calculated_AXIS_Width -parent $panel_calculatedWidth -tclproc "Calculated_AXIS_Width_updated"
	
}

proc page_AXI_Pages {IPINST} {
	set fifo_channels_incl_axis [getfifo_channels_incl_axis]
		
	set axipagelist { "page2_AXI_STREAMING_FIFO" "page2_WACH" "page2_WDCH" "page2_WRCH" "page2_RACH" "page2_RDCH"}
	set axiPageDispNames {"Config" "AW Config." "W Config." "B Config." "AR Config." "R Config."}
	for {set i 0} {$i < 6} {incr i} {
		set channel [lindex $fifo_channels_incl_axis $i]
		set pagename [lindex $axipagelist $i]
		set pagedisplay [lindex $axiPageDispNames $i]
		EvalSubstituting {channel pagename} {
			set PageName [ipgui::add_page $IPINST -parent $IPINST -name $pagename -layout vertical]
			set_property display_name $pagedisplay $PageName
			ipgui::add_param  $IPINST -parent $PageName -name "${channel}_type" -layout horizontal 
			set  FIFO_Application_Type_group [ipgui::add_group $IPINST -parent $PageName -name "FIFO_Options_${channel}" ]
			set_property display_name "FIFO Options" $FIFO_Application_Type_group
			ipgui::add_param  $IPINST -parent $FIFO_Application_Type_group -name "FIFO_Implementation_${channel}" -widget comboBox 
			ipgui::add_param  $IPINST -parent $FIFO_Application_Type_group -name "FIFO_Application_Type_${channel}" -layout horizontal 
			set panel [ipgui::add_panel $IPINST -parent $FIFO_Application_Type_group -name lt_${channel} ]
			ipgui::add_dynamic_text $IPINST -name "Latency2_${channel}" -parent $panel -tclproc "Latency2_${channel}_updated"

			set  ECC_Options_group [ipgui::add_group $IPINST -parent $PageName -name "ECC_Options_${channel}" -layout horizontal]
			set_property display_name "ECC Options" $ECC_Options_group
			ipgui::add_param  $IPINST -parent $ECC_Options_group -name "Enable_ECC_${channel}"  
			ipgui::add_param  $IPINST -parent $ECC_Options_group -name "Inject_Sbit_Error_${channel}"  
			ipgui::add_param  $IPINST -parent $ECC_Options_group -name "Inject_Dbit_Error_${channel}"
			ipgui::add_row $IPINST -parent $ECC_Options_group
			if { $PageName == "page2_AXI_STREAMING_FIFO" } {
				set uerPanel_1 [ipgui::add_panel $IPINST -parent $ECC_Options_group -name uerPanel_1 ]
				ipgui::add_param  $IPINST -parent $uerPanel_1 -name Use_Embedded_Registers_axis
				set_property display_name "Embedded Registers" [ipgui::get_guiparamspec Use_Embedded_Registers_axis -of $IPINST]
				set_property display_name "ECC And Output Register Options" $ECC_Options_group
			}
			
			set  Data_Port_Parameters_group [ipgui::add_panel $IPINST -parent $FIFO_Application_Type_group -name "Data_Port_Parameters_${channel}" -layout horizontal]
			# set_property display_name "Data Port Parameters" $Data_Port_Parameters_group
			ipgui::add_dynamic_text $IPINST -name "FIFO_Width_${channel}" -parent $Data_Port_Parameters_group -tclproc "FIFO_Width_${channel}_updated"
			ipgui::add_param  $IPINST -parent $Data_Port_Parameters_group -name "Input_Depth_${channel}"  
			ipgui::add_dynamic_text $IPINST -name "FIFO_Depth_${channel}" -parent $Data_Port_Parameters_group -tclproc "FIFO_Depth_${channel}_updated"
			
			set  Data_Threshold_Parameters_group [ipgui::add_group $IPINST -parent $PageName -name "Data_Threshold_Parameters_${channel}" -layout horizontal]
			set_property display_name "Data Threshold Parameters" $Data_Threshold_Parameters_group
			ipgui::add_param  $IPINST -parent $Data_Threshold_Parameters_group -name "Programmable_Full_Type_${channel}" -widget comboBox
			ipgui::add_row $IPINST -parent $Data_Threshold_Parameters_group
			ipgui::add_param  $IPINST -parent $Data_Threshold_Parameters_group -name "Full_Threshold_Assert_Value_${channel}"  
			ipgui::add_row $IPINST -parent $Data_Threshold_Parameters_group
			ipgui::add_param  $IPINST -parent $Data_Threshold_Parameters_group -name "Programmable_Empty_Type_${channel}" -widget comboBox
			ipgui::add_row $IPINST -parent $Data_Threshold_Parameters_group
			ipgui::add_param  $IPINST -parent $Data_Threshold_Parameters_group -name "Empty_Threshold_Assert_Value_${channel}"  
			ipgui::add_row $IPINST -parent $Data_Threshold_Parameters_group
			# ipgui::add_static_text  $IPINST -name "dummylabel" -parent  $Data_Threshold_Parameters_group -text ""
			ipgui::add_row $IPINST -parent $Data_Threshold_Parameters_group
			ipgui::add_param  $IPINST -parent $Data_Threshold_Parameters_group -name "Enable_Data_Counts_${channel}"  
			ipgui::add_row $IPINST -parent $Data_Threshold_Parameters_group
			ipgui::add_param  $IPINST -parent $PageName -name "Register_Slice_Mode_${channel}" -widget comboBox
		} 0
	}
}

proc page_page3_AXI_FIFO {IPINST} {
	set page3_AXI_FIFO [ipgui::add_page $IPINST -parent $IPINST -name page3_AXI_FIFO -layout vertical]
	set_property display_name "Status Flags" $page3_AXI_FIFO
	set HandShake_Flags_AXI [ipgui::add_group $IPINST -parent $page3_AXI_FIFO -name "HandShake_Flags_AXI" -layout horizontal ]
	set_property display_name "Interrupt Flag Options" $HandShake_Flags_AXI
	set Under_Flow [ipgui::add_param  $IPINST -parent $HandShake_Flags_AXI -name Underflow_Flag_AXI ]
	set_property display_name "Underflow" $Under_Flow
	ipgui::add_param  $IPINST -parent $HandShake_Flags_AXI -name Underflow_Sense_AXI -widget comboBox -show_label false
	ipgui::add_row $IPINST -parent $HandShake_Flags_AXI
	set over_Flow [ipgui::add_param  $IPINST -parent $HandShake_Flags_AXI -name Overflow_Flag_AXI]
	set_property display_name "Overflow" $over_Flow
	ipgui::add_param  $IPINST -parent $HandShake_Flags_AXI -name Overflow_Sense_AXI -widget comboBox -show_label false
	ipgui::add_row $IPINST -parent $HandShake_Flags_AXI
	set Enable_Common_Underflow [ipgui::add_param  $IPINST -parent $HandShake_Flags_AXI -name Enable_Common_Underflow]
	set Enable_Common_Overflow [ipgui::add_param  $IPINST -parent $HandShake_Flags_AXI -name Enable_Common_Overflow]
	set Simulations_Options_AXI [ipgui::add_group $IPINST -parent $page3_AXI_FIFO -name "Simulations_Options_AXI" -layout horizontal ]
	set_property display_name "Simulation Options"  $Simulations_Options_AXI
	ipgui::add_param  $IPINST -parent $Simulations_Options_AXI -name Disable_Timing_Violations_AXI
	set_property visible false $Simulations_Options_AXI
	set LabelAdd_NGC_Constraint_AXI [ipgui::add_group $IPINST -parent $page3_AXI_FIFO -name "LabelAdd_NGC_Constraint_AXI" -layout horizontal ]
	set_property display_name "Optimization Options" $LabelAdd_NGC_Constraint_AXI
	ipgui::add_param  $IPINST -parent $LabelAdd_NGC_Constraint_AXI -name Add_NGC_Constraint_AXI
	set Labelenable_read_pointer_increment_by2 [ipgui::add_group $IPINST -parent $page3_AXI_FIFO -name "Labelenable_read_pointer_increment_by2" -layout horizontal ]
	set_property display_name "Pointer Options" $Labelenable_read_pointer_increment_by2
	ipgui::add_param  $IPINST -parent $Labelenable_read_pointer_increment_by2 -name enable_read_pointer_increment_by2
	set_property visible false $Labelenable_read_pointer_increment_by2
	set_property visible false $LabelAdd_NGC_Constraint_AXI
	set_property visible false $Enable_Common_Overflow
	set_property visible false $Enable_Common_Underflow
}

proc page_page7_FIFO {IPINST} {
	set page7_FIFO [ipgui::add_page $IPINST -parent $IPINST -name page7_FIFO -layout vertical]
	set_property display_name "Summary" $page7_FIFO
	##set Selected_Simulation_Model [ipgui::add_group $IPINST -parent $page7_FIFO -name "Selected_Simulation_Model" -layout horizontal ]
	##ipgui::add_dynamic_text $IPINST -name LabelModel_InfoValue -parent $Selected_Simulation_Model -tclproc "LabelModel_InfoValue_updated"
	#ipgui::add_row $IPINST -parent $Selected_Simulation_Model
	ipgui::add_dynamic_text $IPINST -name Fifo_Implementation_Warng_1 -parent $page7_FIFO -tclproc "Fifo_Implementation_Warng_1_updated"
	set FIFO_Dimensions $page7_FIFO
	set BlockRAM_Blocks_Used_9 [ipgui::add_dynamic_text $IPINST -name BlockRAM_Blocks_Used_9 -parent $FIFO_Dimensions -tclproc "BlockRAM_Blocks_Used_9_updated"]
	ipgui::add_row $IPINST -parent $FIFO_Dimensions
	set Estimated_Imp_Usage [ipgui::add_dynamic_text $IPINST -name Estimated_Imp_Usage -parent $FIFO_Dimensions -tclproc "Estimated_Imp_Usage_updated"]
	ipgui::add_row $IPINST -parent $FIFO_Dimensions
	set Estimated_Imp_Usage_Value [ipgui::add_dynamic_text $IPINST -name Estimated_Imp_Usage_Value -parent $FIFO_Dimensions -tclproc "Estimated_Imp_Usage_Value_updated"]
	ipgui::add_row $IPINST -parent $FIFO_Dimensions
	set Number_of_FIFO_chained_in_depth_Value [ipgui::add_dynamic_text $IPINST -name Number_of_FIFO_chained_in_depth_Value -parent $FIFO_Dimensions -tclproc "Number_of_FIFO_chained_in_depth_Value_updated"]
	ipgui::add_row $IPINST -parent $FIFO_Dimensions
	set BlockRAM_Blocks_Used_36 [ipgui::add_dynamic_text $IPINST -name BlockRAM_Blocks_Used_36 -parent $FIFO_Dimensions -tclproc "BlockRAM_Blocks_Used_36_updated"]
	ipgui::add_row $IPINST -parent $FIFO_Dimensions
	ipgui::add_dynamic_text $IPINST -name Estimated_Imp_Usage_Comment -parent $FIFO_Dimensions -tclproc "Estimated_Imp_Usage_Comment_updated"
	
	set table_summary [ipgui::add_table $IPINST  -name "table_summary" -rows "13" -columns "2" -parent $page7_FIFO]
	
	
	for { set i 0} {$i <7 } {incr i} {
		EvalSubstituting {i} {
			set table_summary_$i0 [ipgui::add_dynamic_text $IPINST -name table_summary_$i0 -parent $table_summary -tclproc "table_summary_$i0_updated"]
			set table_summary_$i1 [ipgui::add_dynamic_text $IPINST -name table_summary_$i1 -parent $table_summary -tclproc "table_summary_$i1_updated"]
			set_property cell_location "$i,0"  [set table_summary_$i0 ]
			set_property cell_location "$i,1"  [set table_summary_$i1 ]
			
		} 0
	}
	set table2 $table_summary
	set Additional_Featureslabel1 [ipgui::add_static_text  $IPINST -name Additional_Featureslabel1 -parent  $table2 -text "Almost Full/Empty Flags"]
	set Additional_Featureslabel2 [ipgui::add_static_text  $IPINST -name Additional_Featureslabel2 -parent  $table2 -text "Programmable Full/Empty Flags"]
	set Additional_Featureslabel3 [ipgui::add_static_text  $IPINST -name Additional_Featureslabel3 -parent  $table2 -text "Data Count Outputs"]
	set Additional_Featureslabel4 [ipgui::add_static_text  $IPINST -name Additional_Featureslabel4 -parent  $table2 -text "Handshaking"]
	set Additional_Featureslabel5 [ipgui::add_static_text  $IPINST -name Additional_Featureslabel5 -parent  $table2 -text "Read Mode / Reset"]
	set Read_Mode_Reset [ipgui::add_dynamic_text $IPINST -name Read_Mode_Reset -parent $table2 -tclproc "Read_Mode_Reset_updated"]
	set Additional_Featureslabel6 [ipgui::add_static_text  $IPINST -name Additional_Featureslabel6 -parent  $table2 -text "Read Latency (From Rising Edge of Read Clock)"]
	
	set AlmostFullAlmostEmptyFlagDescription [ipgui::add_dynamic_text $IPINST -name AlmostFullAlmostEmptyFlagDescription -parent $table2 -tclproc "AlmostFullAlmostEmptyFlagDescription_updated"]
	set ProgrammableFull_EmptyDescription [ipgui::add_dynamic_text $IPINST -name ProgrammableFull_EmptyDescription -parent $table2 -tclproc "ProgrammableFull_EmptyDescription_updated"]
	set LabelWrite_Data_CountDescription [ipgui::add_dynamic_text $IPINST -name LabelWrite_Data_CountDescription -parent $table2 -tclproc "LabelWrite_Data_CountDescription_updated"]
	set LabelValid_FlagDescription [ipgui::add_dynamic_text $IPINST -name LabelValid_FlagDescription -parent $table2 -tclproc "LabelValid_FlagDescription_updated"]
	set Latency [ipgui::add_dynamic_text $IPINST -name Latency -parent $table2 -tclproc "Latency_updated"]
	
	set_property cell_location "7,0"  $Additional_Featureslabel1 
	set_property cell_location "8,0"  $Additional_Featureslabel2 
	set_property cell_location "9,0"  $Additional_Featureslabel3 
	set_property cell_location "10,0"  $Additional_Featureslabel4 
	set_property cell_location "11,0"  $Additional_Featureslabel5 
	set_property cell_location "11,1"  $Read_Mode_Reset 
	set_property cell_location "12,0"  $Additional_Featureslabel6 
	set_property cell_location "7,1"  $AlmostFullAlmostEmptyFlagDescription
	set_property cell_location "8,1"  $ProgrammableFull_EmptyDescription
	set_property cell_location "9,1"  $LabelWrite_Data_CountDescription
	set_property cell_location "10,1"  $LabelValid_FlagDescription
	set_property cell_location "12,1"  $Latency
	
}

proc page_page3_AXI_STREAMING_FIFO {IPINST} {
	set page3_AXI_STREAMING_FIFO [ipgui::add_page $IPINST -parent $IPINST -name page3_AXI_STREAMING_FIFO ]
	set_property display_name "Summary" $page3_AXI_STREAMING_FIFO
	set FIFO_Generator_Summary_axis [ipgui::add_group $IPINST -parent $page3_AXI_STREAMING_FIFO -name "FIFO_Generator_Summary_axis"]
	set_property display_name "FIFO Generator Summary"  $FIFO_Generator_Summary_axis
	set Selected_Simulation_Model_axis [ipgui::add_group $IPINST -parent $FIFO_Generator_Summary_axis -name "Selected_Simulation_Model_axis" -layout horizontal]
	set_property display_name "Selected Simulation Model" $Selected_Simulation_Model_axis
	ipgui::add_static_text  $IPINST -name Selected_Simulation_Model_axislabel1 -parent  $Selected_Simulation_Model_axis -text "Interface Type :  "
	ipgui::add_dynamic_text $IPINST -name LabelAXI_Interface_Info_2 -parent $Selected_Simulation_Model_axis -tclproc "LabelAXI_Interface_Info_2_updated"
	ipgui::add_row $IPINST -parent $Selected_Simulation_Model_axis
	ipgui::add_static_text  $IPINST -name Selected_Simulation_Model_axislabel2 -parent  $Selected_Simulation_Model_axis -text "Model Generated :"
	ipgui::add_dynamic_text $IPINST -name LabelModel_ChosenValue_AXIS -parent $Selected_Simulation_Model_axis -tclproc "LabelModel_ChosenValue_AXIS_updated"
	ipgui::add_row $IPINST -parent $Selected_Simulation_Model_axis
	ipgui::add_dynamic_text $IPINST -name "NNFifo_Implementation_Warng_axis" -parent $Selected_Simulation_Model_axis -tclproc "NNFifo_Implementation_Warng_axis_updated"
	ipgui::add_row $IPINST -parent $Selected_Simulation_Model_axis
	
	set Clocking_Summary [ipgui::add_group $IPINST -parent $FIFO_Generator_Summary_axis -name "Clocking Summary" -layout horizontal]
	ipgui::add_static_text  $IPINST -name Clocking_Summarylabel -parent  $Clocking_Summary -text "Clocking Scheme:   "
	ipgui::add_dynamic_text $IPINST -name Clock_Type_Info_AXIS -parent $Clocking_Summary -tclproc "Clock_Type_Info_AXIS_updated"
	
	set AXI_Stream_Summary [ipgui::add_group $IPINST -parent $FIFO_Generator_Summary_axis -name "AXI_Stream_Summary" -layout horizontal]
	set panel1 [ipgui::add_panel $IPINST -name panel1 -parent $AXI_Stream_Summary -layout horizontal]
	set panel2 [ipgui::add_panel $IPINST -name panel2 -parent $AXI_Stream_Summary]
	ipgui::add_static_text  $IPINST -name label_Config_Type_axis -parent  $panel1 -text "Configuration Type  :"
	ipgui::add_dynamic_text $IPINST -name Config_Type_axis -parent $panel1 -tclproc "Config_Type_axis_updated"
	ipgui::add_row $IPINST -parent $panel1
	ipgui::add_static_text  $IPINST -name LabelApp_Type_axis -parent  $panel1 -text "Application  Type"
	ipgui::add_dynamic_text $IPINST -name App_Type_axis -parent $panel1 -tclproc "App_Type_axis_updated"
	ipgui::add_row $IPINST -parent $panel1
	ipgui::add_static_text  $IPINST -name Label_cal_width_axis -parent  $panel1 -text "Width/Depth"
	ipgui::add_dynamic_text $IPINST -name cal_width_axis -parent $panel1 -tclproc "cal_width_axis_updated"
	
	ipgui::add_dynamic_text $IPINST -name Mem_Type_axis -parent $panel2 -tclproc "Mem_Type_axis_updated"
	ipgui::add_dynamic_text $IPINST -name BRAM_Res_axis -parent $panel2 -tclproc "BRAM_Res_axis_updated"
	ipgui::add_dynamic_text $IPINST -name Final_Latency_axis -parent $panel2 -tclproc "Final_Latency_axis_updated"
	
	
	
	set Add_Summary_axis [ipgui::add_group $IPINST -parent $FIFO_Generator_Summary_axis -name "Add_Summary_axis" -layout horizontal]
	set_property display_name "AXI Stream Additional Features Summary" $Add_Summary_axis
	#ipgui::add_static_text  $IPINST -name LabelProg_Flags_axis -parent  $Add_Summary_axis -text "Programmable READY/VALID Flag"
	#ipgui::add_dynamic_text $IPINST -name Prog_Flags_axis -parent $Add_Summary_axis -tclproc "Prog_Flags_axis_updated"
	ipgui::add_row $IPINST -parent $Add_Summary_axis
	ipgui::add_static_text  $IPINST -name LabelData_Count_Info_axis -parent  $Add_Summary_axis -text "Occupancy Data Count"
	ipgui::add_dynamic_text $IPINST -name Data_Count_Info_axis -parent $Add_Summary_axis -tclproc "Data_Count_Info_axis_updated"
	ipgui::add_row $IPINST -parent $Add_Summary_axis
	ipgui::add_static_text  $IPINST -name LabelFlags_axis -parent  $Add_Summary_axis -text "Interrupt Flag (UnderFlow/OverFlow)"
	ipgui::add_dynamic_text $IPINST -name Flags_axis -parent $Add_Summary_axis -tclproc "Flags_axis_updated"
}


proc page_page4_AXI_FIFO {IPINST} {
	set fifo_channels_incl_axis [getfifo_channels_incl_axis]
	
	set page4_AXI_FIFO [ipgui::add_page $IPINST -parent $IPINST -name page4_AXI_FIFO ]
	set_property display_name "Summary" $page4_AXI_FIFO
	set FIFO_Generator_Summary_axi4 [ipgui::add_group $IPINST -parent $page4_AXI_FIFO -name "FIFO_Generator_Summary_axi4" -layout horizontal]
	set_property display_name "FIFO Generator Summary" $FIFO_Generator_Summary_axi4
	ipgui::add_static_text  $IPINST -name FIFO_Generator_Summary_axi4label1 -parent  $FIFO_Generator_Summary_axi4 -text "Interface Type :  "
	ipgui::add_dynamic_text $IPINST -name LabelAXI_Interface_Info -parent $FIFO_Generator_Summary_axi4 -tclproc "LabelAXI_Interface_Info_updated"
	ipgui::add_row $IPINST -parent $FIFO_Generator_Summary_axi4
	ipgui::add_static_text  $IPINST -name FIFO_Generator_Summary_axi4label2 -parent  $FIFO_Generator_Summary_axi4 -text "Model Generated :"
	ipgui::add_dynamic_text $IPINST -name LabelModel_ChosenValue_AXI -parent $FIFO_Generator_Summary_axi4 -tclproc "LabelModel_ChosenValue_AXI_updated"
	ipgui::add_row $IPINST -parent $FIFO_Generator_Summary_axi4
	ipgui::add_static_text  $IPINST -name FIFO_Generator_Summary_axi4label3 -parent  $FIFO_Generator_Summary_axi4 -text "Clocking Scheme:   "
	ipgui::add_dynamic_text $IPINST -name Clock_Type_Info_AXI -parent $FIFO_Generator_Summary_axi4 -tclproc "Clock_Type_Info_AXI_updated"
	ipgui::add_row $IPINST -parent $FIFO_Generator_Summary_axi4
	ipgui::add_dynamic_text $IPINST -name NNFifo_Implementation_Warng_summrpg -parent $FIFO_Generator_Summary_axi4 -tclproc "NNFifo_Implementation_Warng_summrpg_updated"
	ipgui::add_row $IPINST -parent $FIFO_Generator_Summary_axi4
	
	set displaynameOfsummary {"Write Address Channel Summary" "Write Data Channel Summary" "Write Response Channel Summary" "Read Address Channel Summary" "Read Data Channel Summary"}
	for { set i 1} {$i <6 } {incr i} {
		set channel [lindex $fifo_channels_incl_axis $i]
		EvalSubstituting {channel} {
			set groupBox_AXI4_summary [ipgui::add_group $IPINST -parent $page4_AXI_FIFO -name "groupBox_${channel}_summary" -layout horizontal]
			set_property display_name [lindex $displaynameOfsummary [expr "$i -1"]] $groupBox_AXI4_summary
			ipgui::add_static_text  $IPINST -name "Label_Config_Type_${channel}" -parent  $groupBox_AXI4_summary -text "Configuration Type  :"
			ipgui::add_dynamic_text $IPINST -name "Config_Type_${channel}" -parent $groupBox_AXI4_summary -tclproc "Config_Type_${channel}_updated"
			ipgui::add_dynamic_text $IPINST -name "Mem_Type_${channel}" -parent $groupBox_AXI4_summary -tclproc "Mem_Type_${channel}_updated"
			ipgui::add_row $IPINST -parent $groupBox_AXI4_summary
			ipgui::add_static_text  $IPINST -name "LabelApp_Type_${channel}" -parent  $groupBox_AXI4_summary -text "Application  Type"
			ipgui::add_dynamic_text $IPINST -name "App_Type_${channel}" -parent $groupBox_AXI4_summary -tclproc "App_Type_${channel}_updated"
			ipgui::add_dynamic_text $IPINST -name "BRAM_Res_${channel}" -parent $groupBox_AXI4_summary -tclproc "BRAM_Res_${channel}_updated"
			ipgui::add_row $IPINST -parent $groupBox_AXI4_summary
			ipgui::add_static_text  $IPINST -name "Labelcal_width_${channel}" -parent  $groupBox_AXI4_summary -text "Width/Depth"
			ipgui::add_dynamic_text $IPINST -name "cal_width_${channel}" -parent $groupBox_AXI4_summary -tclproc "cal_width_${channel}_updated"
			ipgui::add_dynamic_text $IPINST -name "Final_Latency_${channel}" -parent $groupBox_AXI4_summary -tclproc "Final_Latency_${channel}_updated"
			
		} 0
	}
}

proc page_page5_AXI_FIFO {IPINST} {
	set fifo_channels_incl_axis [getfifo_channels_incl_axis]
	
	set displaynamesOfAddSummary {"Write Address Additional Features Summary" "Write Data Additional Features Summary" "Write Response Additional Features Summary" "Read Address Additional Features Summary" "Read Data Additional Features Summary"}
	set page5_AXI_FIFO [ipgui::add_page $IPINST -parent $IPINST -name page5_AXI_FIFO ]
	for { set i 1} {$i <6 } {incr i} {
		set channel [lindex $fifo_channels_incl_axis $i]
		EvalSubstituting {channel} {
			set Add_Summary_AXI_group [ipgui::add_group $IPINST -parent $page5_AXI_FIFO -name "Add_Summary_${channel}" -layout horizontal]
			set_property display_name [lindex $displaynamesOfAddSummary [expr "$i - 1"]] $Add_Summary_AXI_group
			#ipgui::add_static_text  $IPINST -name "Label_Prog_Flags_${channel}" -parent  $Add_Summary_AXI_group -text "Programmable READY/VALID Flag"
			#ipgui::add_dynamic_text $IPINST -name "Prog_Flags_${channel}" -parent $Add_Summary_AXI_group -tclproc "Prog_Flags_${channel}_updated"
			ipgui::add_row $IPINST -parent $Add_Summary_AXI_group
			ipgui::add_static_text  $IPINST -name "LabelData_Count_Info_${channel}" -parent  $Add_Summary_AXI_group -text "Occupancy Data Count"
			ipgui::add_dynamic_text $IPINST -name "Data_Count_Info_${channel}" -parent $Add_Summary_AXI_group -tclproc "Data_Count_Info_${channel}_updated"
			ipgui::add_row $IPINST -parent $Add_Summary_AXI_group
			ipgui::add_static_text  $IPINST -name "LabelFlags_${channel}" -parent  $Add_Summary_AXI_group -text "Interrupt Flag (UnderFlow/OverFlow)"
			ipgui::add_dynamic_text $IPINST -name "Flags_${channel}" -parent $Add_Summary_AXI_group -tclproc "Flags_${channel}_updated"
		} 0
	}
}

;# Validate Procedures -----------
;# Fix for CR: 731421 - Added Validate procs
proc validate_PARAM_VALUE.ENABLE_TLAST {PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.TDATA_NUM_BYTES PARAM_VALUE.TID_WIDTH PARAM_VALUE.TDEST_WIDTH PARAM_VALUE.TUSER_WIDTH} {
	
	set isWidthZero [checkIfAXISWidthIsZero ${PARAM_VALUE.ENABLE_TLAST} ${PARAM_VALUE.TDATA_NUM_BYTES} ${PARAM_VALUE.TID_WIDTH} ${PARAM_VALUE.TDEST_WIDTH} ${PARAM_VALUE.TUSER_WIDTH}]
	if { $isWidthZero } {
		set_property errmsg "Atleast any one option (TDATA_NUM_BYTES, TID_WIDTH, TDEST_WIDTH, TUSER_WIDTH and TLAST) must be selected" ${PARAM_VALUE.ENABLE_TLAST}
		return false
	}
	return true
}

proc validate_PARAM_VALUE.TDATA_NUM_BYTES {PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.TDATA_NUM_BYTES PARAM_VALUE.TID_WIDTH PARAM_VALUE.TDEST_WIDTH PARAM_VALUE.TUSER_WIDTH} {
	
	set isWidthZero [checkIfAXISWidthIsZero ${PARAM_VALUE.ENABLE_TLAST} ${PARAM_VALUE.TDATA_NUM_BYTES} ${PARAM_VALUE.TID_WIDTH} ${PARAM_VALUE.TDEST_WIDTH} ${PARAM_VALUE.TUSER_WIDTH}]
	if { $isWidthZero } {
		set_property errmsg "Atleast any one option (TDATA_NUM_BYTES, TID_WIDTH, TDEST_WIDTH, TUSER_WIDTH and TLAST) must be selected" ${PARAM_VALUE.TDATA_NUM_BYTES}
		return false
	}
	return true
}

proc validate_PARAM_VALUE.TID_WIDTH {PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.TDATA_NUM_BYTES PARAM_VALUE.TID_WIDTH PARAM_VALUE.TDEST_WIDTH PARAM_VALUE.TUSER_WIDTH} {
	
	set isWidthZero [checkIfAXISWidthIsZero ${PARAM_VALUE.ENABLE_TLAST} ${PARAM_VALUE.TDATA_NUM_BYTES} ${PARAM_VALUE.TID_WIDTH} ${PARAM_VALUE.TDEST_WIDTH} ${PARAM_VALUE.TUSER_WIDTH}]
	if { $isWidthZero } {
		set_property errmsg "Atleast any one option (TDATA_NUM_BYTES, TID_WIDTH, TDEST_WIDTH, TUSER_WIDTH and TLAST) must be selected" ${PARAM_VALUE.TID_WIDTH}
		return false
	}
	return true
}

proc validate_PARAM_VALUE.TDEST_WIDTH {PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.TDATA_NUM_BYTES PARAM_VALUE.TID_WIDTH PARAM_VALUE.TDEST_WIDTH PARAM_VALUE.TUSER_WIDTH} {
	
	set isWidthZero [checkIfAXISWidthIsZero ${PARAM_VALUE.ENABLE_TLAST} ${PARAM_VALUE.TDATA_NUM_BYTES} ${PARAM_VALUE.TID_WIDTH} ${PARAM_VALUE.TDEST_WIDTH} ${PARAM_VALUE.TUSER_WIDTH}]
	if { $isWidthZero } {
		set_property errmsg "Atleast any one option (TDATA_NUM_BYTES, TID_WIDTH, TDEST_WIDTH, TUSER_WIDTH and TLAST) must be selected" ${PARAM_VALUE.TDEST_WIDTH}
		return false
	}
	return true
}

proc validate_PARAM_VALUE.TUSER_WIDTH {PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.TDATA_NUM_BYTES PARAM_VALUE.TID_WIDTH PARAM_VALUE.TDEST_WIDTH PARAM_VALUE.TUSER_WIDTH} {
	
	set isWidthZero [checkIfAXISWidthIsZero ${PARAM_VALUE.ENABLE_TLAST} ${PARAM_VALUE.TDATA_NUM_BYTES} ${PARAM_VALUE.TID_WIDTH} ${PARAM_VALUE.TDEST_WIDTH} ${PARAM_VALUE.TUSER_WIDTH}]
	if { $isWidthZero } {
		set_property errmsg "Atleast any one option (TDATA_NUM_BYTES, TID_WIDTH, TDEST_WIDTH, TUSER_WIDTH and TLAST) must be selected" ${PARAM_VALUE.TUSER_WIDTH}
		return false
	}
	return true
}

proc checkIfAXISWidthIsZero {PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.TDATA_NUM_BYTES PARAM_VALUE.TID_WIDTH PARAM_VALUE.TDEST_WIDTH PARAM_VALUE.TUSER_WIDTH} {
	if {([get_property value ${PARAM_VALUE.ENABLE_TLAST}] == true || [get_property value ${PARAM_VALUE.TDATA_NUM_BYTES}] != 0 || 
	[get_property value ${PARAM_VALUE.TID_WIDTH}] !=0 || [get_property value ${PARAM_VALUE.TDEST_WIDTH}] !=0 || [get_property value ${PARAM_VALUE.TUSER_WIDTH}] !=0)} {
		return false
	}
	return true
}

proc validate_PARAM_VALUE.RACH_TYPE { PARAM_VALUE.RACH_TYPE PARAM_VALUE.RDCH_TYPE  
  PARAM_VALUE.WACH_TYPE PARAM_VALUE.WDCH_TYPE  
  PARAM_VALUE.WRCH_TYPE} {
  
   set wach_impl_type [ get_property value ${PARAM_VALUE.WACH_TYPE} ]
   set wdch_impl_type [ get_property value ${PARAM_VALUE.WDCH_TYPE} ]
   set wrch_impl_type [ get_property value ${PARAM_VALUE.WRCH_TYPE} ]
   set rach_impl_type [ get_property value ${PARAM_VALUE.RACH_TYPE} ]
   set rdch_impl_type [ get_property value ${PARAM_VALUE.RDCH_TYPE} ]

	if { ($wach_impl_type == "Pass_Through_Wire") && ($wdch_impl_type == "Pass_Through_Wire") && ($wrch_impl_type == "Pass_Through_Wire") && ($rach_impl_type == "Pass_Through_Wire") && ($rdch_impl_type == "Pass_Through_Wire")} {
		set_property errmsg "All five channels (AW, W, B, AR and R) cannot be Pass Through Wire. At least one channel must be either FIFO or Register Slice"  ${PARAM_VALUE.RACH_TYPE}  
		return false
    }
   return true
}

proc validate_PARAM_VALUE.WDCH_TYPE { PARAM_VALUE.RACH_TYPE PARAM_VALUE.RDCH_TYPE  
  PARAM_VALUE.WACH_TYPE PARAM_VALUE.WDCH_TYPE  
  PARAM_VALUE.WRCH_TYPE} {
  
   set wach_impl_type [ get_property value ${PARAM_VALUE.WACH_TYPE} ]
   set wdch_impl_type [ get_property value ${PARAM_VALUE.WDCH_TYPE} ]
   set wrch_impl_type [ get_property value ${PARAM_VALUE.WRCH_TYPE} ]
   set rach_impl_type [ get_property value ${PARAM_VALUE.RACH_TYPE} ]
   set rdch_impl_type [ get_property value ${PARAM_VALUE.RDCH_TYPE} ]

	if { ($wach_impl_type == "Pass_Through_Wire") && ($wdch_impl_type == "Pass_Through_Wire") && ($wrch_impl_type == "Pass_Through_Wire") && ($rach_impl_type == "Pass_Through_Wire") && ($rdch_impl_type == "Pass_Through_Wire")} {
		set_property errmsg "All five channels (AW, W, B, AR and R) cannot be Pass Through Wire. At least one channel must be either FIFO or Register Slice"  ${PARAM_VALUE.WDCH_TYPE}  
		return false
    }
   return true
}

proc validate_PARAM_VALUE.COMPONENT_NAME { PARAM_VALUE.COMPONENT_NAME} {
   set errStr [ipgui::component_validate [ get_property value ${PARAM_VALUE.COMPONENT_NAME} ] ]
	if  { $errStr == "" } { 
		return true 
	} else { 
		set_property errmsg $errStr   ${PARAM_VALUE.COMPONENT_NAME} 
		return false 
	}
}

proc validate_PARAM_VALUE.WACH_TYPE { PARAM_VALUE.RACH_TYPE PARAM_VALUE.RDCH_TYPE  
  PARAM_VALUE.WACH_TYPE PARAM_VALUE.WDCH_TYPE  
  PARAM_VALUE.WRCH_TYPE} {
  
   set wach_impl_type [ get_property value ${PARAM_VALUE.WACH_TYPE} ]
   set wdch_impl_type [ get_property value ${PARAM_VALUE.WDCH_TYPE} ]
   set wrch_impl_type [ get_property value ${PARAM_VALUE.WRCH_TYPE} ]
   set rach_impl_type [ get_property value ${PARAM_VALUE.RACH_TYPE} ]
   set rdch_impl_type [ get_property value ${PARAM_VALUE.RDCH_TYPE} ]

	if { ($wach_impl_type == "Pass_Through_Wire") && ($wdch_impl_type == "Pass_Through_Wire") && ($wrch_impl_type == "Pass_Through_Wire") && ($rach_impl_type == "Pass_Through_Wire") && ($rdch_impl_type == "Pass_Through_Wire")} {
		set_property errmsg "All five channels (AW, W, B, AR and R) cannot be Pass Through Wire. At least one channel must be either FIFO or Register Slice"  ${PARAM_VALUE.WACH_TYPE}  
		return false
    }
   return true
}

proc validate_PARAM_VALUE.RESET_TYPE { PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.RESET_PIN PARAM_VALUE.RESET_TYPE} {
  
   set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]

	if { [ get_property value ${PARAM_VALUE.RESET_PIN} ] == false && [ get_property value ${PARAM_VALUE.RESET_TYPE} ] == "Synchronous_Reset" } {
		set FIFO_Type $Fifo_Implementation
		set_property errmsg "The Synchronous Reset Pin has to be enabled for the $FIFO_Type configuration"  ${PARAM_VALUE.RESET_TYPE}  
		return false
    }
   return true
}

proc validate_PARAM_VALUE.INPUT_DEPTH { PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.INPUT_DATA_WIDTH  
  PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.asymmetric_port_width PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.OUTPUT_DEPTH} {
	
	set Input_Depth  ${PARAM_VALUE.INPUT_DEPTH} 
	set ID [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ]
	set OD [ get_property value ${PARAM_VALUE.OUTPUT_DEPTH} ]
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	set Input_Data_Width [ get_property value ${PARAM_VALUE.INPUT_DATA_WIDTH} ]
	set output_Data_Width [ get_property value ${PARAM_VALUE.OUTPUT_DATA_WIDTH} ]
	set asymport [get_property value ${PARAM_VALUE.asymmetric_port_width}]
	set INTERFACE_TYPE [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] 
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	
	if { $ID < 16 } {
		set_property errmsg "Input Depth can not be less than 16" $Input_Depth   
		return false
	}
	
	if {$Input_Data_Width >= 1 && $Input_Data_Width <= 128 && $ID > [expr "128*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 128K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 129 && $Input_Data_Width <= 256 && $ID > [expr "64*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 64K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 257 && $Input_Data_Width <= 512 && $ID > [expr "32*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 32K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 513 && $Input_Data_Width <= 1024 && $ID > [expr "16*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 16K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 1025 && $Input_Data_Width <= 2048 && $ID > [expr "8*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 8K " $Input_Depth
		return false
	} elseif {$Input_Data_Width > 2048 && $ID > [expr "4*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 4K " $Input_Depth
		return false
	} 
	
   return true
}
#proc validate_PARAM_VALUE.OUTPUT_DEPTH { PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.OUTPUT_DEPTH PARAM_VALUE.INPUT_DEPTH  PARAM_VALUE.asymmetric_port_width PROJECT_PARAM.ARCHITECTURE } {
#	
#	set OUTPUT_DEPTH  ${PARAM_VALUE.OUTPUT_DEPTH} 
#	set ID [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ]
#	set OD [ get_property value ${PARAM_VALUE.OUTPUT_DEPTH} ]
#	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
#	set asymport [get_property value ${PARAM_VALUE.asymmetric_port_width}]
#	set INTERFACE_TYPE [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] 
#	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
#	
#	if { ($c_family == "virtexu") && ($INTERFACE_TYPE== "Native" ) && ($Fifo_Implementation == "Common_Clock_Block_RAM") && ($asymport == "true" )&& ($ID == $OD )} {
#	set_property errmsg "\n Output Depth should not be equal to Input Depth when asymmetric port width is true  " $OUTPUT_DEPTH
#	return false
#	}
#	return true 
#	}
#
proc validate_PARAM_VALUE.OUTPUT_DATA_WIDTH { PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.INTERFACE_TYPE  PARAM_VALUE.INPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.asymmetric_port_width PROJECT_PARAM.ARCHITECTURE } {
	
	set OUTPUT_DATA_WIDTH  ${PARAM_VALUE.OUTPUT_DATA_WIDTH} 
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	set ID_Width [ get_property value ${PARAM_VALUE.INPUT_DATA_WIDTH} ]
	set OD_Width [ get_property value ${PARAM_VALUE.OUTPUT_DATA_WIDTH} ]
	set asymport [get_property value ${PARAM_VALUE.asymmetric_port_width}]
	set INTERFACE_TYPE [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] 
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	
	if { ($c_family == "virtexu") && ($INTERFACE_TYPE== "Native" )  && ($asymport == "true" )&& ($ID_Width == $OD_Width )} {
	set_property errmsg "\n Read Data Width should not be equal to Write Data Width when asymmetric port width is true  " $OUTPUT_DATA_WIDTH
	return false
	}
	return true 
	}



proc isValidInputDataWidth { asymport input_data_width Fifo_Implementation} {
	set valid_value [list 4 8 9 16 18 32 36 64 72 128 144 256 288 512 576 1024]
	if { $asymport == "true" && ($Fifo_Implementation == "Common_Clock_Builtin_FIFO" || $Fifo_Implementation == "Independent_Clocks_Builtin_FIFO")} {
		if { [lsearch $valid_value $input_data_width] == -1 } {
			return false
		} else {
			return true
		}
   } else {
	return true
   }
}   
 

proc validate_PARAM_VALUE.INPUT_DATA_WIDTH { PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.INPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.asymmetric_port_width PARAM_VALUE.INTERFACE_TYPE PROJECT_PARAM.ARCHITECTURE} {
	set ID_Width [ get_property value ${PARAM_VALUE.INPUT_DATA_WIDTH} ]
	set OD_Width [ get_property value ${PARAM_VALUE.OUTPUT_DATA_WIDTH} ]
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set asymport [get_property value ${PARAM_VALUE.asymmetric_port_width}]
	set INTERFACE_TYPE [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] 
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	set valid_value [list 4 8 9 16 18 32 36 64 72 128 144 256 288 512 576 1024]

 #  set return_val [isValidInputDataWidth $asymport $ID_Width $Fifo_Implementation] 
   if { [isValidInputDataWidth $asymport $ID_Width $Fifo_Implementation] == "false" } {
	 set_property errmsg "\nValid values are $valid_value" ${PARAM_VALUE.INPUT_DATA_WIDTH}
   } 
   

	if { ($c_family == "virtexu") && ($INTERFACE_TYPE== "Native" ) &&  ($asymport == "true" )&& ($ID_Width == $OD_Width )} {
	set_property errmsg "\n Write Data Width should not be equal to Read Data Width when asymmetric port width is true  " ${PARAM_VALUE.INPUT_DATA_WIDTH}
	return false
	}
  
   
   
   return true
}
#911
proc update_PARAM_VALUE.INPUT_DATA_WIDTH { PARAM_VALUE.INPUT_DATA_WIDTH PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.asymmetric_port_width} {
;# Don't remove this proc. This is needed to create a dependency with fifo_implementation
	set asymmetric_port_width [get_property value ${PARAM_VALUE.asymmetric_port_width}]
	set input_data_width [get_property value ${PARAM_VALUE.INPUT_DATA_WIDTH}]
	set Fifo_Implementation [get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION}]
	if {( $asymmetric_port_width == "true" ) && ($Fifo_Implementation == "Common_Clock_Builtin_FIFO" || $Fifo_Implementation == "Independent_Clocks_Builtin_FIFO")} {
	set valid_value [list 4 8 9 16 18 32 36 64 72 128 144 256 288 512 576 1024]
		set_property range $valid_value ${PARAM_VALUE.INPUT_DATA_WIDTH}
	} else {
		set_property range 1,1024 ${PARAM_VALUE.INPUT_DATA_WIDTH}
	}
	set isValidValue [isValidInputDataWidth $asymmetric_port_width $input_data_width $Fifo_Implementation]
	if { $isValidValue == "false" } {
		set_property value 4 ${PARAM_VALUE.INPUT_DATA_WIDTH}
	}
}

proc validate_PARAM_VALUE.WRCH_TYPE { PARAM_VALUE.RACH_TYPE PARAM_VALUE.RDCH_TYPE  
  PARAM_VALUE.WACH_TYPE PARAM_VALUE.WDCH_TYPE  
  PARAM_VALUE.WRCH_TYPE} {
   
   set wach_impl_type [ get_property value ${PARAM_VALUE.WACH_TYPE} ]
   set wdch_impl_type [ get_property value ${PARAM_VALUE.WDCH_TYPE} ]
   set wrch_impl_type [ get_property value ${PARAM_VALUE.WRCH_TYPE} ]
   set rach_impl_type [ get_property value ${PARAM_VALUE.RACH_TYPE} ]
   set rdch_impl_type [ get_property value ${PARAM_VALUE.RDCH_TYPE} ]

	if { ($wach_impl_type == "Pass_Through_Wire") && ($wdch_impl_type == "Pass_Through_Wire") && ($wrch_impl_type == "Pass_Through_Wire") && ($rach_impl_type == "Pass_Through_Wire") && ($rdch_impl_type == "Pass_Through_Wire")} {
		set_property errmsg "All five channels (AW, W, B, AR and R) cannot be Pass Through Wire. At least one channel must be either FIFO or Register Slice"  ${PARAM_VALUE.WRCH_TYPE}  
		return false
    }
   return true
}

proc validate_PARAM_VALUE.RESET_PIN { PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.RESET_PIN} {
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]

   if { [ get_property value ${PARAM_VALUE.RESET_PIN} ] == false
     && ($Fifo_Implementation == "Common_Clock_Shift_Register"
       || $Fifo_Implementation == "Common_Clock_Builtin_FIFO"
       || $Fifo_Implementation == "Independent_Clocks_Builtin_FIFO") } {
      set FIFO_Type $Fifo_Implementation
      set_property errmsg "The Reset Pin has to be enabled for the $FIFO_Type configuration"  ${PARAM_VALUE.RESET_PIN} 
      return false
   }
   return true
}

proc validate_PARAM_VALUE.RDCH_TYPE { PARAM_VALUE.RACH_TYPE PARAM_VALUE.RDCH_TYPE  
  PARAM_VALUE.WACH_TYPE PARAM_VALUE.WDCH_TYPE  
  PARAM_VALUE.WRCH_TYPE} {
  
   set wach_impl_type [ get_property value ${PARAM_VALUE.WACH_TYPE} ]
   set wdch_impl_type [ get_property value ${PARAM_VALUE.WDCH_TYPE} ]
   set wrch_impl_type [ get_property value ${PARAM_VALUE.WRCH_TYPE} ]
   set rach_impl_type [ get_property value ${PARAM_VALUE.RACH_TYPE} ]
   set rdch_impl_type [ get_property value ${PARAM_VALUE.RDCH_TYPE} ]

	if { ($wach_impl_type == "Pass_Through_Wire") && ($wdch_impl_type == "Pass_Through_Wire") && ($wrch_impl_type == "Pass_Through_Wire") && ($rach_impl_type == "Pass_Through_Wire") && ($rdch_impl_type == "Pass_Through_Wire")} {
		set_property errmsg "All five channels (AW, W, B, AR and R) cannot be Pass Through Wire. At least one channel must be either FIFO or Register Slice"  ${PARAM_VALUE.RDCH_TYPE}  
		return false
    }
   return true
}

proc validate_PARAM_VALUE.DOUT_RESET_VALUE { PARAM_VALUE.DOUT_RESET_VALUE PARAM_VALUE.OUTPUT_DATA_WIDTH} {
   # You could trim out spaces and underscores, and then verify that the number of
   # characters in the string doesn't exceed the output_data_width/4,
   # and verify that the string only contains the characters 0-9, A-F, a-f.
	
	set Dout_Reset_Handle  ${PARAM_VALUE.DOUT_RESET_VALUE} 
  set Dout_Reset_Value [get_property value ${PARAM_VALUE.DOUT_RESET_VALUE}]
  set Dout_Reset_Binary [ipgen::number_utils::hex2bin $Dout_Reset_Value]
  
  if {![string is xdigit [ get_property value ${PARAM_VALUE.DOUT_RESET_VALUE} ]]} {
      set_property errmsg "Dout_Reset_Value must represent a valid hexadecimal value \(\[0-9a-fA-F\]\+\)." $Dout_Reset_Handle 
      return false
  }

   # if { [string length [ get_property value ${PARAM_VALUE.DOUT_RESET_VALUE} ]] > [expr { (int(( [ get_property value ${PARAM_VALUE.OUTPUT_DATA_WIDTH} ]-1 ) / 4) ) + 1 }] } 
  if { [string length $Dout_Reset_Binary] > [get_property value ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] } {
      set_property errmsg "Dout_Reset_Value width must be less than or equal to the Read_Width." $Dout_Reset_Handle 
      return false
   }

   return true
}


;# Update Procedures ----------
proc update_PARAM_VALUE.FIFO_IMPLEMENTATION {PARAM_VALUE.FIFO_IMPLEMENTATION PROJECT_PARAM.ARCHITECTURE} {
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	if { $c_family == "virtexu" } {
		set_property range_value	 "Common_Clock_Builtin_FIFO,Common_Clock_Builtin_FIFO,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM,Common_Clock_Shift_Register,Independent_Clocks_Builtin_FIFO,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" ${PARAM_VALUE.FIFO_IMPLEMENTATION}
	} else {
		set_property range_value	 "Common_Clock_Block_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM,Common_Clock_Shift_Register,Common_Clock_Builtin_FIFO,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM,Independent_Clocks_Builtin_FIFO" ${PARAM_VALUE.FIFO_IMPLEMENTATION}
	}
}

proc update_PARAM_VALUE.INJECT_DBIT_ERROR { PARAM_VALUE.ENABLE_ECC PARAM_VALUE.INJECT_DBIT_ERROR  
  PARAM_VALUE.INPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DATA_WIDTH} {
   
   set Inject_Dbit_Error  ${PARAM_VALUE.INJECT_DBIT_ERROR} 
   if { [ get_property value ${PARAM_VALUE.ENABLE_ECC} ] == true && 
        [ get_property value ${PARAM_VALUE.INPUT_DATA_WIDTH} ] > 1  && [ get_property value ${PARAM_VALUE.OUTPUT_DATA_WIDTH} ] > 1 } {
		set_property enabled true $Inject_Dbit_Error
   } else {
		set_property enabled false $Inject_Dbit_Error
		set_property value [get_property default_value $Inject_Dbit_Error] $Inject_Dbit_Error 
   }
}

proc updateVisibilityOfSYNCHRONIZATION_STAGES { PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.INTERFACE_TYPE IPINST} {
	set synchronization_stages  [ipgui::get_guiparamspec synchronization_stages -of $IPINST]
	set fifo_implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	
	if {($fifo_implementation eq "Independent_Clocks_Block_RAM" || $fifo_implementation eq "Independent_Clocks_Distributed_RAM") } {
		if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "Native" } {	
			set_property visible true $synchronization_stages 
		} else {
			set_property visible false $synchronization_stages 
		}
	} else {
		set_property visible false $synchronization_stages 
	}
}

proc update_PARAM_VALUE.TID_WIDTH { PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.TID_WIDTH} {
	set TID_WIDTH  ${PARAM_VALUE.TID_WIDTH} 
	if { [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_STREAM" } {
		set_property enabled true $TID_WIDTH 
	} else {
		set_property enabled false $TID_WIDTH 
	}	
}

proc update_PARAM_VALUE.TKEEP_WIDTH { PARAM_VALUE.TDATA_NUM_BYTES PARAM_VALUE.TKEEP_WIDTH} {

	set TKEEP_WIDTH  ${PARAM_VALUE.TKEEP_WIDTH} 
	set value [ get_property value ${PARAM_VALUE.TDATA_NUM_BYTES} ]
	
	if { $value > 0 } {
		set_property enabled false $TKEEP_WIDTH 
	} else {
		set_property enabled false $TKEEP_WIDTH 
	}	
	set_property range "$value,$value" $TKEEP_WIDTH
}

proc update_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.PROTOCOL} {
	set DATA_WIDTH  ${PARAM_VALUE.DATA_WIDTH} 
	set default_val [get_property default_value $DATA_WIDTH]
	if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" } {
		set_property enabled true $DATA_WIDTH
		if {[ get_property value ${PARAM_VALUE.PROTOCOL} ] == "AXI4" || [ get_property value ${PARAM_VALUE.PROTOCOL} ] == "AXI3"} {
			set_property range "32,64,128,256,512,1024" $DATA_WIDTH
		} else {
			set_property range "32,64" $DATA_WIDTH 
		}
	} else {
		set_property enabled false $DATA_WIDTH
		set_property range "$default_val" $DATA_WIDTH 
	}
}

proc update_PARAM_VALUE.USE_DOUT_RESET { PARAM_VALUE.ENABLE_ECC PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.RESET_PIN PARAM_VALUE.USE_DOUT_RESET  
  PARAM_VALUE.USE_EMBEDDED_REGISTERS PROJECT_PARAM.ARCHITECTURE} {
   set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]

   set Use_Dout_Reset  ${PARAM_VALUE.USE_DOUT_RESET} 
   
	if { [ get_property value ${PARAM_VALUE.RESET_PIN} ] == true } {

        set_property enabled true $Use_Dout_Reset 

      if { ([ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Common_Clock_Block_RAM"
         || [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Independent_Clocks_Block_RAM")
         && [ get_property value ${PARAM_VALUE.ENABLE_ECC} ] == true } {
           set_property enabled false $Use_Dout_Reset 
           set_property value false $Use_Dout_Reset 
      } elseif { [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] eq "Common_Clock_Builtin_FIFO"
              && [ get_property value ${PARAM_VALUE.USE_EMBEDDED_REGISTERS} ] == true } {
           if {[string equal -nocase $c_family "virtexu"]} {
           set_property enabled false $Use_Dout_Reset 
           set_property value true $Use_Dout_Reset 
           } else {
           set_property value true $Use_Dout_Reset 
          }
      } elseif { ([ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Common_Clock_Block_RAM"
        || [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Independent_Clocks_Block_RAM")
             && [ get_property value ${PARAM_VALUE.USE_EMBEDDED_REGISTERS} ] == true } {
           set_property value true $Use_Dout_Reset 
      } elseif { [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Common_Clock_Builtin_FIFO"
        || [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Independent_Clocks_Builtin_FIFO"
             || [ get_property value ${PARAM_VALUE.USE_EMBEDDED_REGISTERS} ] == true } {
           if {[string equal -nocase $c_family "virtexu"]} {
           set_property enabled false $Use_Dout_Reset 
           set_property value true $Use_Dout_Reset 
           } else {
           set_property enabled false $Use_Dout_Reset 
           set_property value false $Use_Dout_Reset
           } 
        } else {
           set_property value true $Use_Dout_Reset 
        }

  } else {
     set_property enabled false $Use_Dout_Reset 
     set_property value false $Use_Dout_Reset 
  }
}

proc update_PARAM_VALUE.DISABLE_TIMING_VIOLATIONS { PARAM_VALUE.DISABLE_TIMING_VIOLATIONS PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.RESET_PIN PARAM_VALUE.RESET_TYPE} {
     
	set Disable_Timing_Violations  ${PARAM_VALUE.DISABLE_TIMING_VIOLATIONS} 
   if {([ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Independent_Clocks_Block_RAM"
       || [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Independent_Clocks_Distributed_RAM")
       || ([ get_property value ${PARAM_VALUE.RESET_PIN} ] == true && [ get_property value ${PARAM_VALUE.RESET_TYPE} ]=="Asynchronous_Reset")
      } {
		set_property enabled true $Disable_Timing_Violations 

   } else {
		set_property enabled false $Disable_Timing_Violations 
		set_property value false $Disable_Timing_Violations 
   }

}

proc update_PARAM_VALUE.OVERFLOW_SENSE_AXI { PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.OVERFLOW_FLAG_AXI  
  PARAM_VALUE.OVERFLOW_SENSE_AXI PROJECT_PARAM.ARCHITECTURE} {

	set Overflow_Sense_AXI  ${PARAM_VALUE.OVERFLOW_SENSE_AXI} 
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	if { $c_family == "virtexu" } {
		set_property enabled false $Overflow_Sense_AXI 
		set_property value [get_property default_value $Overflow_Sense_AXI] $Overflow_Sense_AXI 
		return;
	}
	if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] != "Native"} {
		if {[ get_property value ${PARAM_VALUE.OVERFLOW_FLAG_AXI} ]} {
			set_property enabled true $Overflow_Sense_AXI 
		} else {
		  set_property enabled false $Overflow_Sense_AXI 
		  set_property value [get_property default_value $Overflow_Sense_AXI] $Overflow_Sense_AXI 
		}
	}

}

proc update_PARAM_VALUE.CLOCK_ENABLE_TYPE { PARAM_VALUE.CLOCK_ENABLE_TYPE PARAM_VALUE.HAS_ACLKEN} {
	set Clock_Enable_Type  ${PARAM_VALUE.CLOCK_ENABLE_TYPE} 
	#set_property enabled false $Clock_Enable_Type
	if { [ get_property value ${PARAM_VALUE.HAS_ACLKEN} ] == "false" } {
		set_property enabled false $Clock_Enable_Type
		set_property range_value "Slave_Interface_Clock_Enable,Slave_Interface_Clock_Enable,Master_Interface_Clock_Enable" $Clock_Enable_Type 
	} else {
		set_property enabled true $Clock_Enable_Type
	} 

}

proc update_PARAM_VALUE.TDEST_WIDTH { PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.TDEST_WIDTH} {
	set TDEST_WIDTH  ${PARAM_VALUE.TDEST_WIDTH} 
	if { [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_STREAM" } {
		set_property enabled true $TDEST_WIDTH 
	} else {
		set_property enabled false $TDEST_WIDTH 
	}	

}
###############################################
proc update_PARAM_VALUE.RESET_TYPE {PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.RESET_PIN PARAM_VALUE.RESET_TYPE PROJECT_PARAM.ARCHITECTURE} {
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	set Reset_Pin [ get_property value ${PARAM_VALUE.RESET_PIN} ]
	set Reset_Type  ${PARAM_VALUE.RESET_TYPE} 
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
        set interface [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] 
	if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "Native" } {
		if { ($c_family eq "virtexu") && ( $Fifo_Implementation eq "Common_Clock_Builtin_FIFO"|| $Fifo_Implementation eq "Independent_Clocks_Builtin_FIFO")} {
				set_property enabled false $Reset_Type
				set_property range_value "Synchronous_Reset,Synchronous_Reset" $Reset_Type
		} elseif {($c_family eq "virtexu") && ($Reset_Pin) && ($Fifo_Implementation eq "Common_Clock_Block_RAM" || $Fifo_Implementation eq "Common_Clock_Distributed_RAM" || $Fifo_Implementation eq "Common_Clock_Shift_Register") } {
				set_property enabled true $Reset_Type 
				set_property range_value "Synchronous_Reset,Asynchronous_Reset,Synchronous_Reset" $Reset_Type
				#set_property value "Asynchronous_Reset" $Reset_Type
		} elseif {($Reset_Pin) && ($Fifo_Implementation eq "Common_Clock_Block_RAM" || $Fifo_Implementation eq "Common_Clock_Distributed_RAM" || $Fifo_Implementation eq "Common_Clock_Shift_Register") } {
   		        set_property enabled true $Reset_Type 
				set_property range_value "Asynchronous_Reset,Asynchronous_Reset,Synchronous_Reset" $Reset_Type
                set_property value "Asynchronous_Reset" $Reset_Type
		} else {
			set_property enabled false $Reset_Type 
			#set value [get_property default_value $Reset_Type] 
			set_property range_value "Asynchronous_Reset,Asynchronous_Reset" $Reset_Type
		}
	} else {
                  set_property enabled false $Reset_Type 
#                  set value [get_property default_value $Reset_Type] 
                  set_property range_value "Asynchronous_Reset,Asynchronous_Reset" $Reset_Type
	}
}

############################################
proc update_PARAM_VALUE.INPUT_DEPTH { PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.INPUT_DATA_WIDTH  
  PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.SYNCHRONIZATION_STAGES PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.asymmetric_port_width } {
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
    set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]	
	set Input_Depth  ${PARAM_VALUE.INPUT_DEPTH} 
	set Input_Data_Width [get_property value ${PARAM_VALUE.INPUT_DATA_WIDTH}]
	set asymmetric_port_width [get_property value ${PARAM_VALUE.asymmetric_port_width}]
	##correct this drive with asymeetric port width
	if {($Fifo_Implementation == "Independent_Clocks_Builtin_FIFO" || $Fifo_Implementation == "Common_Clock_Builtin_FIFO")} {
          if { $c_family == "virtexu" && $asymmetric_port_width == "true"} {
		set rangelist "512,1024,2048,4096,8192"
		set_property enabled true $Input_Depth
          } else { 
		set rangelist "512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304"
		set_property enabled true $Input_Depth
          }
	} else {
		set_property enabled true $Input_Depth
		if {($Fifo_Implementation == "Independent_Clocks_Block_RAM" || $Fifo_Implementation == "Independent_Clocks_Distributed_RAM") && ([get_property value ${PARAM_VALUE.SYNCHRONIZATION_STAGES}] > 4) } {
			set rangelist "32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304"
		} else {
			set rangelist "16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304"
		}
	}
	set rangelist [split $rangelist ","]
	set newlist ""
	foreach listval $rangelist {
		if {[isInputDepthValid [ get_property value ${PARAM_VALUE.INPUT_DATA_WIDTH} ] $listval]} {
			tcl::lappend newlist $listval
		}
	}
	set newlist [regsub -all " " $newlist ","]
	set_property range_value "1024,$newlist" $Input_Depth 
	
	if { $asymmetric_port_width  == "true" && ($Fifo_Implementation == "Independent_Clocks_Builtin_FIFO" || $Fifo_Implementation == "Common_Clock_Builtin_FIFO")} {
		if { $Input_Data_Width == 4 } {
			set_property range "4096,8192" $Input_Depth
		} elseif { $Input_Data_Width == 8} {
			set_property range "2048,4096,8192" $Input_Depth
		} elseif { $Input_Data_Width == 9} {
			set_property range "2048,4096" $Input_Depth
		} elseif { $Input_Data_Width == 16} {
			set_property range "1024,2048,4096,8192" $Input_Depth
		} elseif { $Input_Data_Width == 18} {
			set_property range "1024,2048,4096" $Input_Depth
		} elseif { $Input_Data_Width == 32} {
			set_property range "512,1024,2048,4096,8192" $Input_Depth
		} elseif { $Input_Data_Width == 36} {
			set_property range "512,1024,2048,4096" $Input_Depth
		} elseif { $Input_Data_Width == 64} {
			set_property range "512,1024,2048,4096,8192" $Input_Depth
		} elseif { $Input_Data_Width == 72} {
			set_property range "512,1024,2048,4096" $Input_Depth
		} elseif { $Input_Data_Width == 128} {
			set_property range "512,1024,2048,4096,8192" $Input_Depth
		} elseif { $Input_Data_Width == 144} {
			set_property range "512,1024,2048,4096" $Input_Depth
		} elseif { $Input_Data_Width == 256} {
			set_property range "512,1024,2048,4096,8192" $Input_Depth
		} elseif { $Input_Data_Width == 288} {
			set_property range "512,1024,2048,4096" $Input_Depth
		} elseif { $Input_Data_Width == 512} {
			set_property range "512,1024,2048,4096,8192" $Input_Depth
		} elseif { $Input_Data_Width == 576} {
			set_property range "512,1024,2048,4096" $Input_Depth
		} elseif { $Input_Data_Width == 1024} {
			set_property range "512,1024,2048,4096,8192" $Input_Depth
		}
	}
}

proc update_PARAM_VALUE.FULL_FLAGS_RESET_VALUE { PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.FULL_FLAGS_RESET_VALUE  
  PARAM_VALUE.RESET_PIN PARAM_VALUE.RESET_TYPE} {

	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	set Full_Flags_Reset_Value  ${PARAM_VALUE.FULL_FLAGS_RESET_VALUE} 
	if { $Fifo_Implementation == "Common_Clock_Builtin_FIFO" 
     || $Fifo_Implementation == "Independent_Clocks_Builtin_FIFO"
     || [ get_property value ${PARAM_VALUE.RESET_TYPE} ] == "Synchronous_Reset"
     || [ get_property value ${PARAM_VALUE.RESET_PIN} ] == false } {
		set_property range_value "0,0,1" $Full_Flags_Reset_Value 
		set_property enabled false $Full_Flags_Reset_Value 
	} else {
		set_property range_value "1,0,1" $Full_Flags_Reset_Value 
		set_property enabled true $Full_Flags_Reset_Value 
	}
}

proc update_PARAM_VALUE.ADDRESS_WIDTH { PARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.INTERFACE_TYPE} {
	set ADDRESS_WIDTH  ${PARAM_VALUE.ADDRESS_WIDTH} 
	
	if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] != "AXI_MEMORY_MAPPED"} {
		set_property enabled false $ADDRESS_WIDTH 
		set_property value [get_property default_value $ADDRESS_WIDTH] $ADDRESS_WIDTH  
	} else {
		set_property enabled true $ADDRESS_WIDTH 
	}
}

proc update_PARAM_VALUE.FULL_THRESHOLD_ASSERT_VALUE { PARAM_VALUE.ENABLE_ECC PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.FULL_THRESHOLD_ASSERT_VALUE PARAM_VALUE.INPUT_DEPTH  
  PARAM_VALUE.OUTPUT_DEPTH PARAM_VALUE.PERFORMANCE_OPTIONS  
  PARAM_VALUE.PROGRAMMABLE_FULL_TYPE PARAM_VALUE.READ_CLOCK_FREQUENCY  
  PARAM_VALUE.WRITE_CLOCK_FREQUENCY PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.INPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.asymmetric_port_width PARAM_VALUE.enable_low_latency } {
   set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
   set asymport [get_property value ${PARAM_VALUE.asymmetric_port_width}]
   set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
   set Input_Depth [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ]
   set Output_Depth [ get_property value ${PARAM_VALUE.OUTPUT_DEPTH} ]
   set Programmable_Full_Type [ get_property value ${PARAM_VALUE.PROGRAMMABLE_FULL_TYPE} ]
   set Performance_Options [ get_property value ${PARAM_VALUE.PERFORMANCE_OPTIONS} ]
   set Enable_ECC [ get_property value ${PARAM_VALUE.ENABLE_ECC} ]
   set Read_Clock_Frequency [ get_property value ${PARAM_VALUE.READ_CLOCK_FREQUENCY} ]
   set Write_Clock_Frequency [ get_property value ${PARAM_VALUE.WRITE_CLOCK_FREQUENCY} ]
   set Read_Faster [ expr "$Read_Clock_Frequency > $Write_Clock_Frequency" ]
   set low_latency [get_property value ${PARAM_VALUE.enable_low_latency} ]

   set fifo_in_depth [fifo_generator_v12_0_utils::get_Estimated_FIFO_InDepth $c_family [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] [Get_Output_Data_Width ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ] [ get_property value ${PARAM_VALUE.ENABLE_ECC} ] ]


   set pf_assert_max [fifo_generator_v12_0_utils::pf_assert_max $c_family $Fifo_Implementation $Read_Faster [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] $Input_Depth $Output_Depth $Programmable_Full_Type $Performance_Options $Enable_ECC $Write_Clock_Frequency $Read_Clock_Frequency [Get_Output_Data_Width ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] $asymport]
   
   set pf_assert_min [fifo_generator_v12_0_utils::pf_assert_min $c_family $Fifo_Implementation $Read_Faster [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] $Input_Depth $Output_Depth $Programmable_Full_Type $Performance_Options $Enable_ECC $Write_Clock_Frequency $Read_Clock_Frequency [Get_Output_Data_Width ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] $asymport ]

   if {$low_latency} {
     set pf_assert_min_new [expr "2*$fifo_in_depth"]
     set pf_assert_max_new [expr "$Input_Depth - $fifo_in_depth"]
   } else {
     set pf_assert_min_new $pf_assert_min
     set pf_assert_max_new $pf_assert_max
   }
   set_property range_value "$pf_assert_max_new,$pf_assert_min_new,$pf_assert_max_new"  ${PARAM_VALUE.FULL_THRESHOLD_ASSERT_VALUE} 
   
   set_property enabled [expr { ($Programmable_Full_Type == "Single_Programmable_Full_Threshold_Constant" || $Programmable_Full_Type == "Multiple_Programmable_Full_Threshold_Constants")?true:false}]  ${PARAM_VALUE.FULL_THRESHOLD_ASSERT_VALUE} 

}

proc update_PARAM_VALUE.FULL_THRESHOLD_NEGATE_VALUE { PARAM_VALUE.ENABLE_ECC PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.FULL_THRESHOLD_NEGATE_VALUE PARAM_VALUE.INPUT_DEPTH  PARAM_VALUE.FULL_THRESHOLD_ASSERT_VALUE
  PARAM_VALUE.OUTPUT_DEPTH PARAM_VALUE.PERFORMANCE_OPTIONS  
  PARAM_VALUE.PROGRAMMABLE_FULL_TYPE PARAM_VALUE.READ_CLOCK_FREQUENCY  
  PARAM_VALUE.WRITE_CLOCK_FREQUENCY PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.INPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.asymmetric_port_width PARAM_VALUE.enable_low_latency} {
    set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
   set asymport [get_property value ${PARAM_VALUE.asymmetric_port_width}]
   set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
   set Input_Depth [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ]
   set Output_Depth [ get_property value ${PARAM_VALUE.OUTPUT_DEPTH} ]
   set Programmable_Full_Type [ get_property value ${PARAM_VALUE.PROGRAMMABLE_FULL_TYPE} ]
   set Performance_Options [ get_property value ${PARAM_VALUE.PERFORMANCE_OPTIONS} ]
   set Enable_ECC [ get_property value ${PARAM_VALUE.ENABLE_ECC} ]
   set Read_Clock_Frequency [ get_property value ${PARAM_VALUE.READ_CLOCK_FREQUENCY} ]
   set Write_Clock_Frequency [ get_property value ${PARAM_VALUE.WRITE_CLOCK_FREQUENCY} ]
   set Read_Faster [ expr "$Read_Clock_Frequency > $Write_Clock_Frequency" ]
   set low_latency [get_property value ${PARAM_VALUE.enable_low_latency} ]

   set fifo_in_depth [fifo_generator_v12_0_utils::get_Estimated_FIFO_InDepth $c_family [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] [Get_Output_Data_Width ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ] [ get_property value ${PARAM_VALUE.ENABLE_ECC} ] ]


   set Full_Threshold_Assert_Value [get_property value ${PARAM_VALUE.FULL_THRESHOLD_ASSERT_VALUE}]
   ;#set pf_negate_max [fifo_generator_v12_0_utils::pf_negate_max $Input_Depth $Programmable_Full_Type $Full_Threshold_Assert_Value ]
   set pf_negate_max [expr "$Full_Threshold_Assert_Value - 1"]
   set pf_negate_min [fifo_generator_v12_0_utils::pf_negate_min $c_family $Fifo_Implementation [expr "$Read_Clock_Frequency > $Write_Clock_Frequency"] [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] $Input_Depth $Output_Depth $Programmable_Full_Type $Performance_Options $Enable_ECC [Get_Output_Data_Width ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] $asymport]

   if {$low_latency} {
     set pf_negate_min_new [expr "(2*$fifo_in_depth)-2"]
     set pf_negate_max_new [expr "$Input_Depth - $fifo_in_depth-2"]
   } else {
     set pf_negate_min_new $pf_negate_min
     set pf_negate_max_new $pf_negate_max
   }
   
   set_property range_value "$pf_negate_max_new,$pf_negate_min_new,$pf_negate_max_new"  ${PARAM_VALUE.FULL_THRESHOLD_NEGATE_VALUE} 	
   set_property enabled [expr { ($Programmable_Full_Type == "Multiple_Programmable_Full_Threshold_Constants")?true:false}]  ${PARAM_VALUE.FULL_THRESHOLD_NEGATE_VALUE} 
}

proc update_PARAM_VALUE.EMPTY_THRESHOLD_ASSERT_VALUE { PARAM_VALUE.EMPTY_THRESHOLD_ASSERT_VALUE PARAM_VALUE.ENABLE_ECC  
  PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.INPUT_DEPTH  
  PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DEPTH  
  PARAM_VALUE.PERFORMANCE_OPTIONS PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE  
  PARAM_VALUE.READ_CLOCK_FREQUENCY PARAM_VALUE.WRITE_CLOCK_FREQUENCY PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.INPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.asymmetric_port_width PARAM_VALUE.enable_low_latency} {
   set asymport [get_property value ${PARAM_VALUE.asymmetric_port_width}]
   set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
   set Empty_Threshold_Assert_Value  ${PARAM_VALUE.EMPTY_THRESHOLD_ASSERT_VALUE} 
   set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
   set Read_Clock_Frequency [ get_property value ${PARAM_VALUE.READ_CLOCK_FREQUENCY} ]
   set Write_Clock_Frequency [ get_property value ${PARAM_VALUE.WRITE_CLOCK_FREQUENCY} ]
   set Enable_ECC [ get_property value ${PARAM_VALUE.ENABLE_ECC} ]	
   set Input_Depth [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ]
   set Output_Data_Width [ get_property value ${PARAM_VALUE.OUTPUT_DATA_WIDTH} ]
   set Output_Depth [ get_property value ${PARAM_VALUE.OUTPUT_DEPTH} ]
   set Performance_Options [ get_property value ${PARAM_VALUE.PERFORMANCE_OPTIONS} ]
   set Programmable_Empty_Type [ get_property value ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE} ]
   set low_latency [get_property value ${PARAM_VALUE.enable_low_latency} ]

   set fifo_in_depth [fifo_generator_v12_0_utils::get_Estimated_FIFO_InDepth $c_family [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] [Get_Output_Data_Width ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ] [ get_property value ${PARAM_VALUE.ENABLE_ECC} ] ]

   set pe_assert_max [fifo_generator_v12_0_utils::pe_assert_max $c_family $Fifo_Implementation [expr "$Read_Clock_Frequency > $Write_Clock_Frequency" ] [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] $Input_Depth [Get_Output_Data_Width ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] $Output_Depth $Programmable_Empty_Type $Performance_Options $Enable_ECC [Get_Frequency_info ${PARAM_VALUE.READ_CLOCK_FREQUENCY} ${PARAM_VALUE.WRITE_CLOCK_FREQUENCY}] $asymport]
   set pe_assert_min [fifo_generator_v12_0_utils::pe_assert_min $c_family $Fifo_Implementation [expr "$Read_Clock_Frequency > $Write_Clock_Frequency" ] [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] $Input_Depth $Output_Depth $Programmable_Empty_Type $Performance_Options $Enable_ECC [Get_Frequency_info ${PARAM_VALUE.READ_CLOCK_FREQUENCY} ${PARAM_VALUE.WRITE_CLOCK_FREQUENCY}] [Get_Output_Data_Width ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] $asymport ]

   if {$low_latency} {
     set pe_assert_min_new [expr "2*$fifo_in_depth"]
     set pe_assert_max_new [expr "$Output_Depth - $fifo_in_depth"]
   } else {
     set pe_assert_min_new $pe_assert_min
     set pe_assert_max_new $pe_assert_max
   }

##   set_property range_value "$pe_assert_min,$pe_assert_min,$pe_assert_max" $Empty_Threshold_Assert_Value  
   set_property range_value "$pe_assert_min_new,$pe_assert_min_new,$pe_assert_max_new" $Empty_Threshold_Assert_Value  
   
	set_property enabled [expr {($Programmable_Empty_Type == "Single_Programmable_Empty_Threshold_Constant" \
       || $Programmable_Empty_Type == "Multiple_Programmable_Empty_Threshold_Constants")?true:false }] $Empty_Threshold_Assert_Value
}

proc update_PARAM_VALUE.EMPTY_THRESHOLD_NEGATE_VALUE { PARAM_VALUE.EMPTY_THRESHOLD_NEGATE_VALUE PARAM_VALUE.ENABLE_ECC  
  PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.EMPTY_THRESHOLD_ASSERT_VALUE 
  PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DEPTH  
  PARAM_VALUE.PERFORMANCE_OPTIONS PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE  
  PARAM_VALUE.READ_CLOCK_FREQUENCY PARAM_VALUE.WRITE_CLOCK_FREQUENCY PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.INPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.asymmetric_port_width PARAM_VALUE.enable_low_latency} {

   set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
   set EMPTY_THRESHOLD_NEGATE_VALUE  ${PARAM_VALUE.EMPTY_THRESHOLD_NEGATE_VALUE} 
   set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
   set Read_Clock_Frequency [ get_property value ${PARAM_VALUE.READ_CLOCK_FREQUENCY} ]
   set Write_Clock_Frequency [ get_property value ${PARAM_VALUE.WRITE_CLOCK_FREQUENCY} ]
   set Enable_ECC [ get_property value ${PARAM_VALUE.ENABLE_ECC} ]	
   set Input_Depth [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ]
   set Output_Data_Width [ get_property value ${PARAM_VALUE.OUTPUT_DATA_WIDTH} ]
   set Output_Depth [ get_property value ${PARAM_VALUE.OUTPUT_DEPTH} ]
   set Performance_Options [ get_property value ${PARAM_VALUE.PERFORMANCE_OPTIONS} ]
   set Programmable_Empty_Type [ get_property value ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE} ]
   set asymport [get_property value ${PARAM_VALUE.asymmetric_port_width}]
   set Empty_Threshold_Assert_Value [get_property value ${PARAM_VALUE.EMPTY_THRESHOLD_ASSERT_VALUE}]
   set low_latency [get_property value ${PARAM_VALUE.enable_low_latency} ]

   set fifo_in_depth [fifo_generator_v12_0_utils::get_Estimated_FIFO_InDepth $c_family [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] [Get_Output_Data_Width ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ] [ get_property value ${PARAM_VALUE.ENABLE_ECC} ] ]

   
   set pe_negate_max [fifo_generator_v12_0_utils::pe_negate_max $c_family $Fifo_Implementation [expr "$Read_Clock_Frequency > $Write_Clock_Frequency"] [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] $Input_Depth $Output_Data_Width $Output_Depth $Programmable_Empty_Type $Performance_Options $Enable_ECC $asymport]
   ;#set pe_negate_min [fifo_generator_v12_0_utils::pe_negate_min $Programmable_Empty_Type $Empty_Threshold_Assert_Value]
   set pe_negate_min [expr "$Empty_Threshold_Assert_Value + 1"]

   if {$low_latency} {
     set pe_negate_min_new [expr "2*$fifo_in_depth+1"]
     set pe_negate_max_new [expr "$Output_Depth - $fifo_in_depth-2"]
   } else {
     set pe_negate_min_new $pe_negate_min
     set pe_negate_max_new $pe_negate_max
   }
   set_property range_value "$pe_negate_min_new,$pe_negate_min_new,$pe_negate_max_new"  $EMPTY_THRESHOLD_NEGATE_VALUE
   
   set_property enabled [expr {($Programmable_Empty_Type == "Multiple_Programmable_Empty_Threshold_Constants")?true:false }] $EMPTY_THRESHOLD_NEGATE_VALUE
}

proc update_PARAM_VALUE.DATA_COUNT_WIDTH { PARAM_VALUE.DATA_COUNT_WIDTH PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.PERFORMANCE_OPTIONS PARAM_VALUE.DATA_COUNT} {
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	set maxValue [expr { int(ceil(log([ get_property value ${PARAM_VALUE.INPUT_DEPTH} ])/log(2))) }]
	set Data_Count_Width  ${PARAM_VALUE.DATA_COUNT_WIDTH} 
	set MinValue [lindex [split [get_property range $Data_Count_Width] ","] 0]
	if {[ get_property value ${PARAM_VALUE.PERFORMANCE_OPTIONS} ] eq "First_Word_Fall_Through"  && ($Fifo_Implementation eq "Common_Clock_Block_RAM"  || $Fifo_Implementation eq "Common_Clock_Distributed_RAM")} {
		set_property range "$MinValue,[expr {$maxValue + 1}]" $Data_Count_Width   
	} else {
		set_property range "$MinValue,$maxValue" $Data_Count_Width 
	}
	set_property value [lindex [split [get_property range $Data_Count_Width] ","] 1] $Data_Count_Width 
	
	if {[get_property value ${PARAM_VALUE.DATA_COUNT}] == "true"} {
		set_property enabled true $Data_Count_Width 
	} else {
		set_property enabled false $Data_Count_Width 
	}
}

proc update_PARAM_VALUE.ENABLE_ECC { PARAM_VALUE.ENABLE_ECC PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.OUTPUT_DEPTH PARAM_VALUE.asymmetric_port_width} {
   
  set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
  set Enable_ECC  ${PARAM_VALUE.ENABLE_ECC} 
  set asymmetric_port_width [get_property value ${PARAM_VALUE.asymmetric_port_width}]
   if {($Fifo_Implementation == "Independent_Clocks_Builtin_FIFO"
       || $Fifo_Implementation == "Common_Clock_Block_RAM"
       || $Fifo_Implementation == "Independent_Clocks_Block_RAM"
       || $Fifo_Implementation == "Common_Clock_Builtin_FIFO")
       && ([ get_property value ${PARAM_VALUE.INPUT_DEPTH} ] == [ get_property value ${PARAM_VALUE.OUTPUT_DEPTH} ]) && ($asymmetric_port_width == false)} {
      set_property enabled true $Enable_ECC 
   } else {
      set_property enabled false $Enable_ECC 
      set_property value false $Enable_ECC 
   }
}

proc update_PARAM_VALUE.OUTPUT_DATA_WIDTH { PARAM_VALUE.SYNCHRONIZATION_STAGES PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.INPUT_DATA_WIDTH PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.asymmetric_port_width } {

	set Output_Data_Width  ${PARAM_VALUE.OUTPUT_DATA_WIDTH} 
	set asymmetric_port_width [get_property value ${PARAM_VALUE.asymmetric_port_width}]
        set c_family  [ getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}     ]
	set fifo_IMP  [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	set IN_DW     [ get_property value ${PARAM_VALUE.INPUT_DATA_WIDTH}    ] 
	set I_D       [ get_property value ${PARAM_VALUE.INPUT_DEPTH}         ]
	set SYNCHRONIZATION_STAGES       [ get_property value ${PARAM_VALUE.SYNCHRONIZATION_STAGES}]
	set G_IN_DW   [ Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}  ]
	## correct this drive with asymetric_port_width
      
	if {( $fifo_IMP eq "Independent_Clocks_Block_RAM") || ( $fifo_IMP eq "Common_Clock_Block_RAM" )} {
        ;# Fix for CR 780559
        ;# set listvalues [list  [expr $G_IN_DW /8 ]  [expr $G_IN_DW /4 ]  [expr $G_IN_DW /2 ] $G_IN_DW [expr $G_IN_DW * 2 ]  [expr $G_IN_DW * 4 ]  [expr $G_IN_DW *8 ]]
        ;# set listvalues [regsub -all " " $listvalues ","]
        set listvalues [fifo_generator_v12_0_utils::set_Output_Data_Width $G_IN_DW $I_D ]
	} elseif { $c_family == "virtexu"  } {
          set listvalues [fifo_generator_v12_0_utils::set_Output_Data_Width_8series_builtin_fifo $G_IN_DW $I_D $asymmetric_port_width]
	} else {
          set listvalues [fifo_generator_v12_0_utils::set_Output_Data_Width $G_IN_DW $I_D ]
	}
	
	;# Fix for CR 782138
	if { ( $fifo_IMP eq "Independent_Clocks_Block_RAM") && ( $SYNCHRONIZATION_STAGES > 4 ) } {
		set tempList $listvalues
		foreach val $tempList {
			if { [expr $IN_DW * $I_D / $val ] < 32 } {
				set index [tcl::lsearch $listvalues $val]
				set listvalues [tcl::lreplace $listvalues $index $index]
			}
		}
	}
	set listvalues [regsub -all " " $listvalues ","]
	set input_data_width [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}]
	# Fix for CR 780175
	if {$asymmetric_port_width} {
		if { [lsearch [split $listvalues ,] $input_data_width ] == 0 } { 
			set val [lindex [split $listvalues ,] end] 
			set_property range_value "$val , $listvalues"  $Output_Data_Width
		} else {
			set val [lindex [split $listvalues ,] 0] 
			set_property range_value " $val , $listvalues"  $Output_Data_Width
		}
	} else {
			set_property range_value "$input_data_width ,$listvalues" $Output_Data_Width     
	}
	
    if { ( !($c_family eq "virtexu") && (($fifo_IMP eq "Independent_Clocks_Block_RAM")) ) || ( ($asymmetric_port_width) && ($c_family eq "virtexu") && ((($fifo_IMP eq "Independent_Clocks_Block_RAM") || ( $fifo_IMP eq "Common_Clock_Block_RAM" ) ) || (($IN_DW >= 4) && (( $fifo_IMP eq "Common_Clock_Builtin_FIFO" ) || ($fifo_IMP eq "Independent_Clocks_Builtin_FIFO")))) ) } {
		set_property enabled true $Output_Data_Width 
	} else {
		set_property value  $G_IN_DW ${PARAM_VALUE.OUTPUT_DATA_WIDTH}
		set_property enabled false  $Output_Data_Width 
	}

}

proc updateVisibilityOfSYNCHRONIZATION_STAGES_AXI { PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.INTERFACE_TYPE IPINST} {
	set synchronization_stages_axi  [ipgui::get_guiparamspec synchronization_stages_axi -of $IPINST]
	if {[ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq  "Independent_Clock" && [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] != "Native"  } {
	
		set_property visible true $synchronization_stages_axi
	} else {
		set_property visible false $synchronization_stages_axi
	}

}

proc update_PARAM_VALUE.ENABLE_RESET_SYNCHRONIZATION { PARAM_VALUE.ENABLE_RESET_SYNCHRONIZATION PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.RESET_PIN PARAM_VALUE.RESET_TYPE} {

	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	set Reset_Pin [ get_property value ${PARAM_VALUE.RESET_PIN} ]
	set Enable_Reset_Synchronization  ${PARAM_VALUE.ENABLE_RESET_SYNCHRONIZATION} 
	set Reset_Type [get_property value ${PARAM_VALUE.RESET_TYPE}]
   if { ($Reset_Type eq "Asynchronous_Reset") && ($Reset_Pin == true) } {
		if {($Fifo_Implementation eq "Independent_Clocks_Block_RAM"  || $Fifo_Implementation eq "Independent_Clocks_Distributed_RAM" ) } {
			set_property value true $Enable_Reset_Synchronization 
			set_property enabled true $Enable_Reset_Synchronization 
		} elseif {($Fifo_Implementation eq "Common_Clock_Shift_Register" || $Fifo_Implementation eq  "Common_Clock_Block_RAM"|| $Fifo_Implementation eq  "Common_Clock_Distributed_RAM")} {
			set_property value true $Enable_Reset_Synchronization 
			set_property enabled false $Enable_Reset_Synchronization 
		} else {
			set_property value true $Enable_Reset_Synchronization
			set_property enabled false $Enable_Reset_Synchronization
		}
	} else {
		set_property value true $Enable_Reset_Synchronization
		set_property enabled false $Enable_Reset_Synchronization
	}
}

proc update_PARAM_VALUE.TUSER_WIDTH { PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.TUSER_WIDTH} {

	set TUSER_WIDTH  ${PARAM_VALUE.TUSER_WIDTH} 
	if { [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_STREAM" } {
		set_property enabled true $TUSER_WIDTH 
	} else {
		set_property enabled false $TUSER_WIDTH 
	}	

}

proc update_PARAM_VALUE.HAS_TSTRB { PARAM_VALUE.HAS_TSTRB PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.TDATA_NUM_BYTES} {

	if { [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_STREAM" } {
		if { [get_property value ${PARAM_VALUE.TDATA_NUM_BYTES}] > 0 } {
			set_property enabled true  ${PARAM_VALUE.HAS_TSTRB} 
		} else {
			set_property enabled false  ${PARAM_VALUE.HAS_TSTRB} 
			set_property value false  ${PARAM_VALUE.HAS_TSTRB} 
		}
	} else {
		set_property enabled false  ${PARAM_VALUE.HAS_TSTRB} 
		set_property value false  ${PARAM_VALUE.HAS_TSTRB} 
	}

}

proc update_PARAM_VALUE.WRITE_DATA_COUNT_WIDTH { PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.USE_EXTRA_LOGIC  
  PARAM_VALUE.WRITE_DATA_COUNT PARAM_VALUE.WRITE_DATA_COUNT_WIDTH} {
	set increment_write_data_count_width [tcl::lindex [split [get_metaparam_value read_write_data_count_width] " "] 1]
	set store_w [tcl::lindex [split [get_metaparam_value read_write_data_count_width] " "] 0]
	set Write_Data_Count_Width  ${PARAM_VALUE.WRITE_DATA_COUNT_WIDTH} 
        set maxValue [expr { int(ceil(log([ get_property value ${PARAM_VALUE.INPUT_DEPTH} ])/log(2))) }]
	set write_width [ get_property value ${PARAM_VALUE.WRITE_DATA_COUNT_WIDTH} ]
        set MinValue [lindex [split [get_property range $Write_Data_Count_Width] ","] 0]

	if { [ get_property value ${PARAM_VALUE.USE_EXTRA_LOGIC} ] } {
		set_property range_value "[expr {$maxValue + 1}],$MinValue,[expr {$maxValue + 1}]" $Write_Data_Count_Width 
	} else {
		set_property range_value "$maxValue,$MinValue,$maxValue" $Write_Data_Count_Width  
	}
	set write_width [ get_property value ${PARAM_VALUE.WRITE_DATA_COUNT_WIDTH} ]
	
	set Write_Data_Count_Width  ${PARAM_VALUE.WRITE_DATA_COUNT_WIDTH} 
	if {[ get_property value ${PARAM_VALUE.WRITE_DATA_COUNT} ] == true  } {
		set_property enabled true $Write_Data_Count_Width 
		set_property value [expr { [  get_property value ${PARAM_VALUE.WRITE_DATA_COUNT_WIDTH} ] + $increment_write_data_count_width } ] $Write_Data_Count_Width 
	} else {
      set_property enabled false $Write_Data_Count_Width 
      set_property value [lindex [split [get_property range $Write_Data_Count_Width] ","] 1] $Write_Data_Count_Width
	}

}

proc update_read_write_data_count_width {PARAM_VALUE.USE_EXTRA_LOGIC } {

	set stored_use_extra_logic [tcl::lindex [split [get_metaparam_value read_write_data_count_width] " "] 0]
      	if { $stored_use_extra_logic  } {
		set stored_use_extra_logic [ get_property value ${PARAM_VALUE.USE_EXTRA_LOGIC} ]
			# transition from false to true, add width
			return [list $stored_use_extra_logic -1]
	} else {
		return [get_metaparam_value read_write_data_count_width]
	}
}

proc reset_read_write_data_count_width {} {
	return [list "false" 0]
}

proc update_PARAM_VALUE.READ_DATA_COUNT_WIDTH { PARAM_VALUE.OUTPUT_DEPTH PARAM_VALUE.READ_DATA_COUNT  
  PARAM_VALUE.READ_DATA_COUNT_WIDTH PARAM_VALUE.USE_EXTRA_LOGIC} {
	set increment_read_data_count_width [tcl::lindex [split [get_metaparam_value read_write_data_count_width] " "] 1]
	set Read_Data_Count_Width  ${PARAM_VALUE.READ_DATA_COUNT_WIDTH} 
	set maxValue [expr { int(ceil(log([ get_property value ${PARAM_VALUE.OUTPUT_DEPTH} ])/log(2))) }]
	set MinValue [lindex [split [get_property range $Read_Data_Count_Width] ","] 0]
	
	if { [ get_property value ${PARAM_VALUE.USE_EXTRA_LOGIC} ] == true } {
		set_property range_value "[expr {$maxValue + 1}],$MinValue,[expr {$maxValue + 1}]" $Read_Data_Count_Width
	} else {
		set_property range_value "$maxValue,$MinValue,$maxValue" $Read_Data_Count_Width
	}

	
	set Read_Data_Count_Width  ${PARAM_VALUE.READ_DATA_COUNT_WIDTH} 
	if {[ get_property value ${PARAM_VALUE.READ_DATA_COUNT} ] == true} {
		set_property enabled true $Read_Data_Count_Width 
	} else {
		set_property enabled false $Read_Data_Count_Width 
	}
}

proc update_PARAM_VALUE.UNDERFLOW_SENSE_AXI { PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.UNDERFLOW_FLAG_AXI  
  PARAM_VALUE.UNDERFLOW_SENSE_AXI PROJECT_PARAM.ARCHITECTURE} {
	set Underflow_Sense_AXI  ${PARAM_VALUE.UNDERFLOW_SENSE_AXI} 
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	if { $c_family == "virtexu" } {
		set_property enabled false $Underflow_Sense_AXI 
		set_property value [get_property default_value $Underflow_Sense_AXI] $Underflow_Sense_AXI 
		return;
	}
	if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] != "Native"} {
		if {[ get_property value ${PARAM_VALUE.UNDERFLOW_FLAG_AXI} ]} {
			set_property enabled true $Underflow_Sense_AXI 
		} else {
			set_property enabled false $Underflow_Sense_AXI 
			set_property value [get_property default_value $Underflow_Sense_AXI] $Underflow_Sense_AXI 
		}
	} 
}

proc update_PARAM_VALUE.ID_WIDTH { PARAM_VALUE.ID_WIDTH PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.PROTOCOL} {
	set ID_WIDTH  ${PARAM_VALUE.ID_WIDTH} 
	if { [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" && [ get_property value ${PARAM_VALUE.PROTOCOL} ] != "AXI4_Lite" } {			
		set_property enabled true $ID_WIDTH 
	} else {
		set_property enabled false $ID_WIDTH
		set_property value [get_property default_value $ID_WIDTH] $ID_WIDTH  
	}
}

proc update_PARAM_VALUE.HAS_TKEEP { PARAM_VALUE.HAS_TKEEP PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.TDATA_NUM_BYTES} {

	if { [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_STREAM" } {
		if { [get_property value ${PARAM_VALUE.TDATA_NUM_BYTES}] > 0 } {
			set_property enabled true  ${PARAM_VALUE.HAS_TKEEP} 
		} else {
			set_property enabled false  ${PARAM_VALUE.HAS_TKEEP} 
			set_property value false  ${PARAM_VALUE.HAS_TKEEP} 
		}
	} else {
		set_property enabled false  ${PARAM_VALUE.HAS_TKEEP} 
		set_property value false  ${PARAM_VALUE.HAS_TKEEP} 
	}

}

proc update_PARAM_VALUE.USE_EXTRA_LOGIC { PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.PERFORMANCE_OPTIONS  
  PARAM_VALUE.USE_EXTRA_LOGIC PARAM_VALUE.ASYMMETRIC_PORT_WIDTH} {
  set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
  set Performance_Options [ get_property value ${PARAM_VALUE.PERFORMANCE_OPTIONS} ]  
  set Use_Extra_Logic  ${PARAM_VALUE.USE_EXTRA_LOGIC} 
  set asymmetric_port_width [get_property value ${PARAM_VALUE.ASYMMETRIC_PORT_WIDTH}]
  
if { $Performance_Options == "First_Word_Fall_Through"
    && ($Fifo_Implementation == "Independent_Clocks_Block_RAM"
     || $Fifo_Implementation == "Independent_Clocks_Distributed_RAM") } {
		set_property enabled true $Use_Extra_Logic 
		set_property value [get_property default_value $Use_Extra_Logic] $Use_Extra_Logic 
  } elseif { $Performance_Options == "First_Word_Fall_Through"
          && ($Fifo_Implementation == "Common_Clock_Block_RAM"
           || $Fifo_Implementation == "Common_Clock_Distributed_RAM") && !($asymmetric_port_width)} {
		set_property enabled false $Use_Extra_Logic 
		set_property value true $Use_Extra_Logic 
  } elseif { $Fifo_Implementation == "Common_Clock_Block_RAM" && $asymmetric_port_width } {
		set_property enabled false $Use_Extra_Logic 
		set_property value true $Use_Extra_Logic 
  } else {
		set_property enabled false $Use_Extra_Logic 
		set_property value [get_property default_value $Use_Extra_Logic] $Use_Extra_Logic 
  }
}

proc update_PARAM_VALUE.USE_EMBEDDED_REGISTERS { PARAM_VALUE.ENABLE_ECC PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.USE_EMBEDDED_REGISTERS PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.INPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DATA_WIDTH} {
    set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
    set fifo_in_depth [fifo_generator_v12_0_utils::get_Estimated_FIFO_InDepth $c_family [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] [Get_Output_Data_Width ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ] [ get_property value ${PARAM_VALUE.ENABLE_ECC} ] ]
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	set Use_Embedded_Registers  ${PARAM_VALUE.USE_EMBEDDED_REGISTERS} 
   
   
   if {($Fifo_Implementation == "Common_Clock_Block_RAM" || $Fifo_Implementation == "Independent_Clocks_Block_RAM") || ($Fifo_Implementation == "Common_Clock_Builtin_FIFO" && $fifo_in_depth == "1" && $c_family != "virtexu") || (($Fifo_Implementation == "Common_Clock_Builtin_FIFO") && $c_family == "virtexu") } {
		;# Fix for CR 781101
		if { $Fifo_Implementation == "Common_Clock_Builtin_FIFO" } {
			if { ![ get_property value ${PARAM_VALUE.ENABLE_ECC} ] } {
				if { $c_family == "virtexu" } {
					set_property value true  ${PARAM_VALUE.USE_EMBEDDED_REGISTERS} 
				} else {
					set_property value false  ${PARAM_VALUE.USE_EMBEDDED_REGISTERS} 
				}
				set_property enabled true $Use_Embedded_Registers 
			} else {
				set_property value false  ${PARAM_VALUE.USE_EMBEDDED_REGISTERS}
				set_property enabled false $Use_Embedded_Registers 
			}
		} else {
			set_property enabled true $Use_Embedded_Registers 
			if { $c_family == "virtexu" } {
				set_property value true  ${PARAM_VALUE.USE_EMBEDDED_REGISTERS} 
			} else {
				set_property value false  ${PARAM_VALUE.USE_EMBEDDED_REGISTERS} 
			}
		}
   } else {
      set_property enabled false  ${PARAM_VALUE.USE_EMBEDDED_REGISTERS}  
	  set_property value false  ${PARAM_VALUE.USE_EMBEDDED_REGISTERS} 
   }
}

proc update_PARAM_VALUE.TSTRB_WIDTH { PARAM_VALUE.TDATA_NUM_BYTES PARAM_VALUE.TSTRB_WIDTH} {
	set TSTRB_WIDTH  ${PARAM_VALUE.TSTRB_WIDTH} 
	set value [ get_property value ${PARAM_VALUE.TDATA_NUM_BYTES} ]
	if {$value > 0} {
		set_property enabled false $TSTRB_WIDTH
	} else {
		set_property enabled false $TSTRB_WIDTH
	}
	set_property range "$value,$value" $TSTRB_WIDTH
}

proc update_PARAM_VALUE.USE_EMBEDDED_REGISTERS_AXIS { PARAM_VALUE.AXIS_TYPE PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS  
  PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.USE_EMBEDDED_REGISTERS_AXIS} {
		
	set FIFO_Implementation_fifo_name [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} ]
	set Use_Embedded_Registers_axis  ${PARAM_VALUE.USE_EMBEDDED_REGISTERS_AXIS}  
	
	if { ([ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_STREAM" &&
	  [ get_property value ${PARAM_VALUE.AXIS_TYPE} ] == "FIFO" ) && [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS} ] == "Data_FIFO" && 
	  ($FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM" || $FIFO_Implementation_fifo_name == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_fifo_name == "Common_Clock_Builtin_FIFO") } {
		set_property enabled true $Use_Embedded_Registers_axis
	} else {
		set_property enabled false $Use_Embedded_Registers_axis
		set_property value false $Use_Embedded_Registers_axis
	}
}

proc update_PARAM_VALUE.OVERFLOW_SENSE { PARAM_VALUE.OVERFLOW_FLAG PARAM_VALUE.OVERFLOW_SENSE} {

	set Overflow_Sense  ${PARAM_VALUE.OVERFLOW_SENSE} 
	if {[ get_property value ${PARAM_VALUE.OVERFLOW_FLAG} ]} {
		set_property enabled true $Overflow_Sense
   } else {
		set_property enabled false $Overflow_Sense 
		set_property value [get_property default_value $Overflow_Sense] $Overflow_Sense
   }

}
proc update_gui_for_PARAM_VALUE.WRITE_ACKNOWLEDGE_SENSE {IPINST PROJECT_PARAM.ARCHITECTURE } {
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set Write_Acknowledge_Sense [ipgui::get_guiparamspec Write_Acknowledge_Sense -of $IPINST]
	if { $c_family == "virtexu" } {
		set_property visible false $Write_Acknowledge_Sense
	}
}


proc update_gui_for_PARAM_VALUE.OVERFLOW_SENSE {IPINST PROJECT_PARAM.ARCHITECTURE } {
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set Overflow_Sense [ipgui::get_guiparamspec Overflow_Sense -of $IPINST]
	if { $c_family == "virtexu" } {
		set_property visible false $Overflow_Sense
	}
}


proc update_gui_for_PARAM_VALUE.UNDERFLOW_SENSE {IPINST PROJECT_PARAM.ARCHITECTURE } {
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set Underflow_Sense [ipgui::get_guiparamspec Underflow_Sense -of $IPINST]
	if { $c_family == "virtexu" } {
		set_property visible false $Underflow_Sense
	}
}

proc update_gui_for_PARAM_VALUE.VALID_SENSE {IPINST PROJECT_PARAM.ARCHITECTURE } {
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set valid_sense [ipgui::get_guiparamspec Valid_Sense -of $IPINST]
	if { $c_family == "virtexu" } {
		set_property visible false $valid_sense
	}
}

proc update_PARAM_VALUE.VALID_SENSE { PARAM_VALUE.VALID_FLAG PARAM_VALUE.VALID_SENSE} {

	set Valid_Sense  ${PARAM_VALUE.VALID_SENSE} 
	if {[ get_property value ${PARAM_VALUE.VALID_FLAG} ]} {
		set_property enabled true $Valid_Sense
   } else {
      set_property enabled false $Valid_Sense
      set_property value [get_property default_value $Valid_Sense] $Valid_Sense
   }

}

proc update_PARAM_VALUE.OUTPUT_DEPTH { PARAM_VALUE.INPUT_DATA_WIDTH PARAM_VALUE.INPUT_DEPTH  
  PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DEPTH} {
# [ get_property value ${PARAM_VALUE.INPUT_DATA_WIDTH} ] 
# [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ]

	set value [expr { int( ([ get_property value ${PARAM_VALUE.INPUT_DATA_WIDTH} ] * [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ]) / [ get_property value ${PARAM_VALUE.OUTPUT_DATA_WIDTH} ] )}]  
	set_property range_value $value,$value ${PARAM_VALUE.OUTPUT_DEPTH} 

}

proc update_PARAM_VALUE.WRITE_ACKNOWLEDGE_SENSE { PARAM_VALUE.WRITE_ACKNOWLEDGE_FLAG PARAM_VALUE.WRITE_ACKNOWLEDGE_SENSE} {
	set Write_Acknowledge_Sense  ${PARAM_VALUE.WRITE_ACKNOWLEDGE_SENSE} 
	if {[ get_property value ${PARAM_VALUE.WRITE_ACKNOWLEDGE_FLAG} ]} {
		set_property enabled true $Write_Acknowledge_Sense 
	} else {
		set_property enabled false $Write_Acknowledge_Sense 
		set_property value [get_property default_value $Write_Acknowledge_Sense] $Write_Acknowledge_Sense 
	}

}

proc update_PARAM_VALUE.UNDERFLOW_SENSE { PARAM_VALUE.UNDERFLOW_FLAG PARAM_VALUE.UNDERFLOW_SENSE} {
	set Underflow_Sense  ${PARAM_VALUE.UNDERFLOW_SENSE} 
	if {[ get_property value ${PARAM_VALUE.UNDERFLOW_FLAG} ]} {
		set_property enabled true $Underflow_Sense
	} else {
		set_property enabled false $Underflow_Sense 
		set_property value [get_property default_value $Underflow_Sense] $Underflow_Sense 
	}
}

proc update_PARAM_VALUE.INJECT_SBIT_ERROR { PARAM_VALUE.ENABLE_ECC PARAM_VALUE.INJECT_SBIT_ERROR} {
	
	set Inject_Sbit_Error  ${PARAM_VALUE.INJECT_SBIT_ERROR} 
	if { [ get_property value ${PARAM_VALUE.ENABLE_ECC} ] == true } {
      set_property enabled true $Inject_Sbit_Error
   } else {
      set_property enabled false $Inject_Sbit_Error
      set_property value [get_property default_value $Inject_Sbit_Error] $Inject_Sbit_Error 
   }
}

proc update_gui { PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS  
  PARAM_VALUE.INTERFACE_TYPE IPINST} {
	;# updateOfHandShake_Flags_AXI
	set HandShake_Flags_AXI [ipgui::get_groupspec HandShake_Flags_AXI -of $IPINST]
	set val [expr {(([ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_STREAM") && ([ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} ] == "Independent_Clocks_Distributed_RAM") && ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS} ] == "Low_Latency_Data_FIFO"))?false:true }]
	set_property enabled $val $HandShake_Flags_AXI 
	# set_property enabled $val [ipgui::get_guiparamspec Underflow_Flag_AXI -of $IPINST]
	# set_property enabled $val [ipgui::get_guiparamspec Overflow_Flag_AXI -of $IPINST]
}

proc update_PARAM_VALUE.ENABLE_COMMON_UNDERFLOW {PARAM_VALUE.ENABLE_COMMON_UNDERFLOW PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS  
  PARAM_VALUE.INTERFACE_TYPE} {
	set val [expr {(([ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_STREAM") && ([ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} ] == "Independent_Clocks_Distributed_RAM") && ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS} ] == "Low_Latency_Data_FIFO"))?false:true }]
	set_property enabled $val ${PARAM_VALUE.ENABLE_COMMON_UNDERFLOW}
}

proc update_PARAM_VALUE.ENABLE_COMMON_OVERFLOW {PARAM_VALUE.ENABLE_COMMON_OVERFLOW PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS  
  PARAM_VALUE.INTERFACE_TYPE} {
	set val [expr {(([ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_STREAM") && ([ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} ] == "Independent_Clocks_Distributed_RAM") && ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS} ] == "Low_Latency_Data_FIFO"))?false:true }]
	set_property enabled $val ${PARAM_VALUE.ENABLE_COMMON_OVERFLOW}
}

proc update_PARAM_VALUE.use_dout_register {PARAM_VALUE.use_dout_register PARAM_VALUE.enable_low_latency} {
	set dout_reg ${PARAM_VALUE.use_dout_register} 
	set low_latency [get_property value ${PARAM_VALUE.enable_low_latency} ]
	if {$low_latency} {
		set_property enabled true $dout_reg
	} else {
		set_property enabled false $dout_reg
		set_property value false $dout_reg
	}
}

proc update_PARAM_VALUE.enable_low_latency { PARAM_VALUE.enable_low_latency PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.INTERFACE_TYPE PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.INPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.ENABLE_ECC} {
	 set FIFO_IMPLEMENTATION  [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]  
	 set interface_type [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]  
	 set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	 set low_latency  ${PARAM_VALUE.enable_low_latency}
	 set fifo_in_depth [fifo_generator_v12_0_utils::get_Estimated_FIFO_InDepth $c_family [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] [Get_Output_Data_Width ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ] [ get_property value ${PARAM_VALUE.ENABLE_ECC} ] ]
	 
	if {($fifo_in_depth > 1 ) &&  ($c_family eq "virtexu" ) && ($interface_type eq "Native" ) && ($FIFO_IMPLEMENTATION eq "Independent_Clocks_Builtin_FIFO" || $FIFO_IMPLEMENTATION eq "Common_Clock_Builtin_FIFO")} {
		set_property enabled true $low_latency
	} else {
		set_property enabled false $low_latency
		set_property value false $low_latency
	}
}
	
proc update_gui_for_PARAM_VALUE.FIFO_IMPLEMENTATION { PARAM_VALUE.FIFO_IMPLEMENTATION IPINST PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.use_dout_register PARAM_VALUE.enable_low_latency} {
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	updateVisibilityOfSYNCHRONIZATION_STAGES ${PARAM_VALUE.FIFO_IMPLEMENTATION} ${PARAM_VALUE.INTERFACE_TYPE} $IPINST

   	   set FIFO_IMPLEMENTATION  [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]  
	   set interface_type [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]  
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
		if {  ($c_family eq "virtexu" ) && ($interface_type eq "Native" ) && ($FIFO_IMPLEMENTATION eq "Independent_Clocks_Builtin_FIFO" || $FIFO_IMPLEMENTATION eq "Common_Clock_Builtin_FIFO")} {
			set_property visible true [ipgui::get_guiparamspec  use_dout_register -of $IPINST ]  
			set_property visible true [ipgui::get_guiparamspec  enable_low_latency -of $IPINST ]  
		} else { 
			set_property visible false [ipgui::get_guiparamspec  use_dout_register -of $IPINST ]  
			set_property visible false [ipgui::get_guiparamspec  enable_low_latency -of $IPINST ]  
		}
	
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	if {$Fifo_Implementation == "Independent_Clocks_Block_RAM"} {
		foreach val {Independent_Clocks_Block_RAM5 Independent_Clocks_Block_RAM4 Independent_Clocks_Block_RAM2 
			Independent_Clocks_Block_RAM1 } {
			set_property load_image "xgui/Check_mark.png"  [ipgui::get_imagespec $val -of $IPINST]
		}			
	} else {
		foreach val {Independent_Clocks_Block_RAM5 Independent_Clocks_Block_RAM4 Independent_Clocks_Block_RAM2 
			Independent_Clocks_Block_RAM1 } {
			set_property load_image "xgui/CheckmarkGrey.png"  [ipgui::get_imagespec  $val -of $IPINST]
		}
	}
	
	if {$Fifo_Implementation == "Independent_Clocks_Builtin_FIFO"} {
		foreach val {Independent_Clocks_Builtin_FIFO5 Independent_Clocks_Builtin_FIFO4  Independent_Clocks_Builtin_FIFO3
			Independent_Clocks_Builtin_FIFO2 Independent_Clocks_Builtin_FIFO1} {
			set_property load_image "xgui/Check_mark.png"  [ipgui::get_imagespec $val -of $IPINST]
		}
	} else {
		foreach val {Independent_Clocks_Builtin_FIFO5 Independent_Clocks_Builtin_FIFO4  Independent_Clocks_Builtin_FIFO3
			Independent_Clocks_Builtin_FIFO2 Independent_Clocks_Builtin_FIFO1} {
			set_property load_image "xgui/CheckmarkGrey.png"  [ipgui::get_imagespec  $val -of $IPINST]
		}
	}
	
	if {$Fifo_Implementation == "Independent_Clocks_Distributed_RAM"} {
		set_property load_image "xgui/Check_mark.png"  [ipgui::get_imagespec Independent_Clocks_Distributed_RAM2 -of $IPINST]
	} else {
		set_property load_image "xgui/CheckmarkGrey.png"  [ipgui::get_imagespec  Independent_Clocks_Distributed_RAM2 -of $IPINST]
	}
	
	if {$Fifo_Implementation == "Common_Clock_Builtin_FIFO"} {
		foreach val {Common_Clock_Builtin_FIFO5  Common_Clock_Builtin_FIFO4 Common_Clock_Builtin_FIFO3 Common_Clock_Builtin_FIFO2 Common_Clock_Builtin_FIFO1} {
			set_property load_image "xgui/Check_mark.png"  [ipgui::get_imagespec $val -of $IPINST]
		}
	} else {
		foreach val {Common_Clock_Builtin_FIFO5  Common_Clock_Builtin_FIFO4 Common_Clock_Builtin_FIFO3 Common_Clock_Builtin_FIFO2 Common_Clock_Builtin_FIFO1} {
			set_property load_image "xgui/CheckmarkGrey.png"  [ipgui::get_imagespec  $val -of $IPINST]
		}
	}
	
	if {$Fifo_Implementation == "Common_Clock_Shift_Register"} {
	} else {
	}
	
	if {$Fifo_Implementation == "Common_Clock_Distributed_RAM"} {
		foreach val {Common_Clock_Distributed_RAM2} {
			set_property load_image "xgui/Check_mark.png"  [ipgui::get_imagespec $val -of $IPINST]
		}
	} else {
		foreach val {Common_Clock_Distributed_RAM2 } {
			set_property load_image "xgui/CheckmarkGrey.png"  [ipgui::get_imagespec  $val -of $IPINST]
		}
	}
	
	if {$Fifo_Implementation == "Common_Clock_Block_RAM"} {
		foreach val {Common_Clock_Block_RAM5 Common_Clock_Block_RAM4 Common_Clock_Block_RAM2 } {
			set_property load_image "xgui/Check_mark.png"  [ipgui::get_imagespec $val -of $IPINST]
		}
	} else {
		foreach val {Common_Clock_Block_RAM5 Common_Clock_Block_RAM4 Common_Clock_Block_RAM2  } {
			set_property load_image "xgui/CheckmarkGrey.png"  [ipgui::get_imagespec  $val -of $IPINST]
		}
	}
	
	
	
	if { $Fifo_Implementation eq "Independent_Clocks_Builtin_FIFO"} {
		set_property visible true [ipgui::get_groupspec -name "Built-in FIFO Options" -of $IPINST]
	} else {
		set_property visible false [ipgui::get_groupspec -name "Built-in FIFO Options" -of $IPINST]
	}
	
	if { $Fifo_Implementation eq "Common_Clock_Builtin_FIFO" || $Fifo_Implementation eq "Independent_Clocks_Builtin_FIFO" } {
		set_property visible false [ipgui::get_groupspec -name "Optional Flags" -of $IPINST]
		set_property visible false [ipgui::get_pagespec -name page6_FIFO -of $IPINST]
		set_property visible true [ipgui::get_textspec Estimated_Imp_Usage_Value -of $IPINST] 
		set_property visible true [ipgui::get_textspec Estimated_Imp_Usage -of $IPINST]
		set_property visible true [ipgui::get_textspec Number_of_FIFO_chained_in_depth_Value -of $IPINST]
	} else {
		set_property visible true [ipgui::get_groupspec -name "Optional Flags" -of $IPINST]
		if { [get_property value ${PARAM_VALUE.INTERFACE_TYPE}] == "Native" } {
			set_property visible true [ipgui::get_pagespec -name page6_FIFO -of $IPINST]
		} else {
			set_property visible false [ipgui::get_pagespec -name page6_FIFO -of $IPINST]
		}
		set_property visible false [ipgui::get_textspec Estimated_Imp_Usage_Value -of $IPINST]
		set_property visible false [ipgui::get_textspec Number_of_FIFO_chained_in_depth_Value -of $IPINST]
		if { $Fifo_Implementation eq "Common_Clock_Block_RAM" || $Fifo_Implementation eq "Independent_Clocks_Block_RAM" } {
			set_property visible true [ipgui::get_textspec Estimated_Imp_Usage -of $IPINST]
		} else {
			set_property visible false [ipgui::get_textspec Estimated_Imp_Usage -of $IPINST]
		}
	}
	
	set_property visible false [ipgui::get_textspec Estimated_Imp_Usage_Comment -of $IPINST]
	set_property visible false [ipgui::get_textspec BlockRAM_Blocks_Used_9 -of $IPINST]
	set val1 [expr {(($Fifo_Implementation == "Common_Clock_Block_RAM" || $Fifo_Implementation == "Independent_Clocks_Block_RAM") && ($c_family == "virtexu" || $c_family == "virtex7" || $c_family == "kintex7" || $c_family == "artix7" || $c_family == "zynq"))?true:false}]
	set_property visible $val1 [ipgui::get_textspec BlockRAM_Blocks_Used_36 -of $IPINST]
	
	if { ($Fifo_Implementation == "Common_Clock_Shift_Register" ) || ((($Fifo_Implementation == "Common_Clock_Builtin_FIFO") || ($Fifo_Implementation == "Independent_Clocks_Builtin_FIFO")) && ( $c_family ne "virtexu") && ( $c_family ne "virtex7") && ( $c_family ne "kintex7") && ( $c_family ne "artix7") && ( $c_family ne "zynq") ) } {
		set_property enabled false [ipgui::get_textspec LabelFifo_ImplementationComment2 -of $IPINST]
	} else {
		set_property enabled true [ipgui::get_textspec LabelFifo_ImplementationComment2 -of $IPINST]
	}

	if { (($Fifo_Implementation == "Common_Clock_Builtin_FIFO" ) || ($Fifo_Implementation == "Independent_Clocks_Builtin_FIFO")) && ( $c_family eq "virtexu" || $c_family eq "virtex7" || $c_family eq "kintex7" || $c_family eq "artix7" || $c_family eq "zynq" ) } {
		set_property enabled true [ipgui::get_textspec LabelFifo_ImplementationComment3 -of $IPINST]
	} else {
		set_property enabled false [ipgui::get_textspec LabelFifo_ImplementationComment3 -of $IPINST]
	}
   
	if { (($Fifo_Implementation == "Common_Clock_Builtin_FIFO" ) || ($Fifo_Implementation == "Independent_Clocks_Builtin_FIFO") || ($Fifo_Implementation == "Common_Clock_Block_RAM") || ($Fifo_Implementation == "Independent_Clocks_Block_RAM")) && ($c_family eq "virtexu" || $c_family eq "virtex7" || $c_family eq "kintex7" || $c_family eq "artix7" || $c_family eq "zynq") } {
		set_property enabled true [ipgui::get_textspec LabelFifo_ImplementationComment4 -of $IPINST]
	} else {
		set_property enabled false [ipgui::get_textspec LabelFifo_ImplementationComment4 -of $IPINST]
	}

	if { (($Fifo_Implementation == "Common_Clock_Builtin_FIFO" ) || ($Fifo_Implementation == "Independent_Clocks_Builtin_FIFO") || ($Fifo_Implementation == "Common_Clock_Block_RAM") || ($Fifo_Implementation == "Independent_Clocks_Block_RAM")) && ( $c_family eq "virtexu" || $c_family eq "virtex7" || $c_family eq "kintex7" || $c_family eq "artix7" || $c_family eq "zynq") } {
		set_property enabled true [ipgui::get_textspec LabelFifo_ImplementationComment5 -of $IPINST]
	} else {
		set_property enabled false [ipgui::get_textspec LabelFifo_ImplementationComment5 -of $IPINST]
	}
	
	if { ((($Fifo_Implementation == "Independent_Clocks_Block_RAM" )) || (($c_family == "virtexu") && (($Fifo_Implementation == "Common_Clock_Block_RAM") || ($Fifo_Implementation == "Common_Clock_Builtin_FIFO") || ($Fifo_Implementation == "Independent_Clocks_Builtin_FIFO"))))} {
		set_property enabled true [ipgui::get_textspec LabelFifo_ImplementationComment1 -of $IPINST]
	} else {
		set_property enabled false [ipgui::get_textspec LabelFifo_ImplementationComment1 -of $IPINST]
	}
}

proc update_PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH { PARAM_VALUE.CLOCK_TYPE_AXI  
  PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH  
  PARAM_VALUE.INTERFACE_TYPE PROJECT_PARAM.ARCHITECTURE} {
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
		
	set FIFO_Implementation_fifo_name  ${PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH} 
	
	if { [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] != "Native" } {
		if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {
			# if { $c_family == "virtexu" || $c_family == "virtex7" || $c_family == "virtex7l" || $c_family == "kintex7" || $c_family == "kintex7l" || $c_family == "artix7" || $c_family == "zynq" } {
				# ;### Common Clock Builin Fifo is enabled for AXI for V6 and above devices. ###
				# set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
			# } else {
				# set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
			# }

			if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ] != "Packet_FIFO"} {
				if { $c_family == "virtexu" } {
					set_property range_value "Common_Clock_Distributed_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM,Common_Clock_Builtin_FIFO"  $FIFO_Implementation_fifo_name
				} else {
					set_property range_value "Common_Clock_Distributed_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
				}
			} else {
				if { $c_family == "virtexu" } {
					;# Fix for CR 781449
					;# set_property range_value "Common_Clock_Distributed_RAM,Common_Clock_Distributed_RAM,Common_Clock_Builtin_FIFO"  $FIFO_Implementation_fifo_name
					if {  [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" } {
						set_property range_value "Common_Clock_Distributed_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
					} else {
						set_property range_value "Common_Clock_Distributed_RAM,Common_Clock_Distributed_RAM,Common_Clock_Builtin_FIFO"  $FIFO_Implementation_fifo_name
					}
				} else {
					set_property range_value "Common_Clock_Distributed_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
				}
			}
			
		} elseif { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq  "Independent_Clock" } {
			if { $c_family == "virtexu" } {
				;# Fix for CR 781449
				;# set_property range_value "Independent_Clocks_Distributed_RAM,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM,Independent_Clocks_Builtin_FIFO" $FIFO_Implementation_fifo_name
				if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ] == "Packet_FIFO" && [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" } {
					set_property range_value "Independent_Clocks_Distributed_RAM,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
				} else {
					set_property range_value "Independent_Clocks_Distributed_RAM,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM,Independent_Clocks_Builtin_FIFO" $FIFO_Implementation_fifo_name
				}
			} else {
				set_property range_value "Independent_Clocks_Distributed_RAM,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
			}
			;#set_property value "Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
		}	   
	} else {
		if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {
			set_property range "Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
		} else {
			set_property range "Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
		}
	}
}

proc update_PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH { PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH  
  PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH  PARAM_VALUE.INTERFACE_TYPE PROJECT_PARAM.ARCHITECTURE} {
		  
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set FIFO_Implementation_fifo_name  ${PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH} 
	if { [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] != "Native" } {
		if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {
			# if { $c_family == "virtexu" || $c_family == "virtex7" || $c_family == "virtex7l" || $c_family == "kintex7" || $c_family == "kintex7l" || $c_family == "artix7" || $c_family == "zynq" } {
				## Common Clock Builin Fifo is enabled for AXI for V6 and above devices. ###
				# set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
			# } else {
				# set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
			# }
			if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH} ] != "Packet_FIFO"} {
				if { $c_family == "virtexu" } {
					set_property range_value "Common_Clock_Builtin_FIFO,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM,Common_Clock_Builtin_FIFO"  $FIFO_Implementation_fifo_name
				} else {
					set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
				}
			} else {
				if { $c_family == "virtexu" } {
					;# Fix for CR 781449
					;# set_property range_value "Common_Clock_Builtin_FIFO,Common_Clock_Block_RAM,Common_Clock_Builtin_FIFO"  $FIFO_Implementation_fifo_name
					if {  [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" } {
						set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM"  $FIFO_Implementation_fifo_name
					} else {
						set_property range_value "Common_Clock_Builtin_FIFO,Common_Clock_Block_RAM,Common_Clock_Builtin_FIFO"  $FIFO_Implementation_fifo_name
					}
				} else {
					set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM"  $FIFO_Implementation_fifo_name
				}
			}
		} elseif { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq  "Independent_Clock" } {
			if { $c_family == "virtexu" } {
				;# Fix for CR 781449
				;# set_property range_value "Independent_Clocks_Builtin_FIFO,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM,Independent_Clocks_Builtin_FIFO" $FIFO_Implementation_fifo_name
				if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH} ] == "Packet_FIFO" && [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" } {
					set_property range_value "Independent_Clocks_Block_RAM,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
				} else {
					set_property range_value "Independent_Clocks_Builtin_FIFO,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM,Independent_Clocks_Builtin_FIFO" $FIFO_Implementation_fifo_name
				}
			} else {
				set_property range_value "Independent_Clocks_Block_RAM,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
			}
			;# set_property value "Independent_Clocks_Block_RAM" $FIFO_Implementation_fifo_name
		}	   
		
	} else {
		if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {
			set_property range "Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
		} else {
			set_property range "Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
		}
	}
}

proc update_PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS { PARAM_VALUE.CLOCK_TYPE_AXI   
  PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS  PARAM_VALUE.INTERFACE_TYPE PROJECT_PARAM.ARCHITECTURE} {
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
		
	set FIFO_Implementation_fifo_name  ${PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} 
	
	if { [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] != "Native" } {
		if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {
			if { $c_family == "virtexu" || $c_family == "virtex7" || $c_family == "virtex7l" || $c_family == "kintex7" || $c_family == "kintex7l" || $c_family == "artix7" || $c_family == "zynq" } {
				if { $c_family == "virtexu" } {
					### Common Clock Builin Fifo is enabled for AXI for V6 and above devices. ###
					set_property range_value "Common_Clock_Builtin_FIFO,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM,Common_Clock_Builtin_FIFO"  $FIFO_Implementation_fifo_name
				} else {
					set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
				}
			} else {
				set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM" $FIFO_Implementation_fifo_name 
			}

			;# set_property value "Common_Clock_Block_RAM" $FIFO_Implementation_fifo_name 
		} elseif { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq  "Independent_Clock" } {
			if { $c_family == "virtexu" } {
				set_property range_value "Independent_Clocks_Builtin_FIFO,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM,Independent_Clocks_Builtin_FIFO" $FIFO_Implementation_fifo_name
			} else {
				set_property range_value "Independent_Clocks_Block_RAM,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
			}
			;# set_property value "Independent_Clocks_Block_RAM" $FIFO_Implementation_fifo_name
		}	 
	} else {
		if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {
			set_property range "Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
		} else {
			set_property range "Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
		}
	}
}

proc update_PARAM_VALUE.FIFO_IMPLEMENTATION_RACH { PARAM_VALUE.CLOCK_TYPE_AXI   
  PARAM_VALUE.FIFO_IMPLEMENTATION_RACH  PARAM_VALUE.INTERFACE_TYPE PROJECT_PARAM.ARCHITECTURE} {
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
		
	set FIFO_Implementation_fifo_name  ${PARAM_VALUE.FIFO_IMPLEMENTATION_RACH} 
	
	if { [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] != "Native" } {
		if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {
			if { $c_family == "virtexu" || $c_family == "virtex7" || $c_family == "virtex7l" || $c_family == "kintex7" || $c_family == "kintex7l" || $c_family == "artix7" || $c_family == "zynq" } {
				if { $c_family == "virtexu" } {
					### Common Clock Builin Fifo is enabled for AXI for V8 devices. ###
					set_property range_value "Common_Clock_Distributed_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM,Common_Clock_Builtin_FIFO"  $FIFO_Implementation_fifo_name
				} else {
					set_property range_value "Common_Clock_Distributed_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
				}
			} else {
				set_property range_value "Common_Clock_Distributed_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM" $FIFO_Implementation_fifo_name 
			}

			;# set_property value "Common_Clock_Distributed_RAM" $FIFO_Implementation_fifo_name
		} elseif { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq  "Independent_Clock" } {
			if { $c_family == "virtexu" } {
				set_property range_value "Independent_Clocks_Distributed_RAM,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM,Independent_Clocks_Builtin_FIFO" $FIFO_Implementation_fifo_name
			} else {
				set_property range_value "Independent_Clocks_Distributed_RAM,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
			}
			;# set_property value "Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
		}	 
	} else {
		if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {
			set_property range "Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
		} else {
			set_property range "Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
		}
	}
}

proc update_PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH { PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH  
  PARAM_VALUE.INTERFACE_TYPE PROJECT_PARAM.ARCHITECTURE} {
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
		
	set FIFO_Implementation_fifo_name  ${PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH} 
	
	if { [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] != "Native" } {
		if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {
			;# commenting this code as the range is same in both if-else
			# if { $c_family == "virtexu" || $c_family == "virtex7" || $c_family == "virtex7l" || $c_family == "kintex7" || $c_family == "kintex7l" || $c_family == "artix7" || $c_family == "zynq" } {
				# ;### Common Clock Builin Fifo is enabled for AXI for V6 and above devices. ###
				# set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
			# } else {
				# set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
			# }
			
			if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ] != "Packet_FIFO"} {
				if { $c_family == "virtexu" } {
					set_property range_value "Common_Clock_Builtin_FIFO,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM,Common_Clock_Builtin_FIFO"  $FIFO_Implementation_fifo_name
				} else {
					set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
				}
			} else {
				if { $c_family == "virtexu" } {
					;# Fix for CR 781449
					# set_property range_value "Common_Clock_Builtin_FIFO,Common_Clock_Block_RAM,Common_Clock_Builtin_FIFO"  $FIFO_Implementation_fifo_name
					if {  [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" } {
						set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM"  $FIFO_Implementation_fifo_name
					} else {
						set_property range_value "Common_Clock_Builtin_FIFO,Common_Clock_Block_RAM,Common_Clock_Builtin_FIFO"  $FIFO_Implementation_fifo_name
					}
				} else {
					set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM"  $FIFO_Implementation_fifo_name
				}
			}
		} elseif { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq  "Independent_Clock" } {
			if { $c_family == "virtexu" } {
				;# Fix for CR 781449
				;# set_property range_value "Independent_Clocks_Builtin_FIFO,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM,Independent_Clocks_Builtin_FIFO" $FIFO_Implementation_fifo_name
				if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ] == "Packet_FIFO" && [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" } {
					set_property range_value "Independent_Clocks_Block_RAM,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
				} else {
					set_property range_value "Independent_Clocks_Builtin_FIFO,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM,Independent_Clocks_Builtin_FIFO" $FIFO_Implementation_fifo_name
				}
			} else {
				set_property range_value "Independent_Clocks_Block_RAM,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
			}
			;#set_property value "Independent_Clocks_Block_RAM" $FIFO_Implementation_fifo_name
		}	   
	} else {
		if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {
			set_property range "Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
		} else {
			set_property range "Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
		}
	}
}

proc update_PARAM_VALUE.FIFO_IMPLEMENTATION_WACH { PARAM_VALUE.CLOCK_TYPE_AXI   
  PARAM_VALUE.FIFO_IMPLEMENTATION_WACH PARAM_VALUE.INTERFACE_TYPE PROJECT_PARAM.ARCHITECTURE} {
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
		
	set FIFO_Implementation_fifo_name  ${PARAM_VALUE.FIFO_IMPLEMENTATION_WACH} 
	
	if { [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] != "Native" } {
		if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {
			
			if { $c_family == "virtexu" || $c_family == "virtex7" || $c_family == "virtex7l" || $c_family == "kintex7" || $c_family == "kintex7l" || $c_family == "artix7" || $c_family == "zynq" } {
				if { $c_family == "virtexu" } {
					### Common Clock Builin Fifo is enabled for AXI for V8 devices. ###
					set_property range_value "Common_Clock_Distributed_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM,Common_Clock_Builtin_FIFO"  $FIFO_Implementation_fifo_name
				} else {
					set_property range_value "Common_Clock_Distributed_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
				}
			} else {
				set_property range_value "Common_Clock_Distributed_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM" $FIFO_Implementation_fifo_name 
			}

			;# set_property value "Common_Clock_Distributed_RAM" $FIFO_Implementation_fifo_name
		} elseif { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq  "Independent_Clock" } {
			
			if { $c_family == "virtexu" } {
				set_property range_value "Independent_Clocks_Distributed_RAM,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM,Independent_Clocks_Builtin_FIFO" $FIFO_Implementation_fifo_name
			} else {
				set_property range_value "Independent_Clocks_Distributed_RAM,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
			}
			;# set_property value "Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
		}	 
		
	} else {
		if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {
			set_property range "Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
		} else {
			set_property range "Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
		}
	}
}

proc update_PARAM_VALUE.UNDERFLOW_FLAG_AXI { PARAM_VALUE.AXIS_TYPE PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS  
  PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH PARAM_VALUE.FIFO_APPLICATION_TYPE_RDCH  PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS  
  PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH PARAM_VALUE.FIFO_APPLICATION_TYPE_WDCH  
  PARAM_VALUE.FIFO_APPLICATION_TYPE_WRCH PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_AXIS PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_RACH  
  PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_RDCH PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WACH  
  PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WDCH PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WRCH  
  PARAM_VALUE.PROTOCOL PARAM_VALUE.RACH_TYPE  
  PARAM_VALUE.RDCH_TYPE PARAM_VALUE.READ_WRITE_MODE  
  PARAM_VALUE.UNDERFLOW_FLAG_AXI PARAM_VALUE.WACH_TYPE  
  PARAM_VALUE.WDCH_TYPE PARAM_VALUE.WRCH_TYPE PROJECT_PARAM.ARCHITECTURE} {
	
	set Underflow_Flag_AXI  ${PARAM_VALUE.UNDERFLOW_FLAG_AXI} 
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	if { $c_family == "virtexu" } {
		set_property enabled false $Underflow_Flag_AXI 
		set_property value false $Underflow_Flag_AXI 
		return;
	}
	
	if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] != "Native" } {
		if { !([ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" &&  [ get_property value ${PARAM_VALUE.PROTOCOL} ] != "AXI4_Lite" )} {
			set_property value false $Underflow_Flag_AXI 
		}

		if { [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_STREAM"} {
			if { [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS} ] == "Data_FIFO" && [ get_property value ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_AXIS} ] ==  "No_Programmable_Empty_Threshold" && [ get_property value ${PARAM_VALUE.AXIS_TYPE} ] == "FIFO"} {
				set val [expr {(([ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} ] == "Independent_Clocks_Distributed_RAM") && ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS} ] == "Low_Latency_Data_FIFO"))?false:true }]
				set_property enabled $val $Underflow_Flag_AXI 
			} else {
				set_property enabled false $Underflow_Flag_AXI 
				set_property value false $Underflow_Flag_AXI 
			}
		} else {
			if {([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ] == "Data_FIFO" && [ get_property value ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WACH} ] ==  "No_Programmable_Empty_Threshold" && [ get_property value ${PARAM_VALUE.WACH_TYPE} ] == "FIFO" && ([ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "READ_ONLY")) 
			|| ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WDCH} ] == "Data_FIFO" && [ get_property value ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WDCH} ] ==  "No_Programmable_Empty_Threshold" && [ get_property value ${PARAM_VALUE.WDCH_TYPE} ] == "FIFO" && ([ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "READ_ONLY")) 
			|| ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WRCH} ] == "Data_FIFO" && [ get_property value ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WRCH} ] ==  "No_Programmable_Empty_Threshold" && [ get_property value ${PARAM_VALUE.WRCH_TYPE} ] == "FIFO" && ([ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "READ_ONLY"))
			|| ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH} ] == "Data_FIFO" && [ get_property value ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_RACH} ] ==  "No_Programmable_Empty_Threshold" && [ get_property value ${PARAM_VALUE.RACH_TYPE} ] == "FIFO" && ([ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "WRITE_ONLY"))
			|| ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RDCH} ] == "Data_FIFO" && [ get_property value ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_RDCH} ] ==  "No_Programmable_Empty_Threshold" && [ get_property value ${PARAM_VALUE.RDCH_TYPE} ] == "FIFO" && ([ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "WRITE_ONLY"))} {
				set_property enabled true $Underflow_Flag_AXI
			} else {
				set_property enabled false $Underflow_Flag_AXI 
				set_property value false $Underflow_Flag_AXI 
			}
		}
	} else {
		set_property value false $Underflow_Flag_AXI 
	}

}

proc update_PARAM_VALUE.OVERFLOW_FLAG_AXI { PARAM_VALUE.AXIS_TYPE PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS  
  PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH PARAM_VALUE.FIFO_APPLICATION_TYPE_RDCH  PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS
  PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH PARAM_VALUE.FIFO_APPLICATION_TYPE_WDCH  
  PARAM_VALUE.FIFO_APPLICATION_TYPE_WRCH PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.OVERFLOW_FLAG_AXI PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_AXIS  
  PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_RACH PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_RDCH  
  PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_WACH PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_WDCH  
  PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_WRCH PARAM_VALUE.PROTOCOL  
  PARAM_VALUE.RACH_TYPE PARAM_VALUE.RDCH_TYPE  
  PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.WACH_TYPE  
  PARAM_VALUE.WDCH_TYPE PARAM_VALUE.WRCH_TYPE PROJECT_PARAM.ARCHITECTURE} {
	
	set Overflow_Flag_AXI  ${PARAM_VALUE.OVERFLOW_FLAG_AXI} 
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	if { $c_family == "virtexu" } {
		set_property enabled false $Overflow_Flag_AXI 
		set_property value false $Overflow_Flag_AXI 
		return;
	}
	
	if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] != "Native" } {
		if { !([ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" &&  [ get_property value ${PARAM_VALUE.PROTOCOL} ] != "AXI4_Lite" )} {
			 set_property value false $Overflow_Flag_AXI 
		}

		if { [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_STREAM"} {
			if { [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS} ] == "Data_FIFO" && [ get_property value ${PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_AXIS} ] ==  "No_Programmable_Full_Threshold" && [ get_property value ${PARAM_VALUE.AXIS_TYPE} ] == "FIFO"} {
				set val [expr {(([ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} ] == "Independent_Clocks_Distributed_RAM") && ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS} ] == "Low_Latency_Data_FIFO"))?false:true }]
				set_property enabled $val $Overflow_Flag_AXI 
			} else {
				set_property enabled false $Overflow_Flag_AXI 
				set_property value false $Overflow_Flag_AXI 
			}
		} else {
			if { ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ] == "Data_FIFO" && [ get_property value ${PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_WACH} ] ==  "No_Programmable_Full_Threshold" && [ get_property value ${PARAM_VALUE.WACH_TYPE} ] == "FIFO" && ([ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "READ_ONLY")) 
			|| ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WDCH} ] == "Data_FIFO" && [ get_property value ${PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_WDCH} ] ==  "No_Programmable_Full_Threshold" && [ get_property value ${PARAM_VALUE.WDCH_TYPE} ] == "FIFO" && ([ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "READ_ONLY")) 
			|| ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WRCH} ] == "Data_FIFO" && [ get_property value ${PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_WRCH} ] ==  "No_Programmable_Full_Threshold" && [ get_property value ${PARAM_VALUE.WRCH_TYPE} ] == "FIFO" && ([ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "READ_ONLY"))
			|| ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH} ] == "Data_FIFO" && [ get_property value ${PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_RACH} ] ==  "No_Programmable_Full_Threshold" && [ get_property value ${PARAM_VALUE.RACH_TYPE} ] == "FIFO" && ([ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "WRITE_ONLY"))
			|| ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RDCH} ] == "Data_FIFO" && [ get_property value ${PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_RDCH} ] ==  "No_Programmable_Full_Threshold" && [ get_property value ${PARAM_VALUE.RDCH_TYPE} ] == "FIFO" && ([ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "WRITE_ONLY"))} {
				set_property enabled true $Overflow_Flag_AXI 
			} else {
				set_property enabled false $Overflow_Flag_AXI 
				set_property value false $Overflow_Flag_AXI
			}
		}
	} else {
		set_property value false $Overflow_Flag_AXI 
	}
}

proc update_PARAM_VALUE.RUSER_WIDTH { PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL  
  PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.RUSER_WIDTH} {

	set RUSER_Width  ${PARAM_VALUE.RUSER_WIDTH} 
	set rw_val [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ]
	
	if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" && [ get_property value ${PARAM_VALUE.PROTOCOL} ] != "AXI4_Lite"  && ( $rw_val == "READ_WRITE" || $rw_val == "READ_ONLY" ) } {
		set val true
	} else {
		set val false
	}
	set_property enabled $val $RUSER_Width
	if {$val == false } {
		set_property value [get_property default_value $RUSER_Width] $RUSER_Width
	}

}

proc update_PARAM_VALUE.BUSER_WIDTH { PARAM_VALUE.BUSER_WIDTH PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.PROTOCOL PARAM_VALUE.READ_WRITE_MODE} {

	set BUSER_Width  ${PARAM_VALUE.BUSER_WIDTH} 
	set rw_val [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ]
	
	if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" && [ get_property value ${PARAM_VALUE.PROTOCOL} ] != "AXI4_Lite"  && ( $rw_val == "READ_WRITE" || $rw_val == "WRITE_ONLY" ) } {
		set val true
	} else {
		set val false
	}
	set_property enabled $val $BUSER_Width
	if {$val == false } {
		set_property value [get_property default_value $BUSER_Width] $BUSER_Width
	}

}

proc update_PARAM_VALUE.ARUSER_WIDTH { PARAM_VALUE.ARUSER_WIDTH PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.PROTOCOL PARAM_VALUE.READ_WRITE_MODE} {

	set ARUSER_Width  ${PARAM_VALUE.ARUSER_WIDTH} 
	set rw_val [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ]
	
	if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" && [ get_property value ${PARAM_VALUE.PROTOCOL} ] != "AXI4_Lite"  && ( $rw_val == "READ_WRITE" || $rw_val == "READ_ONLY" ) } {
		set val true
	} else {
		set val false
	}
	set_property enabled $val $ARUSER_Width
	if {$val == false } {
		set_property value [get_property default_value $ARUSER_Width] $ARUSER_Width
	}

}

proc update_PARAM_VALUE.WUSER_WIDTH { PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL  
  PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.WUSER_WIDTH} {

	set WUSER_Width  ${PARAM_VALUE.WUSER_WIDTH} 
	set rw_val [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ]
	
	if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" && [ get_property value ${PARAM_VALUE.PROTOCOL} ] != "AXI4_Lite"  && ( $rw_val == "READ_WRITE" || $rw_val == "WRITE_ONLY" ) } {
		set val true
	} else {
		set val false
	}
	set_property enabled $val $WUSER_Width
	if {$val == false } {
		set_property value [get_property default_value $WUSER_Width] $WUSER_Width
	}

}

proc update_PARAM_VALUE.AWUSER_WIDTH { PARAM_VALUE.AWUSER_WIDTH PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.PROTOCOL PARAM_VALUE.READ_WRITE_MODE} {

	set AWUSER_Width  ${PARAM_VALUE.AWUSER_WIDTH} 
	set rw_val [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ]
	
	if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" && [ get_property value ${PARAM_VALUE.PROTOCOL} ] != "AXI4_Lite"  && ( $rw_val == "READ_WRITE" || $rw_val == "WRITE_ONLY" ) } {
		set val true
	} else {
		set val false
	}
	set_property enabled $val $AWUSER_Width
	if {$val == false } {
		set_property value [get_property default_value $AWUSER_Width] $AWUSER_Width
	}

}

proc update_gui_for_PARAM_VALUE.READ_WRITE_MODE {PARAM_VALUE.READ_WRITE_MODE IPINST PARAM_VALUE.INTERFACE_TYPE} {
	set groupBox_wach_summary [ipgui::get_groupspec groupBox_wach_summary -of $IPINST]
	set groupBox_wdch_summary [ipgui::get_groupspec groupBox_wdch_summary -of $IPINST]
	set groupBox_wrch_summary [ipgui::get_groupspec groupBox_wrch_summary -of $IPINST]
	set groupBox_rdch_summary [ipgui::get_groupspec groupBox_rdch_summary -of $IPINST]
	set groupBox_rach_summary [ipgui::get_groupspec groupBox_rach_summary -of $IPINST]
	
	set val [get_property value ${PARAM_VALUE.READ_WRITE_MODE}]
	if {$val == "READ_ONLY"  } {
		set_property visible false $groupBox_wach_summary 
		set_property visible false $groupBox_wdch_summary 
		set_property visible false $groupBox_wrch_summary 
		set_property visible true $groupBox_rach_summary 
		set_property visible true $groupBox_rdch_summary 
	} elseif {$val == "WRITE_ONLY"  } {
		set_property visible false $groupBox_rach_summary 
		set_property visible false $groupBox_rdch_summary
		set_property visible true $groupBox_wach_summary 
		set_property visible true $groupBox_wdch_summary 
		set_property visible true $groupBox_wrch_summary 
	} else {
		set_property visible true $groupBox_wach_summary 
		set_property visible true $groupBox_wdch_summary 
		set_property visible true $groupBox_wrch_summary 
		set_property visible true $groupBox_rach_summary 
		set_property visible true $groupBox_rdch_summary 
	}
	
	INTERFACE_TYPE__READ_WRITE_MODE_updated ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.READ_WRITE_MODE} $IPINST
} 

proc update_PARAM_VALUE.WRITE_DATA_COUNT { PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.WRITE_DATA_COUNT PARAM_VALUE.asymmetric_port_width} {
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
        set asymmetry [get_property value ${PARAM_VALUE.asymmetric_port_width}]
	set Write_Data_Count  ${PARAM_VALUE.WRITE_DATA_COUNT} 
	if {($Fifo_Implementation == "Independent_Clocks_Block_RAM" || $Fifo_Implementation == "Independent_Clocks_Distributed_RAM") || ($Fifo_Implementation == "Common_Clock_Block_RAM" && $asymmetry == true)} {
		set_property enabled true $Write_Data_Count 
	} else {
		set_property enabled false $Write_Data_Count 
		set_property value [get_property default_value $Write_Data_Count] $Write_Data_Count 
	}
}

proc update_PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE { PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE PARAM_VALUE.enable_low_latency} {
    set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	set Programmable_Empty_Type  ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE} 
        set en_low_latency [get_property value ${PARAM_VALUE.enable_low_latency}]
	
	if {$Fifo_Implementation == "Common_Clock_Builtin_FIFO"
        || $Fifo_Implementation == "Independent_Clocks_Builtin_FIFO" } {
           if {$c_family == "virtexu" && $en_low_latency} {
		set_property enabled false $Programmable_Empty_Type
		set_property range "No_Programmable_Empty_Threshold" $Programmable_Empty_Type
           } else { 
		set_property enabled true $Programmable_Empty_Type
		set_property range_value "No_Programmable_Empty_Threshold,No_Programmable_Empty_Threshold,Single_Programmable_Empty_Threshold_Constant" $Programmable_Empty_Type
           }
	} else {
		set_property enabled true $Programmable_Empty_Type
		set_property range_value "No_Programmable_Empty_Threshold,No_Programmable_Empty_Threshold,Single_Programmable_Empty_Threshold_Constant,Multiple_Programmable_Empty_Threshold_Constants,Single_Programmable_Empty_Threshold_Input_Port,Multiple_Programmable_Empty_Threshold_Input_Ports" $Programmable_Empty_Type
	}
}

proc update_PARAM_VALUE.PROGRAMMABLE_FULL_TYPE { PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.PROGRAMMABLE_FULL_TYPE PARAM_VALUE.enable_low_latency} {
    set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	set Programmable_Full_Type  ${PARAM_VALUE.PROGRAMMABLE_FULL_TYPE} 
        set en_low_latency [get_property value ${PARAM_VALUE.enable_low_latency}]
	
	if {$Fifo_Implementation == "Common_Clock_Builtin_FIFO"
        || $Fifo_Implementation == "Independent_Clocks_Builtin_FIFO" } {
           if {$c_family == "virtexu" && $en_low_latency} {
		set_property enabled false $Programmable_Full_Type
		set_property range "No_Programmable_Full_Threshold" $Programmable_Full_Type 
           } else { 
		set_property enabled true $Programmable_Full_Type
		set_property range_value "No_Programmable_Full_Threshold,No_Programmable_Full_Threshold,Single_Programmable_Full_Threshold_Constant" $Programmable_Full_Type 
           }
	} else {
		set_property enabled true $Programmable_Full_Type
		set_property range_value "No_Programmable_Full_Threshold,No_Programmable_Full_Threshold,Single_Programmable_Full_Threshold_Constant,Multiple_Programmable_Full_Threshold_Constants,Single_Programmable_Full_Threshold_Input_Port,Multiple_Programmable_Full_Threshold_Input_Ports" $Programmable_Full_Type 
	}
}

proc update_PARAM_VALUE.READ_CLOCK_FREQUENCY { PARAM_VALUE.ENABLE_ECC PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.USE_EMBEDDED_REGISTERS PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.INPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.READ_CLOCK_FREQUENCY} {
    set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
    set fifo_in_depth [fifo_generator_v12_0_utils::get_Estimated_FIFO_InDepth $c_family [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] [Get_Output_Data_Width ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ] [ get_property value ${PARAM_VALUE.ENABLE_ECC} ] ]

	set Read_Clock_Frequency  ${PARAM_VALUE.READ_CLOCK_FREQUENCY} 
	if {([ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Independent_Clocks_Builtin_FIFO")} {
		set_property enabled true $Read_Clock_Frequency 
	} else {
		set_property enabled false $Read_Clock_Frequency 
		set_property value [get_property default_value $Read_Clock_Frequency] $Read_Clock_Frequency 
	}
}

proc update_PARAM_VALUE.READ_DATA_COUNT { PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.READ_DATA_COUNT PARAM_VALUE.asymmetric_port_width} {
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	set Read_Data_Count  ${PARAM_VALUE.READ_DATA_COUNT}
        set asymmetry [get_property value ${PARAM_VALUE.asymmetric_port_width}]
	if {($Fifo_Implementation == "Independent_Clocks_Block_RAM" || $Fifo_Implementation == "Independent_Clocks_Distributed_RAM") || ($Fifo_Implementation == "Common_Clock_Block_RAM" && $asymmetry == true)} {
		set_property enabled true $Read_Data_Count 
	} else {
		set_property enabled false $Read_Data_Count 
		set_property value [get_property default_value $Read_Data_Count] $Read_Data_Count 
	}
}

proc update_PARAM_VALUE.RESET_PIN { PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.RESET_PIN} {
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	set Reset_Pin  ${PARAM_VALUE.RESET_PIN} 
	if { $Fifo_Implementation == "Common_Clock_Block_RAM" || $Fifo_Implementation == "Common_Clock_Distributed_RAM" || $Fifo_Implementation == "Independent_Clocks_Block_RAM"  || $Fifo_Implementation == "Independent_Clocks_Distributed_RAM" } {
		set_property enabled true $Reset_Pin 
	} else {
		set_property value true $Reset_Pin 
        set_property enabled false $Reset_Pin 
	}
}

proc update_PARAM_VALUE.PERFORMANCE_OPTIONS { PARAM_VALUE.PERFORMANCE_OPTIONS PARAM_VALUE.FIFO_IMPLEMENTATION} {
	set Performance_Options  ${PARAM_VALUE.PERFORMANCE_OPTIONS} 
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	
	 if { $Fifo_Implementation eq "Common_Clock_Block_RAM" 
     || $Fifo_Implementation eq "Common_Clock_Distributed_RAM"
     || $Fifo_Implementation eq "Independent_Clocks_Block_RAM"
     || $Fifo_Implementation eq "Independent_Clocks_Distributed_RAM"
     || $Fifo_Implementation eq "Common_Clock_Builtin_FIFO" 
     || $Fifo_Implementation eq "Independent_Clocks_Builtin_FIFO" } {
      # enable for all architectures
      set_property enabled true $Performance_Options 
	} else {
      set_property enabled false $Performance_Options 
      set_property value [get_property default_value $Performance_Options] $Performance_Options
	}
}

proc update_PARAM_VALUE.DATA_COUNT { PARAM_VALUE.DATA_COUNT PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.asymmetric_port_width} {
 	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	 set Data_Count  ${PARAM_VALUE.DATA_COUNT} 
        set asymmetry [get_property value ${PARAM_VALUE.asymmetric_port_width}]
	 if {($Fifo_Implementation == "Common_Clock_Block_RAM"
       || $Fifo_Implementation == "Common_Clock_Distributed_RAM"
       || $Fifo_Implementation == "Common_Clock_Shift_Register") && ($asymmetry == false)} {
		set_property enabled true $Data_Count 
	} else {
		set_property enabled false $Data_Count 
		set_property value [get_property default_value $Data_Count] $Data_Count 
	}
}

proc update_PARAM_VALUE.ALMOST_EMPTY_FLAG { PARAM_VALUE.ALMOST_EMPTY_FLAG PARAM_VALUE.FIFO_IMPLEMENTATION} {
	set Almost_Empty_Flag  ${PARAM_VALUE.ALMOST_EMPTY_FLAG} 
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	
	if {$Fifo_Implementation == "Common_Clock_Builtin_FIFO"
        || $Fifo_Implementation == "Independent_Clocks_Builtin_FIFO" } {
		set_property enabled false $Almost_Empty_Flag 
		set_property value false $Almost_Empty_Flag 
	} else {
		set_property enabled true $Almost_Empty_Flag 
	}
}

proc update_PARAM_VALUE.ALMOST_FULL_FLAG { PARAM_VALUE.ALMOST_FULL_FLAG PARAM_VALUE.FIFO_IMPLEMENTATION} {
	set Almost_Full_Flag  ${PARAM_VALUE.ALMOST_FULL_FLAG} 
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	if {$Fifo_Implementation == "Common_Clock_Builtin_FIFO"
        || $Fifo_Implementation == "Independent_Clocks_Builtin_FIFO" } {
		set_property enabled false $Almost_Full_Flag 
		set_property value false $Almost_Full_Flag 
	} else {
		set_property enabled true $Almost_Full_Flag 
	}
}

proc update_PARAM_VALUE.WRITE_CLOCK_FREQUENCY { PARAM_VALUE.ENABLE_ECC PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.USE_EMBEDDED_REGISTERS PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.INPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.WRITE_CLOCK_FREQUENCY} {
	set Write_Clock_Frequency  ${PARAM_VALUE.WRITE_CLOCK_FREQUENCY} 
    set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
    set fifo_in_depth [fifo_generator_v12_0_utils::get_Estimated_FIFO_InDepth $c_family [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] [Get_Output_Data_Width ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ] [ get_property value ${PARAM_VALUE.ENABLE_ECC} ] ]

	if {([ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Independent_Clocks_Builtin_FIFO")} {
		set_property enabled true $Write_Clock_Frequency
	} else {
	    set_property enabled false $Write_Clock_Frequency 
		set_property value [get_property default_value $Write_Clock_Frequency] $Write_Clock_Frequency 
	}
}

proc update_PARAM_VALUE.PROTOCOL  {PARAM_VALUE.PROTOCOL PARAM_VALUE.INTERFACE_TYPE} {
	if { [get_property value ${PARAM_VALUE.INTERFACE_TYPE}] == "Native" } {	
		set_property enabled false ${PARAM_VALUE.PROTOCOL}
		set_property value [get_property default_value ${PARAM_VALUE.PROTOCOL}] ${PARAM_VALUE.PROTOCOL}
	} else {
		if {[get_property value ${PARAM_VALUE.INTERFACE_TYPE}] == "AXI_MEMORY_MAPPED" } {
			set_property enabled true ${PARAM_VALUE.PROTOCOL}
		} else {
			set_property enabled false ${PARAM_VALUE.PROTOCOL}
		}
	}
}

proc update_gui_for_PARAM_VALUE.PROTOCOL {PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL IPINST} {
	AXIType__InterfaceType_updated ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.PROTOCOL} $IPINST
}

proc update_PARAM_VALUE.INTERFACE_TYPE {PARAM_VALUE.INTERFACE_TYPE PROJECT_PARAM.ARCHITECTURE} {
	set INTERFACE_TYPE ${PARAM_VALUE.INTERFACE_TYPE}
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	if { !($c_family == "virtexu") && !($c_family == "virtex7") && !($c_family == "kintex7") && !($c_family == "artix7") && !($c_family == "zynq")} {
	   set_property range_value "Native,Native" $INTERFACE_TYPE 
	}
}

proc update_gui_for_PARAM_VALUE.INTERFACE_TYPE {IPINST PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.CLOCK_TYPE_AXI} {
	
	updateVisibilityOfSYNCHRONIZATION_STAGES ${PARAM_VALUE.FIFO_IMPLEMENTATION} ${PARAM_VALUE.INTERFACE_TYPE} $IPINST
	updateVisibilityOfSYNCHRONIZATION_STAGES_AXI ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.INTERFACE_TYPE} $IPINST
	
	if { [get_property value ${PARAM_VALUE.INTERFACE_TYPE}] == "Native" } {		
		set_property visible false [ipgui::get_pagespec page1_AXI_STREAMING_FIFO -of $IPINST]
		set_property visible false [ipgui::get_pagespec page1_AXI_FULL_LITE -of $IPINST]
		set_property visible false [ipgui::get_pagespec page3_AXI_FIFO -of $IPINST]
		set_property visible false [ipgui::get_pagespec page4_AXI_FIFO -of $IPINST]
		set_property visible true [ipgui::get_pagespec "Native Ports" -of $IPINST]
		set_property visible false [ipgui::get_pagespec page5_AXI_FIFO -of $IPINST]
		set_property visible true [ipgui::get_pagespec page4_FIFO -of $IPINST]
		set Fifo_Implementation [get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION}]
		if { $Fifo_Implementation eq "Common_Clock_Builtin_FIFO" || $Fifo_Implementation eq "Independent_Clocks_Builtin_FIFO" } {
			set_property visible false [ipgui::get_pagespec page6_FIFO -of $IPINST]
		} else {
			set_property visible true [ipgui::get_pagespec page6_FIFO -of $IPINST]
		}
		set_property visible true [ipgui::get_pagespec page7_FIFO -of $IPINST]		
		set_property visible false [ipgui::get_pagespec page2_WDCH -of $IPINST]
		set_property visible false [ipgui::get_pagespec page2_WACH -of $IPINST]
		set_property visible false [ipgui::get_pagespec page2_WRCH -of $IPINST]
		set_property visible false [ipgui::get_pagespec page2_RDCH -of $IPINST]
		set_property visible false [ipgui::get_pagespec page2_RACH -of $IPINST]
		set_property visible false [ipgui::get_pagespec page2_AXI_STREAMING_FIFO -of $IPINST]
		set_property visible false [ipgui::get_pagespec page3_AXI_STREAMING_FIFO -of $IPINST]	
		set_property visible true [ipgui::get_guiparamspec Fifo_Implementation -of $IPINST]
		set_property visible true [ipgui::get_guiparamspec Performance_Options -of $IPINST]
		set_property visible true [ipgui::get_groupspec "Data Port Parameters" -of $IPINST]
		set_property visible true [ipgui::get_groupspec "Initialization" -of $IPINST]
		set_property visible false [ipgui::get_groupspec "AXI Memory Mapped Interface Options" -of $IPINST]
		set_property visible false [ipgui::get_groupspec "Clocking Options" -of $IPINST]
		set_property visible true [ipgui::get_groupspec "Fifo Implementation Options" -of $IPINST]
	} else {
		set_property visible false [ipgui::get_guiparamspec Fifo_Implementation -of $IPINST]
		set_property visible false [ipgui::get_guiparamspec Performance_Options -of $IPINST]
		set_property visible false [ipgui::get_groupspec "Data Port Parameters" -of $IPINST]
		set_property visible false [ipgui::get_groupspec "Initialization" -of $IPINST]
		set_property visible false [ipgui::get_groupspec "Fifo Implementation Options" -of $IPINST]
		set_property visible false [ipgui::get_pagespec "Native Ports" -of $IPINST]
		set_property visible true [ipgui::get_groupspec "Clocking Options" -of $IPINST]
		set_property visible false [ipgui::get_pagespec page4_FIFO -of $IPINST]
		set_property visible false [ipgui::get_pagespec page6_FIFO -of $IPINST]
		set_property visible false [ipgui::get_pagespec page7_FIFO -of $IPINST]
		set_property visible true [ipgui::get_pagespec page3_AXI_FIFO -of $IPINST]
		
		if {[get_property value ${PARAM_VALUE.INTERFACE_TYPE}] == "AXI_MEMORY_MAPPED" } {	
			set_property visible false [ipgui::get_pagespec page1_AXI_STREAMING_FIFO -of $IPINST]
			set_property visible true [ipgui::get_pagespec page1_AXI_FULL_LITE -of $IPINST]
			set_property visible true [ipgui::get_pagespec page4_AXI_FIFO -of $IPINST]
			set_property visible true [ipgui::get_pagespec page2_WDCH -of $IPINST]
			set_property visible true [ipgui::get_pagespec page2_WACH -of $IPINST]
			set_property visible true [ipgui::get_pagespec page2_WRCH -of $IPINST]
			set_property visible true [ipgui::get_pagespec page2_RDCH -of $IPINST]
			set_property visible true [ipgui::get_pagespec page2_RACH -of $IPINST]
			set_property visible false [ipgui::get_pagespec page2_AXI_STREAMING_FIFO -of $IPINST]	
			set_property visible false [ipgui::get_pagespec page3_AXI_STREAMING_FIFO -of $IPINST]
			set_property visible true [ipgui::get_guiparamspec PROTOCOL -of $IPINST]
			set_property visible true [ipgui::get_groupspec "AXI Memory Mapped Interface Options" -of $IPINST]
			
		} else {
			set_property visible true [ipgui::get_pagespec page1_AXI_STREAMING_FIFO -of $IPINST]
			set_property visible false [ipgui::get_pagespec page1_AXI_FULL_LITE -of $IPINST]
			set_property visible false [ipgui::get_pagespec page4_AXI_FIFO -of $IPINST]
			set_property visible false [ipgui::get_pagespec page2_WDCH -of $IPINST]
			set_property visible false [ipgui::get_pagespec page2_WACH -of $IPINST]
			set_property visible false [ipgui::get_pagespec page2_WRCH -of $IPINST]
			set_property visible false [ipgui::get_pagespec page2_RDCH -of $IPINST]
			set_property visible false [ipgui::get_pagespec page2_RACH -of $IPINST]
			set_property visible true [ipgui::get_pagespec page2_AXI_STREAMING_FIFO -of $IPINST]	
			set_property visible true [ipgui::get_pagespec page3_AXI_STREAMING_FIFO -of $IPINST]
			set_property visible false [ipgui::get_guiparamspec PROTOCOL -of $IPINST]
			set_property visible false [ipgui::get_groupspec "AXI Memory Mapped Interface Options" -of $IPINST]
			
		}	
	}
	
	if { [get_property value ${PARAM_VALUE.INTERFACE_TYPE}] == "AXI_STREAM"} {
		set_property visible true  [ipgui::get_guiparamspec HAS_ACLKEN -of $IPINST]
		set_property visible true  [ipgui::get_guiparamspec Clock_Enable_Type -of $IPINST]
	} else {
		set_property visible false  [ipgui::get_guiparamspec HAS_ACLKEN -of $IPINST]
		set_property visible false  [ipgui::get_guiparamspec Clock_Enable_Type -of $IPINST]
	}
	
	INTERFACE_TYPE__READ_WRITE_MODE_updated ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.READ_WRITE_MODE} $IPINST
	AXIType__InterfaceType_updated ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.PROTOCOL} $IPINST
} ;

proc INTERFACE_TYPE__READ_WRITE_MODE_updated { PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.READ_WRITE_MODE IPINST} {
	set page2_WDCH [ipgui::get_pagespec page2_WDCH -of $IPINST]
	set page2_WACH [ipgui::get_pagespec page2_WACH -of $IPINST]
	set page2_WRCH [ipgui::get_pagespec page2_WRCH -of $IPINST]
	set Write_Channel_Group [ipgui::get_groupspec Write_Channel_Group -of $IPINST]
	
	if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" } {
		if { [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "READ_ONLY" } {
			set_property visible true $page2_WDCH
			set_property visible true $page2_WACH
			set_property visible true $page2_WRCH
			set_property enabled true $Write_Channel_Group
		} else {
			set_property visible false $page2_WDCH
			set_property visible false $page2_WACH
			set_property visible false $page2_WRCH
			set_property enabled false $Write_Channel_Group
		}		
	} else  {
		set_property visible false $page2_WDCH
		set_property visible false $page2_WACH
		set_property visible false $page2_WRCH
		set_property enabled false $Write_Channel_Group
	}	 

	set page2_RDCH [ipgui::get_pagespec page2_RDCH -of $IPINST]
	set page2_RACH [ipgui::get_pagespec page2_RACH -of $IPINST]
	set Read_Channel_Group [ipgui::get_groupspec Read_Channel_Group -of $IPINST]
	
	if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" } {		
		if { [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "WRITE_ONLY" } {
			set_property visible true $page2_RDCH 
			set_property visible true $page2_RACH 
			set_property enabled true $Read_Channel_Group 
		} else {
			set_property visible false $page2_RDCH 
			set_property visible false $page2_RACH 
			set_property enabled false $Read_Channel_Group 
		}	
	} else {
		set_property visible false $page2_RDCH
		set_property visible false $page2_RACH
		set_property enabled false $Read_Channel_Group
	}
}

proc AXIType__InterfaceType_updated { PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL IPINST} {
	set PROTOCOL [ get_property value ${PARAM_VALUE.PROTOCOL} ]
	set page2_AXI_STREAMING_FIFO [ipgui::get_pagespec page2_AXI_STREAMING_FIFO -of $IPINST]
	set page3_AXI_STREAMING_FIFO [ipgui::get_pagespec page3_AXI_STREAMING_FIFO -of $IPINST]
	set page1_AXI_STREAMING_FIFO [ipgui::get_pagespec page1_AXI_STREAMING_FIFO -of $IPINST]
	set page1_AXI_FULL_LITE [ipgui::get_pagespec page1_AXI_FULL_LITE -of $IPINST]
	set page4_AXI_FIFO [ipgui::get_pagespec page4_AXI_FIFO -of $IPINST]
	set page5_AXI_FIFO [ipgui::get_pagespec page5_AXI_FIFO -of $IPINST]
	set INTERFACE_TYPE [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
	
	if { $INTERFACE_TYPE != "Native" } {		
		if { $INTERFACE_TYPE == "AXI_STREAM" } {		
			set_property visible true $page2_AXI_STREAMING_FIFO   		
			set_property visible true $page3_AXI_STREAMING_FIFO   		
			set_property visible true $page1_AXI_STREAMING_FIFO   	
			set_property visible false $page1_AXI_FULL_LITE   						
			set_property visible false $page4_AXI_FIFO   
			set_property visible false $page5_AXI_FIFO 
		} elseif { $PROTOCOL == "AXI4" } {				   
			set_property visible false $page2_AXI_STREAMING_FIFO   		
			set_property visible false $page3_AXI_STREAMING_FIFO   		
			set_property visible false $page1_AXI_STREAMING_FIFO   
			set_property visible true $page1_AXI_FULL_LITE   
			set_property display_name "AXI4 Ports" $page1_AXI_FULL_LITE
			set_property visible true [ipgui::get_groupspec Read_Channel_Group -of $IPINST]   
			set_property visible true [ipgui::get_groupspec Write_Channel_Group -of $IPINST]
			set_property visible true $page4_AXI_FIFO   
			set_property visible false $page5_AXI_FIFO   	
		} elseif { $PROTOCOL == "AXI3" } {				   
			set_property visible false $page2_AXI_STREAMING_FIFO   		
			set_property visible false $page3_AXI_STREAMING_FIFO   		
			set_property visible false $page1_AXI_STREAMING_FIFO   
			set_property visible true $page1_AXI_FULL_LITE   
			set_property display_name "AXI3 Ports" $page1_AXI_FULL_LITE
			set_property visible true [ipgui::get_groupspec Read_Channel_Group -of $IPINST]   
			set_property visible true [ipgui::get_groupspec Write_Channel_Group -of $IPINST]
			set_property visible true $page4_AXI_FIFO   
			set_property visible false $page5_AXI_FIFO   	
		} else {				
			set_property visible false $page2_AXI_STREAMING_FIFO   	
			set_property visible false $page3_AXI_STREAMING_FIFO   
			set_property visible false $page1_AXI_STREAMING_FIFO   	  
			set_property visible true $page4_AXI_FIFO   
			set_property visible false $page5_AXI_FIFO   	
			set_property visible true $page1_AXI_FULL_LITE   
			set_property display_name "AXI4 Lite Ports" $page1_AXI_FULL_LITE			
			set_property visible false [ipgui::get_groupspec Read_Channel_Group -of $IPINST]  	
			set_property visible false [ipgui::get_groupspec Write_Channel_Group -of $IPINST]
		}
	}
	
	set ID_WIDTH  [ipgui::get_guiparamspec ID_WIDTH -of $IPINST]
	if { $INTERFACE_TYPE == "AXI_MEMORY_MAPPED" && $PROTOCOL != "AXI4_Lite" } {			
		set_property visible true $ID_WIDTH 
	} else {
		set_property visible false $ID_WIDTH
	}
}

proc update_PARAM_VALUE.HAS_ACLKEN {PARAM_VALUE.HAS_ACLKEN PARAM_VALUE.INTERFACE_TYPE} {
	set INTERFACE_TYPE [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
	if { $INTERFACE_TYPE == "AXI_STREAM"} {
		set_property enabled true  ${PARAM_VALUE.HAS_ACLKEN} 
	} else {
		set_property value false  ${PARAM_VALUE.HAS_ACLKEN}
		set_property enabled false  ${PARAM_VALUE.HAS_ACLKEN} 
	}
}

proc device_parameters_settings {IPINST PROJECT_PARAM.ARCHITECTURE} {
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
# Feature (1) rules
	set Common_Clock_Builtin_FIFO1 [ipgui::get_imagespec Common_Clock_Builtin_FIFO1 -of $IPINST]
	set Independent_Clocks_Builtin_FIFO1 [ipgui::get_imagespec Independent_Clocks_Builtin_FIFO1 -of $IPINST]
	if { ($c_family == "virtexu") } {
	   set_property visible true [ipgui::get_imagespec Common_Clock_Builtin_FIFO1 -of $IPINST]
	   set_property visible true [ipgui::get_imagespec Independent_Clocks_Builtin_FIFO1 -of $IPINST]
	} else {
		set_property visible false $Common_Clock_Builtin_FIFO1
	   set_property visible false $Independent_Clocks_Builtin_FIFO1
	}


	
;# Feature (2) rules
	set Common_Clock_Builtin_FIFO2 [ipgui::get_imagespec Common_Clock_Builtin_FIFO2 -of $IPINST]
	set Independent_Clocks_Builtin_FIFO2 [ipgui::get_imagespec Independent_Clocks_Builtin_FIFO2 -of $IPINST]
	if { ($c_family == "virtexu") || ($c_family == "virtex7") || ($c_family == "kintex7") || ($c_family == "artix7") || ($c_family == "zynq")} {
	   set_property visible true [ipgui::get_imagespec Common_Clock_Builtin_FIFO2 -of $IPINST]
	   set_property visible true [ipgui::get_imagespec Independent_Clocks_Builtin_FIFO2 -of $IPINST]
	} else {
		set_property visible false $Common_Clock_Builtin_FIFO2
	   set_property visible false $Independent_Clocks_Builtin_FIFO2
	}

# ;# Feature (3) rules
	set Common_Clock_Builtin_FIFO3 [ipgui::get_imagespec Common_Clock_Builtin_FIFO3 -of $IPINST]
	set Independent_Clocks_Builtin_FIFO3 [ipgui::get_imagespec Independent_Clocks_Builtin_FIFO3 -of $IPINST]
	set val1 [expr {( ($c_family == "virtexu") || ($c_family == "virtex7") || ($c_family == "kintex7") || ($c_family == "artix7") || ($c_family == "zynq"))?true:false}]
	   set_property visible $val1 $Common_Clock_Builtin_FIFO3             
	   set_property visible $val1 $Independent_Clocks_Builtin_FIFO3       

# ;# Feature (4) rules
	set Common_Clock_Block_RAM4 [ipgui::get_imagespec Common_Clock_Block_RAM4 -of $IPINST]
	set Common_Clock_Builtin_FIFO4 [ipgui::get_imagespec Common_Clock_Builtin_FIFO4 -of $IPINST]
	set Independent_Clocks_Block_RAM4 [ipgui::get_imagespec Independent_Clocks_Block_RAM4 -of $IPINST]
	set Independent_Clocks_Builtin_FIFO4 [ipgui::get_imagespec Independent_Clocks_Builtin_FIFO4 -of $IPINST]

   set val2 [expr { (($c_family == "virtexu") || ($c_family == "virtex7") || ($c_family == "kintex7") || ($c_family == "artix7") || ($c_family == "zynq"))?true:false}]
   set_property visible $val2 $Common_Clock_Block_RAM4                
   set_property visible $val2 $Common_Clock_Builtin_FIFO4             
   set_property visible $val2 $Independent_Clocks_Block_RAM4          
   set_property visible $val2 $Independent_Clocks_Builtin_FIFO4       

# ;# Feature (5) rules
	set Common_Clock_Block_RAM5 [ipgui::get_imagespec Common_Clock_Block_RAM5 -of $IPINST]
	set Common_Clock_Builtin_FIFO5 [ipgui::get_imagespec Common_Clock_Builtin_FIFO5 -of $IPINST]
	set Independent_Clocks_Block_RAM5 [ipgui::get_imagespec Independent_Clocks_Block_RAM5 -of $IPINST]
	set Independent_Clocks_Builtin_FIFO5 [ipgui::get_imagespec Independent_Clocks_Builtin_FIFO5 -of $IPINST]

   set val3 [expr {(($c_family == "virtexu") || ($c_family == "virtex7") || ($c_family == "kintex7") || ($c_family == "artix7") || ($c_family == "zynq"))?true:false}]
   set_property visible $val3 $Common_Clock_Block_RAM5                
   set_property visible $val3 $Common_Clock_Builtin_FIFO5             
   set_property visible $val3 $Independent_Clocks_Block_RAM5          
   set_property visible $val3 $Independent_Clocks_Builtin_FIFO5 
}

proc update_gui_for_PARAM_VALUE.CLOCK_TYPE_AXI {PARAM_VALUE.CLOCK_TYPE_AXI IPINST PARAM_VALUE.AXIS_TYPE PARAM_VALUE.WACH_TYPE
PARAM_VALUE.WDCH_TYPE PARAM_VALUE.WRCH_TYPE PARAM_VALUE.RACH_TYPE PARAM_VALUE.RDCH_TYPE PARAM_VALUE.INTERFACE_TYPE} {
	updateVisibilityOfRegister_Slice_Mode_axis  $IPINST ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.AXIS_TYPE}
	updateVisibilityOfRegister_Slice_Mode_wach  $IPINST ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.WACH_TYPE}
	updateVisibilityOfRegister_Slice_Mode_wdch  $IPINST ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.WDCH_TYPE}
	updateVisibilityOfRegister_Slice_Mode_wrch  $IPINST ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.WRCH_TYPE}
	updateVisibilityOfRegister_Slice_Mode_rach  $IPINST ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.RACH_TYPE}
	updateVisibilityOfRegister_Slice_Mode_rdch  $IPINST ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.RDCH_TYPE}
	updateVisibilityOfSYNCHRONIZATION_STAGES_AXI ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.INTERFACE_TYPE} $IPINST
}

for {set n 0} { $n <$num_fifo_channels_incl_axis} {incr n} {
	set fifo_name [lindex $fifo_channels_incl_axis $n]   
	set FIFO_NAME_UPPERCASE [string toupper $fifo_name]
    EvalSubstituting {fifo_name FIFO_NAME_UPPERCASE} {
		proc update_PARAM_VALUE.EMPTY_THRESHOLD_ASSERT_VALUE_$FIFO_NAME_UPPERCASE { PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.EMPTY_THRESHOLD_ASSERT_VALUE_$FIFO_NAME_UPPERCASE  
		  PARAM_VALUE.ENABLE_ECC_$FIFO_NAME_UPPERCASE PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE  
		  PARAM_VALUE.INPUT_DEPTH_$FIFO_NAME_UPPERCASE PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_$FIFO_NAME_UPPERCASE PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.asymmetric_port_width} {

			set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
			set asymport [get_property value ${PARAM_VALUE.asymmetric_port_width}]
			set FIFO_Implementation_fifo_name [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE} ]
			set Input_Depth_fifo_name [ get_property value ${PARAM_VALUE.INPUT_DEPTH_$FIFO_NAME_UPPERCASE} ]
			set Enable_ECC_fifo_name [ get_property value ${PARAM_VALUE.ENABLE_ECC_$FIFO_NAME_UPPERCASE} ]
			set Programmable_Empty_Type_fifo_name [ get_property value ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_$FIFO_NAME_UPPERCASE} ]
			set Empty_Threshold_Assert_Value_fifo_name ${PARAM_VALUE.EMPTY_THRESHOLD_ASSERT_VALUE_$FIFO_NAME_UPPERCASE} 
			 if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] != "Native" } {			   	  		
				set pe_assert_max [fifo_generator_v12_0_utils::pe_assert_max $c_family $FIFO_Implementation_fifo_name 0 1  $Input_Depth_fifo_name 1 $Input_Depth_fifo_name $Programmable_Empty_Type_fifo_name "First_Word_Fall_Through"  $Enable_ECC_fifo_name 1 $asymport]
				
				set pe_assert_min [fifo_generator_v12_0_utils::pe_assert_min $c_family $FIFO_Implementation_fifo_name 0 1  $Input_Depth_fifo_name $Input_Depth_fifo_name $Programmable_Empty_Type_fifo_name "First_Word_Fall_Through" $Enable_ECC_fifo_name 1 1 $asymport]

				set_property range_value "$pe_assert_max,$pe_assert_min,$pe_assert_max"  $Empty_Threshold_Assert_Value_fifo_name
			} 
			
			if {$Programmable_Empty_Type_fifo_name == "Single_Programmable_Empty_Threshold_Constant" } {			       
				set_property enabled true $Empty_Threshold_Assert_Value_fifo_name  
			} elseif {$Programmable_Empty_Type_fifo_name == "Single_Programmable_Empty_Threshold_Input_Port" } {
				set_property enabled false $Empty_Threshold_Assert_Value_fifo_name  
			}	else {
				set_property enabled false $Empty_Threshold_Assert_Value_fifo_name  
			}

		}

		proc update_PARAM_VALUE.FULL_THRESHOLD_ASSERT_VALUE_$FIFO_NAME_UPPERCASE { PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.ENABLE_ECC_$FIFO_NAME_UPPERCASE  
		  PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE PARAM_VALUE.FULL_THRESHOLD_ASSERT_VALUE_$FIFO_NAME_UPPERCASE  
		  PARAM_VALUE.INPUT_DEPTH_$FIFO_NAME_UPPERCASE PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_$FIFO_NAME_UPPERCASE PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.asymmetric_port_width} {

			set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
			set asymport [get_property value ${PARAM_VALUE.asymmetric_port_width}]
			set FIFO_Implementation_fifo_name [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE} ]
			set Input_Depth_fifo_name [ get_property value ${PARAM_VALUE.INPUT_DEPTH_$FIFO_NAME_UPPERCASE} ]
			set Programmable_Full_Type_fifo_name [ get_property value ${PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_$FIFO_NAME_UPPERCASE} ]
			set Enable_ECC_fifo_name [ get_property value ${PARAM_VALUE.ENABLE_ECC_$FIFO_NAME_UPPERCASE} ]
			set Full_Threshold_Assert_Value_fifo_name ${PARAM_VALUE.FULL_THRESHOLD_ASSERT_VALUE_$FIFO_NAME_UPPERCASE} 
			
			if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] != "Native" } {	
				set pf_assert_max [fifo_generator_v12_0_utils::pf_assert_max $c_family $FIFO_Implementation_fifo_name 0 1  $Input_Depth_fifo_name $Input_Depth_fifo_name $Programmable_Full_Type_fifo_name "First_Word_Fall_Through"  $Enable_ECC_fifo_name 1 1 1 $asymport]
				set pf_assert_min [fifo_generator_v12_0_utils::pf_assert_min $c_family $FIFO_Implementation_fifo_name 0 1  $Input_Depth_fifo_name $Input_Depth_fifo_name $Programmable_Full_Type_fifo_name "First_Word_Fall_Through"  $Enable_ECC_fifo_name 1 1 1 $asymport]
				set_property range_value "$pf_assert_max,$pf_assert_min,$pf_assert_max"  $Full_Threshold_Assert_Value_fifo_name
			} 		
			
			if {$Programmable_Full_Type_fifo_name == "Single_Programmable_Full_Threshold_Constant" } {			       
				set_property enabled true $Full_Threshold_Assert_Value_fifo_name
			} elseif {$Programmable_Full_Type_fifo_name == "Single_Programmable_Full_Threshold_Input_Port" } {
				set_property enabled false $Full_Threshold_Assert_Value_fifo_name
			} else {
				set_property enabled false $Full_Threshold_Assert_Value_fifo_name
			}

		}

		proc update_gui_for_PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_$FIFO_NAME_UPPERCASE {PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_$FIFO_NAME_UPPERCASE IPINST} {
			set Programmable_Empty_Type_fifo_name [ get_property value ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_$FIFO_NAME_UPPERCASE} ]
			set Empty_Threshold_Assert_Value_fifo_name  [ipgui::get_guiparamspec Empty_Threshold_Assert_Value_$fifo_name -of $IPINST] 
			
			if {$Programmable_Empty_Type_fifo_name == "Single_Programmable_Empty_Threshold_Constant" } {			       
				set_property visible true $Empty_Threshold_Assert_Value_fifo_name   
			} elseif {$Programmable_Empty_Type_fifo_name == "Single_Programmable_Empty_Threshold_Input_Port" } {
				set_property visible true $Empty_Threshold_Assert_Value_fifo_name   
			}	else {
				set_property visible false $Empty_Threshold_Assert_Value_fifo_name   
			}
		}
		
		proc update_gui_for_PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_$FIFO_NAME_UPPERCASE {PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_$FIFO_NAME_UPPERCASE IPINST} {
			set Full_Threshold_Assert_Value_fifo_name  [ipgui::get_guiparamspec Full_Threshold_Assert_Value_$fifo_name -of $IPINST]
			set Programmable_Full_Type_fifo_name [ get_property value ${PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_$FIFO_NAME_UPPERCASE} ]
			
			if {$Programmable_Full_Type_fifo_name == "Single_Programmable_Full_Threshold_Constant" } {			       
				set_property visible true $Full_Threshold_Assert_Value_fifo_name 
			} elseif {$Programmable_Full_Type_fifo_name == "Single_Programmable_Full_Threshold_Input_Port" } {
				set_property visible true $Full_Threshold_Assert_Value_fifo_name
			} else {
				set_property visible false $Full_Threshold_Assert_Value_fifo_name
			}
		}
		
		proc update_PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_$FIFO_NAME_UPPERCASE { PARAM_VALUE.FIFO_APPLICATION_TYPE_$FIFO_NAME_UPPERCASE PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE  
		  PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_$FIFO_NAME_UPPERCASE PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE } {
			set Programmable_Full_Type_fifo_name  ${PARAM_VALUE.PROGRAMMABLE_FULL_TYPE_$FIFO_NAME_UPPERCASE} 
			set FIFO_Application_Type_fifo_name [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_$FIFO_NAME_UPPERCASE} ]
			
			if { [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE} ] == "Common_Clock_Builtin_FIFO" || [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE} ] == "Independent_Clocks_Builtin_FIFO" } {
				if { $FIFO_Application_Type_fifo_name == "Low_Latency_Data_FIFO" } {
					set_property range_value "No_Programmable_Full_Threshold,No_Programmable_Full_Threshold" $Programmable_Full_Type_fifo_name 
				} else {
					set_property range_value "No_Programmable_Full_Threshold,No_Programmable_Full_Threshold,Single_Programmable_Full_Threshold_Constant" $Programmable_Full_Type_fifo_name 
				}
			} else {
				if { $FIFO_Application_Type_fifo_name == "Low_Latency_Data_FIFO" } {
					set_property range_value "No_Programmable_Full_Threshold,No_Programmable_Full_Threshold" $Programmable_Full_Type_fifo_name 
				} else {
					set_property range_value "No_Programmable_Full_Threshold,No_Programmable_Full_Threshold,Single_Programmable_Full_Threshold_Constant,Single_Programmable_Full_Threshold_Input_Port" $Programmable_Full_Type_fifo_name 
				}
			}
			
			set var $fifo_name
			set interface_type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
			
			if { [ get_property value ${PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE} ] == "FIFO" && $interface_type_value != "Native" &&
			 (([expr {($var=="axis")?true:false}] && $interface_type_value == "AXI_STREAM" ) ||
			 (([expr {($var=="wdch")?true:false}] ||  [expr {($var=="wach")?true:false}] || [expr {($var=="wrch")?true:false}]) && $interface_type_value == "AXI_MEMORY_MAPPED" && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "READ_ONLY") ||
			 (([expr {($var=="rdch")?true:false}] ||  [expr {($var=="rach")?true:false}] ) && $interface_type_value == "AXI_MEMORY_MAPPED" && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "WRITE_ONLY") )} {			    
				set_property enabled true $Programmable_Full_Type_fifo_name 
			} else {
				set_property enabled false $Programmable_Full_Type_fifo_name 
				set_property value "No_Programmable_Full_Threshold" $Programmable_Full_Type_fifo_name 
			}	
		}
		
		proc update_PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_$FIFO_NAME_UPPERCASE { PARAM_VALUE.FIFO_APPLICATION_TYPE_$FIFO_NAME_UPPERCASE PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE  
		  PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_$FIFO_NAME_UPPERCASE PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.READ_WRITE_MODE  
  PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE } {
			set Programmable_Empty_Type_fifo_name  ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_$FIFO_NAME_UPPERCASE} 
			set FIFO_Application_Type_fifo_name [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_$FIFO_NAME_UPPERCASE} ]
			
			if { [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE} ] == "Common_Clock_Builtin_FIFO" || [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE} ] == "Independent_Clocks_Builtin_FIFO" } {
				if { $FIFO_Application_Type_fifo_name == "Low_Latency_Data_FIFO" } {
					set_property range_value "No_Programmable_Empty_Threshold,No_Programmable_Empty_Threshold"  $Programmable_Empty_Type_fifo_name 
				} else {
					set_property range_value "No_Programmable_Empty_Threshold,No_Programmable_Empty_Threshold,Single_Programmable_Empty_Threshold_Constant" $Programmable_Empty_Type_fifo_name 
				}
			} else {
				if { $FIFO_Application_Type_fifo_name == "Low_Latency_Data_FIFO" } {
					set_property range_value "No_Programmable_Empty_Threshold,No_Programmable_Empty_Threshold" $Programmable_Empty_Type_fifo_name 
				} else {
					set_property range_value "No_Programmable_Empty_Threshold,No_Programmable_Empty_Threshold,Single_Programmable_Empty_Threshold_Constant,Single_Programmable_Empty_Threshold_Input_Port" $Programmable_Empty_Type_fifo_name 
				}
			}
			
			set var $fifo_name
			set interface_type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
			
			if { [ get_property value ${PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE} ] == "FIFO" && $interface_type_value != "Native" &&
			 (([expr {($var=="axis")?true:false}] && $interface_type_value == "AXI_STREAM" ) ||
			 (([expr {($var=="wdch")?true:false}] ||  [expr {($var=="wach")?true:false}] || [expr {($var=="wrch")?true:false}]) && $interface_type_value == "AXI_MEMORY_MAPPED" && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "READ_ONLY") ||
			 (([expr {($var=="rdch")?true:false}] ||  [expr {($var=="rach")?true:false}] ) && $interface_type_value == "AXI_MEMORY_MAPPED" && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "WRITE_ONLY") )} {			    
				
				set_property enabled true $Programmable_Empty_Type_fifo_name
			} else {
				set_property enabled false $Programmable_Empty_Type_fifo_name
				set_property value "No_Programmable_Empty_Threshold" $Programmable_Empty_Type_fifo_name 
			}
		}

		proc update_PARAM_VALUE.ENABLE_ECC_$FIFO_NAME_UPPERCASE { PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH  
		  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.READ_WRITE_MODE  
		  PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE PARAM_VALUE.ENABLE_ECC_$FIFO_NAME_UPPERCASE  
		  PARAM_VALUE.FIFO_APPLICATION_TYPE_$FIFO_NAME_UPPERCASE PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE} {

			set var $fifo_name		
			set FIFO_Implementation_fifo_name [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE} ]
			set Enable_ECC_fifo_name  ${PARAM_VALUE.ENABLE_ECC_$FIFO_NAME_UPPERCASE} 
			set interface_type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
			
			if {!($var == "wdch" || $var == "wrch" || $var == "rdch")} {
				if { [ get_property value ${PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE} ] == "FIFO"  &&
				($FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM" || $FIFO_Implementation_fifo_name == "Common_Clock_Builtin_FIFO" ||
				$FIFO_Implementation_fifo_name == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_fifo_name == "Independent_Clocks_Builtin_FIFO") &&				
				$interface_type_value != "Native" &&
				(([expr {($var=="axis")?true:false}] && $interface_type_value == "AXI_STREAM" ) ||
				(([expr {($var=="wach")?true:false}]) && $interface_type_value == "AXI_MEMORY_MAPPED" && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "READ_ONLY") ||
				(([expr {($var=="rach")?true:false}]) && $interface_type_value == "AXI_MEMORY_MAPPED" && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "WRITE_ONLY") )} {
					if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_$FIFO_NAME_UPPERCASE} ] != "Packet_FIFO"} {
						set_property enabled true $Enable_ECC_fifo_name
					} else {
						set_property enabled false $Enable_ECC_fifo_name
						set_property value false $Enable_ECC_fifo_name
					}					
				} else {
					set_property enabled false $Enable_ECC_fifo_name
					set_property value false $Enable_ECC_fifo_name
				}
			} elseif { $var == "wdch" || $var == "wrch" } {
				if { [ get_property value ${PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE} ] == "FIFO"  &&
					($FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM" || $FIFO_Implementation_fifo_name == "Common_Clock_Builtin_FIFO" ||
				$FIFO_Implementation_fifo_name == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_fifo_name == "Independent_Clocks_Builtin_FIFO") &&				
					[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" &&
				 ((([expr {($var=="wdch")?true:false}] || [expr {($var=="wrch")?true:false}]) && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "READ_ONLY") )} {
					if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ] != "Packet_FIFO"} {
						set_property enabled true $Enable_ECC_fifo_name				
					} else {
						set_property enabled false $Enable_ECC_fifo_name
						set_property value false $Enable_ECC_fifo_name
					}					
				} else {
					set_property enabled false $Enable_ECC_fifo_name
					set_property value false $Enable_ECC_fifo_name
				}
			} else {
				if { [ get_property value ${PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE} ] == "FIFO"  &&
					($FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM" || $FIFO_Implementation_fifo_name == "Common_Clock_Builtin_FIFO" ||
				$FIFO_Implementation_fifo_name == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_fifo_name == "Independent_Clocks_Builtin_FIFO") &&				
					[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" &&
				 (([expr {($var=="rdch")?true:false}]) && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "WRITE_ONLY") } {
					if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH} ] != "Packet_FIFO"} {
						set_property enabled true $Enable_ECC_fifo_name					
					} else {
						set_property enabled false $Enable_ECC_fifo_name
						set_property value false $Enable_ECC_fifo_name
					}					
				} else {
					set_property enabled false $Enable_ECC_fifo_name
					set_property value false $Enable_ECC_fifo_name
				}
			}
		}

		# proc update_PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE { PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH  
		  # PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH PARAM_VALUE.INTERFACE_TYPE  
		  # PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE PROJECT_PARAM.ARCHITECTURE} {
				  
			# set var $fifo_name		  
			# set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
				
			# set FIFO_Implementation_fifo_name  ${PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE} 
			
			# if { [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] != "Native" } {
				# if {!($var == "wdch" || $var == "wrch" || $var == "rdch")} {
					# if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {
						# if { $c_family == "virtexu" || $c_family == "virtex7" || $c_family == "virtex7l" || $c_family == "kintex7" || $c_family == "kintex7l" || $c_family == "artix7" || $c_family == "zynq" } {
							## Common Clock Builin Fifo is enabled for AXI for V6 and above devices. ###
							# set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
						# } else {
							# set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM" $FIFO_Implementation_fifo_name 
						# }

						# if { [expr {($var=="axis")?true:false}] } {
							# set_property value "Common_Clock_Block_RAM" $FIFO_Implementation_fifo_name 
						# } elseif { [expr {($var=="wach")?true:false}] ||  [expr {($var=="rach")?true:false}] } {
							# set_property value "Common_Clock_Distributed_RAM" $FIFO_Implementation_fifo_name
						# }
					# } elseif { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq  "Independent_Clock" } {
						# set_property range_value "Independent_Clocks_Block_RAM,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name

						# if { [expr {($var=="axis")?true:false}] } {
							# set_property value "Independent_Clocks_Block_RAM" $FIFO_Implementation_fifo_name
						# } elseif { [expr {($var=="wach")?true:false}] || [expr {($var=="rach")?true:false}] } {
							# set_property value "Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
						# } 
					# }	 
				# } elseif {($var == "wdch" || $var == "wrch")} {
					# if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {
						# if { $c_family == "virtexu" || $c_family == "virtex7" || $c_family == "virtex7l" || $c_family == "kintex7" || $c_family == "kintex7l" || $c_family == "artix7" || $c_family == "zynq" } {
							## Common Clock Builin Fifo is enabled for AXI for V6 and above devices. ###
							# set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
						# } else {
							# set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
						# }

						# if { [expr {($var=="wdch")?true:false}] } {
							# if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ] != "Packet_FIFO"} {
								# set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
							# } else {
								# set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM"  $FIFO_Implementation_fifo_name
							# }
						# } elseif {[expr {($var=="wrch")?true:false}]} {
							# if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ] != "Packet_FIFO"} {
								# set_property range_value "Common_Clock_Distributed_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
							# } else {
								# set_property range_value "Common_Clock_Distributed_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
							# }
						# }
					# } elseif { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq  "Independent_Clock" } {
						# set_property range_value "Independent_Clocks_Block_RAM,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
						# if { [expr {($var=="wdch")?true:false}] } {
							# set_property value "Independent_Clocks_Block_RAM" $FIFO_Implementation_fifo_name
						# } elseif { [expr {($var=="wrch")?true:false}] } {
							# set_property value "Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
						# } 
					# }	   
				# } else {
					# if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {
						# if { $c_family == "virtexu" || $c_family == "virtex7" || $c_family == "virtex7l" || $c_family == "kintex7" || $c_family == "kintex7l" || $c_family == "artix7" || $c_family == "zynq" } {
							## Common Clock Builin Fifo is enabled for AXI for V6 and above devices. ###
							# set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
						# } else {
							# set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
						# }
						# if { [expr {($var=="rdch")?true:false}] } {
							# if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH} ] != "Packet_FIFO"} {
								# set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
							# } else {
								# set_property range_value "Common_Clock_Block_RAM,Common_Clock_Block_RAM"  $FIFO_Implementation_fifo_name
							# }
						# } 
					# } elseif { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq  "Independent_Clock" } {
						# set_property range_value "Independent_Clocks_Block_RAM,Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
						# if { [expr {($var=="rdch")?true:false}] } {
							# set_property value "Independent_Clocks_Block_RAM" $FIFO_Implementation_fifo_name
						# } 
					# }	   
				# }
			# } else {
				# if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {
					# set_property range "Common_Clock_Block_RAM,Common_Clock_Distributed_RAM"  $FIFO_Implementation_fifo_name
				# } else {
					# set_property range "Independent_Clocks_Block_RAM,Independent_Clocks_Distributed_RAM" $FIFO_Implementation_fifo_name
				# }
			# }

		# }

		proc update_gui_for_PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE {IPINST PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE PARAM_VALUE.CLOCK_TYPE_AXI} {
			set ECC_Options_fifo_name [ipgui::get_groupspec "ECC_Options_$fifo_name" -of $IPINST]
			set Data_Port_Parameters_fifo_name [ipgui::get_panelspec "Data_Port_Parameters_$fifo_name" -of $IPINST]
			set Data_Threshold_Parameters_fifo_name [ipgui::get_groupspec "Data_Threshold_Parameters_$fifo_name" -of $IPINST]
			set FIFO_Options_fifoname [ipgui::get_groupspec "FIFO_Options_$fifo_name" -of $IPINST]
			set Mem_Type_fifo_name [ipgui::get_textspec "Mem_Type_$fifo_name" -of $IPINST]
			set Add_Summary_fifo_name [ipgui::get_groupspec "Add_Summary_$fifo_name" -of $IPINST]
			set BRAM_Res_fifo_name [ipgui::get_textspec "BRAM_Res_$fifo_name" -of $IPINST]
			set Use_Embedded_Registers_axis [ipgui::get_guiparamspec "Use_Embedded_Registers_axis" -of $IPINST]
			set FIFO_Application_Type_fifo_name [ipgui::get_guiparamspec FIFO_Application_Type_$fifo_name -of $IPINST]
			set Fifo_name_val $fifo_name
			
			set fifo_value [ get_property value ${PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE} ]
			if { $fifo_value != "FIFO" } {	
				set_property visible false $ECC_Options_fifo_name
				set_property visible false $Data_Port_Parameters_fifo_name
				set_property visible false $Data_Threshold_Parameters_fifo_name
				set_property visible false $FIFO_Options_fifoname
				set_property visible false $Mem_Type_fifo_name 
				set_property visible false $Add_Summary_fifo_name
				set_property visible false $BRAM_Res_fifo_name 
				if { $Fifo_name_val == "axis" } {
					set_property visible false $Use_Embedded_Registers_axis 
				}
				set_property visible false $FIFO_Application_Type_fifo_name
			} else {
				set_property visible true $ECC_Options_fifo_name
				set_property visible true $Data_Port_Parameters_fifo_name
				set_property visible true $Data_Threshold_Parameters_fifo_name
				set_property visible true $FIFO_Options_fifoname
				set_property visible true $Mem_Type_fifo_name
				set_property visible true $Add_Summary_fifo_name  
				set_property visible true $BRAM_Res_fifo_name
				if { $Fifo_name_val == "axis" } {
					set_property visible true $Use_Embedded_Registers_axis
				}
				set_property visible true $FIFO_Application_Type_fifo_name
			 }
			
			set App_Type_fifo_name [ipgui::get_textspec "App_Type_$fifo_name" -of $IPINST]
			set LabelApp_Type_fifo_name [ipgui::get_textspec "LabelApp_Type_$fifo_name" -of $IPINST]
			set Final_Latency_fifo_name [ipgui::get_textspec "Final_Latency_$fifo_name" -of $IPINST]
			
			if { $fifo_value == "Register_Slice" || $fifo_value == "Pass_Through_Wire" } {
				set_property visible false $App_Type_fifo_name
				set_property visible false $LabelApp_Type_fifo_name
				set_property visible false $Final_Latency_fifo_name
			} else {
				set_property visible true $App_Type_fifo_name
				set_property visible true $LabelApp_Type_fifo_name
				set_property visible true $Final_Latency_fifo_name
			}
			updateVisibilityOfRegister_Slice_Mode_$fifo_name  $IPINST ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE} 
	    }
		
		proc update_PARAM_VALUE.INJECT_SBIT_ERROR_$FIFO_NAME_UPPERCASE { PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH  
		  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.READ_WRITE_MODE  
		  PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE PARAM_VALUE.ENABLE_ECC_$FIFO_NAME_UPPERCASE  
		  PARAM_VALUE.FIFO_APPLICATION_TYPE_$FIFO_NAME_UPPERCASE PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE  
		  PARAM_VALUE.INJECT_SBIT_ERROR_$FIFO_NAME_UPPERCASE} {

			set var $fifo_name
			set FIFO_Implementation_fifo_name [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE} ]
			set Inject_Sbit_Error_fifo_name  ${PARAM_VALUE.INJECT_SBIT_ERROR_$FIFO_NAME_UPPERCASE} 
			set interface_type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
			
			if {!($var == "wdch" || $var == "wrch" || $var == "rdch")} {
				if { [ get_property value ${PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE} ]  == "FIFO" &&
					 [ get_property value ${PARAM_VALUE.ENABLE_ECC_$FIFO_NAME_UPPERCASE} ] == true && 
					 ($FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM" || $FIFO_Implementation_fifo_name == "Common_Clock_Builtin_FIFO" ||
				$FIFO_Implementation_fifo_name == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_fifo_name == "Independent_Clocks_Builtin_FIFO") && $interface_type_value != "Native" &&
				 (([expr {($var=="axis")?true:false}] && $interface_type_value == "AXI_STREAM" ) ||
				 (([expr {($var=="wach")?true:false}]) && $interface_type_value == "AXI_MEMORY_MAPPED" && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "READ_ONLY") ||
				 (([expr {($var=="rach")?true:false}]) && $interface_type_value == "AXI_MEMORY_MAPPED" && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "WRITE_ONLY") )} {
					if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_$FIFO_NAME_UPPERCASE} ] != "Packet_FIFO"} {
						set_property enabled true $Inject_Sbit_Error_fifo_name	
					} else {
						set_property enabled false $Inject_Sbit_Error_fifo_name
						set_property value false $Inject_Sbit_Error_fifo_name
					}	
				} else {
					set_property enabled false $Inject_Sbit_Error_fifo_name
					set_property value false $Inject_Sbit_Error_fifo_name
				}
			} elseif {$var == "wdch" || $var == "wrch" } {
				if { [ get_property value ${PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE} ] == "FIFO" &&
					 [ get_property value ${PARAM_VALUE.ENABLE_ECC_$FIFO_NAME_UPPERCASE} ] == true && 
					 ($FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM" || $FIFO_Implementation_fifo_name == "Common_Clock_Builtin_FIFO" ||
				$FIFO_Implementation_fifo_name == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_fifo_name == "Independent_Clocks_Builtin_FIFO") && [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" &&
				 (([expr {($var=="wdch")?true:false}] || [expr {($var=="wrch")?true:false}]) && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "READ_ONLY")} {
					if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ] != "Packet_FIFO"} {
						set_property enabled true $Inject_Sbit_Error_fifo_name			
					} else {
						set_property enabled false $Inject_Sbit_Error_fifo_name
						set_property value false $Inject_Sbit_Error_fifo_name
					}	
				} else {
					set_property enabled false $Inject_Sbit_Error_fifo_name
					set_property value false $Inject_Sbit_Error_fifo_name
				}
			} else {
				if { [ get_property value ${PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE} ] == "FIFO" &&
					 [ get_property value ${PARAM_VALUE.ENABLE_ECC_$FIFO_NAME_UPPERCASE} ] == true && 
					 ($FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM" || $FIFO_Implementation_fifo_name == "Common_Clock_Builtin_FIFO" ||
				$FIFO_Implementation_fifo_name == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_fifo_name == "Independent_Clocks_Builtin_FIFO") && [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" &&
				 (([expr {($var=="rdch")?true:false}]) && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "WRITE_ONLY") } {
					if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH} ] != "Packet_FIFO"} {
						set_property enabled true $Inject_Sbit_Error_fifo_name
					} else {
						set_property enabled false $Inject_Sbit_Error_fifo_name
						set_property value false $Inject_Sbit_Error_fifo_name
					}	
				} else {
					set_property enabled false $Inject_Sbit_Error_fifo_name
					set_property value false $Inject_Sbit_Error_fifo_name
				}
			}
		}

		proc update_PARAM_VALUE.ENABLE_DATA_COUNTS_$FIFO_NAME_UPPERCASE { PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH  
		  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.READ_WRITE_MODE  PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE
		  PARAM_VALUE.ENABLE_DATA_COUNTS_$FIFO_NAME_UPPERCASE PARAM_VALUE.FIFO_APPLICATION_TYPE_$FIFO_NAME_UPPERCASE} {

			set var $fifo_name
			set Enable_Data_Counts_fifo_name  ${PARAM_VALUE.ENABLE_DATA_COUNTS_$FIFO_NAME_UPPERCASE} 
			set interface_type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
			set fifo_implementation [get_property value [set PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE]]
			if { $fifo_implementation == "Common_Clock_Builtin_FIFO" || $fifo_implementation == "Independent_Clocks_Builtin_FIFO" } {
				set_property enabled false $Enable_Data_Counts_fifo_name 
				set_property value false $Enable_Data_Counts_fifo_name
				return;
			}
			
			if {!($var == "wdch" || $var == "wrch" || $var == "rdch")} {
				if { $interface_type_value != "Native" &&
				 (([expr {($var=="axis")?true:false}] && $interface_type_value == "AXI_STREAM" ) ||
				 (([expr {($var=="wach")?true:false}]) && $interface_type_value == "AXI_MEMORY_MAPPED" && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "READ_ONLY") ||
				 (([expr {($var=="rach")?true:false}]) && $interface_type_value == "AXI_MEMORY_MAPPED" && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "WRITE_ONLY") )} {			    
					if { [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_$FIFO_NAME_UPPERCASE} ] == "Low_Latency_Data_FIFO" } {
						set_property enabled false $Enable_Data_Counts_fifo_name 
						set_property value false $Enable_Data_Counts_fifo_name
					} else {
						if { $interface_type_value == "AXI_STREAM" } {
							set_property enabled true $Enable_Data_Counts_fifo_name 
						} else {
							if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_$FIFO_NAME_UPPERCASE} ] != "Packet_FIFO"} {
								set_property enabled true $Enable_Data_Counts_fifo_name 
							} else {
								set_property enabled false $Enable_Data_Counts_fifo_name 
								set_property value false $Enable_Data_Counts_fifo_name 
							}
						}
					}
				 } else {
					set_property enabled false $Enable_Data_Counts_fifo_name 
					set_property value false $Enable_Data_Counts_fifo_name 
				 }
			} elseif {($var == "wdch" || $var == "wrch")} {
				if { $interface_type_value == "AXI_MEMORY_MAPPED" &&
					 (([expr {($var=="wdch")?true:false}] || [expr {($var=="wrch")?true:false}]) && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "READ_ONLY")} {			    
						if { [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_$FIFO_NAME_UPPERCASE} ] == "Low_Latency_Data_FIFO" } {
							set_property enabled false $Enable_Data_Counts_fifo_name 
							set_property value false $Enable_Data_Counts_fifo_name
						} else {
							if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ] != "Packet_FIFO"} {
								set_property enabled true $Enable_Data_Counts_fifo_name
							} else {
								set_property enabled false $Enable_Data_Counts_fifo_name 
								set_property value false $Enable_Data_Counts_fifo_name
							}
						}
				} else {
					set_property enabled false $Enable_Data_Counts_fifo_name 
					set_property value false $Enable_Data_Counts_fifo_name
				}
			} else {
				if { [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" &&
					 (([expr {($var=="rdch")?true:false}]) && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "WRITE_ONLY")} {			    
						if { [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_$FIFO_NAME_UPPERCASE} ] == "Low_Latency_Data_FIFO" } {
							set_property enabled false $Enable_Data_Counts_fifo_name 
							set_property value false $Enable_Data_Counts_fifo_name
						} else {
							if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH} ] != "Packet_FIFO"} {
								set_property enabled true $Enable_Data_Counts_fifo_name
							} else {
								set_property enabled false $Enable_Data_Counts_fifo_name 
								set_property value false $Enable_Data_Counts_fifo_name
							}
						}
					 } else {
						set_property enabled false $Enable_Data_Counts_fifo_name 
						set_property value false $Enable_Data_Counts_fifo_name
					 }
			}


		}

		proc update_PARAM_VALUE.INJECT_DBIT_ERROR_$FIFO_NAME_UPPERCASE { PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH  
		  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.READ_WRITE_MODE  
		  PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE PARAM_VALUE.ENABLE_ECC_$FIFO_NAME_UPPERCASE  
		  PARAM_VALUE.FIFO_APPLICATION_TYPE_$FIFO_NAME_UPPERCASE PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE  
		  PARAM_VALUE.INJECT_DBIT_ERROR_$FIFO_NAME_UPPERCASE} {

			set var $fifo_name
			set FIFO_Implementation_fifo_name [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_$FIFO_NAME_UPPERCASE} ]
			set Inject_Dbit_Error_fifo_name  ${PARAM_VALUE.INJECT_DBIT_ERROR_$FIFO_NAME_UPPERCASE} 
			set interface_type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
			
			if {!($var == "wdch" || $var == "wrch" || $var == "rdch")} {
				if { [ get_property value ${PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE} ]  == "FIFO" &&
					 [ get_property value ${PARAM_VALUE.ENABLE_ECC_$FIFO_NAME_UPPERCASE} ] == true && 
					 ($FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM" || $FIFO_Implementation_fifo_name == "Common_Clock_Builtin_FIFO" ||
				$FIFO_Implementation_fifo_name == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_fifo_name == "Independent_Clocks_Builtin_FIFO") && $interface_type_value != "Native" &&
				 (([expr {($var=="axis")?true:false}] && $interface_type_value == "AXI_STREAM" ) ||
				 (([expr {($var=="wach")?true:false}]) && $interface_type_value == "AXI_MEMORY_MAPPED" && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "READ_ONLY") ||
				 (([expr {($var=="rach")?true:false}]) && $interface_type_value == "AXI_MEMORY_MAPPED" && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "WRITE_ONLY") )} {
					if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_$FIFO_NAME_UPPERCASE} ] != "Packet_FIFO"} {
						if {([get_metaparam_value  Calculated_Width_$fifo_name] > 1)} {
							set_property enabled true $Inject_Dbit_Error_fifo_name	
						} else {
							set_property enabled false $Inject_Dbit_Error_fifo_name
							set_property value false $Inject_Dbit_Error_fifo_name
						}
					} else {
						set_property enabled false $Inject_Dbit_Error_fifo_name
						set_property value false $Inject_Dbit_Error_fifo_name
					}	
				} else {
					set_property enabled false $Inject_Dbit_Error_fifo_name
					set_property value false $Inject_Dbit_Error_fifo_name
				}
			} elseif {$var == "wdch" || $var == "wrch" } {
				if { [ get_property value ${PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE} ] == "FIFO" &&
					 [ get_property value ${PARAM_VALUE.ENABLE_ECC_$FIFO_NAME_UPPERCASE} ] == true && 
					 ($FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM" || $FIFO_Implementation_fifo_name == "Common_Clock_Builtin_FIFO" ||
				$FIFO_Implementation_fifo_name == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_fifo_name == "Independent_Clocks_Builtin_FIFO") && [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" &&
				 (([expr {($var=="wdch")?true:false}] || [expr {($var=="wrch")?true:false}]) && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "READ_ONLY")} {
					if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ] != "Packet_FIFO"} {
						if {([get_metaparam_value  Calculated_Width_$fifo_name] > 1)} {
							set_property enabled true $Inject_Dbit_Error_fifo_name	
						} else {
							set_property enabled false $Inject_Dbit_Error_fifo_name
							set_property value false $Inject_Dbit_Error_fifo_name
						}
					} else {
						set_property enabled false $Inject_Dbit_Error_fifo_name
						set_property value false $Inject_Dbit_Error_fifo_name
					}	
				} else {
					set_property enabled false $Inject_Dbit_Error_fifo_name
					set_property value false $Inject_Dbit_Error_fifo_name
				}
			} else {
				if { [ get_property value ${PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE} ] == "FIFO" &&
					 [ get_property value ${PARAM_VALUE.ENABLE_ECC_$FIFO_NAME_UPPERCASE} ] == true && 
					 ($FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM" || $FIFO_Implementation_fifo_name == "Common_Clock_Builtin_FIFO" ||
				$FIFO_Implementation_fifo_name == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_fifo_name == "Independent_Clocks_Builtin_FIFO") && [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_MEMORY_MAPPED" &&
				 (([expr {($var=="rdch")?true:false}]) && [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "WRITE_ONLY") } {
					if {[ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH} ] != "Packet_FIFO"} {
						if {([get_metaparam_value  Calculated_Width_$fifo_name] > 1)} {
							set_property enabled true $Inject_Dbit_Error_fifo_name	
						} else {
							set_property enabled false $Inject_Dbit_Error_fifo_name
							set_property value false $Inject_Dbit_Error_fifo_name
						}
					} else {
						set_property enabled false $Inject_Dbit_Error_fifo_name
						set_property value false $Inject_Dbit_Error_fifo_name
					}	
				} else {
					set_property enabled false $Inject_Dbit_Error_fifo_name
					set_property value false $Inject_Dbit_Error_fifo_name
				}
			}
			

		}

		proc updateVisibilityOfRegister_Slice_Mode_$fifo_name { IPINST PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE } {
			set Register_Slice_Mode_fifo_name  [ipgui::get_guiparamspec Register_Slice_Mode_$fifo_name -of $IPINST]
			if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq  "Independent_Clock" } {
				set_property visible false $Register_Slice_Mode_fifo_name
			} else {
				if { [ get_property value ${PARAM_VALUE.$FIFO_NAME_UPPERCASE_TYPE} ] == "Register_Slice" } {
					set_property visible true $Register_Slice_Mode_fifo_name
				} else {
					set_property visible false $Register_Slice_Mode_fifo_name
				}
			}
		}
	} 0
}

proc validate_PARAM_VALUE.INPUT_DEPTH_WDCH { PARAM_VALUE.INPUT_DEPTH_WDCH PARAM_VALUE.DATA_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL  
  PARAM_VALUE.WUSER_WIDTH} {
	set Input_Depth ${PARAM_VALUE.INPUT_DEPTH_WDCH}
	set Input_Data_Width [get_metaparam_value Calculated_Width_wdch]
	set ID [get_property value ${PARAM_VALUE.INPUT_DEPTH_WDCH}]
	
	if {$Input_Data_Width >= 1 && $Input_Data_Width <= 128 && $ID > [expr "128*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 128K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 129 && $Input_Data_Width <= 256 && $ID > [expr "64*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 64K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 257 && $Input_Data_Width <= 512 && $ID > [expr "32*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 32K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 513 && $Input_Data_Width <= 1024 && $ID > [expr "16*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 16K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 1025 && $Input_Data_Width <= 2048 && $ID > [expr "8*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 8K " $Input_Depth
		return false
	} elseif {$Input_Data_Width > 2048 && $ID > [expr "4*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 4K " $Input_Depth
		return false
	}
	return true

}

proc validate_PARAM_VALUE.INPUT_DEPTH_RDCH { PARAM_VALUE.INPUT_DEPTH_RDCH PARAM_VALUE.DATA_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PARAM_VALUE.RUSER_WIDTH} {

	set Input_Depth ${PARAM_VALUE.INPUT_DEPTH_RDCH}
	set Input_Data_Width [get_metaparam_value Calculated_Width_rdch ]
	set ID [get_property value ${PARAM_VALUE.INPUT_DEPTH_RDCH}]
	
	if {$Input_Data_Width >= 1 && $Input_Data_Width <= 128 && $ID > [expr "128*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 128K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 129 && $Input_Data_Width <= 256 && $ID > [expr "64*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 64K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 257 && $Input_Data_Width <= 512 && $ID > [expr "32*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 32K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 513 && $Input_Data_Width <= 1024 && $ID > [expr "16*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 16K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 1025 && $Input_Data_Width <= 2048 && $ID > [expr "8*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 8K " $Input_Depth
		return false
	} elseif {$Input_Data_Width > 2048 && $ID > [expr "4*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 4K " $Input_Depth
		return false
	}
	return true

}

proc validate_PARAM_VALUE.INPUT_DEPTH_WACH { PARAM_VALUE.INPUT_DEPTH_WACH PARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.AWUSER_WIDTH  
  PARAM_VALUE.ID_WIDTH PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.PROTOCOL} {

	set Input_Depth ${PARAM_VALUE.INPUT_DEPTH_WACH}
	set Input_Data_Width [get_metaparam_value Calculated_Width_wach]
	set ID [get_property value ${PARAM_VALUE.INPUT_DEPTH_WACH}]
	
	if {$Input_Data_Width >= 1 && $Input_Data_Width <= 128 && $ID > [expr "128*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 128K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 129 && $Input_Data_Width <= 256 && $ID > [expr "64*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 64K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 257 && $Input_Data_Width <= 512 && $ID > [expr "32*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 32K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 513 && $Input_Data_Width <= 1024 && $ID > [expr "16*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 16K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 1025 && $Input_Data_Width <= 2048 && $ID > [expr "8*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 8K " $Input_Depth
		return false
	} elseif {$Input_Data_Width > 2048 && $ID > [expr "4*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 4K " $Input_Depth
		return false
	}
	return true

}

proc validate_PARAM_VALUE.INPUT_DEPTH_RACH { PARAM_VALUE.INPUT_DEPTH_RACH PARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.ARUSER_WIDTH  
  PARAM_VALUE.ID_WIDTH PARAM_VALUE.INTERFACE_TYPE  PARAM_VALUE.PROTOCOL} {

	set Input_Depth ${PARAM_VALUE.INPUT_DEPTH_RACH}
	set Input_Data_Width [get_metaparam_value Calculated_Width_rach]
	set ID [get_property value ${PARAM_VALUE.INPUT_DEPTH_RACH}]
	
	if {$Input_Data_Width >= 1 && $Input_Data_Width <= 128 && $ID > [expr "128*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 128K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 129 && $Input_Data_Width <= 256 && $ID > [expr "64*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 64K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 257 && $Input_Data_Width <= 512 && $ID > [expr "32*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 32K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 513 && $Input_Data_Width <= 1024 && $ID > [expr "16*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 16K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 1025 && $Input_Data_Width <= 2048 && $ID > [expr "8*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 8K " $Input_Depth
		return false
	} elseif {$Input_Data_Width > 2048 && $ID > [expr "4*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 4K " $Input_Depth
		return false
	}
	return true

}

proc validate_PARAM_VALUE.INPUT_DEPTH_WRCH { PARAM_VALUE.INPUT_DEPTH_WRCH PARAM_VALUE.BUSER_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL} {

	set Input_Depth ${PARAM_VALUE.INPUT_DEPTH_WRCH}
	set Input_Data_Width [get_metaparam_value Calculated_Width_wrch]
	set ID [get_property value ${PARAM_VALUE.INPUT_DEPTH_WRCH}]
	
	if {$Input_Data_Width >= 1 && $Input_Data_Width <= 128 && $ID > [expr "128*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 128K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 129 && $Input_Data_Width <= 256 && $ID > [expr "64*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 64K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 257 && $Input_Data_Width <= 512 && $ID > [expr "32*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 32K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 513 && $Input_Data_Width <= 1024 && $ID > [expr "16*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 16K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 1025 && $Input_Data_Width <= 2048 && $ID > [expr "8*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 8K " $Input_Depth
		return false
	} elseif {$Input_Data_Width > 2048 && $ID > [expr "4*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 4K " $Input_Depth
		return false
	}
	return true

}

proc validate_PARAM_VALUE.INPUT_DEPTH_AXIS { PARAM_VALUE.INPUT_DEPTH_AXIS PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.HAS_TKEEP  
  PARAM_VALUE.HAS_TSTRB PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.TDATA_NUM_BYTES PARAM_VALUE.TDEST_WIDTH  
  PARAM_VALUE.TID_WIDTH PARAM_VALUE.TKEEP_WIDTH  
  PARAM_VALUE.TSTRB_WIDTH PARAM_VALUE.TUSER_WIDTH} {

	set Input_Depth ${PARAM_VALUE.INPUT_DEPTH_AXIS}
	set Input_Data_Width [get_metaparam_value Calculated_Width_axis]
	set ID [get_property value ${PARAM_VALUE.INPUT_DEPTH_AXIS}]
	
	if {$Input_Data_Width >= 1 && $Input_Data_Width <= 128 && $ID > [expr "128*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 128K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 129 && $Input_Data_Width <= 256 && $ID > [expr "64*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 64K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 257 && $Input_Data_Width <= 512 && $ID > [expr "32*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 32K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 513 && $Input_Data_Width <= 1024 && $ID > [expr "16*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 16K " $Input_Depth
		return false
	} elseif {$Input_Data_Width >= 1025 && $Input_Data_Width <= 2048 && $ID > [expr "8*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 8K " $Input_Depth
		return false
	} elseif {$Input_Data_Width > 2048 && $ID > [expr "4*1024"] } {
		set_property errmsg "\nInput Depth should be less than or equal to 4K " $Input_Depth
		return false
	}
	return true

}

proc update_PARAM_VALUE.INPUT_DEPTH_WRCH { PARAM_VALUE.ENABLE_ECC_WRCH 
PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH PARAM_VALUE.INPUT_DEPTH_WRCH PARAM_VALUE.BUSER_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PARAM_VALUE.SYNCHRONIZATION_STAGES_AXI PROJECT_PARAM.ARCHITECTURE} {
	set calc_width_wrch [get_metaparam_value Calculated_Width_wrch]
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH} ]
        set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	
	set Input_Depth_fifo_name  ${PARAM_VALUE.INPUT_DEPTH_WRCH} 
	if { $Fifo_Implementation  == "Common_Clock_Builtin_FIFO" || $Fifo_Implementation  == "Independent_Clocks_Builtin_FIFO" } {
		set depthrange {"512" "1024" "2048" "4096" "8192" "16384"}
		for { set depthval 16384 } { $depthval >= 512 } { set depthval [expr "$depthval/2"] }  {
			set fifodepth [fifo_generator_v12_0_utils::get_Estimated_FIFO_InDepth $c_family $calc_width_wrch $calc_width_wrch $depthval [ get_property value ${PARAM_VALUE.ENABLE_ECC_WRCH} ] ]
			if { $fifodepth == 1 } {
			break
			}
		}
		set depthrangelimit [lsearch $depthrange $depthval]
		set rangelist [lreplace $depthrange [expr "$depthrangelimit + 1"] end]
		set defaultval [lindex $rangelist 0]
	} else {
		if {($Fifo_Implementation == "Independent_Clocks_Block_RAM" || $Fifo_Implementation == "Independent_Clocks_Distributed_RAM") && ([get_property value ${PARAM_VALUE.SYNCHRONIZATION_STAGES_AXI}] > 4) } {
			set defaultval 32
			set rangelist "32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304" 
		} else {
			set defaultval 16
			set rangelist "16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304" 
		}
		set rangelist [split $rangelist ","]
	}
	
	set newlist ""
	foreach listval $rangelist {
		if {[isInputDepthValid $calc_width_wrch $listval]} {
			tcl::lappend newlist $listval
		}
	}
	set newlist [regsub -all " " $newlist ","]
	set_property range_value "$defaultval,$newlist" $Input_Depth_fifo_name 
}

proc update_PARAM_VALUE.INPUT_DEPTH_AXIS { PARAM_VALUE.ENABLE_ECC_AXIS PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS PARAM_VALUE.INPUT_DEPTH_AXIS 
PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.HAS_TKEEP  PARAM_VALUE.SYNCHRONIZATION_STAGES_AXI
  PARAM_VALUE.HAS_TSTRB PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.TDATA_NUM_BYTES PARAM_VALUE.TDEST_WIDTH  
  PARAM_VALUE.TID_WIDTH PARAM_VALUE.TKEEP_WIDTH  
  PARAM_VALUE.TSTRB_WIDTH PARAM_VALUE.TUSER_WIDTH PROJECT_PARAM.ARCHITECTURE} {
  
        set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set Input_Depth_fifo_name  ${PARAM_VALUE.INPUT_DEPTH_AXIS} 
	set calc_width_axis [get_metaparam_value Calculated_Width_axis]
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} ]
	
	if { $Fifo_Implementation  == "Common_Clock_Builtin_FIFO" || $Fifo_Implementation  == "Independent_Clocks_Builtin_FIFO" } {
		set depthrange {"512" "1024" "2048" "4096" "8192" "16384"}
		for { set depthval 16384 } { $depthval >= 512 } { set depthval [expr "$depthval/2"] }  {
			set fifodepth [fifo_generator_v12_0_utils::get_Estimated_FIFO_InDepth $c_family $calc_width_axis $calc_width_axis $depthval [ get_property value ${PARAM_VALUE.ENABLE_ECC_AXIS} ] ]
			if { $fifodepth == 1 } {
			break
			}
		}
		set depthrangelimit [lsearch $depthrange $depthval]
		set rangelist [lreplace $depthrange [expr "$depthrangelimit + 1"] end]
		set defaultval [lindex $rangelist 0]
	} else {
		if {($Fifo_Implementation == "Independent_Clocks_Block_RAM" || $Fifo_Implementation == "Independent_Clocks_Distributed_RAM") && ([get_property value ${PARAM_VALUE.SYNCHRONIZATION_STAGES_AXI}] > 4) } {
			set defaultval 1024
			set rangelist "32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304" 
		} else {
			set defaultval 1024
			set rangelist "16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304" 
		}
		set rangelist [split $rangelist ","]
	}
	
	set newlist ""
	foreach listval $rangelist {
		if {[isInputDepthValid $calc_width_axis $listval]} {
			tcl::lappend newlist $listval
		}
	}
	set newlist [regsub -all " " $newlist ","]
	set_property range_value "$defaultval,$newlist" $Input_Depth_fifo_name 
}

proc update_PARAM_VALUE.INPUT_DEPTH_WDCH { PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH PARAM_VALUE.ENABLE_ECC_WDCH PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH PARAM_VALUE.INPUT_DEPTH_WDCH 
PARAM_VALUE.DATA_WIDTH PARAM_VALUE.ID_WIDTH  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL   PARAM_VALUE.WUSER_WIDTH PARAM_VALUE.SYNCHRONIZATION_STAGES_AXI PROJECT_PARAM.ARCHITECTURE} {
	set Input_Depth_fifo_name  ${PARAM_VALUE.INPUT_DEPTH_WDCH} 
	set calc_width_wdch [get_metaparam_value Calculated_Width_wdch]
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH} ]
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]

	if { $Fifo_Implementation  == "Common_Clock_Builtin_FIFO" || $Fifo_Implementation  == "Independent_Clocks_Builtin_FIFO" } {
		set depthrange {"512" "1024" "2048" "4096" "8192" "16384"}
		for { set depthval 16384 } { $depthval >= 512 } { set depthval [expr "$depthval/2"] }  {
			set fifodepth [fifo_generator_v12_0_utils::get_Estimated_FIFO_InDepth $c_family $calc_width_wdch $calc_width_wdch $depthval [ get_property value ${PARAM_VALUE.ENABLE_ECC_WDCH} ] ]
			if { $fifodepth == 1 } {
			break
			}
		}
		set depthrangelimit [lsearch $depthrange $depthval]
		set rangelist [lreplace $depthrange [expr "$depthrangelimit + 1"] end]
		set defaultval [lindex $rangelist 0]
	} else {
		if {([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ] == "Packet_FIFO")} {
			set defaultval 512
			set rangelist "512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304" 
			set rangelist [split $rangelist ","]
		} else {
			set defaultval 1024
			if {($Fifo_Implementation == "Independent_Clocks_Block_RAM" || $Fifo_Implementation == "Independent_Clocks_Distributed_RAM") && ([get_property value ${PARAM_VALUE.SYNCHRONIZATION_STAGES_AXI}] > 4) } {
				set rangelist "32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304" 
			} else {
				set rangelist "16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304" 
			}
			set rangelist [split $rangelist ","]
		}
	}
	
	set newlist ""
	foreach listval $rangelist {
		if {[isInputDepthValid $calc_width_wdch $listval]} {
			tcl::lappend newlist $listval
		}
	}
	set newlist [regsub -all " " $newlist ","]
	set_property range_value "$defaultval,$newlist" $Input_Depth_fifo_name 
}

proc update_PARAM_VALUE.INPUT_DEPTH_RDCH { PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH PARAM_VALUE.ENABLE_ECC_RDCH PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH PARAM_VALUE.INPUT_DEPTH_RDCH 
PARAM_VALUE.DATA_WIDTH PARAM_VALUE.ID_WIDTH  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PARAM_VALUE.RUSER_WIDTH PARAM_VALUE.SYNCHRONIZATION_STAGES_AXI PROJECT_PARAM.ARCHITECTURE} {
	set Input_Depth_fifo_name  ${PARAM_VALUE.INPUT_DEPTH_RDCH} 
	set calc_width_rdch [get_metaparam_value Calculated_Width_rdch]
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH} ]
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	
	if { $Fifo_Implementation  == "Common_Clock_Builtin_FIFO" || $Fifo_Implementation  == "Independent_Clocks_Builtin_FIFO" } {
		set depthrange {"512" "1024" "2048" "4096" "8192" "16384"}
		for { set depthval 16384 } { $depthval >= 512 } { set depthval [expr "$depthval/2"] }  {
			set fifodepth [fifo_generator_v12_0_utils::get_Estimated_FIFO_InDepth $c_family $calc_width_rdch $calc_width_rdch $depthval [ get_property value ${PARAM_VALUE.ENABLE_ECC_RDCH} ] ]
			if { $fifodepth == 1 } {
			break
			}
		}
		set depthrangelimit [lsearch $depthrange $depthval]
		set rangelist [lreplace $depthrange [expr "$depthrangelimit + 1"] end]
		set defaultval [lindex $rangelist 0]
	} else {
		if {([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH} ] == "Packet_FIFO")} {
			set defaultval 512
			set rangelist "512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304" 
			set rangelist [split $rangelist ","]
		} else {
			set defaultval 1024
			if {($Fifo_Implementation == "Independent_Clocks_Block_RAM" || $Fifo_Implementation == "Independent_Clocks_Distributed_RAM") && ([get_property value ${PARAM_VALUE.SYNCHRONIZATION_STAGES_AXI}] > 4) } {
				set rangelist "32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304" 
			} else {
				set rangelist "16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304" 
			}
			set rangelist [split $rangelist ","]
		}
	}
	
	set newlist ""
	foreach listval $rangelist {
		if {[isInputDepthValid $calc_width_rdch $listval]} {
			tcl::lappend newlist $listval
		}
	}
	set newlist [regsub -all " " $newlist ","]
	set_property range_value "$defaultval,$newlist" $Input_Depth_fifo_name 
}

proc update_PARAM_VALUE.INPUT_DEPTH_WACH { PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH PARAM_VALUE.ENABLE_ECC_WACH 
PARAM_VALUE.FIFO_IMPLEMENTATION_WACH PARAM_VALUE.INPUT_DEPTH_WACH PARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.AWUSER_WIDTH  
  PARAM_VALUE.ID_WIDTH PARAM_VALUE.INTERFACE_TYPE   PARAM_VALUE.PROTOCOL PARAM_VALUE.SYNCHRONIZATION_STAGES_AXI PROJECT_PARAM.ARCHITECTURE} {
	set Input_Depth_fifo_name  ${PARAM_VALUE.INPUT_DEPTH_WACH} 
	set calc_width_wach [get_metaparam_value Calculated_Width_wach]
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WACH} ]
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	
	if { $Fifo_Implementation  == "Common_Clock_Builtin_FIFO" || $Fifo_Implementation  == "Independent_Clocks_Builtin_FIFO" } {
		set depthrange {"512" "1024" "2048" "4096" "8192" "16384"}
		for { set depthval 16384 } { $depthval >= 512 } { set depthval [expr "$depthval/2"] }  {
			set fifodepth [fifo_generator_v12_0_utils::get_Estimated_FIFO_InDepth $c_family $calc_width_wach $calc_width_wach $depthval [ get_property value ${PARAM_VALUE.ENABLE_ECC_WACH} ] ]
			if { $fifodepth == 1 } {
			break
			}
		}
		set depthrangelimit [lsearch $depthrange $depthval]
		set rangelist [lreplace $depthrange [expr "$depthrangelimit + 1"] end]
		set defaultval [lindex $rangelist 0]
	} else {
		if {($Fifo_Implementation == "Independent_Clocks_Block_RAM" || $Fifo_Implementation == "Independent_Clocks_Distributed_RAM") && ([get_property value ${PARAM_VALUE.SYNCHRONIZATION_STAGES_AXI}] > 4) } {
			set defaultval 32
			set rangelist "32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304" 
		} else {
			set defaultval 16
			set rangelist "16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304" 
		}
		set rangelist [split $rangelist ","]
	}
	
	set newlist ""
	foreach listval $rangelist {
		if {[isInputDepthValid $calc_width_wach $listval]} {
			tcl::lappend newlist $listval
		}
	}
	set newlist [regsub -all " " $newlist ","]
	set_property range_value "$defaultval,$newlist" $Input_Depth_fifo_name 
}

proc update_PARAM_VALUE.INPUT_DEPTH_RACH { PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH PARAM_VALUE.ENABLE_ECC_RACH 
PARAM_VALUE.FIFO_IMPLEMENTATION_RACH PARAM_VALUE.INPUT_DEPTH_RACH PARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.ARUSER_WIDTH  
  PARAM_VALUE.ID_WIDTH PARAM_VALUE.INTERFACE_TYPE  PARAM_VALUE.PROTOCOL PARAM_VALUE.SYNCHRONIZATION_STAGES_AXI PROJECT_PARAM.ARCHITECTURE} {
	set Input_Depth_fifo_name  ${PARAM_VALUE.INPUT_DEPTH_RACH} 
	set calc_width_rach [get_metaparam_value Calculated_Width_rach]
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_RACH} ]
        set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	
	if { $Fifo_Implementation  == "Common_Clock_Builtin_FIFO" || $Fifo_Implementation  == "Independent_Clocks_Builtin_FIFO" } {
		set depthrange {"512" "1024" "2048" "4096" "8192" "16384"}
		for { set depthval 16384 } { $depthval >= 512 } { set depthval [expr "$depthval/2"] }  {
			set fifodepth [fifo_generator_v12_0_utils::get_Estimated_FIFO_InDepth $c_family $calc_width_rach $calc_width_rach $depthval [ get_property value ${PARAM_VALUE.ENABLE_ECC_RACH} ] ]
			if { $fifodepth == 1 } {
			break
			}
		}
		set depthrangelimit [lsearch $depthrange $depthval]
		set rangelist [lreplace $depthrange [expr "$depthrangelimit + 1"] end]
		set defaultval [lindex $rangelist 0]
	} else {
		if {($Fifo_Implementation == "Independent_Clocks_Block_RAM" || $Fifo_Implementation == "Independent_Clocks_Distributed_RAM") && ([get_property value ${PARAM_VALUE.SYNCHRONIZATION_STAGES_AXI}] > 4) } {
			set defaultval 32
			set rangelist "32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304" 
		} else {
			set defaultval 16
			set rangelist "16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304" 
		}
		set rangelist [split $rangelist ","]
	}
	
	set newlist ""
	foreach listval $rangelist {
		if {[isInputDepthValid $calc_width_rach $listval]} {
			tcl::lappend newlist $listval
		}
	}
	set newlist [regsub -all " " $newlist ","]
	set_property range_value "$defaultval,$newlist" $Input_Depth_fifo_name 
}


proc update_PARAM_VALUE.FIFO_APPLICATION_TYPE_WDCH { PARAM_VALUE.WDCH_TYPE PARAM_VALUE.FIFO_APPLICATION_TYPE_WDCH 
PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH } {
	set FIFO_Application_Type_fifo_name  ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WDCH} 
	
	if {[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH} ] == "Common_Clock_Distributed_RAM"  } {
		set rangelist "Data_FIFO Packet_FIFO Low_Latency_Data_FIFO" 
	} else {
		set rangelist "Data_FIFO Packet_FIFO"  
	}
	
	set index [lsearch $rangelist "Packet_FIFO"]
	set rangelist [lreplace $rangelist $index $index]
	set defaultval [get_property default_value $FIFO_Application_Type_fifo_name] 
	
	if {[llength $rangelist] == 1} {
		set_property range_value "$defaultval,Data_FIFO,Packet_FIFO,Low_Latency_Data_FIFO" $FIFO_Application_Type_fifo_name
		set_property enabled false $FIFO_Application_Type_fifo_name
	} else {
		set rangelist [regsub -all " " $rangelist ","]
		set_property enabled true $FIFO_Application_Type_fifo_name
		set_property range_value "$defaultval,$rangelist" $FIFO_Application_Type_fifo_name
	}
}

proc update_PARAM_VALUE.FIFO_APPLICATION_TYPE_RDCH {  PARAM_VALUE.RDCH_TYPE PARAM_VALUE.FIFO_APPLICATION_TYPE_RDCH 
PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH } {
	set FIFO_Application_Type_fifo_name  ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RDCH} 
	
	if {[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH} ] == "Common_Clock_Distributed_RAM"  } {
		set rangelist "Data_FIFO Packet_FIFO Low_Latency_Data_FIFO" 
	} else {
		set rangelist "Data_FIFO Packet_FIFO"  
	}
	
	set index [lsearch $rangelist "Packet_FIFO"]
	set rangelist [lreplace $rangelist $index $index]
	set defaultval [get_property default_value $FIFO_Application_Type_fifo_name] 
	
	if {[llength $rangelist] == 1} {
		set_property range_value "$defaultval,Data_FIFO,Packet_FIFO,Low_Latency_Data_FIFO" $FIFO_Application_Type_fifo_name
		set_property enabled false $FIFO_Application_Type_fifo_name
	} else {
		set rangelist [regsub -all " " $rangelist ","]
		set_property enabled true $FIFO_Application_Type_fifo_name
		set_property range_value "$defaultval,$rangelist" $FIFO_Application_Type_fifo_name
	}
}

proc update_PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH { PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PARAM_VALUE.WACH_TYPE PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH PARAM_VALUE.FIFO_IMPLEMENTATION_WACH } {
	set FIFO_Application_Type_fifo_name  ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} 
	
	if {[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WACH} ] == "Common_Clock_Distributed_RAM"  } {
		set rangelist "Data_FIFO Packet_FIFO Low_Latency_Data_FIFO" 
		set defaultval [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ]
	} else {
		set rangelist "Data_FIFO Packet_FIFO"  
		set defaultval [get_property default_value $FIFO_Application_Type_fifo_name] 
	}
	
	if { ([ get_property value ${PARAM_VALUE.PROTOCOL} ] != "AXI4_Lite"  && [ get_property value ${PARAM_VALUE.WACH_TYPE} ] == "FIFO"  && [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock"  && [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WACH} ] == "Common_Clock_Distributed_RAM") } {
		
	} else {
		set index [lsearch $rangelist "Packet_FIFO"]
		set rangelist [lreplace $rangelist $index $index]
		set defaultval [get_property default_value $FIFO_Application_Type_fifo_name] 
	}
	
	if {[llength $rangelist] == 1} {
		set_property range_value "$defaultval,Data_FIFO,Packet_FIFO,Low_Latency_Data_FIFO" $FIFO_Application_Type_fifo_name
		set_property enabled false $FIFO_Application_Type_fifo_name
	} else {
		set rangelist [regsub -all " " $rangelist ","]
		set_property enabled true $FIFO_Application_Type_fifo_name
		set_property range_value "$defaultval,$rangelist" $FIFO_Application_Type_fifo_name
	}
}

proc update_PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH { PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.ENABLE_TLAST 
PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PARAM_VALUE.RACH_TYPE 
PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH PARAM_VALUE.FIFO_IMPLEMENTATION_RACH } {
	set FIFO_Application_Type_fifo_name  ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH} 
	
	if {[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_RACH} ] == "Common_Clock_Distributed_RAM"  } {
		set rangelist "Data_FIFO Packet_FIFO Low_Latency_Data_FIFO" 
		set defaultval [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH} ]
	} else {
		set rangelist "Data_FIFO Packet_FIFO"  
		set defaultval [get_property default_value $FIFO_Application_Type_fifo_name] 
	}
	
	if { ([ get_property value ${PARAM_VALUE.PROTOCOL} ] != "AXI4_Lite"  && [ get_property value ${PARAM_VALUE.RACH_TYPE} ] == "FIFO"  && [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock"  && [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_RACH} ] == "Common_Clock_Distributed_RAM") } {
		
	} else {
		set index [lsearch $rangelist "Packet_FIFO"]
		set rangelist [lreplace $rangelist $index $index]
		set defaultval [get_property default_value $FIFO_Application_Type_fifo_name] 
	}
	
	if {[llength $rangelist] == 1} {
		set_property range_value "$defaultval,Data_FIFO,Packet_FIFO,Low_Latency_Data_FIFO" $FIFO_Application_Type_fifo_name
		set_property enabled false $FIFO_Application_Type_fifo_name
	} else {
		set rangelist [regsub -all " " $rangelist ","]
		set_property enabled true $FIFO_Application_Type_fifo_name
		set_property range_value "$defaultval,$rangelist" $FIFO_Application_Type_fifo_name
	}
}

proc update_PARAM_VALUE.FIFO_APPLICATION_TYPE_WRCH { PARAM_VALUE.WRCH_TYPE 
PARAM_VALUE.FIFO_APPLICATION_TYPE_WRCH PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH } {
	set FIFO_Application_Type_fifo_name  ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WRCH} 
	
	if {[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH} ] == "Common_Clock_Distributed_RAM"  } {
		set rangelist "Data_FIFO Packet_FIFO Low_Latency_Data_FIFO" 
	} else {
		set rangelist "Data_FIFO Packet_FIFO"  
	}
	
	set index [lsearch $rangelist "Packet_FIFO"]
	set rangelist [lreplace $rangelist $index $index]
	set defaultval [get_property default_value $FIFO_Application_Type_fifo_name] 
	
	if {[llength $rangelist] == 1} {
		set_property range_value "$defaultval,Data_FIFO,Packet_FIFO,Low_Latency_Data_FIFO" $FIFO_Application_Type_fifo_name
		set_property enabled false $FIFO_Application_Type_fifo_name
	} else {
		set rangelist [regsub -all " " $rangelist ","]
		set_property enabled true $FIFO_Application_Type_fifo_name
		set_property range_value "$defaultval,$rangelist" $FIFO_Application_Type_fifo_name
	}
}

proc update_PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS { PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PARAM_VALUE.AXIS_TYPE PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS } {
	set FIFO_Application_Type_fifo_name  ${PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS} 
	set clock_type [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ]
	set fifo_implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} ]
	if { $fifo_implementation == "Common_Clock_Distributed_RAM"  } {
		set rangelist "Data_FIFO Packet_FIFO Low_Latency_Data_FIFO" 
		set defaultval [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS} ]
	} elseif {($fifo_implementation == "Independent_Clocks_Builtin_FIFO" || $fifo_implementation == "Common_Clock_Builtin_FIFO")} {
		set rangelist "Data_FIFO"  
		set defaultval [get_property default_value $FIFO_Application_Type_fifo_name] 
	} else {
		set rangelist "Data_FIFO Packet_FIFO"  
		set defaultval [get_property default_value $FIFO_Application_Type_fifo_name] 
	}
	
	if { ([ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_STREAM"  && [ get_property value ${PARAM_VALUE.ENABLE_TLAST} ] == true  && [ get_property value ${PARAM_VALUE.AXIS_TYPE} ] == "FIFO" ) 
		&&( ($clock_type  eq  "Common_Clock" && ( $fifo_implementation == "Common_Clock_Block_RAM" || $fifo_implementation == "Common_Clock_Builtin_FIFO" || $fifo_implementation == "Common_Clock_Distributed_RAM"))
		||($clock_type  eq  "Independent_Clock" &&( $fifo_implementation == "Independent_Clocks_Builtin_FIFO" || $fifo_implementation == "Independent_Clocks_Block_RAM" ))) } {
		
	} else {
		set index [lsearch $rangelist "Packet_FIFO"]
		set rangelist [lreplace $rangelist $index $index]
		set defaultval [get_property default_value $FIFO_Application_Type_fifo_name] 
	}
	
	if {[llength $rangelist] == 1} {
		set_property range_value "$defaultval,Data_FIFO,Packet_FIFO,Low_Latency_Data_FIFO" $FIFO_Application_Type_fifo_name
		set_property enabled false $FIFO_Application_Type_fifo_name
	} else {
		set rangelist [regsub -all " " $rangelist ","]
		set_property enabled true $FIFO_Application_Type_fifo_name
		set_property range_value "$defaultval,$rangelist" $FIFO_Application_Type_fifo_name
	}
}

proc update_PARAM_VALUE.WACH_TYPE { PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.WACH_TYPE } {
	set fifo_type_handle  ${PARAM_VALUE.WACH_TYPE} 
	if { [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] eq "READ_ONLY"  } {
		set_property value [get_property default_value $fifo_type_handle] $fifo_type_handle
	}	 
	if {[ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq "Independent_Clock" } {				    
		set_property range_value "[get_property default_value $fifo_type_handle],FIFO,Pass_Through_Wire" $fifo_type_handle
	} else {
		set_property range "FIFO,Register_Slice,Pass_Through_Wire" $fifo_type_handle
	
	}
}

proc update_PARAM_VALUE.WRCH_TYPE { PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.WRCH_TYPE } {
	set fifo_type_handle  ${PARAM_VALUE.WRCH_TYPE} 
	if { [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] eq "READ_ONLY"  } {
		set_property value [get_property default_value $fifo_type_handle] $fifo_type_handle
	}	 
	
	if {[ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq "Independent_Clock" } {				    
		set_property range_value "[get_property default_value $fifo_type_handle],FIFO,Pass_Through_Wire" $fifo_type_handle
	} else {
		set_property range "FIFO,Register_Slice,Pass_Through_Wire" $fifo_type_handle
	}
}

proc update_PARAM_VALUE.RDCH_TYPE { PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.RDCH_TYPE } {
	set fifo_type_handle  ${PARAM_VALUE.RDCH_TYPE} 
	if { [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] ne "WRITE_ONLY"  } {
		set defaultval [get_property default_value $fifo_type_handle] 
	}	
	
	if {[ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq "Independent_Clock" } {			    
		set defaultval [get_property default_value $fifo_type_handle]
		set rangelist "FIFO Pass_Through_Wire"
	} else {
		if {([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH} ] eq "Packet_FIFO")} {
			set defaultval [get_property default_value $fifo_type_handle]
			set rangelist "FIFO Pass_Through_Wire"
		} else {
			set defaultval [ get_property value ${PARAM_VALUE.RDCH_TYPE} ]
			set rangelist "FIFO Register_Slice Pass_Through_Wire"
		}
	}

	if {([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH} ] eq "Packet_FIFO")} {
		set index [lsearch $rangelist "Pass_Through_Wire"]
		set rangelist [lreplace $rangelist $index $index]
		set defaultval [get_property default_value $fifo_type_handle]
	}

	set rangelist [regsub -all " " $rangelist ","]
	set_property range_value "$defaultval,$rangelist" $fifo_type_handle
}

proc update_PARAM_VALUE.WDCH_TYPE { PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH PARAM_VALUE.READ_WRITE_MODE PARAM_VALUE.WDCH_TYPE } {
	set fifo_type_handle  ${PARAM_VALUE.WDCH_TYPE} 
	if { [ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] == "READ_ONLY"  } {
		set defaultval [get_property default_value $fifo_type_handle] 
	} 
	
	if {[ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq  "Independent_Clock" } {				    
		set defaultval [get_property default_value $fifo_type_handle]
		set rangelist "FIFO Pass_Through_Wire"
	} else {
		if {([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ] == "Packet_FIFO")} {
			set defaultval [get_property default_value $fifo_type_handle]
			set rangelist "FIFO Pass_Through_Wire"
		} else {
			set defaultval [ get_property value ${PARAM_VALUE.WDCH_TYPE} ]
			set rangelist "FIFO Register_Slice Pass_Through_Wire"
		}
	}

	if {([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ] == "Packet_FIFO")} {
		set index [lsearch $rangelist "Pass_Through_Wire"]
		set rangelist [lreplace $rangelist $index $index]
		set defaultval [get_property default_value $fifo_type_handle]
	}
	
	set rangelist [regsub -all " " $rangelist ","]
	set_property range_value "$defaultval,$rangelist" $fifo_type_handle
}

proc update_PARAM_VALUE.AXIS_TYPE { PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.HAS_ACLKEN PARAM_VALUE.AXIS_TYPE } {
	set fifo_type_handle  ${PARAM_VALUE.AXIS_TYPE} 
set k [get_property value ${PARAM_VALUE.HAS_ACLKEN} ]
set p [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ]
	set_property range_value "FIFO,FIFO,Register_Slice" $fifo_type_handle
	if {[ get_property value ${PARAM_VALUE.HAS_ACLKEN} ] } {
		if {[ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq "Independent_Clock" } {				    
			set_property range_value "FIFO,FIFO" $fifo_type_handle
set r [get_property range $fifo_type_handle ]
#send_msg INFO 911 "$k $r $p"

		} else {
			set_property range_value "FIFO,FIFO,Register_Slice" $fifo_type_handle
		}
	} elseif {[ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq "Independent_Clock" } {				    
			set_property range_value "FIFO,FIFO" $fifo_type_handle
set r [get_property range $fifo_type_handle ]
#send_msg INFO 911 "$k $r $p"

		} else {

			set_property range_value "FIFO,FIFO,Register_Slice" $fifo_type_handle
set r [get_property range $fifo_type_handle ]
#send_msg INFO 913 "$k $r $p"
		}
}

proc update_PARAM_VALUE.RACH_TYPE { PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.RACH_TYPE } {
	set fifo_type_handle  ${PARAM_VALUE.RACH_TYPE} 
	
	if {[ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq  "Independent_Clock" } {				    
		set_property range_value "[get_property default_value $fifo_type_handle],FIFO,Pass_Through_Wire" $fifo_type_handle
	} else {
		set_property range "FIFO,Register_Slice,Pass_Through_Wire" $fifo_type_handle
	}
}

proc update_gui_for_PARAM_VALUE.USE_DOUT_RESET { IPINST PARAM_VALUE.USE_DOUT_RESET} {

	if {[ get_property value ${PARAM_VALUE.USE_DOUT_RESET} ]=="true"} {
		set_property visible true  [ipgui::get_guiparamspec Dout_Reset_Value -of $IPINST]
		set_property visible true [ipgui::get_textspec LabelFifotext24 -of $IPINST ]
		set_property visible false [ipgui::get_textspec Labelprevious24 -of $IPINST ]
	} else {
		set_property visible false  [ipgui::get_guiparamspec Dout_Reset_Value -of $IPINST]
		set_property visible false [ipgui::get_textspec LabelFifotext24 -of $IPINST ]
		set_property visible true [ipgui::get_textspec Labelprevious24 -of $IPINST ]
	}

}

proc update_PARAM_VALUE.DOUT_RESET_VALUE { PARAM_VALUE.DOUT_RESET_VALUE PARAM_VALUE.USE_DOUT_RESET PARAM_VALUE.OUTPUT_DATA_WIDTH} {

	set Dout_Reset_Value  ${PARAM_VALUE.DOUT_RESET_VALUE} 
	if {[ get_property value ${PARAM_VALUE.USE_DOUT_RESET} ] == "true"} {
		set_property enabled true $Dout_Reset_Value
   } else {
      set_property enabled false $Dout_Reset_Value
      set_property value [get_property default_value $Dout_Reset_Value] $Dout_Reset_Value 
   }

}
proc update_PARAM_VALUE.asymmetric_port_width { PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.asymmetric_port_width PARAM_VALUE.FIFO_IMPLEMENTATION} {
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set fifo_implementation [get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION}]
        	if { ($c_family ne "virtexu") && ($c_family ne "artixu")&& ($c_family ne "kintexu") } {
	    set_property value false ${PARAM_VALUE.asymmetric_port_width}
		set_property enabled false ${PARAM_VALUE.asymmetric_port_width}
	} else {
		if { ($fifo_implementation eq "Common_Clock_Builtin_FIFO" )|| ($fifo_implementation eq "Independent_Clocks_Builtin_FIFO")||($fifo_implementation eq "Common_Clock_Block_RAM" ) || ($fifo_implementation eq "Independent_Clocks_Block_RAM")} {
			set_property enabled true ${PARAM_VALUE.asymmetric_port_width}
		} else {
			set_property value false ${PARAM_VALUE.asymmetric_port_width}
			set_property enabled false ${PARAM_VALUE.asymmetric_port_width}
		}	
	}
	
}

proc update_PARAM_VALUE.ecc_pipeline_reg {PARAM_VALUE.ecc_pipeline_reg PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.ENABLE_ECC} {
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set fifo_implementation [get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION}]
	set enable_ecc_ntv [get_property value ${PARAM_VALUE.ENABLE_ECC}]
	if { $c_family eq "virtexu" } {
		if { (($fifo_implementation eq "Common_Clock_Builtin_FIFO") || ($fifo_implementation eq "Independent_Clocks_Builtin_FIFO") || ($fifo_implementation eq "Common_Clock_Block_RAM" ) || ($fifo_implementation eq "Independent_Clocks_Block_RAM")) && ($enable_ecc_ntv == true)} {
			set_property enabled true ${PARAM_VALUE.ecc_pipeline_reg}
		} else {
			set_property value false ${PARAM_VALUE.ecc_pipeline_reg}
			set_property enabled false ${PARAM_VALUE.ecc_pipeline_reg}
		}
	} else {
		set_property value false ${PARAM_VALUE.ecc_pipeline_reg}
		set_property enabled false  ${PARAM_VALUE.ecc_pipeline_reg}
	}
}

proc update_PARAM_VALUE.dynamic_power_saving {PARAM_VALUE.dynamic_power_saving PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.ENABLE_ECC PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.INPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.enable_low_latency} {
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set fifo_implementation [get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION}]
    set fifo_in_depth [fifo_generator_v12_0_utils::get_Estimated_FIFO_InDepth $c_family [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] [Get_Output_Data_Width ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ] [ get_property value ${PARAM_VALUE.ENABLE_ECC} ] ]
    set en_low_latency [get_property value ${PARAM_VALUE.enable_low_latency}]
	
	if { $c_family eq "virtexu" } {
		if { ((($fifo_implementation eq "Common_Clock_Builtin_FIFO") || ($fifo_implementation eq "Independent_Clocks_Builtin_FIFO")) && ($fifo_in_depth <= "12")) } {
			set_property enabled true ${PARAM_VALUE.dynamic_power_saving}
		} elseif { ((($fifo_implementation eq "Common_Clock_Builtin_FIFO") || ($fifo_implementation eq "Independent_Clocks_Builtin_FIFO")) && ($en_low_latency )) } {
			set_property enabled true ${PARAM_VALUE.dynamic_power_saving}
		} else {
			set_property value false ${PARAM_VALUE.dynamic_power_saving}
			set_property enabled false ${PARAM_VALUE.dynamic_power_saving}
		}
	} else {
		set_property value false ${PARAM_VALUE.dynamic_power_saving}
		set_property enabled false  ${PARAM_VALUE.dynamic_power_saving}
	}
}

#proc update_gui_for_PARAM_VALUE.asymmetric_port_width {IPINST PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.FIFO_IMPLEMENTATION} {
#	set fifo_implementation [get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION}]
#	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
#	if { $c_family != "virtexu" } {
#		set_property visible false [ ipgui::get_guiparamspec asymmetric_port_width -of $IPInst ]
#	} else {
#		if { $fifo_implementation eq "Common_Clock_Builtin_FIFO" || $fifo_implementation eq "Independent_Clocks_Builtin_FIFO"} {
#			set_property visible true [ ipgui::get_guiparamspec asymmetric_port_width -of $IPInst ]
#		} else {
#			set_property visible false [ ipgui::get_guiparamspec asymmetric_port_width -of $IPInst ]
#		}
#	}
#}

;# Model Parameter Updates ------------------

for {set n 0} { $n <$num_fifo_channels_incl_axis} {incr n} {
    set fifo_name [lindex $fifo_channels_incl_axis $n]   
    set fifo_name_upper [string toupper $fifo_name]   
	
	set userParam "PARAM_VALUE.[string toupper FIFO_Implementation_$fifo_name]"
	set ModelParam "MODELPARAM_VALUE.C_IMPLEMENTATION_TYPE_$fifo_name_upper"
    EvalSubstituting {userParam ModelParam} {
		proc update_$ModelParam {$userParam $ModelParam} {
			switch  [get_property value [set $userParam]]  {
				"Common_Clock_Block_RAM" 				{ set SimValue 1 }
				"Common_Clock_Distributed_RAM" 			{ set SimValue 2 } 
				"Common_Clock_Builtin_FIFO" 			{ set SimValue 5 }
				"Independent_Clocks_Block_RAM" 			{ set SimValue 11 }
				"Independent_Clocks_Distributed_RAM" 	{ set SimValue 12 }
				"Independent_Clocks_Builtin_FIFO" 		{ set SimValue 13 }
			}
			set_property value $SimValue [set $ModelParam]
		}
	} 0
	
	set userParam1 "PARAM_VALUE.[string toupper FIFO_Implementation_$fifo_name]"
	set userParam2 "PARAM_VALUE.[string toupper FIFO_Application_Type_$fifo_name]"
	set ModelParam "MODELPARAM_VALUE.C_APPLICATION_TYPE_$fifo_name_upper"
    EvalSubstituting {userParam1 userParam2 ModelParam} {	
		proc update_$ModelParam {$userParam1 $userParam2 $ModelParam PARAM_VALUE.CLOCK_TYPE_AXI} {
			if { !([get_property value  [set $userParam1]] == "Common_Clock_Builtin_FIFO" || [get_property value  [set $userParam1]] == "Independent_Clocks_Builtin_FIFO") } {
				switch  [get_property value [set $userParam2]]  {
					"Data_FIFO" 			{ set SimValue 0 }
					"Packet_FIFO" 			{ set SimValue 1 }
					"Low_Latency_Data_FIFO" { 
						if { [get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI}] == "Common_Clock" } {
							set SimValue 2
						} else {
							set SimValue 3 
						}
					}
				}
			} else {
				set SimValue 4
			}
			set_property value $SimValue [set $ModelParam]
		}
	} 0
		
	set userParam "PARAM_VALUE.[string toupper Enable_ECC_$fifo_name]"
	set ModelParam "MODELPARAM_VALUE.C_USE_ECC_$fifo_name_upper"
    EvalSubstituting {userParam ModelParam} {
		proc update_$ModelParam {$userParam $ModelParam} {
			set_property value [expr {([get_property value [set $userParam]] == true)?1:0}] [set $ModelParam]
		}
	} 0
		
	set userParam "PARAM_VALUE.[string toupper Enable_Data_Counts_$fifo_name]"
	set ModelParam "MODELPARAM_VALUE.C_HAS_DATA_COUNTS_$fifo_name_upper"
    EvalSubstituting {userParam ModelParam} {
		proc update_$ModelParam {$userParam $ModelParam} {
			set_property value [expr {([get_property value [set $userParam]] == true)?1:0}] [set $ModelParam]
		}
	} 0
		
	set userParam1 "PARAM_VALUE.[string toupper Inject_Sbit_Error_$fifo_name]"
	set userParam2 "PARAM_VALUE.[string toupper Inject_Dbit_Error_$fifo_name]"
	set ModelParam "MODELPARAM_VALUE.C_ERROR_INJECTION_TYPE_$fifo_name_upper"
    EvalSubstituting {userParam1 userParam2 ModelParam} {	
		proc update_$ModelParam {$userParam1 $userParam2 $ModelParam} {
			set Inject_Sbit_Error_fifo_name [get_property value [set $userParam1]]
			set Inject_Dbit_Error_fifo_name [get_property value [set $userParam2]]
			
			if { $Inject_Sbit_Error_fifo_name && $Inject_Dbit_Error_fifo_name } {
				set SimValue 3
			} elseif { $Inject_Dbit_Error_fifo_name } {
				set SimValue 2
			} elseif { $Inject_Sbit_Error_fifo_name } {
				set SimValue 1
			} else {
				set SimValue 0
			}
			
			set_property value $SimValue [set $ModelParam]
		}
	} 0
	
	set userParam "PARAM_VALUE.[string toupper Input_Depth_$fifo_name]"
	set ModelParam "MODELPARAM_VALUE.C_WR_DEPTH_$fifo_name_upper"
    EvalSubstituting {userParam ModelParam} {
		proc update_$ModelParam {$userParam $ModelParam} {
			set_property value [get_property value [set $userParam]] [set $ModelParam]
		}
	} 0
	
	set userParam "PARAM_VALUE.[string toupper Input_Depth_$fifo_name]"
	set ModelParam "MODELPARAM_VALUE.C_WR_PNTR_WIDTH_$fifo_name_upper"
    EvalSubstituting {userParam ModelParam} {
		proc update_$ModelParam {$userParam $ModelParam} {
			set_property value [expr { int(ceil(log([get_property value [set $userParam]])/log(2)))}] [set $ModelParam]
		}
	} 0
		
	set userParam "PARAM_VALUE.[string toupper Programmable_Full_Type_$fifo_name]"
	set ModelParam "MODELPARAM_VALUE.C_PROG_FULL_TYPE_$fifo_name_upper"
    EvalSubstituting {userParam ModelParam} {
		proc update_$ModelParam {$userParam $ModelParam} {
			switch  [get_property value [set $userParam]]  {		      
		      "Single_Programmable_Full_Threshold_Constant" 		{ set SimValue 1 }
		      "Single_Programmable_Full_Threshold_Input_Port" 		{ set SimValue 3 }		     
		      "No_Programmable_Full_Threshold" 						{ set SimValue 0 }
			}
			set_property value $SimValue [set $ModelParam]
		}
	} 0
	
	set userParam "PARAM_VALUE.[string toupper Full_Threshold_Assert_Value_$fifo_name]"
	set ModelParam "MODELPARAM_VALUE.C_PROG_FULL_THRESH_ASSERT_VAL_$fifo_name_upper"
    EvalSubstituting {userParam ModelParam} {
		proc update_$ModelParam {$userParam $ModelParam} {
			set_property value [get_property value [set $userParam]] [set $ModelParam]
		}
	} 0
		
	set userParam "PARAM_VALUE.[string toupper Programmable_Empty_Type_$fifo_name]"
	set ModelParam "MODELPARAM_VALUE.C_PROG_EMPTY_TYPE_$fifo_name_upper"
    EvalSubstituting {userParam ModelParam} {
		proc update_$ModelParam {$userParam $ModelParam} {
			switch  [get_property value [set $userParam]]  {		      
				"Single_Programmable_Empty_Threshold_Constant" 			{ set SimValue 1 }
				"Single_Programmable_Empty_Threshold_Input_Port" 		{ set SimValue 3 }		      
				"No_Programmable_Empty_Threshold" 						{ set SimValue 0 }
			}
			set_property value $SimValue [set $ModelParam]
		}
	} 0
		
	set userParam "PARAM_VALUE.[string toupper Empty_Threshold_Assert_Value_$fifo_name]"
	set ModelParam "MODELPARAM_VALUE.C_PROG_EMPTY_THRESH_ASSERT_VAL_$fifo_name_upper"
    EvalSubstituting {userParam ModelParam} {
		proc update_$ModelParam {$userParam $ModelParam} {
			set_property value [get_property value [set $userParam]] [set $ModelParam]
		}
	} 0
	
	set userParam "PARAM_VALUE.[string toupper Register_Slice_Mode_$fifo_name]"
	set ModelParam "MODELPARAM_VALUE.C_REG_SLICE_MODE_$fifo_name_upper"
    EvalSubstituting {userParam ModelParam} {
		proc update_$ModelParam {$userParam $ModelParam} {	
			switch  [get_property value [set $userParam]]  {		      		     
			  "Fully_Registered" 	{ set SimValue 0 }
		      "Light_Weight" 		{ set SimValue 1 }
			}	
			set_property value $SimValue [set $ModelParam]
		}
		
	} 0
}

set ParamList1 "AWUSER_Width WUSER_Width BUSER_Width RUSER_Width ARUSER_Width"
foreach Param $ParamList1 {
	set userParam "PARAM_VALUE.[string toupper $Param]"
	set ModelParam "MODELPARAM_VALUE.C_AXI_[string toupper $Param]"
	EvalSubstituting {userParam ModelParam} {
		proc update_$ModelParam {$userParam $ModelParam} {
			if {[get_property value [set $userParam]] <= 1 } {
				set val 1
			} else {
				set val [get_property value [set $userParam]]
			}
			set_property value $val [set $ModelParam]
		}
	} 0
}

proc update_MODELPARAM_VALUE.C_POWER_SAVING_MODE { MODELPARAM_VALUE.C_POWER_SAVING_MODE PARAM_VALUE.dynamic_power_saving } {
	set dynamic_power_saving [get_property value ${PARAM_VALUE.dynamic_power_saving}]
	if { $dynamic_power_saving == "true" } {
		set_property value 1 ${MODELPARAM_VALUE.C_POWER_SAVING_MODE}
	} else {
		set_property value 0 ${MODELPARAM_VALUE.C_POWER_SAVING_MODE}
	}
}


proc update_MODELPARAM_VALUE.C_USE_PIPELINE_REG { MODELPARAM_VALUE.C_USE_PIPELINE_REG PARAM_VALUE.ecc_pipeline_reg } {
	set ecc_pipeline_reg [get_property value ${PARAM_VALUE.ecc_pipeline_reg}]
	if { $ecc_pipeline_reg == "true" } {
		set_property value 1 ${MODELPARAM_VALUE.C_USE_PIPELINE_REG}
	} else {
		set_property value 0 ${MODELPARAM_VALUE.C_USE_PIPELINE_REG}
	}
}

proc update_MODELPARAM_VALUE.C_HAS_AXIS_TLAST { MODELPARAM_VALUE.C_HAS_AXIS_TLAST PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.TDATA_NUM_BYTES 
PARAM_VALUE.TID_WIDTH PARAM_VALUE.TDEST_WIDTH PARAM_VALUE.TUSER_WIDTH} {
	set_property value [expr {([get_property value ${PARAM_VALUE.ENABLE_TLAST}]==true)?1:0}] ${MODELPARAM_VALUE.C_HAS_AXIS_TLAST}
}

proc update_MODELPARAM_VALUE.C_HAS_AXIS_TREADY { MODELPARAM_VALUE.C_HAS_AXIS_TREADY PARAM_VALUE.ENABLE_TREADY PARAM_VALUE.TDATA_NUM_BYTES 
PARAM_VALUE.TID_WIDTH PARAM_VALUE.TDEST_WIDTH PARAM_VALUE.TUSER_WIDTH} {
	set_property value [expr {([get_property value ${PARAM_VALUE.ENABLE_TREADY}]==true)?1:0}] ${MODELPARAM_VALUE.C_HAS_AXIS_TREADY}
}

set ParamList3 "ARUSER RUSER BUSER WUSER AWUSER"
foreach Param $ParamList3 {
	set userParam "PARAM_VALUE.[string toupper ${Param}_Width]"
	set ModelParam "MODELPARAM_VALUE.C_HAS_AXI_${Param}"
	EvalSubstituting {userParam ModelParam} {
		proc update_$ModelParam {$userParam $ModelParam} {
			if { [get_property value [set $userParam]] > 0 } {
				set val 1
			} else {
				set val 0
			}
			set_property value $val [set $ModelParam]
		}
	} 0
}

for {set n 0} { $n <$num_fifo_channels_incl_axis} {incr n} {
   set fifo [lindex $fifo_channels_incl_axis $n]
   set fifo_upper [string toupper $fifo]
	EvalSubstituting {fifo_upper fifo} {
		proc update_MODELPARAM_VALUE.C_$fifo_upper_TYPE {PARAM_VALUE.$fifo_upper_TYPE MODELPARAM_VALUE.C_$fifo_upper_TYPE} {
			switch  [get_property value [set "PARAM_VALUE.$fifo_upper_TYPE"]  ]  {
				"FIFO" 				{ set SimValue  0 }
				"Register_Slice" 	{ set SimValue  1 }
				"Pass_Through_Wire" { set SimValue  2 }
			}
			set_property value $SimValue  [set MODELPARAM_VALUE.C_$fifo_upper_TYPE]
		}
	} 0
}

set ParamsList "Write_Clock_Frequency Read_Clock_Frequency ADDRESS_WIDTH DATA_WIDTH \
                Full_Flags_Reset_Value Dout_Reset_Value Data_Count_Width Write_Data_Count_Width Read_Data_Count_Width \
				Empty_Threshold_Assert_Value Empty_Threshold_Negate_Value Full_Threshold_Assert_Value Full_Threshold_Negate_Value \
				Input_Data_Width Output_Data_Width Input_Depth Output_Depth"
				
set ModelParamsList "C_WR_FREQ C_RD_FREQ C_AXI_ADDR_WIDTH C_AXI_DATA_WIDTH \
                     C_FULL_FLAGS_RST_VAL C_DOUT_RST_VAL C_DATA_COUNT_WIDTH C_WR_DATA_COUNT_WIDTH C_RD_DATA_COUNT_WIDTH \
					 C_PROG_EMPTY_THRESH_ASSERT_VAL C_PROG_EMPTY_THRESH_NEGATE_VAL C_PROG_FULL_THRESH_ASSERT_VAL C_PROG_FULL_THRESH_NEGATE_VAL \
					 C_DIN_WIDTH C_DOUT_WIDTH C_WR_DEPTH C_RD_DEPTH"
					 
for {set i 0} {$i < [llength $ParamsList]} {incr i} {
	set Param "PARAM_VALUE.[string toupper [lindex $ParamsList $i]]"
	set ModelParam "MODELPARAM_VALUE.[string toupper [lindex $ModelParamsList $i]]"
	EvalSubstituting {Param ModelParam} {	
		proc update_$ModelParam {$Param $ModelParam} {
			set_property value [get_property value [set $Param]] [set $ModelParam]
		}
	} 0
}

set ParamsList1 "Enable_Common_Underflow Enable_Common_Overflow Add_NGC_Constraint_AXI   \
                 Enable_Reset_Synchronization Write_Data_Count Read_Data_Count Use_Extra_Logic Data_Count\
				 Write_Acknowledge_Flag Use_Dout_Reset Enable_ECC Use_Embedded_Registers Almost_Full_Flag \
				 Almost_Empty_Flag Valid_Flag"
				 
set ModelParamsList1 "C_USE_COMMON_UNDERFLOW C_USE_COMMON_OVERFLOW C_ADD_NGC_CONSTRAINT   \
                      C_ENABLE_RST_SYNC C_HAS_WR_DATA_COUNT C_HAS_RD_DATA_COUNT C_USE_FWFT_DATA_COUNT C_HAS_DATA_COUNT \
					  C_HAS_WR_ACK C_USE_DOUT_RST C_USE_ECC C_USE_EMBEDDED_REG C_HAS_ALMOST_FULL \
					  C_HAS_ALMOST_EMPTY C_HAS_VALID"
					  
for {set i 0} {$i < [llength $ParamsList1]} {incr i} {
	set Param "PARAM_VALUE.[string toupper [lindex $ParamsList1 $i]]"
	set ModelParam "MODELPARAM_VALUE.[string toupper [lindex $ModelParamsList1 $i]]"
	EvalSubstituting {Param ModelParam} {	
		proc update_$ModelParam {$Param $ModelParam} {
			set_property value [expr {([get_property value [set $Param]]==true)?1:0}] [set $ModelParam]
		}
	} 0
}

proc update_MODELPARAM_VALUE.C_WR_PNTR_WIDTH { MODELPARAM_VALUE.C_WR_PNTR_WIDTH PARAM_VALUE.INPUT_DEPTH} {

	set log2xcoValue [expr { int(ceil(log( [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ] )/log(2))) }]
	set_property value $log2xcoValue  ${MODELPARAM_VALUE.C_WR_PNTR_WIDTH} 

}

proc update_MODELPARAM_VALUE.C_HAS_PROG_FLAGS_WDCH { MODELPARAM_VALUE.C_HAS_PROG_FLAGS_WDCH} {

	set_property value 0  ${MODELPARAM_VALUE.C_HAS_PROG_FLAGS_WDCH} 

}

proc update_MODELPARAM_VALUE.C_WR_FREQ { MODELPARAM_VALUE.C_WR_FREQ PARAM_VALUE.WRITE_CLOCK_FREQUENCY} {

	
	set_property value [ get_property value ${PARAM_VALUE.WRITE_CLOCK_FREQUENCY} ]  ${MODELPARAM_VALUE.C_WR_FREQ}   

}

proc update_MODELPARAM_VALUE.C_HAS_AXIS_TSTRB { MODELPARAM_VALUE.C_HAS_AXIS_TSTRB PARAM_VALUE.HAS_TSTRB} {

	set_property value [expr {([ get_property value ${PARAM_VALUE.HAS_TSTRB} ] == true)?1:0}]  ${MODELPARAM_VALUE.C_HAS_AXIS_TSTRB}   

}

proc update_MODELPARAM_VALUE.C_HAS_PROG_FLAGS_RDCH { MODELPARAM_VALUE.C_HAS_PROG_FLAGS_RDCH} {

	set_property value 0  ${MODELPARAM_VALUE.C_HAS_PROG_FLAGS_RDCH} 

}

proc update_MODELPARAM_VALUE.C_HAS_AXIS_TID { MODELPARAM_VALUE.C_HAS_AXIS_TID PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.TDATA_NUM_BYTES 
PARAM_VALUE.TID_WIDTH PARAM_VALUE.TDEST_WIDTH PARAM_VALUE.TUSER_WIDTH} {

	if {[ get_property value ${PARAM_VALUE.TID_WIDTH} ] > 0} {
		set val 1
	} else {
		set val 0
	}
	
	set_property value $val  ${MODELPARAM_VALUE.C_HAS_AXIS_TID} 

}

proc update_MODELPARAM_VALUE.C_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_AXIS_TDATA_WIDTH PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.TDATA_NUM_BYTES 
PARAM_VALUE.TID_WIDTH PARAM_VALUE.TDEST_WIDTH PARAM_VALUE.TUSER_WIDTH} {

	if {[ get_property value ${PARAM_VALUE.TDATA_NUM_BYTES} ] == 0} {
		set val 1
	} else {
		set val [expr [ get_property value ${PARAM_VALUE.TDATA_NUM_BYTES} ] * 8]
	}
	
	set_property value $val  ${MODELPARAM_VALUE.C_AXIS_TDATA_WIDTH} 

}

proc update_MODELPARAM_VALUE.C_VALID_LOW { MODELPARAM_VALUE.C_VALID_LOW PARAM_VALUE.VALID_SENSE} {

	set_property value [expr {([ get_property value ${PARAM_VALUE.VALID_SENSE} ]=="Active_Low")?1:0}]  ${MODELPARAM_VALUE.C_VALID_LOW}   

}

proc update_MODELPARAM_VALUE.C_INTERFACE_TYPE { MODELPARAM_VALUE.C_INTERFACE_TYPE PARAM_VALUE.INTERFACE_TYPE} {

	if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "Native"} {
		set val 0
	} elseif {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI_STREAM"} {
		set val 1
	} else {
		set val 2
	}
	set_property value $val  ${MODELPARAM_VALUE.C_INTERFACE_TYPE}   

}

proc update_MODELPARAM_VALUE.C_FAMILY { MODELPARAM_VALUE.C_FAMILY PROJECT_PARAM.ARCHITECTURE} {
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set_property value $c_family  ${MODELPARAM_VALUE.C_FAMILY}   
}

proc update_MODELPARAM_VALUE.C_PRIM_FIFO_TYPE { MODELPARAM_VALUE.C_PRIM_FIFO_TYPE PARAM_VALUE.ENABLE_ECC  
  PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.INPUT_DATA_WIDTH PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.OUTPUT_DATA_WIDTH} {

   set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
   set Input_Depth [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ]
   set Enable_ECC [ get_property value ${PARAM_VALUE.ENABLE_ECC} ]
	 if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]== "Native"} {	    
		set prim_fifo_type [fifo_generator_v12_0_utils::get_Prim_Fifo_Type $c_family [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] [Get_Output_Data_Width ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] $Input_Depth  $Enable_ECC  ]
		set_property value $prim_fifo_type  ${MODELPARAM_VALUE.C_PRIM_FIFO_TYPE} 
	}	else {
		set_property value "4kx4"  ${MODELPARAM_VALUE.C_PRIM_FIFO_TYPE} 
  }

}

proc update_MODELPARAM_VALUE.C_HAS_OVERFLOW { MODELPARAM_VALUE.C_HAS_OVERFLOW PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.OVERFLOW_FLAG PARAM_VALUE.OVERFLOW_FLAG_AXI} {
 
     set Overflow_Flag [ get_property value ${PARAM_VALUE.OVERFLOW_FLAG} ]
     set Overflow_Flag_AXI [ get_property value ${PARAM_VALUE.OVERFLOW_FLAG_AXI} ]
     set INTERFACE_TYPE [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
   if {$INTERFACE_TYPE  == "Native"} {
	   if {$Overflow_Flag} {
	      set val 1
	   } else {
	      set val 0
	   }
   } else {
	   if {$Overflow_Flag_AXI  } {
		    set val 1
	   } else {
		    set val 0
	   }
   }

  set_property value $val  ${MODELPARAM_VALUE.C_HAS_OVERFLOW} 

}

proc update_MODELPARAM_VALUE.C_PRELOAD_REGS { MODELPARAM_VALUE.C_PRELOAD_REGS PARAM_VALUE.PERFORMANCE_OPTIONS  
  PARAM_VALUE.USE_EMBEDDED_REGISTERS PARAM_VALUE.USE_EMBEDDED_REGISTERS_AXIS} {

	set Performance_Options [ get_property value ${PARAM_VALUE.PERFORMANCE_OPTIONS} ]
	set Use_Embedded_Registers [ get_property value ${PARAM_VALUE.USE_EMBEDDED_REGISTERS} ]
	set Use_Embedded_Registers_axis [ get_property value ${PARAM_VALUE.USE_EMBEDDED_REGISTERS_AXIS} ]
	if {$Performance_Options == "Standard_FIFO"} {
      if {$Use_Embedded_Registers  == true || $Use_Embedded_Registers_axis == true } {
        # Same regardless of built-in and block ram  
        set val 1
      } else {
        set val 0
      }
   } elseif {$Performance_Options == "First_Word_Fall_Through"} {
      set val 1
   }
   set_property value $val  ${MODELPARAM_VALUE.C_PRELOAD_REGS} 

}

proc update_MODELPARAM_VALUE.C_AXI_LOCK_WIDTH { MODELPARAM_VALUE.C_AXI_LOCK_WIDTH PARAM_VALUE.PROTOCOL} {

	if {[ get_property value ${PARAM_VALUE.PROTOCOL} ] == "AXI4"} {
		set val 1
	} else {
		set val 2
	}
	
	set_property value $val  ${MODELPARAM_VALUE.C_AXI_LOCK_WIDTH} 

}

proc update_MODELPARAM_VALUE.C_SYNCHRONIZER_STAGE { MODELPARAM_VALUE.C_SYNCHRONIZER_STAGE PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.SYNCHRONIZATION_STAGES PARAM_VALUE.SYNCHRONIZATION_STAGES_AXI} {

	if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "Native"} {
		set val  [ get_property value ${PARAM_VALUE.SYNCHRONIZATION_STAGES} ]
	} else {
		set val [ get_property value ${PARAM_VALUE.SYNCHRONIZATION_STAGES_AXI} ] 
	}
	set_property value $val  ${MODELPARAM_VALUE.C_SYNCHRONIZER_STAGE} 

}

proc update_MODELPARAM_VALUE.C_USE_DEFAULT_SETTINGS { MODELPARAM_VALUE.C_USE_DEFAULT_SETTINGS} {

	set_property value 0  ${MODELPARAM_VALUE.C_USE_DEFAULT_SETTINGS} 

}

proc update_MODELPARAM_VALUE.C_HAS_PROG_FLAGS_WACH { MODELPARAM_VALUE.C_HAS_PROG_FLAGS_WACH} {

	set_property value 0  ${MODELPARAM_VALUE.C_HAS_PROG_FLAGS_WACH} 

}

proc update_MODELPARAM_VALUE.C_AXI_TYPE { MODELPARAM_VALUE.C_AXI_TYPE PARAM_VALUE.PROTOCOL} {


	set PROTOCOL [ get_property value ${PARAM_VALUE.PROTOCOL} ]
	switch  $PROTOCOL  {
      "AXI4" {set val 1 }
      "AXI4_Lite" { set val 2 }     
	  "AXI3" { set val 3  }
   }
	set_property value $val  ${MODELPARAM_VALUE.C_AXI_TYPE} 

}

proc update_MODELPARAM_VALUE.C_RD_FREQ { MODELPARAM_VALUE.C_RD_FREQ PARAM_VALUE.READ_CLOCK_FREQUENCY} {


	set_property value [ get_property value ${PARAM_VALUE.READ_CLOCK_FREQUENCY} ]  ${MODELPARAM_VALUE.C_RD_FREQ}   

}

proc update_MODELPARAM_VALUE.C_USE_EMBEDDED_REG { MODELPARAM_VALUE.C_USE_EMBEDDED_REG PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.USE_EMBEDDED_REGISTERS PARAM_VALUE.USE_EMBEDDED_REGISTERS_AXIS} {


	if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "Native" } {
	  if {[ get_property value ${PARAM_VALUE.USE_EMBEDDED_REGISTERS} ]  == true} {
        set val 1
      } else {
         set val 0
      }
	} else {
	  if {[ get_property value ${PARAM_VALUE.USE_EMBEDDED_REGISTERS_AXIS} ]  == true} {
        set val 1
      } else {
         set val 0
      }
	}
	set_property value $val  ${MODELPARAM_VALUE.C_USE_EMBEDDED_REG}   

}

proc update_MODELPARAM_VALUE.C_PROG_FULL_TYPE { MODELPARAM_VALUE.C_PROG_FULL_TYPE PARAM_VALUE.PROGRAMMABLE_FULL_TYPE} {
 
	set Programmable_Full_Type [ get_property value ${PARAM_VALUE.PROGRAMMABLE_FULL_TYPE} ]
   switch  $Programmable_Full_Type  {
      "No_Programmable_Full_Threshold" { set val 0 }
      "Single_Programmable_Full_Threshold_Constant" { set val 1  }
      "Multiple_Programmable_Full_Threshold_Constants" { set val 2  }
      "Single_Programmable_Full_Threshold_Input_Port" { set val 3  }
      "Multiple_Programmable_Full_Threshold_Input_Ports" { set val 4 }
   }
	set_property value $val  ${MODELPARAM_VALUE.C_PROG_FULL_TYPE} 

}

proc update_MODELPARAM_VALUE.C_AXIS_TKEEP_WIDTH { MODELPARAM_VALUE.C_AXIS_TKEEP_WIDTH PARAM_VALUE.TKEEP_WIDTH} {

	if {[ get_property value ${PARAM_VALUE.TKEEP_WIDTH} ] < 1} {
		set val 1
	} else {
		set val [ get_property value ${PARAM_VALUE.TKEEP_WIDTH} ]
	}
	
	set_property value $val  ${MODELPARAM_VALUE.C_AXIS_TKEEP_WIDTH} 

}

proc update_MODELPARAM_VALUE.C_HAS_PROG_FLAGS_RACH { MODELPARAM_VALUE.C_HAS_PROG_FLAGS_RACH} {

	set_property value 0  ${MODELPARAM_VALUE.C_HAS_PROG_FLAGS_RACH} 

}

proc update_MODELPARAM_VALUE.C_HAS_RST { MODELPARAM_VALUE.C_HAS_RST PARAM_VALUE.RESET_PIN  
  PARAM_VALUE.RESET_TYPE PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.FIFO_IMPLEMENTATION} {

	set Reset_Pin [ get_property value ${PARAM_VALUE.RESET_PIN} ]
	set Reset_Type [ get_property value ${PARAM_VALUE.RESET_TYPE} ]
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set fifo_implementation [get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION}]	
   if {$Reset_Pin} {
	if {$c_family == "virtexu" && ($fifo_implementation == "Common_Clock_Builtin_FIFO" || $fifo_implementation == "Independent_Clocks_Builtin_FIFO") } {
		set val 0
	} else {
	  if {$Reset_Type  == "Asynchronous_Reset"} {
        set val 1
      } else {
         set val 0
      }
	}
   } else {
	  set val 0
   }

  set_property value $val  ${MODELPARAM_VALUE.C_HAS_RST} 

}

proc update_MODELPARAM_VALUE.C_HAS_SLAVE_CE { MODELPARAM_VALUE.C_HAS_SLAVE_CE PARAM_VALUE.HAS_ACLKEN PARAM_VALUE.CLOCK_ENABLE_TYPE} {

	if {[ get_property value ${PARAM_VALUE.HAS_ACLKEN}] && [ get_property value ${PARAM_VALUE.CLOCK_ENABLE_TYPE}] == "Slave_Interface_Clock_Enable"} {	   
		set SimValue 1
   } else {
	    set SimValue 0
   }   
	set_property value $SimValue  ${MODELPARAM_VALUE.C_HAS_SLAVE_CE}   

}

proc update_MODELPARAM_VALUE.C_HAS_MASTER_CE { MODELPARAM_VALUE.C_HAS_MASTER_CE PARAM_VALUE.HAS_ACLKEN PARAM_VALUE.CLOCK_ENABLE_TYPE} {

	if {[ get_property value ${PARAM_VALUE.HAS_ACLKEN}] && [ get_property value ${PARAM_VALUE.CLOCK_ENABLE_TYPE}] == "Master_Interface_Clock_Enable" } {	   
		set SimValue 1
   } else {
	    set SimValue 0
   }   
	set_property value $SimValue  ${MODELPARAM_VALUE.C_HAS_MASTER_CE}   

}

proc update_MODELPARAM_VALUE.C_PRELOAD_LATENCY { MODELPARAM_VALUE.C_PRELOAD_LATENCY PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.PERFORMANCE_OPTIONS PARAM_VALUE.USE_EMBEDDED_REGISTERS  
  PARAM_VALUE.USE_EMBEDDED_REGISTERS_AXIS PROJECT_PARAM.ARCHITECTURE } {
    set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set Performance_Options [ get_property value ${PARAM_VALUE.PERFORMANCE_OPTIONS} ]
	set Use_Embedded_Registers [ get_property value ${PARAM_VALUE.USE_EMBEDDED_REGISTERS} ]
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	set Use_Embedded_Registers_axis [ get_property value ${PARAM_VALUE.USE_EMBEDDED_REGISTERS_AXIS} ]
	if {$Performance_Options == "Standard_FIFO"} {
      if {$Use_Embedded_Registers  == true || $Use_Embedded_Registers_axis == true } {
        # Same regardless of built-in and block ram  
        set val 2
      } else {
        set val 1
      }
   } elseif {$Performance_Options == "First_Word_Fall_Through"} {
       if {($Use_Embedded_Registers  == true || $Use_Embedded_Registers_axis == true) 
          && ($Fifo_Implementation  == "Common_Clock_Builtin_FIFO") && ($c_family ne "virtexu") } {
       set val 1
      } else {
        set val 0
      }
   }
   set_property value $val  ${MODELPARAM_VALUE.C_PRELOAD_LATENCY} 

}

proc update_MODELPARAM_VALUE.C_WR_RESPONSE_LATENCY { MODELPARAM_VALUE.C_WR_RESPONSE_LATENCY} {
	set_property value 1  ${MODELPARAM_VALUE.C_WR_RESPONSE_LATENCY} 
}

proc update_MODELPARAM_VALUE.C_HAS_AXIS_TKEEP { MODELPARAM_VALUE.C_HAS_AXIS_TKEEP PARAM_VALUE.HAS_TKEEP} {
	set_property value [expr {([ get_property value ${PARAM_VALUE.HAS_TKEEP} ] == true)?1:0}]  ${MODELPARAM_VALUE.C_HAS_AXIS_TKEEP}   
}

proc update_MODELPARAM_VALUE.C_COUNT_TYPE { MODELPARAM_VALUE.C_COUNT_TYPE} {
	set_property value 0  ${MODELPARAM_VALUE.C_COUNT_TYPE} 
}

proc update_MODELPARAM_VALUE.C_OPTIMIZATION_MODE { MODELPARAM_VALUE.C_OPTIMIZATION_MODE} {
	set_property value 0  ${MODELPARAM_VALUE.C_OPTIMIZATION_MODE} 
}

proc update_MODELPARAM_VALUE.C_HAS_WR_RST { MODELPARAM_VALUE.C_HAS_WR_RST} {
	set_property value 0  ${MODELPARAM_VALUE.C_HAS_WR_RST} 
}

proc update_MODELPARAM_VALUE.C_HAS_AXIS_TDATA { MODELPARAM_VALUE.C_HAS_AXIS_TDATA PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.TDATA_NUM_BYTES 
PARAM_VALUE.TID_WIDTH PARAM_VALUE.TDEST_WIDTH PARAM_VALUE.TUSER_WIDTH} {
	if {[ get_property value ${PARAM_VALUE.TDATA_NUM_BYTES} ] > 0} {
		set val 1
	} else {
		set val 0
	}
	
	set_property value $val  ${MODELPARAM_VALUE.C_HAS_AXIS_TDATA} 
}

proc update_MODELPARAM_VALUE.C_HAS_AXI_WR_CHANNEL { MODELPARAM_VALUE.C_HAS_AXI_WR_CHANNEL PARAM_VALUE.READ_WRITE_MODE} {

	if {[ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "READ_ONLY"} {
		set val 1
	} else {
		set val 0
	}
	
	set_property value $val  ${MODELPARAM_VALUE.C_HAS_AXI_WR_CHANNEL} 

}

proc update_MODELPARAM_VALUE.C_ERROR_INJECTION_TYPE { MODELPARAM_VALUE.C_ERROR_INJECTION_TYPE PARAM_VALUE.INJECT_DBIT_ERROR  
  PARAM_VALUE.INJECT_SBIT_ERROR} {
 
	set Inject_Sbit_Error [ get_property value ${PARAM_VALUE.INJECT_SBIT_ERROR} ]
	set Inject_Dbit_Error [ get_property value ${PARAM_VALUE.INJECT_DBIT_ERROR} ]
   if { $Inject_Sbit_Error  && $Inject_Dbit_Error  } {
      set val 3
   } elseif { $Inject_Dbit_Error  } {
      set val 2
   } elseif { $Inject_Sbit_Error  } {
      set val 1
   } else {
      set val 0
   }
	set_property value $val  ${MODELPARAM_VALUE.C_ERROR_INJECTION_TYPE} 

}

proc update_MODELPARAM_VALUE.C_OVERFLOW_LOW { MODELPARAM_VALUE.C_OVERFLOW_LOW PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.OVERFLOW_SENSE PARAM_VALUE.OVERFLOW_SENSE_AXI} {
 
     set Overflow_Sense [ get_property value ${PARAM_VALUE.OVERFLOW_SENSE} ]
     set Overflow_Sense_AXI [ get_property value ${PARAM_VALUE.OVERFLOW_SENSE_AXI} ]
     set INTERFACE_TYPE [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
   if {$INTERFACE_TYPE  == "Native"} {
	   if {$Overflow_Sense == "Active_Low"} {
	      set val 1
	   } else {
	      set val 0
	   }
   } else {
	   if {$Overflow_Sense_AXI == "Active_Low" } {
		    set val 1
	   } else {
		    set val 0
	   }
   }
	set_property value $val  ${MODELPARAM_VALUE.C_OVERFLOW_LOW} 

}

proc update_MODELPARAM_VALUE.C_AXIS_TUSER_WIDTH { MODELPARAM_VALUE.C_AXIS_TUSER_WIDTH PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.TDATA_NUM_BYTES 
PARAM_VALUE.TID_WIDTH PARAM_VALUE.TDEST_WIDTH PARAM_VALUE.TUSER_WIDTH} {

	if {[ get_property value ${PARAM_VALUE.TUSER_WIDTH} ] < 1} {
		set val 1
	} else {
		set val [ get_property value ${PARAM_VALUE.TUSER_WIDTH} ]
	}
	
	set_property value $val  ${MODELPARAM_VALUE.C_AXIS_TUSER_WIDTH} 

}

proc update_MODELPARAM_VALUE.C_HAS_INT_CLK { MODELPARAM_VALUE.C_HAS_INT_CLK} {
	set_property value 0  ${MODELPARAM_VALUE.C_HAS_INT_CLK} 
}

proc update_MODELPARAM_VALUE.C_DEFAULT_VALUE { MODELPARAM_VALUE.C_DEFAULT_VALUE} {
	set_property value "BlankString"  ${MODELPARAM_VALUE.C_DEFAULT_VALUE} 
}

proc update_MODELPARAM_VALUE.C_AXIS_TSTRB_WIDTH { MODELPARAM_VALUE.C_AXIS_TSTRB_WIDTH PARAM_VALUE.TSTRB_WIDTH} {
	if {[ get_property value ${PARAM_VALUE.TSTRB_WIDTH} ] < 1} {
		set val 1
	} else {
		set val [ get_property value ${PARAM_VALUE.TSTRB_WIDTH} ]
	}
	
	set_property value $val  ${MODELPARAM_VALUE.C_AXIS_TSTRB_WIDTH} 
}

proc update_MODELPARAM_VALUE.C_HAS_AXI_RD_CHANNEL { MODELPARAM_VALUE.C_HAS_AXI_RD_CHANNEL PARAM_VALUE.READ_WRITE_MODE} {
	if {[ get_property value ${PARAM_VALUE.READ_WRITE_MODE} ] != "WRITE_ONLY"} {
		set val 1
	} else {
		set val 0
	}
	set_property value $val  ${MODELPARAM_VALUE.C_HAS_AXI_RD_CHANNEL} 
}

proc update_MODELPARAM_VALUE.C_HAS_MEMINIT_FILE { MODELPARAM_VALUE.C_HAS_MEMINIT_FILE} {
	set_property value 0  ${MODELPARAM_VALUE.C_HAS_MEMINIT_FILE} 
}

proc update_MODELPARAM_VALUE.C_PROG_EMPTY_TYPE { MODELPARAM_VALUE.C_PROG_EMPTY_TYPE PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE} {
	set Programmable_Empty_Type [ get_property value ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE} ]
   switch  $Programmable_Empty_Type  {
      "No_Programmable_Empty_Threshold" { set val 0 }
      "Single_Programmable_Empty_Threshold_Constant" { set val 1 }
      "Multiple_Programmable_Empty_Threshold_Constants" { set val 2 }
      "Single_Programmable_Empty_Threshold_Input_Port" { set val 3 }
      "Multiple_Programmable_Empty_Threshold_Input_Ports" { set val 4 }
   }
	set_property value $val  ${MODELPARAM_VALUE.C_PROG_EMPTY_TYPE} 
}

proc update_MODELPARAM_VALUE.C_HAS_AXI_ID { MODELPARAM_VALUE.C_HAS_AXI_ID PARAM_VALUE.ID_WIDTH} {
	if {[ get_property value ${PARAM_VALUE.ID_WIDTH} ] > 0} {
		set val 1
	} else {
		set val 0
	}

	set_property value $val  ${MODELPARAM_VALUE.C_HAS_AXI_ID} 
}

proc update_MODELPARAM_VALUE.C_HAS_BACKUP { MODELPARAM_VALUE.C_HAS_BACKUP} {
	set_property value 0  ${MODELPARAM_VALUE.C_HAS_BACKUP} 
}

proc update_MODELPARAM_VALUE.C_MEMORY_TYPE { MODELPARAM_VALUE.C_MEMORY_TYPE  PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.ENABLE_ECC  
  PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.INPUT_DEPTH  PARAM_VALUE.INTERFACE_TYPE PROJECT_PARAM.ARCHITECTURE} {
	set_property value [lindex [implementation_common_clock   ${PARAM_VALUE.CLOCK_TYPE_AXI} \
	${PARAM_VALUE.ENABLE_ECC} ${PARAM_VALUE.FIFO_IMPLEMENTATION} ${PARAM_VALUE.INPUT_DEPTH} \
	${PARAM_VALUE.INTERFACE_TYPE} ${PROJECT_PARAM.ARCHITECTURE} ] 1]  ${MODELPARAM_VALUE.C_MEMORY_TYPE} 
}

proc update_MODELPARAM_VALUE.C_HAS_AXIS_TDEST { MODELPARAM_VALUE.C_HAS_AXIS_TDEST PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.TDATA_NUM_BYTES 
PARAM_VALUE.TID_WIDTH PARAM_VALUE.TDEST_WIDTH PARAM_VALUE.TUSER_WIDTH} {
	if {[ get_property value ${PARAM_VALUE.TDEST_WIDTH} ] > 0} {
		set val 1
	} else {
		set val 0
	}
	
	set_property value $val  ${MODELPARAM_VALUE.C_HAS_AXIS_TDEST} 
}

proc update_MODELPARAM_VALUE.C_MSGON_VAL { MODELPARAM_VALUE.C_MSGON_VAL PARAM_VALUE.DISABLE_TIMING_VIOLATIONS  
  PARAM_VALUE.DISABLE_TIMING_VIOLATIONS_AXI PARAM_VALUE.INTERFACE_TYPE} {
 
     set Disable_Timing_Violations [ get_property value ${PARAM_VALUE.DISABLE_TIMING_VIOLATIONS} ]
     set Disable_Timing_Violations_AXI [ get_property value ${PARAM_VALUE.DISABLE_TIMING_VIOLATIONS_AXI} ]
     set INTERFACE_TYPE [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
   if {$INTERFACE_TYPE  == "Native"} {
	   if {$Disable_Timing_Violations} {
	      set val 0
	   } else {
	      set val 1
	   }
   } else {
	   if {$Disable_Timing_Violations_AXI  } {
		    set val 0
	   } else {
		    set val 1
	   }
   }

  set_property value $val  ${MODELPARAM_VALUE.C_MSGON_VAL} 
}

proc update_MODELPARAM_VALUE.C_HAS_SRST { MODELPARAM_VALUE.C_HAS_SRST PARAM_VALUE.RESET_PIN  
  PARAM_VALUE.RESET_TYPE PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.FIFO_IMPLEMENTATION} {

	set Reset_Pin [ get_property value ${PARAM_VALUE.RESET_PIN} ]
	set Reset_Type [ get_property value ${PARAM_VALUE.RESET_TYPE} ]
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set fifo_implementation [get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION}]	
   	
   if {$Reset_Pin} {
	if {$c_family == "virtexu" && ($fifo_implementation == "Common_Clock_Builtin_FIFO" || $fifo_implementation == "Independent_Clocks_Builtin_FIFO") } {
		set val 1
	} else { 
      if {$Reset_Type  == "Asynchronous_Reset"} {
        set val 0
      } else {
         set val 1
      }
	}
   } else {
	  set val 0
   }
	
  set_property value $val  ${MODELPARAM_VALUE.C_HAS_SRST} 

}

proc update_MODELPARAM_VALUE.C_UNDERFLOW_LOW { MODELPARAM_VALUE.C_UNDERFLOW_LOW PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.UNDERFLOW_SENSE PARAM_VALUE.UNDERFLOW_SENSE_AXI} {
 
     set Underflow_Sense [ get_property value ${PARAM_VALUE.UNDERFLOW_SENSE} ]
     set Underflow_Sense_AXI [ get_property value ${PARAM_VALUE.UNDERFLOW_SENSE_AXI} ]
     set INTERFACE_TYPE [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
   if {$INTERFACE_TYPE  == "Native"} {
	   if {$Underflow_Sense =="Active_Low"} {
	      set val 1
	   } else {
	      set val 0
	   }
   } else {
	   if {$Underflow_Sense_AXI == "Active_Low" } {
		    set val 1
	   } else {
		    set val 0
	   }
   }

  set_property value $val  ${MODELPARAM_VALUE.C_UNDERFLOW_LOW} 
}

proc update_MODELPARAM_VALUE.C_IMPLEMENTATION_TYPE { MODELPARAM_VALUE.C_IMPLEMENTATION_TYPE  PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.ENABLE_ECC  
  PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.INTERFACE_TYPE PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.enable_low_latency PARAM_VALUE.use_dout_register} {
	set fifo_imp [string tolower [get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION}] ]
	set intface_type [string  tolower [get_property value ${PARAM_VALUE.INTERFACE_TYPE}] ]

	if { $intface_type == "native" && (($fifo_imp == "common_clock_builtin_fifo" ) || ($fifo_imp == "independent_clocks_builtin_fifo")) && [get_property value ${PARAM_VALUE.enable_low_latency}]} {
		if {![get_property value ${PARAM_VALUE.use_dout_register}] } {
			set_property value 8 ${MODELPARAM_VALUE.C_IMPLEMENTATION_TYPE} 
		} else {
			set_property value 9 ${MODELPARAM_VALUE.C_IMPLEMENTATION_TYPE} 
		}
	} else {
 
     
	set_property value [lindex [implementation_common_clock   ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.ENABLE_ECC} ${PARAM_VALUE.FIFO_IMPLEMENTATION} ${PARAM_VALUE.INPUT_DEPTH} ${PARAM_VALUE.INTERFACE_TYPE} ${PROJECT_PARAM.ARCHITECTURE}] 2]  ${MODELPARAM_VALUE.C_IMPLEMENTATION_TYPE} 
}
}
proc update_MODELPARAM_VALUE.C_HAS_PROG_FLAGS_WRCH { MODELPARAM_VALUE.C_HAS_PROG_FLAGS_WRCH} {
	set_property value 0  ${MODELPARAM_VALUE.C_HAS_PROG_FLAGS_WRCH} 
}

proc update_MODELPARAM_VALUE.C_HAS_PROG_FLAGS_AXIS { MODELPARAM_VALUE.C_HAS_PROG_FLAGS_AXIS} {
	set_property value 0  ${MODELPARAM_VALUE.C_HAS_PROG_FLAGS_AXIS} 
}

proc update_MODELPARAM_VALUE.C_AXIS_TID_WIDTH { MODELPARAM_VALUE.C_AXIS_TID_WIDTH PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.TDATA_NUM_BYTES 
PARAM_VALUE.TID_WIDTH PARAM_VALUE.TDEST_WIDTH PARAM_VALUE.TUSER_WIDTH} {
	if {[ get_property value ${PARAM_VALUE.TID_WIDTH} ] < 1} {
		set val 1
	} else {
		set val [ get_property value ${PARAM_VALUE.TID_WIDTH} ]
	}
	set_property value $val  ${MODELPARAM_VALUE.C_AXIS_TID_WIDTH} 
}

proc update_MODELPARAM_VALUE.C_AXI_ID_WIDTH { MODELPARAM_VALUE.C_AXI_ID_WIDTH PARAM_VALUE.ID_WIDTH} {
	if {[ get_property value ${PARAM_VALUE.ID_WIDTH} ] > 1} {
		set val [ get_property value ${PARAM_VALUE.ID_WIDTH} ]
	} else {
		set val 1
	}
	set_property value $val  ${MODELPARAM_VALUE.C_AXI_ID_WIDTH} 
}

proc update_MODELPARAM_VALUE.C_AXI_LEN_WIDTH { MODELPARAM_VALUE.C_AXI_LEN_WIDTH PARAM_VALUE.PROTOCOL} {

	if {[ get_property value ${PARAM_VALUE.PROTOCOL} ] == "AXI4"} {
		set val 8
	} else {
		set val 4
	}
	
	set_property value $val  ${MODELPARAM_VALUE.C_AXI_LEN_WIDTH} 
}

proc update_MODELPARAM_VALUE.C_AXIS_TDEST_WIDTH { MODELPARAM_VALUE.C_AXIS_TDEST_WIDTH PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.TDATA_NUM_BYTES 
PARAM_VALUE.TID_WIDTH PARAM_VALUE.TDEST_WIDTH PARAM_VALUE.TUSER_WIDTH} {
	if {[ get_property value ${PARAM_VALUE.TDEST_WIDTH} ] < 1} {
		set val 1
	} else {
		set val [ get_property value ${PARAM_VALUE.TDEST_WIDTH} ]
	}
	set_property value $val  ${MODELPARAM_VALUE.C_AXIS_TDEST_WIDTH} 
}

proc update_MODELPARAM_VALUE.C_HAS_UNDERFLOW { MODELPARAM_VALUE.C_HAS_UNDERFLOW PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.UNDERFLOW_FLAG PARAM_VALUE.UNDERFLOW_FLAG_AXI} {
 
     set Underflow_Flag [ get_property value ${PARAM_VALUE.UNDERFLOW_FLAG} ]
     set Underflow_Flag_AXI [ get_property value ${PARAM_VALUE.UNDERFLOW_FLAG_AXI} ]
     set INTERFACE_TYPE [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
   if {$INTERFACE_TYPE  == "Native"} {
	   if {$Underflow_Flag} {
	      set val 1
	   } else {
	      set val 0
	   }
   } else {
	   if {$Underflow_Flag_AXI  } {
		    set val 1
	   } else {
		    set val 0
	   }
   }

  set_property value $val  ${MODELPARAM_VALUE.C_HAS_UNDERFLOW} 

}

proc update_MODELPARAM_VALUE.C_ENABLE_RLOCS { MODELPARAM_VALUE.C_ENABLE_RLOCS} {
	set_property value 0  ${MODELPARAM_VALUE.C_ENABLE_RLOCS} 
}

proc update_MODELPARAM_VALUE.C_INIT_WR_PNTR_VAL { MODELPARAM_VALUE.C_INIT_WR_PNTR_VAL} {
	set_property value 0  ${MODELPARAM_VALUE.C_INIT_WR_PNTR_VAL} 
}

proc update_MODELPARAM_VALUE.C_MIF_FILE_NAME { MODELPARAM_VALUE.C_MIF_FILE_NAME} {
	set_property value "BlankString"  ${MODELPARAM_VALUE.C_MIF_FILE_NAME} 
}

proc update_MODELPARAM_VALUE.C_USE_FIFO16_FLAGS { MODELPARAM_VALUE.C_USE_FIFO16_FLAGS} {
	set_property value 0  ${MODELPARAM_VALUE.C_USE_FIFO16_FLAGS} 
}

proc update_MODELPARAM_VALUE.C_COMMON_CLOCK { MODELPARAM_VALUE.C_COMMON_CLOCK  PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.ENABLE_ECC  
  PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.INTERFACE_TYPE PROJECT_PARAM.ARCHITECTURE} {
	set_property value [lindex [implementation_common_clock ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.ENABLE_ECC} ${PARAM_VALUE.FIFO_IMPLEMENTATION} ${PARAM_VALUE.INPUT_DEPTH} ${PARAM_VALUE.INTERFACE_TYPE} ${PROJECT_PARAM.ARCHITECTURE}] 0]  ${MODELPARAM_VALUE.C_COMMON_CLOCK} 
}

proc update_MODELPARAM_VALUE.C_WR_ACK_LOW { MODELPARAM_VALUE.C_WR_ACK_LOW PARAM_VALUE.WRITE_ACKNOWLEDGE_SENSE} {
	set_property value [expr {([ get_property value ${PARAM_VALUE.WRITE_ACKNOWLEDGE_SENSE} ]=="Active_Low")?1:0}]  ${MODELPARAM_VALUE.C_WR_ACK_LOW}   
}

proc update_MODELPARAM_VALUE.C_RD_PNTR_WIDTH { MODELPARAM_VALUE.C_RD_PNTR_WIDTH PARAM_VALUE.OUTPUT_DEPTH} {

	set log2xcoValue [expr { int( ceil( log( [ get_property value ${PARAM_VALUE.OUTPUT_DEPTH} ] )/log(2) ) ) }]
	set_property value $log2xcoValue  ${MODELPARAM_VALUE.C_RD_PNTR_WIDTH} 

}

proc update_MODELPARAM_VALUE.C_HAS_RD_RST { MODELPARAM_VALUE.C_HAS_RD_RST} {

	set_property value 0  ${MODELPARAM_VALUE.C_HAS_RD_RST} 

}

proc update_MODELPARAM_VALUE.C_HAS_AXIS_TUSER { MODELPARAM_VALUE.C_HAS_AXIS_TUSER PARAM_VALUE.ENABLE_TLAST 
PARAM_VALUE.TDATA_NUM_BYTES PARAM_VALUE.TID_WIDTH PARAM_VALUE.TDEST_WIDTH PARAM_VALUE.TUSER_WIDTH} {

	if {[ get_property value ${PARAM_VALUE.TUSER_WIDTH} ] > 0} {
		set val 1
	} else {
		set val 0
	}
	
	set_property value $val  ${MODELPARAM_VALUE.C_HAS_AXIS_TUSER} 

}

proc update_MODELPARAM_VALUE.C_PRIM_FIFO_TYPE_AXIS { MODELPARAM_VALUE.C_PRIM_FIFO_TYPE_AXIS PARAM_VALUE.ENABLE_ECC_AXIS 
  PARAM_VALUE.INPUT_DEPTH_AXIS PROJECT_PARAM.ARCHITECTURE} {

   set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
   set Input_Depth_axis [ get_property value ${PARAM_VALUE.INPUT_DEPTH_AXIS} ]
   set Enable_ECC_axis [ get_property value ${PARAM_VALUE.ENABLE_ECC_AXIS} ]
   set Input_Width_axis [get_metaparam_value Calculated_Width_axis]
		set prim_fifo_type [fifo_generator_v12_0_utils::get_Prim_Fifo_Type $c_family $Input_Width_axis $Input_Width_axis $Input_Depth_axis  $Enable_ECC_axis  ]
		set_property value $prim_fifo_type  ${MODELPARAM_VALUE.C_PRIM_FIFO_TYPE_AXIS} 

}

proc update_MODELPARAM_VALUE.C_PRIM_FIFO_TYPE_WACH { MODELPARAM_VALUE.C_PRIM_FIFO_TYPE_WACH PARAM_VALUE.ENABLE_ECC_WACH 
  PARAM_VALUE.INPUT_DEPTH_WACH PROJECT_PARAM.ARCHITECTURE} {

   set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
   set Input_Depth_wach [ get_property value ${PARAM_VALUE.INPUT_DEPTH_WACH} ]
   set Enable_ECC_wach [ get_property value ${PARAM_VALUE.ENABLE_ECC_WACH} ]
   set Input_Width_wach [get_metaparam_value Calculated_Width_wach]
		set prim_fifo_type [fifo_generator_v12_0_utils::get_Prim_Fifo_Type $c_family $Input_Width_wach $Input_Width_wach $Input_Depth_wach  $Enable_ECC_wach  ]
		set_property value $prim_fifo_type  ${MODELPARAM_VALUE.C_PRIM_FIFO_TYPE_WACH} 

}

proc update_MODELPARAM_VALUE.C_PRIM_FIFO_TYPE_WDCH { MODELPARAM_VALUE.C_PRIM_FIFO_TYPE_WDCH PARAM_VALUE.ENABLE_ECC_WDCH 
  PARAM_VALUE.INPUT_DEPTH_WDCH PROJECT_PARAM.ARCHITECTURE} {

   set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
   set Input_Depth_wdch [ get_property value ${PARAM_VALUE.INPUT_DEPTH_WDCH} ]
   set Enable_ECC_wdch [ get_property value ${PARAM_VALUE.ENABLE_ECC_WDCH} ]
   set Input_Width_wdch [get_metaparam_value Calculated_Width_wdch]
		set prim_fifo_type [fifo_generator_v12_0_utils::get_Prim_Fifo_Type $c_family $Input_Width_wdch $Input_Width_wdch $Input_Depth_wdch  $Enable_ECC_wdch  ]
		set_property value $prim_fifo_type  ${MODELPARAM_VALUE.C_PRIM_FIFO_TYPE_WDCH} 

}

proc update_MODELPARAM_VALUE.C_PRIM_FIFO_TYPE_WRCH { MODELPARAM_VALUE.C_PRIM_FIFO_TYPE_WRCH PARAM_VALUE.ENABLE_ECC_WRCH 
  PARAM_VALUE.INPUT_DEPTH_WRCH PROJECT_PARAM.ARCHITECTURE} {

   set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
   set Input_Depth_wrch [ get_property value ${PARAM_VALUE.INPUT_DEPTH_WRCH} ]
   set Enable_ECC_wrch [ get_property value ${PARAM_VALUE.ENABLE_ECC_WRCH} ]
   set Input_Width_wrch [get_metaparam_value Calculated_Width_wrch]
		set prim_fifo_type [fifo_generator_v12_0_utils::get_Prim_Fifo_Type $c_family $Input_Width_wrch $Input_Width_wrch $Input_Depth_wrch  $Enable_ECC_wrch  ]
		set_property value $prim_fifo_type  ${MODELPARAM_VALUE.C_PRIM_FIFO_TYPE_WRCH} 

}

proc update_MODELPARAM_VALUE.C_PRIM_FIFO_TYPE_RACH { MODELPARAM_VALUE.C_PRIM_FIFO_TYPE_RACH PARAM_VALUE.ENABLE_ECC_RACH 
  PARAM_VALUE.INPUT_DEPTH_RACH PROJECT_PARAM.ARCHITECTURE} {

   set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
   set Input_Depth_rach [ get_property value ${PARAM_VALUE.INPUT_DEPTH_RACH} ]
   set Enable_ECC_rach [ get_property value ${PARAM_VALUE.ENABLE_ECC_RACH} ]
   set Input_Width_rach [get_metaparam_value Calculated_Width_rach]
		set prim_fifo_type [fifo_generator_v12_0_utils::get_Prim_Fifo_Type $c_family $Input_Width_rach $Input_Width_rach $Input_Depth_rach  $Enable_ECC_rach  ]
		set_property value $prim_fifo_type  ${MODELPARAM_VALUE.C_PRIM_FIFO_TYPE_RACH} 

}

proc update_MODELPARAM_VALUE.C_PRIM_FIFO_TYPE_RDCH { MODELPARAM_VALUE.C_PRIM_FIFO_TYPE_RDCH PARAM_VALUE.ENABLE_ECC_RDCH 
  PARAM_VALUE.INPUT_DEPTH_RDCH PROJECT_PARAM.ARCHITECTURE} {

   set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
   set Input_Depth_rdch [ get_property value ${PARAM_VALUE.INPUT_DEPTH_RDCH} ]
   set Enable_ECC_rdch [ get_property value ${PARAM_VALUE.ENABLE_ECC_RDCH} ]
   set Input_Width_rdch [get_metaparam_value Calculated_Width_rdch]
		set prim_fifo_type [fifo_generator_v12_0_utils::get_Prim_Fifo_Type $c_family $Input_Width_rdch $Input_Width_rdch $Input_Depth_rdch  $Enable_ECC_rdch  ]
		set_property value $prim_fifo_type  ${MODELPARAM_VALUE.C_PRIM_FIFO_TYPE_RDCH} 

}

proc update_MODELPARAM_VALUE.C_DIN_WIDTH_WACH { MODELPARAM_VALUE.C_DIN_WIDTH_WACH PARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.AWUSER_WIDTH  
  PARAM_VALUE.ID_WIDTH PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.PROTOCOL} {
	set val [get_metaparam_value Calculated_Width_wach]
	set_property value $val [set MODELPARAM_VALUE.C_DIN_WIDTH_WACH]
}

proc update_MODELPARAM_VALUE.C_DIN_WIDTH_WRCH { MODELPARAM_VALUE.C_DIN_WIDTH_WRCH PARAM_VALUE.BUSER_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL} {
	set val [get_metaparam_value Calculated_Width_wrch]
	set_property value $val [set MODELPARAM_VALUE.C_DIN_WIDTH_WRCH]
}

proc update_MODELPARAM_VALUE.C_DIN_WIDTH_RDCH { MODELPARAM_VALUE.C_DIN_WIDTH_RDCH PARAM_VALUE.DATA_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PARAM_VALUE.RUSER_WIDTH} {
	set val [get_metaparam_value Calculated_Width_rdch]
	set_property value $val [set MODELPARAM_VALUE.C_DIN_WIDTH_RDCH]
}

proc update_MODELPARAM_VALUE.C_DIN_WIDTH_AXIS { MODELPARAM_VALUE.C_DIN_WIDTH_AXIS PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.HAS_TKEEP  
  PARAM_VALUE.HAS_TSTRB PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.TDATA_NUM_BYTES PARAM_VALUE.TDEST_WIDTH  
  PARAM_VALUE.TID_WIDTH PARAM_VALUE.TKEEP_WIDTH  
  PARAM_VALUE.TSTRB_WIDTH PARAM_VALUE.TUSER_WIDTH} {
	set val [get_metaparam_value Calculated_Width_axis]
	set_property value $val [set MODELPARAM_VALUE.C_DIN_WIDTH_AXIS]
}

proc update_MODELPARAM_VALUE.C_DIN_WIDTH_RACH { MODELPARAM_VALUE.C_DIN_WIDTH_RACH  PARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.ARUSER_WIDTH  
  PARAM_VALUE.ID_WIDTH PARAM_VALUE.INTERFACE_TYPE  PARAM_VALUE.PROTOCOL} {
	set val [get_metaparam_value Calculated_Width_rach]
	set_property value $val [set MODELPARAM_VALUE.C_DIN_WIDTH_RACH]
}

proc update_MODELPARAM_VALUE.C_DIN_WIDTH_WDCH { MODELPARAM_VALUE.C_DIN_WIDTH_WDCH PARAM_VALUE.DATA_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PARAM_VALUE.WUSER_WIDTH} {
	set val [get_metaparam_value Calculated_Width_wdch]
	set_property value $val [set MODELPARAM_VALUE.C_DIN_WIDTH_WDCH]
}

;# Dynamic Text procedures and Other Common Procedures
proc getSimulationModel {} {
	### set simulation_model [$IpModel GetProperty "SIMULATIONFILES"]
	return "Behavioral"
}

proc isInputDepthValid {Input_Data_Width Input_Depth} {
	if {$Input_Data_Width >= 1 && $Input_Data_Width <= 128 && $Input_Depth > [expr "128*1024"] } {
		return false
	} elseif {$Input_Data_Width >= 129 && $Input_Data_Width <= 256 && $Input_Depth > [expr "64*1024"] } {
		return false
	} elseif {$Input_Data_Width >= 257 && $Input_Data_Width <= 512 && $Input_Depth > [expr "32*1024"] } {
		return false
	} elseif {$Input_Data_Width >= 513 && $Input_Data_Width <= 1024 && $Input_Depth > [expr "16*1024"] } {
		return false
	} elseif {$Input_Data_Width >= 1025 && $Input_Data_Width <= 2048 && $Input_Depth > [expr "8*1024"] } {
		return false
	} elseif {$Input_Data_Width > 2048 && $Input_Depth > [expr "4*1024"] } {
		return false
	}
	return true
}

proc implementation_common_clock { CLOCK_TYPE_AXI ENABLE_ECC  
  FIFO_IMPLEMENTATION INPUT_DEPTH  
  INTERFACE_TYPE PROJECT_PARAM.ARCHITECTURE } {

   set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
   set Input_Depth [ get_property value ${INPUT_DEPTH} ]
   set Enable_ECC [ get_property value ${ENABLE_ECC} ]
   set Clock_Type_AXI [ get_property value ${CLOCK_TYPE_AXI} ]
   set Fifo_Implementation [ get_property value ${FIFO_IMPLEMENTATION} ]

   if {[ get_property value ${INTERFACE_TYPE} ]== "Native"} {	   
	   if {$Fifo_Implementation == "Common_Clock_Block_RAM"} {
	      set c_implementation_type 0
	      set c_common_clock 1
	      set c_memory_type 1
	   } elseif {$Fifo_Implementation == "Common_Clock_Distributed_RAM"} {
	      set c_implementation_type 0
	      set c_common_clock 1
	      set c_memory_type 2
	   } elseif {$Fifo_Implementation == "Common_Clock_Shift_Register"} {
	      set c_implementation_type 1
	      set c_common_clock 1
	      set c_memory_type 3
	   } elseif {$Fifo_Implementation == "Common_Clock_Builtin_FIFO"} {
	      if { [string equal -nocase $c_family "virtexu"] || [string equal -nocase $c_family "virtex7"] || [string equal -nocase $c_family "kintex7"] || [string equal -nocase $c_family "artix7"] || [string equal -nocase $c_family "zynq"] } {
				set c_implementation_type 6
				set c_common_clock 1
				set c_memory_type 4
		        } else {
	        set  c_implementation_type 7
	        set  c_common_clock 1
	        set  c_memory_type 4
	      }
	   } elseif {$Fifo_Implementation == "Independent_Clocks_Block_RAM"} {
	     set  c_implementation_type 2
	      set c_common_clock 0
	      set c_memory_type 1
	   } elseif {$Fifo_Implementation == "Independent_Clocks_Distributed_RAM"} {
	     set  c_implementation_type 2
	     set  c_common_clock 0
	      set c_memory_type 2
	   } elseif {$Fifo_Implementation == "Independent_Clocks_Builtin_FIFO"} {
	      if { [string equal -nocase $c_family "virtexu"] || [string equal -nocase $c_family "virtex7"] || [string equal -nocase $c_family "kintex7"] || [string equal -nocase $c_family "artix7"] || [string equal -nocase $c_family "zynq"] } {
			set c_implementation_type 6
			set c_common_clock 0
			set c_memory_type 4
	      } else {
	         set c_implementation_type 7
	         set c_common_clock 0
	        set c_memory_type 4
	      }
	   }
   } else {
	    if { $Clock_Type_AXI  ==  "Common_Clock" } {
		    set c_common_clock 1
	    } elseif { $Clock_Type_AXI  ==  "Independent_Clock" } {
		   set  c_common_clock 0
	    }
		set c_memory_type 1 
		set c_implementation_type 0 
   }
   return "$c_common_clock $c_memory_type $c_implementation_type"

}

proc updateOfLabelFifotext9 { PARAM_VALUE.FIFO_IMPLEMENTATION} {

	if {[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Common_Clock_Block_RAM" } {
		return "<b>Common Clock (CLK)"
	} else {
		return "Common Clock (CLK)"
	}

}

proc LabelRead_Clock_FrequencyDescription_updated {} {

	return "The frequency relationship of WR_CLK and RD_CLK MUST be specified to generate the correct implementation."

}

proc BlockRAM_Blocks_Used_9_updated { PARAM_VALUE.FIFO_IMPLEMENTATION} {
	set fifo_implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	### To Be Verified Again -- It requires loading of an external library ### 
	if {$fifo_implementation == "Common_Clock_Block_RAM"  || $fifo_implementation == "Independent_Clocks_Block_RAM"} {
      # ;#show 9k if needed
      if {$fifo_implementation == "Common_Clock_Block_RAM"} { 
	      set is_common_clk 1
      } else {
	      set is_common_clk 0
      }
	}
}

proc BlockRAM_Blocks_Used_36_updated { PARAM_VALUE.ENABLE_ECC PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.INPUT_DATA_WIDTH PARAM_VALUE.INPUT_DEPTH  
  PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DEPTH IPINST PROJECT_PARAM.ARCHITECTURE} {

	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	### To Be Verified Again -- It requires loading of an external library ### 
	set fifo_implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	if {$fifo_implementation == "Common_Clock_Block_RAM"  || $fifo_implementation == "Independent_Clocks_Block_RAM"} {
        if {$fifo_implementation == "Common_Clock_Block_RAM"} { 
			set is_common_clk 1
		} else {
			set is_common_clk 0
		}
      
		if {$c_family == "virtex7" || $c_family == "kintex7" || $c_family == "artix7" || $c_family == "zynq" || $c_family == "virtexu"} {
			set ID [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ]
			set Input_Data_Width [ get_property value ${PARAM_VALUE.INPUT_DATA_WIDTH} ]
			
			if {![isInputDepthValid $Input_Data_Width $ID]} {
				return ""
			}
         set blockram36s [fifo_generator_v12_0_utils::get_Estimated_BlockRAM_Usage_x $c_family $is_common_clk [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ]   [ get_property value ${PARAM_VALUE.OUTPUT_DATA_WIDTH} ] [ get_property value ${PARAM_VALUE.OUTPUT_DEPTH} ]   [ get_property value ${PARAM_VALUE.ENABLE_ECC} ] 36]
			return "Block RAM resource(s) (36K BRAMs): $blockram36s"
		}
	}

}

proc AlmostFullAlmostEmptyFlagDescription_updated { PARAM_VALUE.ALMOST_EMPTY_FLAG PARAM_VALUE.ALMOST_FULL_FLAG} {

# Take the Concat of "LabelAlmost_Full_FlagDescription" and "LabelAlmost_Empty_FlagDescription"
	if {[ get_property value ${PARAM_VALUE.ALMOST_FULL_FLAG} ]} {
		set LabelAlmost_Full_FlagDescription "Selected"
	} else {
		set LabelAlmost_Full_FlagDescription "Not Selected" 
	}
   
   if {[ get_property value ${PARAM_VALUE.ALMOST_EMPTY_FLAG} ]} {
      set LabelAlmost_Empty_FlagDescription "Selected" 
   } else {
      set LabelAlmost_Empty_FlagDescription "Not Selected" 
   }
   return "$LabelAlmost_Full_FlagDescription/$LabelAlmost_Empty_FlagDescription"

}

proc Calculated_ARUSER_Width_updated {IPINST} {
	return "Calculated Width: [get_metaparam_value Calculated_Width_rach]"

}

proc LabelAXI_Interface_Info_updated { PARAM_VALUE.PROTOCOL} {

	if {[ get_property value ${PARAM_VALUE.PROTOCOL} ] == "AXI4" } {			
		return "AXI4"
	} elseif {[ get_property value ${PARAM_VALUE.PROTOCOL} ] == "AXI3" } {
		return "AXI3"
	} else {
		return "AXI4 Lite"
	}

}

proc TDATA_NUM_BYTES_Range_updated { PARAM_VALUE.TDATA_NUM_BYTES} {

	set x [split [get_property range  ${PARAM_VALUE.TDATA_NUM_BYTES} ] ,]
	
	return "\[[tcl::lindex $x 0],[tcl::lindex $x 1],[tcl::lindex $x 2]...[tcl::lindex $x end]\]"

}

proc LabelInput_DepthDescription_updated {PARAM_VALUE.ENABLE_ECC PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.OUTPUT_DEPTH  
  PARAM_VALUE.PERFORMANCE_OPTIONS PARAM_VALUE.READ_CLOCK_FREQUENCY  
  PARAM_VALUE.WRITE_CLOCK_FREQUENCY IPINST PARAM_VALUE.INPUT_DATA_WIDTH PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.OUTPUT_DATA_WIDTH} {

	return "Write Depth : [Actual_Write_Depth_updated   ${PARAM_VALUE.ENABLE_ECC} ${PARAM_VALUE.FIFO_IMPLEMENTATION} ${PARAM_VALUE.INPUT_DEPTH} ${PARAM_VALUE.OUTPUT_DEPTH} ${PARAM_VALUE.PERFORMANCE_OPTIONS} ${PARAM_VALUE.READ_CLOCK_FREQUENCY} ${PARAM_VALUE.WRITE_CLOCK_FREQUENCY} $IPINST ${PARAM_VALUE.INPUT_DATA_WIDTH} ${PROJECT_PARAM.ARCHITECTURE} ${PARAM_VALUE.OUTPUT_DATA_WIDTH}]"

}

proc updateOfLabelFifotext14a { PARAM_VALUE.FIFO_IMPLEMENTATION} {

	if {[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Independent_Clocks_Builtin_FIFO" } {
		return "<b>Built-in FIFO"
	} else {
		return "Built-in FIFO"
	}

}

proc NNFifo_Implementation_Warng_summrpg_updated { PARAM_VALUE.CLOCK_TYPE_AXI} {

	if {[ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {		
	  return ""
	} else {
	  return "<b>WARNING : </b>Behavioral models do not model synchronization delays. Use post-par simulation models for accurate behavior"	
	}

}

proc Calculated_AXIS_Width_updated {IPINST} {
	return "Calculated Width: [get_metaparam_value Calculated_Width_axis]"
}

proc table_summary_10_updated {PARAM_VALUE.FIFO_IMPLEMENTATION} {

	set text [split [Fifo_Implementation_Info_2_updated ${PARAM_VALUE.FIFO_IMPLEMENTATION}] :]
	return [lindex $text 0]

}

proc table_summary_11_updated {PARAM_VALUE.FIFO_IMPLEMENTATION} {

	set text [split [Fifo_Implementation_Info_2_updated ${PARAM_VALUE.FIFO_IMPLEMENTATION}] :]
	return [lindex $text 1]

}

proc Number_of_FIFO_chained_in_depth_Value_updated { PARAM_VALUE.ENABLE_ECC PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.INPUT_DEPTH IPINST PARAM_VALUE.INPUT_DATA_WIDTH PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.OUTPUT_DATA_WIDTH} {

	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
        set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	if {$Fifo_Implementation == "Common_Clock_Builtin_FIFO"
       || $Fifo_Implementation == "Independent_Clocks_Builtin_FIFO" } {
      
     return "Number of FIFO chained in depth : [fifo_generator_v12_0_utils::get_Estimated_FIFO_InDepth $c_family [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] [Get_Output_Data_Width ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ]  [ get_property value ${PARAM_VALUE.ENABLE_ECC} ] ]"
	}

}

proc Calculated_BUSER_Width_updated {IPINST} {
	return "Calculated Width: [get_metaparam_value Calculated_Width_wrch]"
}

proc Clock_Type_Info_AXI_updated { PARAM_VALUE.CLOCK_TYPE_AXI} {
	if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {
		return "Common Clock"
	} else {
	    return "Independent Clock"
	}
}

proc Latency2_updated {PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.PERFORMANCE_OPTIONS  
  PARAM_VALUE.USE_EMBEDDED_REGISTERS PROJECT_PARAM.ARCHITECTURE} {
	return "Read Latency : [Latency_updated   ${PARAM_VALUE.FIFO_IMPLEMENTATION} ${PARAM_VALUE.PERFORMANCE_OPTIONS} ${PARAM_VALUE.USE_EMBEDDED_REGISTERS} ${PROJECT_PARAM.ARCHITECTURE}]"
}

proc Fifo_Implementation_Info_1_updated { PARAM_VALUE.FIFO_IMPLEMENTATION} {
	set FII_Prefix_1 "Clocking Scheme:  "
	set FII_Prefix_2 "Memory Type:  "

   set fifo_implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
   switch  $fifo_implementation {
      "Common_Clock_Block_RAM" {
         return "${FII_Prefix_1}Common Clock"
      }
      "Common_Clock_Distributed_RAM" {
         return "${FII_Prefix_1}Common Clock"
      }
      "Common_Clock_Shift_Register" {
         return "${FII_Prefix_1}Common Clock"
      }
      "Common_Clock_Builtin_FIFO" {
         return "${FII_Prefix_1}Common Clock"
      }
      "Independent_Clocks_Block_RAM" {
         return "${FII_Prefix_1}Independent Clocks"
      }
      "Independent_Clocks_Distributed_RAM" {
         return "${FII_Prefix_1}Independent Clocks"
      }
      "Independent_Clocks_Builtin_FIFO" {
         return "${FII_Prefix_1}Independent Clocks"
      }
   } ;# end switch
}

proc Fifo_Implementation_Info_2_updated { PARAM_VALUE.FIFO_IMPLEMENTATION} {

	set FII_Prefix_1 "Clocking Scheme:  "
	set FII_Prefix_2 "Memory Type:  "

   set fifo_implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
   switch  $fifo_implementation {
      "Common_Clock_Block_RAM" {
         return "${FII_Prefix_2}Block RAM"
      }
      "Common_Clock_Distributed_RAM" {
         return "${FII_Prefix_2}Distributed RAM"
      }
      "Common_Clock_Shift_Register" {
         return "${FII_Prefix_2}Shift Register"
      }
      "Common_Clock_Builtin_FIFO" {
         return "${FII_Prefix_2}Built-in FIFO"
      }
      "Independent_Clocks_Block_RAM" {
         return "${FII_Prefix_2}Block RAM"
      }
      "Independent_Clocks_Distributed_RAM" {
         return "${FII_Prefix_2}Distributed RAM"
      }
      "Independent_Clocks_Builtin_FIFO" {
         return "${FII_Prefix_2}Built-in FIFO"
      }
   } ;# end switch

}

proc LabelDATA_WIDTHRange_updated { PARAM_VALUE.DATA_WIDTH PARAM_VALUE.PROTOCOL} {

	set listval [split [get_property range  ${PARAM_VALUE.DATA_WIDTH} ] ","]
	if {[ get_property value ${PARAM_VALUE.PROTOCOL} ] == "AXI4_Lite"} {
		return "Range: 32,64"
	} else {
		return "Range:  [lindex $listval 0],[lindex $listval 1]..[lindex $listval [expr {[llength $listval] - 1}]]"
	}

}

proc table_summary_20_updated {} {

	return "Model Generated"

}

proc Fifo_Implementation_Warng_1_updated { PARAM_VALUE.FIFO_IMPLEMENTATION IPINST} {

	set fifo_implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	set Fifo_Implementation_Warng_1 [ipgui::get_textspec Fifo_Implementation_Warng_1 -of $IPINST] 
	set_property visible true $Fifo_Implementation_Warng_1
	if {$fifo_implementation == "Independent_Clocks_Builtin_FIFO" || $fifo_implementation == "Common_Clock_Builtin_FIFO" || $fifo_implementation == "Independent_Clocks_Distributed_RAM" || $fifo_implementation == "Independent_Clocks_Block_RAM"} {
		return "<b>WARNING : </b>Behavioral models do not model synchronization delays. Use post-par simulation models for accurate behaviour"	
	} else {
		set_property visible false $Fifo_Implementation_Warng_1
		return ""	
	}

}

proc NNFifo_Implementation_Warng_axis_updated { PARAM_VALUE.CLOCK_TYPE_AXI} {

	if {[ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {		
	  return ""
	} else {
	  return "<b>WARNING : </b>Behavioral models do not model synchronization delays. Use post-par simulation models for accurate behavior"	
	}

}

proc Calculated_AWUSER_Width_updated {IPINST} {
	return "Calculated Width: [get_metaparam_value Calculated_Width_wach]"
}

proc table_summary_21_updated { PARAM_VALUE.FIFO_IMPLEMENTATION} {

	set model_chosen  "None"
	set simulation_model [getSimulationModel]
	set fifo_implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	 
   if { $simulation_model eq "Structural" } {

      if { $fifo_implementation eq "Common_Clock_Block_RAM" 
        || $fifo_implementation eq "Common_Clock_Distributed_RAM" 
        || $fifo_implementation eq "Common_Clock_Shift_Register"
        || $fifo_implementation eq "Common_Clock_Builtin_FIFO"
        || $fifo_implementation eq "Independent_Clocks_Builtin_FIFO"
        || $fifo_implementation eq "Independent_Clocks_Block_RAM"
        || $fifo_implementation eq "Independent_Clocks_Distributed_RAM" } {
         set model_chosen  "Unisim Structural Model"
      } 
      
   } else {

      if { $fifo_implementation eq "Common_Clock_Block_RAM" 
        || $fifo_implementation eq "Common_Clock_Distributed_RAM" 
        || $fifo_implementation eq "Common_Clock_Shift_Register" } {
         set model_chosen  "Behavioral Model"
      } 

      if { $fifo_implementation eq "Common_Clock_Builtin_FIFO" 
        || $fifo_implementation eq "Independent_Clocks_Builtin_FIFO"  } {
         set model_chosen  "Behavioral Model"
      }

      if { $fifo_implementation eq "Independent_Clocks_Block_RAM" 
        || $fifo_implementation eq "Independent_Clocks_Distributed_RAM" } {
         set model_chosen  "Behavioral Model"
      }

   }

   return $model_chosen

}

proc Actual_Read_Depth_updated { PARAM_VALUE.ENABLE_ECC PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.OUTPUT_DATA_WIDTH  
  PARAM_VALUE.OUTPUT_DEPTH PARAM_VALUE.PERFORMANCE_OPTIONS  
  PARAM_VALUE.READ_CLOCK_FREQUENCY PARAM_VALUE.WRITE_CLOCK_FREQUENCY IPINST PARAM_VALUE.INPUT_DATA_WIDTH PROJECT_PARAM.ARCHITECTURE } {

	 set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	 set Read_Faster [ expr [ get_property value ${PARAM_VALUE.READ_CLOCK_FREQUENCY} ] > [ get_property value ${PARAM_VALUE.WRITE_CLOCK_FREQUENCY} ] ]
	 set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	 set Performance_Options [ get_property value ${PARAM_VALUE.PERFORMANCE_OPTIONS} ]
	 set Input_Depth [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ]
	 set Output_Data_Width [ get_property value ${PARAM_VALUE.OUTPUT_DATA_WIDTH} ]
	 set Output_Depth [ get_property value ${PARAM_VALUE.OUTPUT_DEPTH} ]
	 set Enable_ECC [ get_property value ${PARAM_VALUE.ENABLE_ECC} ]
	 set Input_Data_width [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}]
	 # set asymport [get_property value ${PARAM_VALUE.asymmetric_port_width}]

	set c_fifo_Output_depth [fifo_generator_v12_0_utils::get_Actual_Output_Fifo_Depth $c_family $Fifo_Implementation $Performance_Options $Read_Faster $Input_Data_width $Input_Depth $Output_Data_Width $Output_Depth $Enable_ECC ]
     return $c_fifo_Output_depth

}

proc Estimated_Imp_Usage_Value_updated { PARAM_VALUE.ENABLE_ECC PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.INPUT_DEPTH IPINST PARAM_VALUE.INPUT_DATA_WIDTH PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.OUTPUT_DATA_WIDTH} {

	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	if {$Fifo_Implementation == "Common_Clock_Builtin_FIFO"
       || $Fifo_Implementation == "Independent_Clocks_Builtin_FIFO" } {
      return "Estimated FIFO Usage : [fifo_generator_v12_0_utils::get_Estimated_FIFO_Usage $c_family [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] [Get_Output_Data_Width ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ]  [ get_property value ${PARAM_VALUE.ENABLE_ECC} ] ]"
    } 

}

proc LabelAXI_Interface_Info_2_updated {} {

	return " AXI Stream"

}

proc table_summary_30_updated {PARAM_VALUE.INPUT_DATA_WIDTH} {

	return [lindex [split [LabelInput_Data_WidthDescription_updated ${PARAM_VALUE.INPUT_DATA_WIDTH}] :] 0]

}

proc Latency_updated { PARAM_VALUE.FIFO_IMPLEMENTATION PARAM_VALUE.PERFORMANCE_OPTIONS  
  PARAM_VALUE.USE_EMBEDDED_REGISTERS PROJECT_PARAM.ARCHITECTURE} {

	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
    return [fifo_generator_v12_0_utils::get_Read_Latency $c_family [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] [ get_property value ${PARAM_VALUE.PERFORMANCE_OPTIONS} ] [ get_property value ${PARAM_VALUE.USE_EMBEDDED_REGISTERS} ]]
}

proc table_summary_31_updated {PARAM_VALUE.INPUT_DATA_WIDTH} {

	return [lindex [split [LabelInput_Data_WidthDescription_updated ${PARAM_VALUE.INPUT_DATA_WIDTH}] :] 1]

}

proc Calculated_RUSER_Width_updated {IPINST} {
	return "Calculated Width: [get_metaparam_value Calculated_Width_rdch]"		
}

proc updateOfLabelFifotext10a { PARAM_VALUE.FIFO_IMPLEMENTATION} {

	if {[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Independent_Clocks_Distributed_RAM" } {
		return "<b>Independent Clocks (RD_CLK, WR_CLK)"
	} else {
		return "Independent Clocks (RD_CLK, WR_CLK)"
	}

}

proc updateOfLabelFifotext10b { PARAM_VALUE.FIFO_IMPLEMENTATION} {

	if {[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Independent_Clocks_Builtin_FIFO" } {
		return "<b>Independent Clocks (RD_CLK, WR_CLK)"
	} else {
		return "Independent Clocks (RD_CLK, WR_CLK)"
	}

}

proc table_summary_40_updated {PARAM_VALUE.ENABLE_ECC PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.OUTPUT_DEPTH  
  PARAM_VALUE.PERFORMANCE_OPTIONS PARAM_VALUE.READ_CLOCK_FREQUENCY  
  PARAM_VALUE.WRITE_CLOCK_FREQUENCY IPINST PARAM_VALUE.INPUT_DATA_WIDTH PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.OUTPUT_DATA_WIDTH} {

	return [lindex [split [LabelInput_DepthDescription_updated ${PARAM_VALUE.ENABLE_ECC} ${PARAM_VALUE.FIFO_IMPLEMENTATION} \
	${PARAM_VALUE.INPUT_DEPTH} ${PARAM_VALUE.OUTPUT_DEPTH} ${PARAM_VALUE.PERFORMANCE_OPTIONS} ${PARAM_VALUE.READ_CLOCK_FREQUENCY} \
	${PARAM_VALUE.WRITE_CLOCK_FREQUENCY} $IPINST ${PARAM_VALUE.INPUT_DATA_WIDTH} ${PROJECT_PARAM.ARCHITECTURE} ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] :] 0]

}

proc table_summary_41_updated {PARAM_VALUE.ENABLE_ECC PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.OUTPUT_DEPTH  
  PARAM_VALUE.PERFORMANCE_OPTIONS PARAM_VALUE.READ_CLOCK_FREQUENCY  
  PARAM_VALUE.WRITE_CLOCK_FREQUENCY IPINST PARAM_VALUE.INPUT_DATA_WIDTH PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.OUTPUT_DATA_WIDTH} {

	return [lindex [split [LabelInput_DepthDescription_updated ${PARAM_VALUE.ENABLE_ECC} ${PARAM_VALUE.FIFO_IMPLEMENTATION} \
	${PARAM_VALUE.INPUT_DEPTH} ${PARAM_VALUE.OUTPUT_DEPTH} ${PARAM_VALUE.PERFORMANCE_OPTIONS} ${PARAM_VALUE.READ_CLOCK_FREQUENCY} \
	${PARAM_VALUE.WRITE_CLOCK_FREQUENCY} $IPINST ${PARAM_VALUE.INPUT_DATA_WIDTH} ${PROJECT_PARAM.ARCHITECTURE} ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] :] 1]

}

proc LabelInput_Data_WidthDescription_updated { PARAM_VALUE.INPUT_DATA_WIDTH} {

	return "Write Width : [ get_property value ${PARAM_VALUE.INPUT_DATA_WIDTH} ]"

}

proc Clock_Type_Info_AXIS_updated { PARAM_VALUE.CLOCK_TYPE_AXI} {

	if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] == "Common_Clock" } {
		return "Common Clock"
	} else {
	    return "Independent Clock"
	}

}

proc updateOfLabelFifotext9a { PARAM_VALUE.FIFO_IMPLEMENTATION} {

	if {[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Common_Clock_Distributed_RAM" } {
		return "<b>Common Clock (CLK)"
	} else {
		return "Common Clock (CLK)"
	}

}

proc updateOfLabelFifotext11a { PARAM_VALUE.FIFO_IMPLEMENTATION} {

	if {[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Independent_Clocks_Block_RAM" } {
		return "<b>Block RAM"
	} else {
		return "Block RAM"
	}

}

proc updateOfLabelFifotext9b { PARAM_VALUE.FIFO_IMPLEMENTATION} {

	if {[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Common_Clock_Shift_Register" } {
		return "<b>Common Clock (CLK)"
	} else {
		return "Common Clock (CLK)"
	}

}

proc ProgrammableFull_EmptyDescription_updated { PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE PARAM_VALUE.PROGRAMMABLE_FULL_TYPE} {

# Take the Concat of "LabelProgrammable_Full_TypeDescription" and "LabelProgrammable_Empty_TypeDescription"
	if {[ get_property value ${PARAM_VALUE.PROGRAMMABLE_FULL_TYPE} ] != "No_Programmable_Full_Threshold"} {
		set LabelProgrammable_Full_TypeDescription "Selected"
	} else {
		set LabelProgrammable_Full_TypeDescription "Not Selected"
	}
	if {[ get_property value ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE} ] != "No_Programmable_Empty_Threshold"} {
		set LabelProgrammable_Empty_TypeDescription "Selected"
   } else {
		set LabelProgrammable_Empty_TypeDescription "Not Selected"
   }
   return "$LabelProgrammable_Full_TypeDescription/$LabelProgrammable_Empty_TypeDescription"

}

proc LabelModel_ChosenValue_AXI_updated {IPINST} {

	set simulation_model [getSimulationModel]
   	if { $simulation_model eq "Structural" } {
		return "Unisim Structural Model"
	} else {
	    return "Behavioral Model"
	}

}

proc updateOfLabelFifotext9c { PARAM_VALUE.FIFO_IMPLEMENTATION} {

	if {[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Common_Clock_Builtin_FIFO" } {
		return "<b>Common Clock (CLK)"
	} else {
		return "Common Clock (CLK)"
	}

}

proc LabelWrite_Data_CountDescription_updated { PARAM_VALUE.DATA_COUNT PARAM_VALUE.READ_DATA_COUNT  
  PARAM_VALUE.WRITE_DATA_COUNT} {

	if {[ get_property value ${PARAM_VALUE.DATA_COUNT} ] || [ get_property value ${PARAM_VALUE.WRITE_DATA_COUNT} ] || [ get_property value ${PARAM_VALUE.READ_DATA_COUNT} ]} {
      return "Selected" 
   } else {
      return "Not Selected" 
   }

}

proc LabelModel_ChosenValue_AXIS_updated {IPINST} {

	return [LabelModel_ChosenValue_AXI_updated $IPINST]

}

proc Read_Mode_Reset_updated { PARAM_VALUE.PERFORMANCE_OPTIONS PARAM_VALUE.RESET_PIN  
  PARAM_VALUE.RESET_TYPE} {

	set Read_Mode "-"
	set Reset "-"

   switch [ get_property value ${PARAM_VALUE.PERFORMANCE_OPTIONS} ] {
	"Standard_FIFO" { set Read_Mode "Standard FIFO" }
      "First_Word_Fall_Through" { set Read_Mode "First-word Fall-through" }
   }

   if {[ get_property value ${PARAM_VALUE.RESET_PIN} ] == true} {
      if {[ get_property value ${PARAM_VALUE.RESET_TYPE} ] == "Synchronous_Reset"} {
         set Reset "Synchronous"
      } else {
         set Reset "Asynchronous"
      }
   } else {
         set Reset "Not Selected"
   }

   return "$Read_Mode / $Reset"

}


proc Estimated_Imp_Usage_Comment_updated { PARAM_VALUE.FIFO_IMPLEMENTATION} {
	set fifo_implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	return $fifo_implementation
}

proc updateOfLabelFifotext10 { PARAM_VALUE.FIFO_IMPLEMENTATION} {

	if {[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Independent_Clocks_Block_RAM" } {
		return "<b>Independent Clocks (RD_CLK, WR_CLK)"
	} else {
		return "Independent Clocks (RD_CLK, WR_CLK)"
	}

}

proc LabelValid_FlagDescription_updated { PARAM_VALUE.OVERFLOW_FLAG PARAM_VALUE.UNDERFLOW_FLAG  
  PARAM_VALUE.VALID_FLAG PARAM_VALUE.WRITE_ACKNOWLEDGE_FLAG} {

	if {[ get_property value ${PARAM_VALUE.VALID_FLAG} ] || [ get_property value ${PARAM_VALUE.UNDERFLOW_FLAG} ]
       || [ get_property value ${PARAM_VALUE.WRITE_ACKNOWLEDGE_FLAG} ] || [ get_property value ${PARAM_VALUE.OVERFLOW_FLAG} ]} {
      return "Selected" 
	} else {
      return "Not Selected" 
	}

}

proc updateOfLabelFifotext11 { PARAM_VALUE.FIFO_IMPLEMENTATION} {
	if {[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Common_Clock_Block_RAM" } {
		return "<b>Block RAM"
	} else {
		return "Block RAM"
	}
}

proc updateOfLabelFifotext12 { PARAM_VALUE.FIFO_IMPLEMENTATION} {
	if {[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Common_Clock_Distributed_RAM" } {
		return "<b>Distributed RAM"
	} else {
		return "Distributed RAM"
	}
}

proc Calculated_WUSER_Width_updated {IPINST} {
	return "Calculated Width: [get_metaparam_value Calculated_Width_wdch]"
}

proc updateOfLabelFifotext13 { PARAM_VALUE.FIFO_IMPLEMENTATION} {
	if {[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Common_Clock_Shift_Register" } {
		return "<b>Shift Register" 
	} else {
		return "Shift Register" 
	}
}

proc updateOfLabelFifotext12a { PARAM_VALUE.FIFO_IMPLEMENTATION} {
	if {[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Independent_Clocks_Distributed_RAM" } {
		return "<b>Distributed RAM"
	} else {
		return "Distributed RAM"
	}
}

proc updateOfLabelFifotext14 { PARAM_VALUE.FIFO_IMPLEMENTATION} {
	if {[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ] == "Common_Clock_Builtin_FIFO" } {
		return "<b>Built-in FIFO"
	} else {
		return "Built-in FIFO"
	}
}

proc Actual_Write_Depth_updated { PARAM_VALUE.ENABLE_ECC PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.OUTPUT_DEPTH  
  PARAM_VALUE.PERFORMANCE_OPTIONS PARAM_VALUE.READ_CLOCK_FREQUENCY  
  PARAM_VALUE.WRITE_CLOCK_FREQUENCY IPINST PARAM_VALUE.INPUT_DATA_WIDTH PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.OUTPUT_DATA_WIDTH} {

	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	 set Read_Faster [ expr [ get_property value ${PARAM_VALUE.READ_CLOCK_FREQUENCY} ] > [ get_property value ${PARAM_VALUE.WRITE_CLOCK_FREQUENCY} ] ]
	 set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	 set Performance_Options [ get_property value ${PARAM_VALUE.PERFORMANCE_OPTIONS} ]
	 set Input_Depth [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ]
	 set Output_Depth [ get_property value ${PARAM_VALUE.OUTPUT_DEPTH} ]
	 set Enable_ECC [ get_property value ${PARAM_VALUE.ENABLE_ECC} ]
	 set Input_Data_width [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}]
	 set Output_Data_Width [Get_Output_Data_Width ${PARAM_VALUE.OUTPUT_DATA_WIDTH}]
	set c_fifo_depth [fifo_generator_v12_0_utils::get_Actual_Input_Fifo_Depth $c_family $Fifo_Implementation $Performance_Options $Read_Faster $Input_Data_width $Input_Depth $Output_Depth $Enable_ECC $Output_Data_Width]

  return $c_fifo_depth
}

proc input_data_width_updated { PARAM_VALUE.asymmetric_port_width PARAM_VALUE.FIFO_IMPLEMENTATION} {
	set value [get_property value ${PARAM_VALUE.asymmetric_port_width}]
	set Fifo_Implementation [get_property  value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	set return_value  "1,2,3,..1024"
	if { $value && ($Fifo_Implementation == "Common_Clock_Builtin_FIFO" || $Fifo_Implementation == "Independent_Clocks_Builtin_FIFO" )} {
		set return_value "4,8,9,...1024"
	}
	return $return_value
} 

proc Estimated_Imp_Usage_updated { PARAM_VALUE.ENABLE_ECC PARAM_VALUE.FIFO_IMPLEMENTATION  
  PARAM_VALUE.INPUT_DATA_WIDTH PARAM_VALUE.INPUT_DEPTH  
  PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DEPTH IPINST PARAM_VALUE.INPUT_DATA_WIDTH PROJECT_PARAM.ARCHITECTURE} {

	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	### To Be Verified Again --  It requires loading an external library
	set Fifo_Implementation [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	if {$Fifo_Implementation == "Common_Clock_Builtin_FIFO"
       || $Fifo_Implementation == "Independent_Clocks_Builtin_FIFO" } {
	   return ""
	} else {
		if {$Fifo_Implementation == "Common_Clock_Block_RAM"
        || $Fifo_Implementation == "Independent_Clocks_Block_RAM"} {
			set is_common_clk [expr {($Fifo_Implementation == "Common_Clock_Block_RAM")?1:0}]
			set ID [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ]
			set Input_Data_Width [ get_property value ${PARAM_VALUE.INPUT_DATA_WIDTH} ]
			
			if {![isInputDepthValid $Input_Data_Width $ID]} {
				return ""
			}
			set blockram18s [fifo_generator_v12_0_utils::get_Estimated_BlockRAM_Usage_x $c_family $is_common_clk [Get_Input_Data_Width ${PARAM_VALUE.INPUT_DATA_WIDTH}] [ get_property value ${PARAM_VALUE.INPUT_DEPTH} ]  [ get_property value ${PARAM_VALUE.OUTPUT_DATA_WIDTH} ] [ get_property value ${PARAM_VALUE.OUTPUT_DEPTH} ] [ get_property value ${PARAM_VALUE.ENABLE_ECC} ] 18]
			return "Block RAM resource(s) (18K BRAMs): $blockram18s"
 		}
	} 
}

proc Get_Frequency_info { READ_CLOCK_FREQUENCY WRITE_CLOCK_FREQUENCY} {
   set wrclk [ get_property value ${WRITE_CLOCK_FREQUENCY} ]
   set rdclk [ get_property value ${READ_CLOCK_FREQUENCY} ]
   if {[ expr {$wrclk % $rdclk }] == 0} {
      return [expr {int($wrclk/$rdclk)}];
  } else {
    return [expr {int($wrclk/$rdclk) + 1}];
  }
}

proc Get_Input_Data_Width { INPUT_DATA_WIDTH} {
   set retval [ get_property value ${INPUT_DATA_WIDTH} ]
   if {$retval == ""} {
      return 1
  }
    return $retval;
}

proc Get_Output_Data_Width { OUTPUT_DATA_WIDTH} {
   set retval [ get_property value ${OUTPUT_DATA_WIDTH} ]
   if {$retval == ""} {
      return 1
  }
    return $retval;
}


;# Meta Param Procedures

proc update_Calculated_Width_wrch { PARAM_VALUE.BUSER_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL} {
	set INTERFACE_TYPE [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
	set PROTOCOL [ get_property value ${PARAM_VALUE.PROTOCOL} ]
	
    if {[ get_property value ${PARAM_VALUE.BUSER_WIDTH} ] > 0} {		 
	    set b_width_val [ get_property value ${PARAM_VALUE.BUSER_WIDTH} ]
    } else {
	    set b_width_val 0
    }
    
	if {$INTERFACE_TYPE == "AXI_MEMORY_MAPPED" &&  $PROTOCOL != "AXI4_Lite" } {	
		if { [ get_property value ${PARAM_VALUE.ID_WIDTH} ] < 0 } {
			set IDWIDTH_val 0
		} else {
			set IDWIDTH_val [ get_property value ${PARAM_VALUE.ID_WIDTH} ]
		}
		set Calculated_Width_wrch [expr {$IDWIDTH_val+$b_width_val+2}]
	} elseif {$INTERFACE_TYPE == "AXI_MEMORY_MAPPED" && $PROTOCOL == "AXI4_Lite" } {
		set Calculated_Width_wrch 2
	} elseif {$INTERFACE_TYPE == "AXI_STREAM" } {
		set Calculated_Width_wrch 2
	} else {
		set Calculated_Width_wrch 2
	}
	return $Calculated_Width_wrch
}

proc update_Calculated_Width_rdch { PARAM_VALUE.DATA_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PARAM_VALUE.RUSER_WIDTH} {
	set INTERFACE_TYPE [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
	set PROTOCOL [ get_property value ${PARAM_VALUE.PROTOCOL} ]
	set DATA_WIDTH [ get_property value ${PARAM_VALUE.DATA_WIDTH} ]
	
	 if {[ get_property value ${PARAM_VALUE.RUSER_WIDTH} ] > 0 } {		 
	    set r_width_val [ get_property value ${PARAM_VALUE.RUSER_WIDTH} ]
    } else {
	    set r_width_val 0
    }
    
	if {$INTERFACE_TYPE == "AXI_MEMORY_MAPPED" &&  $PROTOCOL != "AXI4_Lite" } {	
		if { [ get_property value ${PARAM_VALUE.ID_WIDTH} ] < 0 } {
			set IDWIDTH_val 0
		} else {
			set IDWIDTH_val [ get_property value ${PARAM_VALUE.ID_WIDTH} ]
		}
		set Calculated_Width_rdch [expr {$IDWIDTH_val + $DATA_WIDTH+$r_width_val+3}]
	} elseif {$INTERFACE_TYPE == "AXI_MEMORY_MAPPED" && $PROTOCOL == "AXI4_Lite" } {
		set Calculated_Width_rdch [expr {$DATA_WIDTH+2}]
	} elseif {$INTERFACE_TYPE == "AXI_STREAM" } {
		set Calculated_Width_rdch $DATA_WIDTH
	} else {
		set Calculated_Width_rdch $DATA_WIDTH
	}
	return $Calculated_Width_rdch
}

proc update_Calculated_Width_axis { PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.HAS_TKEEP  
  PARAM_VALUE.HAS_TSTRB PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.TDATA_NUM_BYTES PARAM_VALUE.TDEST_WIDTH  
  PARAM_VALUE.TID_WIDTH PARAM_VALUE.TKEEP_WIDTH  
  PARAM_VALUE.TSTRB_WIDTH PARAM_VALUE.TUSER_WIDTH} {
	set INTERFACE_TYPE [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
	
	if {$INTERFACE_TYPE == "AXI_MEMORY_MAPPED"} {	
		set Calculated_Width_axis 1	    
	} elseif {$INTERFACE_TYPE == "AXI_STREAM" } {
		#AXI Streaming
		set Calculated_Width_axis 0 
		if {[ get_property value ${PARAM_VALUE.TDATA_NUM_BYTES} ] > 0} {
			incr Calculated_Width_axis [expr "[ get_property value ${PARAM_VALUE.TDATA_NUM_BYTES} ] * 8"]
		} 
		
		incr Calculated_Width_axis [ get_property value ${PARAM_VALUE.TID_WIDTH} ] 
		incr Calculated_Width_axis [ get_property value ${PARAM_VALUE.TDEST_WIDTH} ] 
		incr Calculated_Width_axis [ get_property value ${PARAM_VALUE.TUSER_WIDTH} ] 
		
		if { [ get_property value ${PARAM_VALUE.HAS_TKEEP} ] } {
			incr Calculated_Width_axis [ get_property value ${PARAM_VALUE.TKEEP_WIDTH} ] 
		}
		if { [ get_property value ${PARAM_VALUE.HAS_TSTRB} ] } {
			incr Calculated_Width_axis [ get_property value ${PARAM_VALUE.TSTRB_WIDTH} ] 
		}
		
		if {[ get_property value ${PARAM_VALUE.ENABLE_TLAST} ] } {
			incr Calculated_Width_axis 
		}
	} else {
		set Calculated_Width_axis 1
	}	
	return $Calculated_Width_axis
}

proc update_Calculated_Width_rach { PARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.ARUSER_WIDTH  
  PARAM_VALUE.ID_WIDTH PARAM_VALUE.INTERFACE_TYPE  PARAM_VALUE.PROTOCOL} {

	set INTERFACE_TYPE [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
	set PROTOCOL [ get_property value ${PARAM_VALUE.PROTOCOL} ]
	set ADDRESS_WIDTH [ get_property value ${PARAM_VALUE.ADDRESS_WIDTH} ]
	
    if {[ get_property value ${PARAM_VALUE.ARUSER_WIDTH} ] > 0 } {		 
	    set ar_width_val [ get_property value ${PARAM_VALUE.ARUSER_WIDTH} ]
    } else {
	    set ar_width_val 0
    }
   
	if {$INTERFACE_TYPE == "AXI_MEMORY_MAPPED" &&  $PROTOCOL != "AXI4_Lite" } {	
		if {[ get_property value ${PARAM_VALUE.PROTOCOL} ] == "AXI4"} {
			set Len_width 8
		} else {	
			set Len_width 4
		}
        if {[ get_property value ${PARAM_VALUE.PROTOCOL} ] == "AXI4"} {
			set Lock_width 1
		} else {
			set Lock_width 2
		}
		if { [ get_property value ${PARAM_VALUE.ID_WIDTH} ] < 0 } {
			set IDWIDTH_val 0
		} else {
			set IDWIDTH_val [ get_property value ${PARAM_VALUE.ID_WIDTH} ]
		}
		if { [ get_property value ${PARAM_VALUE.PROTOCOL} ] == "AXI4" } {
			set Constant_arval 20
		} else {
			set Constant_arval 16
                        ## ARREGION not applicable for AXI3
		}
		set Calculated_Width_rach [expr {$IDWIDTH_val + $ADDRESS_WIDTH + $ar_width_val + $Len_width + $Lock_width + $Constant_arval}]		
	} elseif {$INTERFACE_TYPE == "AXI_MEMORY_MAPPED" && $PROTOCOL == "AXI4_Lite" } {
			set Calculated_Width_rach [expr {$ADDRESS_WIDTH + 3}]
	} elseif {$INTERFACE_TYPE == "AXI_STREAM" } {
		set Calculated_Width_rach $ADDRESS_WIDTH
	} else {
		set Calculated_Width_rach $ADDRESS_WIDTH
	}
	return $Calculated_Width_rach
}

proc update_Calculated_Width_wdch { PARAM_VALUE.DATA_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL  
  PARAM_VALUE.WUSER_WIDTH} {
	
	set INTERFACE_TYPE [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
	set DATA_WIDTH [ get_property value ${PARAM_VALUE.DATA_WIDTH} ]
	set PROTOCOL [ get_property value ${PARAM_VALUE.PROTOCOL} ]
	
     if {[ get_property value ${PARAM_VALUE.WUSER_WIDTH} ] > 0 } {		 
	    set w_width_val [ get_property value ${PARAM_VALUE.WUSER_WIDTH} ]
    } else {
	    set w_width_val 0
    }
    
	if {$INTERFACE_TYPE == "AXI_MEMORY_MAPPED" &&  $PROTOCOL != "AXI4_Lite" } {	
		if { [ get_property value ${PARAM_VALUE.ID_WIDTH} ] < 0 || ($PROTOCOL == "AXI4")} {
			set IDWIDTH_val 0
		} else {
			set IDWIDTH_val [ get_property value ${PARAM_VALUE.ID_WIDTH} ]
		}
		set Calculated_Width_wdch [expr {($DATA_WIDTH/8)+$DATA_WIDTH+$w_width_val+$IDWIDTH_val+1}]
	} elseif {$INTERFACE_TYPE == "AXI_MEMORY_MAPPED" && $PROTOCOL == "AXI4_Lite" } {
		set Calculated_Width_wdch [expr {($DATA_WIDTH/8)+$DATA_WIDTH }]
	} elseif {$INTERFACE_TYPE == "AXI_STREAM" } {
		set Calculated_Width_wdch $DATA_WIDTH
	} else {
		set Calculated_Width_wdch $DATA_WIDTH
	}
	return $Calculated_Width_wdch
}

proc update_Calculated_Width_wach { PARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.AWUSER_WIDTH  
  PARAM_VALUE.ID_WIDTH PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.PROTOCOL} {
	set ADDRESS_WIDTH [ get_property value ${PARAM_VALUE.ADDRESS_WIDTH} ]
	set PROTOCOL [ get_property value ${PARAM_VALUE.PROTOCOL} ]
	set INTERFACE_TYPE [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
	
	if {[ get_property value ${PARAM_VALUE.AWUSER_WIDTH} ] > 0 } {		 
	    set aw_width_val [ get_property value ${PARAM_VALUE.AWUSER_WIDTH} ]
    } else {
	    set aw_width_val 0
    }
	
	if {$INTERFACE_TYPE == "AXI_MEMORY_MAPPED" && $PROTOCOL != "AXI4_Lite" } {	
		if {[ get_property value ${PARAM_VALUE.PROTOCOL} ] == "AXI4"} {
			set Len_width 8
		} else {
			set Len_width 4
		}
		if {[ get_property value ${PARAM_VALUE.PROTOCOL} ] == "AXI4"} {
			set Lock_width 1
		} else {
			set Lock_width 2
		}
		if { [ get_property value ${PARAM_VALUE.ID_WIDTH} ] < 0 } {
			set IDWIDTH_val 0
		} else {
			set IDWIDTH_val [ get_property value ${PARAM_VALUE.ID_WIDTH} ]
		}
		if { [ get_property value ${PARAM_VALUE.PROTOCOL} ] == "AXI4" } {
			set Constant_awval 20
		} else {
			set Constant_awval 16
                        ## AWREGION not applicable for AXI3
		}
		
		set Calculated_Width_wach [expr { $IDWIDTH_val + $ADDRESS_WIDTH + $aw_width_val + $Len_width + $Lock_width + $Constant_awval}]
	} elseif {$INTERFACE_TYPE == "AXI_MEMORY_MAPPED" && $PROTOCOL == "AXI4_Lite" } {
		set Calculated_Width_wach [expr {$ADDRESS_WIDTH + 3}]
	} elseif {$INTERFACE_TYPE == "AXI_STREAM" } {
		set Calculated_Width_wach $ADDRESS_WIDTH  
	} else {
		set Calculated_Width_wach $ADDRESS_WIDTH  
	}
	return $Calculated_Width_wach

}

proc Calculated_Depth_wach { PARAM_VALUE.ENABLE_ECC_WACH PARAM_VALUE.FIFO_IMPLEMENTATION_WACH  
  PARAM_VALUE.INPUT_DEPTH_WACH PARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.AWUSER_WIDTH 
	PARAM_VALUE.ID_WIDTH PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PROJECT_PARAM.ARCHITECTURE} {
	
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set Calculated_Depth_wach  [fifo_generator_v12_0_utils::get_Actual_Input_Fifo_Depth $c_family  [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WACH} ] "First_Word_Fall_Through" 0 [get_metaparam_value Calculated_Width_wach] [ get_property value ${PARAM_VALUE.INPUT_DEPTH_WACH} ] [ get_property value ${PARAM_VALUE.INPUT_DEPTH_WACH} ]  [ get_property value ${PARAM_VALUE.ENABLE_ECC_WACH} ]  [get_metaparam_value Calculated_Width_wach]  ]
	return $Calculated_Depth_wach
}

proc Calculated_Depth_wrch { PARAM_VALUE.ENABLE_ECC_WRCH PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH  
  PARAM_VALUE.INPUT_DEPTH_WRCH PARAM_VALUE.BUSER_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PROJECT_PARAM.ARCHITECTURE} {

	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set Calculated_Depth_wrch  [fifo_generator_v12_0_utils::get_Actual_Input_Fifo_Depth $c_family [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH} ] "First_Word_Fall_Through" 0 [get_metaparam_value Calculated_Width_wrch] [ get_property value ${PARAM_VALUE.INPUT_DEPTH_WRCH} ] [ get_property value ${PARAM_VALUE.INPUT_DEPTH_WRCH} ]  [ get_property value ${PARAM_VALUE.ENABLE_ECC_WRCH} ] [get_metaparam_value Calculated_Width_wrch] ]
	return $Calculated_Depth_wrch
}

proc Calculated_Depth_rdch { PARAM_VALUE.ENABLE_ECC_RDCH PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH  
  PARAM_VALUE.INPUT_DEPTH_RDCH PARAM_VALUE.DATA_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PARAM_VALUE.RUSER_WIDTH PROJECT_PARAM.ARCHITECTURE} {
	
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set Calculated_Depth_rdch  [fifo_generator_v12_0_utils::get_Actual_Input_Fifo_Depth $c_family [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH} ] "First_Word_Fall_Through" 0 [get_metaparam_value Calculated_Width_rdch] [ get_property value ${PARAM_VALUE.INPUT_DEPTH_RDCH} ] [ get_property value ${PARAM_VALUE.INPUT_DEPTH_RDCH} ]  [ get_property value ${PARAM_VALUE.ENABLE_ECC_RDCH} ] [get_metaparam_value Calculated_Width_rdch]  ]
	return $Calculated_Depth_rdch
}

proc Calculated_Depth_axis { PARAM_VALUE.ENABLE_ECC_AXIS PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS  
  PARAM_VALUE.INPUT_DEPTH_AXIS PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.HAS_TKEEP  
  PARAM_VALUE.HAS_TSTRB PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.TDATA_NUM_BYTES PARAM_VALUE.TDEST_WIDTH  
  PARAM_VALUE.TID_WIDTH PARAM_VALUE.TKEEP_WIDTH  
  PARAM_VALUE.TSTRB_WIDTH PARAM_VALUE.TUSER_WIDTH PROJECT_PARAM.ARCHITECTURE} {
	
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set Calculated_Depth_axis  [fifo_generator_v12_0_utils::get_Actual_Input_Fifo_Depth $c_family [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} ] "First_Word_Fall_Through" 0  [get_metaparam_value Calculated_Width_axis] [ get_property value ${PARAM_VALUE.INPUT_DEPTH_AXIS} ] [ get_property value ${PARAM_VALUE.INPUT_DEPTH_AXIS} ] [ get_property value ${PARAM_VALUE.ENABLE_ECC_AXIS} ] [get_metaparam_value Calculated_Width_axis] ]
	return $Calculated_Depth_axis
}

proc Calculated_Depth_rach { PARAM_VALUE.ENABLE_ECC_RACH PARAM_VALUE.FIFO_IMPLEMENTATION_RACH  
  PARAM_VALUE.INPUT_DEPTH_RACH PARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.ARUSER_WIDTH  
  PARAM_VALUE.ID_WIDTH PARAM_VALUE.INTERFACE_TYPE  PARAM_VALUE.PROTOCOL PROJECT_PARAM.ARCHITECTURE} {
	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set Calculated_Depth_rach  [fifo_generator_v12_0_utils::get_Actual_Input_Fifo_Depth $c_family 	[ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_RACH} ] "First_Word_Fall_Through" 0 [get_metaparam_value Calculated_Width_rach] [ get_property value ${PARAM_VALUE.INPUT_DEPTH_RACH} ] [ get_property value ${PARAM_VALUE.INPUT_DEPTH_RACH} ]  [ get_property value ${PARAM_VALUE.ENABLE_ECC_RACH} ] [get_metaparam_value Calculated_Width_rach]  ]
	return $Calculated_Depth_rach
}

proc Calculated_Depth_wdch { PARAM_VALUE.ENABLE_ECC_WDCH PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH  
  PARAM_VALUE.INPUT_DEPTH_WDCH PARAM_VALUE.DATA_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL  
  PARAM_VALUE.WUSER_WIDTH PROJECT_PARAM.ARCHITECTURE} {

	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	set Calculated_Depth_wdch  [fifo_generator_v12_0_utils::get_Actual_Input_Fifo_Depth $c_family [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH} ] "First_Word_Fall_Through" 0 	[get_metaparam_value Calculated_Width_wdch] [ get_property value ${PARAM_VALUE.INPUT_DEPTH_WDCH} ] [ get_property value ${PARAM_VALUE.INPUT_DEPTH_WDCH} ] [ get_property value ${PARAM_VALUE.ENABLE_ECC_WDCH} ] [get_metaparam_value Calculated_Width_wdch] ]
	return $Calculated_Depth_wdch
}

proc AllowedWriteWidth_updated { PARAM_VALUE.FIFO_IMPLEMENTATION} {
	set fifo_iml_val [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION} ]
	if {$fifo_iml_val == "Common_Clock_Block_RAM" || $fifo_iml_val == "Independent_Clocks_Block_RAM"} {
		return "Range: 1,2,3..1024"
	} else {
		return "Range: 1,2,3..4096"
	}
}

proc Latency2_wdch_updated {PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_WDCH  
  PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WDCH} {
	return [LatencyCalculation_wdch ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WDCH} ${PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH} ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WDCH}]
}

proc Latency2_rdch_updated {PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_RDCH  
  PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_RDCH} {
	return [LatencyCalculation_rdch ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RDCH} ${PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH} ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_RDCH}]
}

proc Latency2_wach_updated {PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH  
  PARAM_VALUE.FIFO_IMPLEMENTATION_WACH PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WACH} {
	return [LatencyCalculation_wach ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ${PARAM_VALUE.FIFO_IMPLEMENTATION_WACH} ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WACH}]
}

proc Latency2_rach_updated {PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH  
  PARAM_VALUE.FIFO_IMPLEMENTATION_RACH PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_RACH} {
	return [LatencyCalculation_rach ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH} ${PARAM_VALUE.FIFO_IMPLEMENTATION_RACH} ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_RACH}]
}

proc Latency2_wrch_updated {PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_WRCH  
  PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WRCH} {
	return [LatencyCalculation_wrch ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WRCH} \
	${PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH} ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WRCH}]
}

proc Latency2_axis_updated {PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS  
  PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_AXIS} {
	return [LatencyCalculation_axis ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS} \
	${PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_AXIS}]
}

proc Final_Latency_wdch_updated {PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_WDCH  
  PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WDCH} {
	return [LatencyCalculation_wdch ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WDCH} \
	${PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH} ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WDCH}]
}

proc Final_Latency_rdch_updated {PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_RDCH  
  PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_RDCH} {
	return [LatencyCalculation_rdch ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RDCH} \
	${PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH} ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_RDCH}]
}

proc Final_Latency_wach_updated {PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH  
  PARAM_VALUE.FIFO_IMPLEMENTATION_WACH PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WACH} {
	return [LatencyCalculation_wach ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} \
	${PARAM_VALUE.FIFO_IMPLEMENTATION_WACH} ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WACH}]
}

proc Final_Latency_rach_updated {PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH  
  PARAM_VALUE.FIFO_IMPLEMENTATION_RACH PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_RACH} {
	return [LatencyCalculation_rach ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH} \
	${PARAM_VALUE.FIFO_IMPLEMENTATION_RACH} ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_RACH}]
}

proc Final_Latency_wrch_updated {PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_WRCH  
  PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WRCH} {
	return [LatencyCalculation_wrch ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WRCH} \
	${PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH} ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WRCH}]
}

proc Final_Latency_axis_updated {PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS  
  PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_AXIS} {
	return [LatencyCalculation_axis ${PARAM_VALUE.CLOCK_TYPE_AXI} ${PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS} \
	${PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_AXIS}]
}

proc LatencyCalculation_rdch { PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_RDCH  
  PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_RDCH} {

	set Programmable_Empty_Type_channel [ get_property value ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_RDCH} ]
	if { $Programmable_Empty_Type_channel == "No_Programmable_Empty_Threshold" } {
			set  prog_empty_common_clk_val 2
			set  prog_empty_indep_clk_val "1 WR_CLK + 4 RD_CLK "
	} elseif { $Programmable_Empty_Type_channel == "Almost_Empty" } {
			set  prog_empty_common_clk_val 1
			set  prog_empty_indep_clk_val "1 WR_CLK + 4 RD_CLK "
	} else {
		set  prog_empty_common_clk_val 1
		set  prog_empty_indep_clk_val "1 WR_CLK + 5 RD_CLK "
	}
	
	set FIFO_Implementation_channel [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH} ]
	if { $FIFO_Implementation_channel == "Common_Clock_Block_RAM" || $FIFO_Implementation_channel == "Common_Clock_Distributed_RAM" } {
		 return "Latency : $prog_empty_common_clk_val"
	} elseif { $FIFO_Implementation_channel == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_channel == "Independent_Clocks_Distributed_RAM" } {
		 return "Latency : $prog_empty_indep_clk_val"
	}    		 
	
	if { [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RDCH} ] == "Low_Latency_Data_FIFO" } {
		if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq  "Independent_Clock"  } {
			return "Latency : 1 WR_CLK + 1 RD_CLK"
		} else {
			return "Latency : 1"
		}
	}
}

proc LatencyCalculation_rach { PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH  
  PARAM_VALUE.FIFO_IMPLEMENTATION_RACH PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_RACH} {

	set Programmable_Empty_Type_channel [ get_property value ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_RACH} ]
	if { $Programmable_Empty_Type_channel == "No_Programmable_Empty_Threshold" } {
			set  prog_empty_common_clk_val 2
			set  prog_empty_indep_clk_val "1 WR_CLK + 4 RD_CLK "
	} elseif { $Programmable_Empty_Type_channel == "Almost_Empty" } {
			set  prog_empty_common_clk_val 1
			set  prog_empty_indep_clk_val "1 WR_CLK + 4 RD_CLK "
	} else {
		set  prog_empty_common_clk_val 1
		set  prog_empty_indep_clk_val "1 WR_CLK + 5 RD_CLK "
	}
	
	set FIFO_Implementation_channel [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_RACH} ]
	if { $FIFO_Implementation_channel == "Common_Clock_Block_RAM" || $FIFO_Implementation_channel == "Common_Clock_Distributed_RAM" } {
		 return "Latency : $prog_empty_common_clk_val"
	} elseif { $FIFO_Implementation_channel == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_channel == "Independent_Clocks_Distributed_RAM" } {
		 return "Latency : $prog_empty_indep_clk_val"
	}    		 
	
	if { [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH} ] == "Low_Latency_Data_FIFO" } {
		if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq  "Independent_Clock"  } {
			return "Latency : 1 WR_CLK + 1 RD_CLK"
		} else {
			return "Latency : 1"
		}
	}
}

proc LatencyCalculation_wach { PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH  
  PARAM_VALUE.FIFO_IMPLEMENTATION_WACH PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WACH} {

	set Programmable_Empty_Type_channel [ get_property value ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WACH} ]
	if { $Programmable_Empty_Type_channel == "No_Programmable_Empty_Threshold" } {
			set  prog_empty_common_clk_val 2
			set  prog_empty_indep_clk_val "1 WR_CLK + 4 RD_CLK "
	} elseif { $Programmable_Empty_Type_channel == "Almost_Empty" } {
			set  prog_empty_common_clk_val 1
			set  prog_empty_indep_clk_val "1 WR_CLK + 4 RD_CLK "
	} else {
		set  prog_empty_common_clk_val 1
		set  prog_empty_indep_clk_val "1 WR_CLK + 5 RD_CLK "
	}
	
	set FIFO_Implementation_channel [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WACH} ]
	if { $FIFO_Implementation_channel == "Common_Clock_Block_RAM" || $FIFO_Implementation_channel == "Common_Clock_Distributed_RAM" } {
		 return "Latency : $prog_empty_common_clk_val"
	} elseif { $FIFO_Implementation_channel == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_channel == "Independent_Clocks_Distributed_RAM" } {
		 return "Latency : $prog_empty_indep_clk_val"
	}    		 
	
	if { [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ] == "Low_Latency_Data_FIFO" } {
		if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq  "Independent_Clock"  } {
			return "Latency : 1 WR_CLK + 1 RD_CLK"
		} else {
			return "Latency : 1"
		}
	}
}

proc LatencyCalculation_wrch { PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_WRCH  
  PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WRCH} {

	set Programmable_Empty_Type_channel [ get_property value ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WRCH} ]
	if { $Programmable_Empty_Type_channel == "No_Programmable_Empty_Threshold" } {
			set  prog_empty_common_clk_val 2
			set  prog_empty_indep_clk_val "1 WR_CLK + 4 RD_CLK "
	} elseif { $Programmable_Empty_Type_channel == "Almost_Empty" } {
			set  prog_empty_common_clk_val 1
			set  prog_empty_indep_clk_val "1 WR_CLK + 4 RD_CLK "
	} else {
		set  prog_empty_common_clk_val 1
		set  prog_empty_indep_clk_val "1 WR_CLK + 5 RD_CLK "
	}
	
	set FIFO_Implementation_channel [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH} ]
	if { $FIFO_Implementation_channel == "Common_Clock_Block_RAM" || $FIFO_Implementation_channel == "Common_Clock_Distributed_RAM" } {
		 return "Latency : $prog_empty_common_clk_val"
	} elseif { $FIFO_Implementation_channel == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_channel == "Independent_Clocks_Distributed_RAM" } {
		 return "Latency : $prog_empty_indep_clk_val"
	}    		 
	
	if { [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WRCH} ] == "Low_Latency_Data_FIFO" } {
		if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq  "Independent_Clock"  } {
			return "Latency : 1 WR_CLK + 1 RD_CLK"
		} else {
			return "Latency : 1"
		}
	}
}

proc LatencyCalculation_wdch { PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_WDCH  
  PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WDCH} {

	set Programmable_Empty_Type_channel [ get_property value ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_WDCH} ]
	if { $Programmable_Empty_Type_channel == "No_Programmable_Empty_Threshold" } {
			set  prog_empty_common_clk_val 2
			set  prog_empty_indep_clk_val "1 WR_CLK + 4 RD_CLK "
	} elseif { $Programmable_Empty_Type_channel == "Almost_Empty" } {
			set  prog_empty_common_clk_val 1
			set  prog_empty_indep_clk_val "1 WR_CLK + 4 RD_CLK "
	} else {
		set  prog_empty_common_clk_val 1
		set  prog_empty_indep_clk_val "1 WR_CLK + 5 RD_CLK "
	}
	
	set FIFO_Implementation_channel [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH} ]
	if { $FIFO_Implementation_channel == "Common_Clock_Block_RAM" || $FIFO_Implementation_channel == "Common_Clock_Distributed_RAM" } {
		 return "Latency : $prog_empty_common_clk_val"
	} elseif { $FIFO_Implementation_channel == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_channel == "Independent_Clocks_Distributed_RAM" } {
		 return "Latency : $prog_empty_indep_clk_val"
	}    		 
	
	if { [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WDCH} ] == "Low_Latency_Data_FIFO" } {
		if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq  "Independent_Clock"  } {
			return "Latency : 1 WR_CLK + 1 RD_CLK"
		} else {
			return "Latency : 1"
		}
	}
}

proc LatencyCalculation_axis { PARAM_VALUE.CLOCK_TYPE_AXI PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS  
  PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_AXIS} {

	set Programmable_Empty_Type_channel [ get_property value ${PARAM_VALUE.PROGRAMMABLE_EMPTY_TYPE_AXIS} ]
	if { $Programmable_Empty_Type_channel == "No_Programmable_Empty_Threshold" } {
			set  prog_empty_common_clk_val 2
			set  prog_empty_indep_clk_val "1 WR_CLK + 4 RD_CLK "
	} elseif { $Programmable_Empty_Type_channel == "Almost_Empty" } {
			set  prog_empty_common_clk_val 1
			set  prog_empty_indep_clk_val "1 WR_CLK + 4 RD_CLK "
	} else {
		set  prog_empty_common_clk_val 1
		set  prog_empty_indep_clk_val "1 WR_CLK + 5 RD_CLK "
	}
	if { [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS} ] == "Low_Latency_Data_FIFO" } {
		if { [ get_property value ${PARAM_VALUE.CLOCK_TYPE_AXI} ] eq  "Independent_Clock"  } {
			return "Latency : 1 WR_CLK + 1 RD_CLK"
		} else {
			return "Latency : 1"
		}
	}
	set FIFO_Implementation_channel [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} ]
	if { $FIFO_Implementation_channel == "Common_Clock_Block_RAM" || $FIFO_Implementation_channel == "Common_Clock_Distributed_RAM" || $FIFO_Implementation_channel == "Common_Clock_Builtin_FIFO"} {
		 return "Latency : $prog_empty_common_clk_val"
	} elseif { $FIFO_Implementation_channel == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_channel == "Independent_Clocks_Distributed_RAM" || $FIFO_Implementation_channel == "Independent_Clocks_Builtin_FIFO"} {
		 return "Latency : $prog_empty_indep_clk_val"
	} else {
	     return "Latency : "
	} 	
	

}

proc App_Type_wrch_updated { PARAM_VALUE.FIFO_APPLICATION_TYPE_WRCH PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH} {
	set FIFO_Application_Type_channel [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WRCH} ]
	if { $FIFO_Application_Type_channel == "Data_FIFO" } {
		set AppTypeText "Data FIFO"
	} elseif { $FIFO_Application_Type_channel == "Packet_FIFO" } {
		set AppTypeText "Packet FIFO"
	} else {
		set AppTypeText "Low Latency Data FIFO"
	}
	
	set FIFO_Implementation_channel [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH} ]
#	if { $FIFO_Implementation_channel == "Common_Clock_Block_RAM" || $FIFO_Implementation_channel == "Common_Clock_Distributed_RAM" ||  $FIFO_Implementation_channel == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_channel == "Independent_Clocks_Distributed_RAM" } {
		return "$AppTypeText"
#	} 	 
}

proc App_Type_axis_updated { PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} {
	set FIFO_Application_Type_channel [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS} ]
	if { $FIFO_Application_Type_channel == "Data_FIFO" } {
		set AppTypeText "Data FIFO"
	} elseif { $FIFO_Application_Type_channel == "Packet_FIFO" } {
		set AppTypeText "Packet FIFO"
	} else {
		set AppTypeText "Low Latency Data FIFO"
	}
			
	set FIFO_Implementation_channel [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} ]
	#if { $FIFO_Implementation_channel == "Common_Clock_Block_RAM" || $FIFO_Implementation_channel == "Common_Clock_Distributed_RAM" ||  $FIFO_Implementation_channel == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_channel == "Independent_Clocks_Distributed_RAM" } {
		return "$AppTypeText"
	#} 	 
}

proc App_Type_wdch_updated { PARAM_VALUE.FIFO_APPLICATION_TYPE_WDCH PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH} {
	set FIFO_Application_Type_channel [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WDCH} ]
	if { $FIFO_Application_Type_channel == "Data_FIFO" } {
		set AppTypeText "Data FIFO"
	} elseif { $FIFO_Application_Type_channel == "Packet_FIFO" } {
		set AppTypeText "Packet FIFO"
	} else {
		set AppTypeText "Low Latency Data FIFO"
	}
	
	set FIFO_Implementation_channel [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH} ]
#	if { $FIFO_Implementation_channel == "Common_Clock_Block_RAM" || $FIFO_Implementation_channel == "Common_Clock_Distributed_RAM" ||  $FIFO_Implementation_channel == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_channel == "Independent_Clocks_Distributed_RAM" } {
		return "$AppTypeText"
#	} 	 
}

proc App_Type_rdch_updated { PARAM_VALUE.FIFO_APPLICATION_TYPE_RDCH PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH} {
	set FIFO_Application_Type_channel [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RDCH} ]
	if { $FIFO_Application_Type_channel == "Data_FIFO" } {
		set AppTypeText "Data FIFO"
	} elseif { $FIFO_Application_Type_channel == "Packet_FIFO" } {
		set AppTypeText "Packet FIFO"
	} else {
		set AppTypeText "Low Latency Data FIFO"
	}
	
	set FIFO_Implementation_channel [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH} ]
#	if { $FIFO_Implementation_channel == "Common_Clock_Block_RAM" || $FIFO_Implementation_channel == "Common_Clock_Distributed_RAM" ||  $FIFO_Implementation_channel == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_channel == "Independent_Clocks_Distributed_RAM" } {
		return "$AppTypeText"
#	} 	 
}

proc App_Type_wach_updated { PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH PARAM_VALUE.FIFO_IMPLEMENTATION_WACH} {
	set FIFO_Application_Type_channel [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ]
	if { $FIFO_Application_Type_channel == "Data_FIFO" } {
		set AppTypeText "Data FIFO"
	} elseif { $FIFO_Application_Type_channel == "Packet_FIFO" } {
		set AppTypeText "Packet FIFO"
	} else {
		set AppTypeText "Low Latency Data FIFO"
	}
	
	set FIFO_Implementation_channel [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WACH} ]
#	if { $FIFO_Implementation_channel == "Common_Clock_Block_RAM" || $FIFO_Implementation_channel == "Common_Clock_Distributed_RAM" ||  $FIFO_Implementation_channel == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_channel == "Independent_Clocks_Distributed_RAM" } {
		return "$AppTypeText"
#	} 	 
}

proc App_Type_rach_updated { PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH PARAM_VALUE.FIFO_IMPLEMENTATION_RACH} {
	set FIFO_Application_Type_channel [ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH} ]
	if { $FIFO_Application_Type_channel == "Data_FIFO" } {
		set AppTypeText "Data FIFO"
	} elseif { $FIFO_Application_Type_channel == "Packet_FIFO" } {
		set AppTypeText "Packet FIFO"
	} else {
		set AppTypeText "Low Latency Data FIFO"
	}
	
	set FIFO_Implementation_channel [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_RACH} ]
#	if { $FIFO_Implementation_channel == "Common_Clock_Block_RAM" || $FIFO_Implementation_channel == "Common_Clock_Distributed_RAM" ||  $FIFO_Implementation_channel == "Independent_Clocks_Block_RAM" || $FIFO_Implementation_channel == "Independent_Clocks_Distributed_RAM" } {
		return "$AppTypeText"
#	} 	 
}

proc FIFO_Width_wrch_updated {PARAM_VALUE.BUSER_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL } {
	return "FIFO Width:[get_metaparam_value Calculated_Width_wrch]      "
}

proc FIFO_Width_axis_updated {PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.HAS_TKEEP  
  PARAM_VALUE.HAS_TSTRB PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.TDATA_NUM_BYTES PARAM_VALUE.TDEST_WIDTH  
  PARAM_VALUE.TID_WIDTH PARAM_VALUE.TKEEP_WIDTH  
  PARAM_VALUE.TSTRB_WIDTH PARAM_VALUE.TUSER_WIDTH} {
	return "FIFO Width:[get_metaparam_value Calculated_Width_axis]      "
}

proc FIFO_Width_wdch_updated {PARAM_VALUE.DATA_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL  
  PARAM_VALUE.WUSER_WIDTH} {
	return "FIFO Width:[get_metaparam_value Calculated_Width_wdch]      "
}

proc FIFO_Width_rdch_updated {PARAM_VALUE.DATA_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PARAM_VALUE.RUSER_WIDTH} {
	return "FIFO Width:[get_metaparam_value Calculated_Width_rdch]      "
}

proc FIFO_Width_wach_updated {PARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.AWUSER_WIDTH  
  PARAM_VALUE.ID_WIDTH PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.PROTOCOL} {
	return "FIFO Width:[get_metaparam_value Calculated_Width_wach]      "
}

proc FIFO_Width_rach_updated {PARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.ARUSER_WIDTH  
  PARAM_VALUE.ID_WIDTH PARAM_VALUE.INTERFACE_TYPE  PARAM_VALUE.PROTOCOL} {
	return "FIFO Width:[get_metaparam_value Calculated_Width_rach]      "
}


proc FIFO_Depth_wrch_updated { PARAM_VALUE.ENABLE_ECC_WRCH PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH  
  PARAM_VALUE.INPUT_DEPTH_WRCH PARAM_VALUE.BUSER_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PROJECT_PARAM.ARCHITECTURE} {
	
	set calc_depth_wrch [Calculated_Depth_wrch ${PARAM_VALUE.ENABLE_ECC_WRCH} ${PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH} ${PARAM_VALUE.INPUT_DEPTH_WRCH} ${PARAM_VALUE.BUSER_WIDTH} ${PARAM_VALUE.ID_WIDTH} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.PROTOCOL} ${PROJECT_PARAM.ARCHITECTURE}]
  
	return "Actual FIFO Depth : $calc_depth_wrch"
}

proc FIFO_Depth_axis_updated { PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS PARAM_VALUE.ENABLE_ECC_AXIS PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS  
  PARAM_VALUE.INPUT_DEPTH_AXIS PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.HAS_TKEEP  
  PARAM_VALUE.HAS_TSTRB PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.TDATA_NUM_BYTES PARAM_VALUE.TDEST_WIDTH  
  PARAM_VALUE.TID_WIDTH PARAM_VALUE.TKEEP_WIDTH  
  PARAM_VALUE.TSTRB_WIDTH PARAM_VALUE.TUSER_WIDTH PROJECT_PARAM.ARCHITECTURE} {
	
	set calc_depth_axis [Calculated_Depth_axis ${PARAM_VALUE.ENABLE_ECC_AXIS} ${PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} ${PARAM_VALUE.INPUT_DEPTH_AXIS} ${PARAM_VALUE.ENABLE_TLAST} ${PARAM_VALUE.HAS_TKEEP} ${PARAM_VALUE.HAS_TSTRB} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.TDATA_NUM_BYTES} ${PARAM_VALUE.TDEST_WIDTH} ${PARAM_VALUE.TID_WIDTH} ${PARAM_VALUE.TKEEP_WIDTH} ${PARAM_VALUE.TSTRB_WIDTH} ${PARAM_VALUE.TUSER_WIDTH} ${PROJECT_PARAM.ARCHITECTURE}]
  
	;# Fix for CR: 731422
	# if { ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS} ] == "Packet_FIFO") } {
		# set FIFO_Depth_axis_val  [expr {$calc_depth_axis + 1}]
	# } else {
		# set FIFO_Depth_axis_val  $calc_depth_axis
	# }
	set FIFO_Depth_axis_val  $calc_depth_axis
	return "Actual FIFO Depth : $FIFO_Depth_axis_val"
}

proc FIFO_Depth_wach_updated { PARAM_VALUE.ENABLE_ECC_WACH PARAM_VALUE.FIFO_IMPLEMENTATION_WACH  
  PARAM_VALUE.INPUT_DEPTH_WACH PARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.AWUSER_WIDTH 
	PARAM_VALUE.ID_WIDTH PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PROJECT_PARAM.ARCHITECTURE} {
	
	set calc_depth_wach [Calculated_Depth_wach ${PARAM_VALUE.ENABLE_ECC_WACH} ${PARAM_VALUE.FIFO_IMPLEMENTATION_WACH} ${PARAM_VALUE.INPUT_DEPTH_WACH} ${PARAM_VALUE.ADDRESS_WIDTH} ${PARAM_VALUE.AWUSER_WIDTH} ${PARAM_VALUE.ID_WIDTH} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.PROTOCOL} ${PROJECT_PARAM.ARCHITECTURE}]
	
	return "Actual FIFO Depth : $calc_depth_wach"
}


proc FIFO_Depth_rach_updated { PARAM_VALUE.ENABLE_ECC_RACH PARAM_VALUE.FIFO_IMPLEMENTATION_RACH  
  PARAM_VALUE.INPUT_DEPTH_RACH PARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.ARUSER_WIDTH  
  PARAM_VALUE.ID_WIDTH PARAM_VALUE.INTERFACE_TYPE  PARAM_VALUE.PROTOCOL PROJECT_PARAM.ARCHITECTURE} {
	
	set calc_depth_rach [Calculated_Depth_rach ${PARAM_VALUE.ENABLE_ECC_RACH} ${PARAM_VALUE.FIFO_IMPLEMENTATION_RACH} ${PARAM_VALUE.INPUT_DEPTH_RACH} ${PARAM_VALUE.ADDRESS_WIDTH} ${PARAM_VALUE.ARUSER_WIDTH} ${PARAM_VALUE.ID_WIDTH} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.PROTOCOL} ${PROJECT_PARAM.ARCHITECTURE}]
  
	return "Actual FIFO Depth : $calc_depth_rach"
}


proc FIFO_Depth_wdch_updated { PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS PARAM_VALUE.ENABLE_ECC_WDCH PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH  
  PARAM_VALUE.INPUT_DEPTH_WDCH PARAM_VALUE.DATA_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL  
  PARAM_VALUE.WUSER_WIDTH PROJECT_PARAM.ARCHITECTURE} {
	
	set calc_depth_wdch [Calculated_Depth_wdch ${PARAM_VALUE.ENABLE_ECC_WDCH} ${PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH} ${PARAM_VALUE.INPUT_DEPTH_WDCH} ${PARAM_VALUE.DATA_WIDTH} ${PARAM_VALUE.ID_WIDTH} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.PROTOCOL} ${PARAM_VALUE.WUSER_WIDTH} ${PROJECT_PARAM.ARCHITECTURE}]
  
	return "Actual FIFO Depth : $calc_depth_wdch"
}

proc FIFO_Depth_rdch_updated { PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS PARAM_VALUE.ENABLE_ECC_RDCH PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH  
  PARAM_VALUE.INPUT_DEPTH_RDCH PARAM_VALUE.DATA_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PARAM_VALUE.RUSER_WIDTH PROJECT_PARAM.ARCHITECTURE} {
	
	set calc_depth_rdch [Calculated_Depth_rdch ${PARAM_VALUE.ENABLE_ECC_RDCH} ${PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH} ${PARAM_VALUE.INPUT_DEPTH_RDCH} ${PARAM_VALUE.DATA_WIDTH} ${PARAM_VALUE.ID_WIDTH} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.PROTOCOL} ${PARAM_VALUE.RUSER_WIDTH} ${PROJECT_PARAM.ARCHITECTURE}]
  
	return "Actual FIFO Depth : $calc_depth_rdch"
}


proc cal_width_wrch_updated { PARAM_VALUE.WRCH_TYPE PARAM_VALUE.FIFO_APPLICATION_TYPE_WRCH PARAM_VALUE.BUSER_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PARAM_VALUE.ENABLE_ECC_WRCH PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH  
  PARAM_VALUE.INPUT_DEPTH_WRCH PROJECT_PARAM.ARCHITECTURE} {
	set fifo_type [ get_property value ${PARAM_VALUE.WRCH_TYPE} ]
	if { $fifo_type == "Register_Slice" || $fifo_type == "Pass_Through_Wire" } {
		return "[get_metaparam_value Calculated_Width_wrch] / NA" 
	} else {
		set calc_depth_wrch [Calculated_Depth_wrch ${PARAM_VALUE.ENABLE_ECC_WRCH} ${PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH} ${PARAM_VALUE.INPUT_DEPTH_WRCH} ${PARAM_VALUE.BUSER_WIDTH} ${PARAM_VALUE.ID_WIDTH} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.PROTOCOL} ${PROJECT_PARAM.ARCHITECTURE}]

		if { ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WRCH} ] == "Packet_FIFO") } {
			set FIFO_Depth_wrch_val  [expr {$calc_depth_wrch + 1}]
		} else {
			set FIFO_Depth_wrch_val  $calc_depth_wrch
		}
		return "[get_metaparam_value Calculated_Width_wrch] / $FIFO_Depth_wrch_val" 
	}
}

proc cal_width_axis_updated { PARAM_VALUE.AXIS_TYPE PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.HAS_TKEEP  
  PARAM_VALUE.HAS_TSTRB PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.TDATA_NUM_BYTES PARAM_VALUE.TDEST_WIDTH  
  PARAM_VALUE.TID_WIDTH PARAM_VALUE.TKEEP_WIDTH  
  PARAM_VALUE.TSTRB_WIDTH PARAM_VALUE.TUSER_WIDTH PARAM_VALUE.ENABLE_ECC_AXIS PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS  
  PARAM_VALUE.INPUT_DEPTH_AXIS PROJECT_PARAM.ARCHITECTURE} {
	
	set fifo_type [ get_property value ${PARAM_VALUE.AXIS_TYPE} ]
	if { $fifo_type == "Register_Slice" || $fifo_type == "Pass_Through_Wire" } {
#		return "[get_metaparam_value Calculated_Width_axis] / NA" 
set w_text "[get_metaparam_value Calculated_Width_axis] / NA"
	} else {
#send_msg INFO 921 "! "

		set calc_depth_axis [Calculated_Depth_axis ${PARAM_VALUE.ENABLE_ECC_AXIS} ${PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} ${PARAM_VALUE.INPUT_DEPTH_AXIS} ${PARAM_VALUE.ENABLE_TLAST} ${PARAM_VALUE.HAS_TKEEP} ${PARAM_VALUE.HAS_TSTRB} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.TDATA_NUM_BYTES} ${PARAM_VALUE.TDEST_WIDTH} ${PARAM_VALUE.TID_WIDTH} ${PARAM_VALUE.TKEEP_WIDTH} ${PARAM_VALUE.TSTRB_WIDTH} ${PARAM_VALUE.TUSER_WIDTH} ${PROJECT_PARAM.ARCHITECTURE}]
#send_msg INFO 921 "$calc_depth_axis "

		if { ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_AXIS} ] == "Packet_FIFO") } {
			set FIFO_Depth_axis_val  [expr {$calc_depth_axis + 1}]
		} else {
			set FIFO_Depth_axis_val  $calc_depth_axis
		}
		set value [get_metaparam_value Calculated_Width_axis]
                set w_text "$value / $FIFO_Depth_axis_val" 
		#return "$value / $FIFO_Depth_axis_val" 
	}
		
return $w_text
}


proc cal_width_wdch_updated { PARAM_VALUE.WDCH_TYPE PARAM_VALUE.FIFO_APPLICATION_TYPE_WDCH PARAM_VALUE.DATA_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL  
  PARAM_VALUE.WUSER_WIDTH PARAM_VALUE.ENABLE_ECC_WDCH PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH  
  PARAM_VALUE.INPUT_DEPTH_WDCH PROJECT_PARAM.ARCHITECTURE} {
			
	set fifo_type [ get_property value ${PARAM_VALUE.WDCH_TYPE} ]
	if { $fifo_type == "Register_Slice" || $fifo_type == "Pass_Through_Wire" } {
		return "[get_metaparam_value Calculated_Width_wdch] / NA" 
	} else {
		set calc_depth_wdch [Calculated_Depth_wdch ${PARAM_VALUE.ENABLE_ECC_WDCH} ${PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH} ${PARAM_VALUE.INPUT_DEPTH_WDCH} ${PARAM_VALUE.DATA_WIDTH} ${PARAM_VALUE.ID_WIDTH} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.PROTOCOL} ${PARAM_VALUE.WUSER_WIDTH} ${PROJECT_PARAM.ARCHITECTURE}]

		if { ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WDCH} ] == "Packet_FIFO") } {
			set FIFO_Depth_wdch_val  [expr {$calc_depth_wdch + 1}]
		} else {
			set FIFO_Depth_wdch_val  $calc_depth_wdch
		}
		set value [get_metaparam_value Calculated_Width_wdch]
		return "$value / $FIFO_Depth_wdch_val" 
	}
}

proc cal_width_rdch_updated { PARAM_VALUE.RDCH_TYPE PARAM_VALUE.FIFO_APPLICATION_TYPE_RDCH PARAM_VALUE.DATA_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PARAM_VALUE.RUSER_WIDTH PARAM_VALUE.ENABLE_ECC_RDCH PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH  
  PARAM_VALUE.INPUT_DEPTH_RDCH PROJECT_PARAM.ARCHITECTURE} {  
			
	set fifo_type [ get_property value ${PARAM_VALUE.RDCH_TYPE} ]
	if { $fifo_type == "Register_Slice" || $fifo_type == "Pass_Through_Wire" } {
		return "[get_metaparam_value Calculated_Width_rdch] / NA" 
	} else {
		set calc_depth_rdch [Calculated_Depth_rdch ${PARAM_VALUE.ENABLE_ECC_RDCH} ${PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH} ${PARAM_VALUE.INPUT_DEPTH_RDCH} \
		${PARAM_VALUE.DATA_WIDTH} ${PARAM_VALUE.ID_WIDTH} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.PROTOCOL} ${PARAM_VALUE.RUSER_WIDTH} ${PROJECT_PARAM.ARCHITECTURE}]

		if { ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RDCH} ] == "Packet_FIFO") } {
			set FIFO_Depth_rdch_val  [expr {$calc_depth_rdch + 1}]
		} else {
			set FIFO_Depth_rdch_val  $calc_depth_rdch
		}
		set value [get_metaparam_value Calculated_Width_rdch]
		return "$value / $FIFO_Depth_rdch_val" 
	}
}

proc cal_width_wach_updated { PARAM_VALUE.WACH_TYPE PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH PARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.AWUSER_WIDTH  
  PARAM_VALUE.ID_WIDTH PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.PROTOCOL PARAM_VALUE.ENABLE_ECC_WACH PARAM_VALUE.FIFO_IMPLEMENTATION_WACH  
  PARAM_VALUE.INPUT_DEPTH_WACH PROJECT_PARAM.ARCHITECTURE} {

	set fifo_type [ get_property value ${PARAM_VALUE.WACH_TYPE} ]
	if { $fifo_type == "Register_Slice" || $fifo_type == "Pass_Through_Wire" } {
		return "[get_metaparam_value Calculated_Width_wach] / NA" 
	} else {
		set calc_depth_wach [Calculated_Depth_wach ${PARAM_VALUE.ENABLE_ECC_WACH} ${PARAM_VALUE.FIFO_IMPLEMENTATION_WACH} ${PARAM_VALUE.INPUT_DEPTH_WACH} \
		${PARAM_VALUE.ADDRESS_WIDTH} ${PARAM_VALUE.AWUSER_WIDTH} ${PARAM_VALUE.ID_WIDTH} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.PROTOCOL} ${PROJECT_PARAM.ARCHITECTURE}]
		
		if { ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_WACH} ] == "Packet_FIFO") } {
			set FIFO_Depth_wach_val  [expr {$calc_depth_wach + 1}]
		} else {
			set FIFO_Depth_wach_val  $calc_depth_wach
		}
		set value [get_metaparam_value Calculated_Width_wach]
		return "$value / $FIFO_Depth_wach_val" 
	}
		
}

proc cal_width_rach_updated { PARAM_VALUE.RACH_TYPE PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH PARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.ARUSER_WIDTH  
  PARAM_VALUE.ID_WIDTH PARAM_VALUE.INTERFACE_TYPE  PARAM_VALUE.PROTOCOL PARAM_VALUE.ENABLE_ECC_RACH PARAM_VALUE.FIFO_IMPLEMENTATION_RACH  
  PARAM_VALUE.INPUT_DEPTH_RACH PROJECT_PARAM.ARCHITECTURE} {

	set fifo_type [ get_property value ${PARAM_VALUE.RACH_TYPE} ]
	if { $fifo_type == "Register_Slice" || $fifo_type == "Pass_Through_Wire" } {
		return "[get_metaparam_value Calculated_Width_rach] / NA" 
	} else {
		set calc_depth_rach [Calculated_Depth_rach ${PARAM_VALUE.ENABLE_ECC_RACH} ${PARAM_VALUE.FIFO_IMPLEMENTATION_RACH} ${PARAM_VALUE.INPUT_DEPTH_RACH} \
		${PARAM_VALUE.ADDRESS_WIDTH} ${PARAM_VALUE.ARUSER_WIDTH} ${PARAM_VALUE.ID_WIDTH} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.PROTOCOL} ${PROJECT_PARAM.ARCHITECTURE}]

		if { ([ get_property value ${PARAM_VALUE.FIFO_APPLICATION_TYPE_RACH} ] == "Packet_FIFO") } {
			set FIFO_Depth_rach_val  [expr {$calc_depth_rach + 1}]
		} else {
			set FIFO_Depth_rach_val  $calc_depth_rach
		}
		set value [get_metaparam_value Calculated_Width_rach]
		return "$value / $FIFO_Depth_rach_val" 
	}
}


proc Config_Type_wrch_updated { PARAM_VALUE.WRCH_TYPE} {
	return "[ get_property value ${PARAM_VALUE.WRCH_TYPE} ]"
}

proc Config_Type_axis_updated { PARAM_VALUE.AXIS_TYPE} {
	return "[ get_property value ${PARAM_VALUE.AXIS_TYPE} ]"
}

proc Config_Type_wdch_updated { PARAM_VALUE.WDCH_TYPE} {
	return "[ get_property value ${PARAM_VALUE.WDCH_TYPE} ]"
}

proc Config_Type_rdch_updated { PARAM_VALUE.RDCH_TYPE} {
	return "[ get_property value ${PARAM_VALUE.RDCH_TYPE} ]"
}

proc Config_Type_wach_updated { PARAM_VALUE.WACH_TYPE} {
	return "[ get_property value ${PARAM_VALUE.WACH_TYPE} ]"
}

proc Config_Type_rach_updated { PARAM_VALUE.RACH_TYPE} {
	return "[ get_property value ${PARAM_VALUE.RACH_TYPE} ]"
}


proc Data_Count_Info_wrch_updated { PARAM_VALUE.ENABLE_DATA_COUNTS_WRCH PARAM_VALUE.WRCH_TYPE} {
	if {[ get_property value ${PARAM_VALUE.WRCH_TYPE} ] == "FIFO" } {				   
		   
		if {[ get_property value ${PARAM_VALUE.ENABLE_DATA_COUNTS_WRCH} ] } {
			return "Selected"
		} else {
			return "Not Selected"
		}
	}
}

proc Data_Count_Info_axis_updated { PARAM_VALUE.AXIS_TYPE PARAM_VALUE.ENABLE_DATA_COUNTS_AXIS} {
	if {[ get_property value ${PARAM_VALUE.AXIS_TYPE} ] == "FIFO" } {				   
		   
		if {[ get_property value ${PARAM_VALUE.ENABLE_DATA_COUNTS_AXIS} ] } {
			return "Selected"
		} else {
			return "Not Selected"
		}
	}

}


proc Data_Count_Info_wdch_updated { PARAM_VALUE.ENABLE_DATA_COUNTS_WDCH PARAM_VALUE.WDCH_TYPE} {

	if {[ get_property value ${PARAM_VALUE.WDCH_TYPE} ] == "FIFO" } {				   
		   
		if {[ get_property value ${PARAM_VALUE.ENABLE_DATA_COUNTS_WDCH} ] } {
			return "Selected"
		} else {
			return "Not Selected"
		}
	}

}

proc Data_Count_Info_rdch_updated { PARAM_VALUE.ENABLE_DATA_COUNTS_RDCH PARAM_VALUE.RDCH_TYPE} {

	if {[ get_property value ${PARAM_VALUE.RDCH_TYPE} ] == "FIFO" } {				   
		   
		if {[ get_property value ${PARAM_VALUE.ENABLE_DATA_COUNTS_RDCH} ] } {
			return "Selected"
		} else {
			return "Not Selected"
		}
	}

}

proc Data_Count_Info_wach_updated { PARAM_VALUE.ENABLE_DATA_COUNTS_WACH PARAM_VALUE.WACH_TYPE} {

	if {[ get_property value ${PARAM_VALUE.WACH_TYPE} ] == "FIFO" } {				   
		   
		if {[ get_property value ${PARAM_VALUE.ENABLE_DATA_COUNTS_WACH} ] } {
			return "Selected"
		} else {
			return "Not Selected"
		}
	}

}

proc Data_Count_Info_rach_updated { PARAM_VALUE.ENABLE_DATA_COUNTS_RACH PARAM_VALUE.RACH_TYPE} {

	if {[ get_property value ${PARAM_VALUE.RACH_TYPE} ] == "FIFO" } {				   
		   
		if {[ get_property value ${PARAM_VALUE.ENABLE_DATA_COUNTS_RACH} ] } {
			return "Selected"
		} else {
			return "Not Selected"
		}
	}

}


proc Flags_wdch_updated { PARAM_VALUE.OVERFLOW_FLAG_AXI PARAM_VALUE.UNDERFLOW_FLAG_AXI  
  PARAM_VALUE.WDCH_TYPE} {
	if {[ get_property value ${PARAM_VALUE.WDCH_TYPE} ] == "FIFO" } {				   
		set Underflow_Flag_AXI [ get_property value ${PARAM_VALUE.UNDERFLOW_FLAG_AXI} ]
		set Overflow_Flag_AXI [ get_property value ${PARAM_VALUE.OVERFLOW_FLAG_AXI} ]
		
		if {$Underflow_Flag_AXI && $Overflow_Flag_AXI  } {
			return "Selected / Selected"
		} elseif {$Underflow_Flag_AXI && !$Overflow_Flag_AXI  } {
			return "Selected/Not Selected"
		} elseif {!$Underflow_Flag_AXI && $Overflow_Flag_AXI  } {
			return "Not Selected / Selected"
		} else {
			return "Not Selected / Not Selected"
		}
	}
}

proc Flags_rdch_updated { PARAM_VALUE.OVERFLOW_FLAG_AXI PARAM_VALUE.RDCH_TYPE  
  PARAM_VALUE.UNDERFLOW_FLAG_AXI} {
	if {[ get_property value ${PARAM_VALUE.RDCH_TYPE} ] == "FIFO" } {				   
		set Underflow_Flag_AXI [ get_property value ${PARAM_VALUE.UNDERFLOW_FLAG_AXI} ]
		set Overflow_Flag_AXI [ get_property value ${PARAM_VALUE.OVERFLOW_FLAG_AXI} ]
		
		if {$Underflow_Flag_AXI && $Overflow_Flag_AXI  } {
			return "Selected / Selected"
		} elseif {$Underflow_Flag_AXI && !$Overflow_Flag_AXI  } {
			return "Selected/Not Selected"
		} elseif {!$Underflow_Flag_AXI && $Overflow_Flag_AXI  } {
			return "Not Selected / Selected"
		} else {
			return "Not Selected / Not Selected"
		}
	}
}

proc Flags_wach_updated { PARAM_VALUE.OVERFLOW_FLAG_AXI PARAM_VALUE.UNDERFLOW_FLAG_AXI  
  PARAM_VALUE.WACH_TYPE} {
	if {[ get_property value ${PARAM_VALUE.WACH_TYPE} ] == "FIFO" } {				   
		set Underflow_Flag_AXI [ get_property value ${PARAM_VALUE.UNDERFLOW_FLAG_AXI} ]
		set Overflow_Flag_AXI [ get_property value ${PARAM_VALUE.OVERFLOW_FLAG_AXI} ]
		
		if {$Underflow_Flag_AXI && $Overflow_Flag_AXI  } {
			return "Selected / Selected"
		} elseif {$Underflow_Flag_AXI && !$Overflow_Flag_AXI  } {
			return "Selected/Not Selected"
		} elseif {!$Underflow_Flag_AXI && $Overflow_Flag_AXI  } {
			return "Not Selected / Selected"
		} else {
			return "Not Selected / Not Selected"
		}
	}
}

proc Flags_rach_updated { PARAM_VALUE.OVERFLOW_FLAG_AXI PARAM_VALUE.RACH_TYPE  
  PARAM_VALUE.UNDERFLOW_FLAG_AXI} {
	if {[ get_property value ${PARAM_VALUE.RACH_TYPE} ] == "FIFO" } {				   
		set Underflow_Flag_AXI [ get_property value ${PARAM_VALUE.UNDERFLOW_FLAG_AXI} ]
		set Overflow_Flag_AXI [ get_property value ${PARAM_VALUE.OVERFLOW_FLAG_AXI} ]
		
		if {$Underflow_Flag_AXI && $Overflow_Flag_AXI  } {
			return "Selected / Selected"
		} elseif {$Underflow_Flag_AXI && !$Overflow_Flag_AXI  } {
			return "Selected/Not Selected"
		} elseif {!$Underflow_Flag_AXI && $Overflow_Flag_AXI  } {
			return "Not Selected / Selected"
		} else {
			return "Not Selected / Not Selected"
		}
	}
}

proc Flags_wrch_updated { PARAM_VALUE.OVERFLOW_FLAG_AXI PARAM_VALUE.UNDERFLOW_FLAG_AXI  
  PARAM_VALUE.WRCH_TYPE} {

	if {[ get_property value ${PARAM_VALUE.WRCH_TYPE} ] == "FIFO" } {				   
		set Underflow_Flag_AXI [ get_property value ${PARAM_VALUE.UNDERFLOW_FLAG_AXI} ]
		set Overflow_Flag_AXI [ get_property value ${PARAM_VALUE.OVERFLOW_FLAG_AXI} ]
		
		if {$Underflow_Flag_AXI && $Overflow_Flag_AXI  } {
			return "Selected / Selected"
		} elseif {$Underflow_Flag_AXI && !$Overflow_Flag_AXI  } {
			return "Selected/Not Selected"
		} elseif {!$Underflow_Flag_AXI && $Overflow_Flag_AXI  } {
			return "Not Selected / Selected"
		} else {
			return "Not Selected / Not Selected"
		}
	}
}

proc Flags_axis_updated { PARAM_VALUE.AXIS_TYPE PARAM_VALUE.OVERFLOW_FLAG_AXI  
  PARAM_VALUE.UNDERFLOW_FLAG_AXI} {

	if {[ get_property value ${PARAM_VALUE.AXIS_TYPE} ] == "FIFO" } {				   
		set Underflow_Flag_AXI [ get_property value ${PARAM_VALUE.UNDERFLOW_FLAG_AXI} ]
		set Overflow_Flag_AXI [ get_property value ${PARAM_VALUE.OVERFLOW_FLAG_AXI} ]
		
		if {$Underflow_Flag_AXI && $Overflow_Flag_AXI  } {
			return "Selected / Selected"
		} elseif {$Underflow_Flag_AXI && !$Overflow_Flag_AXI  } {
			return "Selected/Not Selected"
		} elseif {!$Underflow_Flag_AXI && $Overflow_Flag_AXI  } {
			return "Not Selected / Selected"
		} else {
			return "Not Selected / Not Selected"
		}
	}
}


proc BRAM_Res_wdch_updated { PARAM_VALUE.ENABLE_ECC_WDCH PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH  
  PARAM_VALUE.INPUT_DEPTH_WDCH PARAM_VALUE.WDCH_TYPE PARAM_VALUE.DATA_WIDTH PARAM_VALUE.ID_WIDTH  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL  
  PARAM_VALUE.WUSER_WIDTH PROJECT_PARAM.ARCHITECTURE} {

	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	
	set Input_Depth_channel [ get_property value ${PARAM_VALUE.INPUT_DEPTH_WDCH} ]
	set Enable_ECC_channel [ get_property value ${PARAM_VALUE.ENABLE_ECC_WDCH} ]
	if {[ get_property value ${PARAM_VALUE.WDCH_TYPE} ] == "FIFO" } {				   
		
		set FIFO_Implementation_fifo_name  [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH} ]
		if { $FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM" || $FIFO_Implementation_fifo_name == "Independent_Clocks_Block_RAM" } {
				
			if {$FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM"} { 
				set is_common_clk 1
			} else {
				set is_common_clk 0
			}
			
			set calc_width_wdch [get_metaparam_value Calculated_Width_wdch]
			if {![isInputDepthValid $calc_width_wdch $Input_Depth_channel]} {
				return ""
			}
			set brams_val_18 [fifo_generator_v12_0_utils::get_Estimated_BlockRAM_Usage_x $c_family $is_common_clk  $calc_width_wdch  $Input_Depth_channel $calc_width_wdch $Input_Depth_channel $Enable_ECC_channel 18]
			#puts "bramval18 $brams_val_18"
			set brams_val_36 [fifo_generator_v12_0_utils::get_Estimated_BlockRAM_Usage_x $c_family $is_common_clk $calc_width_wdch  $Input_Depth_channel $calc_width_wdch $Input_Depth_channel $Enable_ECC_channel 36]
			#puts "bramval36 $brams_val_36"
			return "BRAM Resource (s) (18K/36K) : $brams_val_18/$brams_val_36"
		} else {
			return "BRAM Resource (s) (18K/36K) : N/A"
		}
	}

}

proc BRAM_Res_rdch_updated { PARAM_VALUE.ENABLE_ECC_RDCH PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH  
PARAM_VALUE.INPUT_DEPTH_RDCH PARAM_VALUE.RDCH_TYPE PARAM_VALUE.DATA_WIDTH PARAM_VALUE.ID_WIDTH  
PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PARAM_VALUE.RUSER_WIDTH PROJECT_PARAM.ARCHITECTURE} {

	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	
	set Input_Depth_channel [ get_property value ${PARAM_VALUE.INPUT_DEPTH_RDCH} ]
	set Enable_ECC_channel [ get_property value ${PARAM_VALUE.ENABLE_ECC_RDCH} ]
	if {[ get_property value ${PARAM_VALUE.RDCH_TYPE} ] == "FIFO" } {				   
		## To Be Verified Again -- dynamic text is not getting displayed for Block RAMs ###  It requires loading a library
		set FIFO_Implementation_fifo_name  [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH} ]
		if { $FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM" || $FIFO_Implementation_fifo_name == "Independent_Clocks_Block_RAM" } {
				
			if {$FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM"} { 
				set is_common_clk 1
			} else {
				set is_common_clk 0
			}
			
			set calc_width_rdch [get_metaparam_value Calculated_Width_rdch]
			if {![isInputDepthValid $calc_width_rdch $Input_Depth_channel]} {
				return ""
			}
			set brams_val_18 [fifo_generator_v12_0_utils::get_Estimated_BlockRAM_Usage_x $c_family $is_common_clk  $calc_width_rdch  $Input_Depth_channel $calc_width_rdch $Input_Depth_channel $Enable_ECC_channel 18]
			#puts "bramval18 $brams_val_18"
			set brams_val_36 [fifo_generator_v12_0_utils::get_Estimated_BlockRAM_Usage_x $c_family $is_common_clk $calc_width_rdch  $Input_Depth_channel $calc_width_rdch $Input_Depth_channel $Enable_ECC_channel 36]
			#puts "bramval36 $brams_val_36"
			return "BRAM Resource (s) (18K/36K) : $brams_val_18/$brams_val_36"
		} else {
			return "BRAM Resource (s) (18K/36K) : N/A"
		}
	}

}

proc BRAM_Res_wach_updated { PARAM_VALUE.ENABLE_ECC_WACH PARAM_VALUE.FIFO_IMPLEMENTATION_WACH  
PARAM_VALUE.INPUT_DEPTH_WACH PARAM_VALUE.WACH_TYPE PARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.AWUSER_WIDTH  
PARAM_VALUE.ID_WIDTH PARAM_VALUE.INTERFACE_TYPE  
PARAM_VALUE.PROTOCOL PROJECT_PARAM.ARCHITECTURE} {

	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	
	set Input_Depth_channel [ get_property value ${PARAM_VALUE.INPUT_DEPTH_WACH} ]
	set Enable_ECC_channel [ get_property value ${PARAM_VALUE.ENABLE_ECC_WACH} ]
	if {[ get_property value ${PARAM_VALUE.WACH_TYPE} ] == "FIFO" } {				   
		## To Be Verified Again -- dynamic text is not getting displayed for Block RAMs ###  It requires loading a library
		set FIFO_Implementation_fifo_name  [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WACH} ]
		if { $FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM" || $FIFO_Implementation_fifo_name == "Independent_Clocks_Block_RAM" } {
				
			if {$FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM"} { 
				set is_common_clk 1
			} else {
				set is_common_clk 0
			}
			
			set calc_width_wach [get_metaparam_value Calculated_Width_wach]
			if {![isInputDepthValid $calc_width_wach $Input_Depth_channel]} {
				return ""
			}
			set brams_val_18 [fifo_generator_v12_0_utils::get_Estimated_BlockRAM_Usage_x $c_family $is_common_clk  $calc_width_wach  $Input_Depth_channel $calc_width_wach $Input_Depth_channel $Enable_ECC_channel 18]
			#puts "bramval18 $brams_val_18"
			set brams_val_36 [fifo_generator_v12_0_utils::get_Estimated_BlockRAM_Usage_x $c_family $is_common_clk $calc_width_wach  $Input_Depth_channel $calc_width_wach $Input_Depth_channel $Enable_ECC_channel 36]
			#puts "bramval36 $brams_val_36"
			return "BRAM Resource (s) (18K/36K) : $brams_val_18/$brams_val_36"
		} else {
			return "BRAM Resource (s) (18K/36K) : N/A"
		}
	}

}

proc BRAM_Res_rach_updated { PARAM_VALUE.ENABLE_ECC_RACH PARAM_VALUE.FIFO_IMPLEMENTATION_RACH  
PARAM_VALUE.INPUT_DEPTH_RACH PARAM_VALUE.RACH_TYPE PARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.ARUSER_WIDTH  
PARAM_VALUE.ID_WIDTH PARAM_VALUE.INTERFACE_TYPE  PARAM_VALUE.PROTOCOL PROJECT_PARAM.ARCHITECTURE} {

	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	
	set Input_Depth_channel [ get_property value ${PARAM_VALUE.INPUT_DEPTH_RACH} ]
	set Enable_ECC_channel [ get_property value ${PARAM_VALUE.ENABLE_ECC_RACH} ]
	if {[ get_property value ${PARAM_VALUE.RACH_TYPE} ] == "FIFO" } {				   
		## To Be Verified Again -- dynamic text is not getting displayed for Block RAMs ###  It requires loading a library
		set FIFO_Implementation_fifo_name  [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_RACH} ]
		if { $FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM" || $FIFO_Implementation_fifo_name == "Independent_Clocks_Block_RAM" } {
				
			if {$FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM"} { 
				set is_common_clk 1
			} else {
				set is_common_clk 0
			}
			
			set calc_width_rach [get_metaparam_value Calculated_Width_rach]
			if {![isInputDepthValid $calc_width_rach $Input_Depth_channel]} {
				return ""
			}
			set brams_val_18 [fifo_generator_v12_0_utils::get_Estimated_BlockRAM_Usage_x $c_family $is_common_clk  $calc_width_rach  $Input_Depth_channel $calc_width_rach $Input_Depth_channel $Enable_ECC_channel 18]
			#puts "bramval18 $brams_val_18"
			set brams_val_36 [fifo_generator_v12_0_utils::get_Estimated_BlockRAM_Usage_x $c_family $is_common_clk $calc_width_rach  $Input_Depth_channel $calc_width_rach $Input_Depth_channel $Enable_ECC_channel 36]
			#puts "bramval36 $brams_val_36"
			return "BRAM Resource (s) (18K/36K) : $brams_val_18/$brams_val_36"
		} else {
			return "BRAM Resource (s) (18K/36K) : N/A"
		}
	}

}

proc BRAM_Res_wrch_updated { PARAM_VALUE.ENABLE_ECC_WRCH PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH  
PARAM_VALUE.INPUT_DEPTH_WRCH PARAM_VALUE.WRCH_TYPE PARAM_VALUE.BUSER_WIDTH PARAM_VALUE.ID_WIDTH  
PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PROTOCOL PROJECT_PARAM.ARCHITECTURE} {

	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	
	set Input_Depth_channel [ get_property value ${PARAM_VALUE.INPUT_DEPTH_WRCH} ]
	set Enable_ECC_channel [ get_property value ${PARAM_VALUE.ENABLE_ECC_WRCH} ]
	if {[ get_property value ${PARAM_VALUE.WRCH_TYPE} ] == "FIFO" } {				   
		## To Be Verified Again -- dynamic text is not getting displayed for Block RAMs ###  It requires loading a library
		set FIFO_Implementation_fifo_name  [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH} ]
		if { $FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM" || $FIFO_Implementation_fifo_name == "Independent_Clocks_Block_RAM" } {
				
			if {$FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM"} { 
				set is_common_clk 1
			} else {
				set is_common_clk 0
			}
			
			set calc_width_wrch [get_metaparam_value Calculated_Width_wrch]
			if {![isInputDepthValid $calc_width_wrch $Input_Depth_channel]} {
				return ""
			}
			set brams_val_18 [fifo_generator_v12_0_utils::get_Estimated_BlockRAM_Usage_x $c_family $is_common_clk  $calc_width_wrch  $Input_Depth_channel $calc_width_wrch $Input_Depth_channel $Enable_ECC_channel 18]
			#puts "bramval18 $brams_val_18"
			set brams_val_36 [fifo_generator_v12_0_utils::get_Estimated_BlockRAM_Usage_x $c_family $is_common_clk $calc_width_wrch  $Input_Depth_channel $calc_width_wrch $Input_Depth_channel $Enable_ECC_channel 36]
			#puts "bramval36 $brams_val_36"
			return "BRAM Resource (s) (18K/36K) : $brams_val_18/$brams_val_36"
		} else {
			return "BRAM Resource (s) (18K/36K) : N/A"
		}
	}

}

proc BRAM_Res_axis_updated { PARAM_VALUE.AXIS_TYPE PARAM_VALUE.ENABLE_ECC_AXIS  
PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS PARAM_VALUE.INPUT_DEPTH_AXIS PARAM_VALUE.ENABLE_TLAST PARAM_VALUE.HAS_TKEEP  
PARAM_VALUE.HAS_TSTRB PARAM_VALUE.INTERFACE_TYPE  
PARAM_VALUE.TDATA_NUM_BYTES PARAM_VALUE.TDEST_WIDTH  
PARAM_VALUE.TID_WIDTH PARAM_VALUE.TKEEP_WIDTH  
PARAM_VALUE.TSTRB_WIDTH PARAM_VALUE.TUSER_WIDTH PROJECT_PARAM.ARCHITECTURE} {

	set c_family [getParentDeviceName ${PROJECT_PARAM.ARCHITECTURE}]
	
	set Input_Depth_channel [ get_property value ${PARAM_VALUE.INPUT_DEPTH_AXIS} ]
	set Enable_ECC_channel [ get_property value ${PARAM_VALUE.ENABLE_ECC_AXIS} ]
	if {[ get_property value ${PARAM_VALUE.AXIS_TYPE} ] == "FIFO" } {				   
		## To Be Verified Again -- dynamic text is not getting displayed for Block RAMs ###  It requires loading a library
		set FIFO_Implementation_fifo_name  [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} ]
		if { $FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM" || $FIFO_Implementation_fifo_name == "Independent_Clocks_Block_RAM" } {
				
			if {$FIFO_Implementation_fifo_name == "Common_Clock_Block_RAM"} { 
				set is_common_clk 1
			} else {
				set is_common_clk 0
			}
			
			set calc_width_axis [get_metaparam_value Calculated_Width_axis]
			if {![isInputDepthValid $calc_width_axis $Input_Depth_channel]} {
				return ""
			}
			set brams_val_18 [fifo_generator_v12_0_utils::get_Estimated_BlockRAM_Usage_x $c_family $is_common_clk  $calc_width_axis  $Input_Depth_channel $calc_width_axis $Input_Depth_channel $Enable_ECC_channel 18]
			#puts "bramval18 $brams_val_18"
			set brams_val_36 [fifo_generator_v12_0_utils::get_Estimated_BlockRAM_Usage_x $c_family $is_common_clk $calc_width_axis  $Input_Depth_channel $calc_width_axis $Input_Depth_channel $Enable_ECC_channel 36]
			#puts "bramval36 $brams_val_36"
			return "BRAM Resource (s) (18K/36K) : $brams_val_18/$brams_val_36"
		} else {
			return "BRAM Resource (s) (18K/36K) : N/A"
		}
	}
		
}

proc Mem_Type_wrch_updated { PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH PARAM_VALUE.WRCH_TYPE} {
	set FIFO_Implementation_channel [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WRCH} ]
	if {[ get_property value ${PARAM_VALUE.WRCH_TYPE} ] == "FIFO" } {				   
		if {$FIFO_Implementation_channel == "Common_Clock_Block_RAM" || $FIFO_Implementation_channel == "Independent_Clocks_Block_RAM" } {
			return "Memory Type:	Block RAM"
		} elseif {$FIFO_Implementation_channel == "Common_Clock_Builtin_FIFO" || $FIFO_Implementation_channel == "Independent_Clocks_Builtin_FIFO" } {
			return "Memory Type:	Built-in"
		} else {
			return "Memory Type:	Distributed RAM"
		}		    		
	} 
}

proc Mem_Type_axis_updated { PARAM_VALUE.AXIS_TYPE PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} {
	set FIFO_Implementation_channel [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_AXIS} ]
	if {[ get_property value ${PARAM_VALUE.AXIS_TYPE} ] == "FIFO" } {				   
		if {$FIFO_Implementation_channel == "Common_Clock_Block_RAM" || $FIFO_Implementation_channel == "Independent_Clocks_Block_RAM" } {
			return "Memory Type:	Block RAM"
		} elseif {$FIFO_Implementation_channel == "Common_Clock_Builtin_FIFO" || $FIFO_Implementation_channel == "Independent_Clocks_Builtin_FIFO" } {
			return "Memory Type:	Built-in"
		} else {
			return "Memory Type:	Distributed RAM"
		}		    		
	} 
}

proc Mem_Type_wdch_updated { PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH PARAM_VALUE.WDCH_TYPE} {
	set FIFO_Implementation_channel [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WDCH} ]
	if {[ get_property value ${PARAM_VALUE.WDCH_TYPE} ] == "FIFO" } {				   
		if {$FIFO_Implementation_channel == "Common_Clock_Block_RAM" || $FIFO_Implementation_channel == "Independent_Clocks_Block_RAM" } {
			return "Memory Type:	Block RAM"
		} elseif {$FIFO_Implementation_channel == "Common_Clock_Builtin_FIFO" || $FIFO_Implementation_channel == "Independent_Clocks_Builtin_FIFO" } {
			return "Memory Type:	Built-in"
		} else {
			return "Memory Type:	Distributed RAM"
		}		    		
	} 
}

proc Mem_Type_rdch_updated { PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH PARAM_VALUE.RDCH_TYPE} {
	set FIFO_Implementation_channel [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_RDCH} ]
	if {[ get_property value ${PARAM_VALUE.RDCH_TYPE} ] == "FIFO" } {				   
		if {$FIFO_Implementation_channel == "Common_Clock_Block_RAM" || $FIFO_Implementation_channel == "Independent_Clocks_Block_RAM" } {
			return "Memory Type:	Block RAM"
		} elseif {$FIFO_Implementation_channel == "Common_Clock_Builtin_FIFO" || $FIFO_Implementation_channel == "Independent_Clocks_Builtin_FIFO" } {
			return "Memory Type:	Built-in"
		} else {
			return "Memory Type:	Distributed RAM"
		}		    		
	} 
}

proc Mem_Type_wach_updated { PARAM_VALUE.FIFO_IMPLEMENTATION_WACH PARAM_VALUE.WACH_TYPE} {
	set FIFO_Implementation_channel [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_WACH} ]
	if {[ get_property value ${PARAM_VALUE.WACH_TYPE} ] == "FIFO" } {				   
		if {$FIFO_Implementation_channel == "Common_Clock_Block_RAM" || $FIFO_Implementation_channel == "Independent_Clocks_Block_RAM" } {
			return "Memory Type:	Block RAM"
		} elseif {$FIFO_Implementation_channel == "Common_Clock_Builtin_FIFO" || $FIFO_Implementation_channel == "Independent_Clocks_Builtin_FIFO" } {
			return "Memory Type:	Built-in"
		} else {
			return "Memory Type:	Distributed RAM"
		}		    		
	} 
}

proc Mem_Type_rach_updated { PARAM_VALUE.FIFO_IMPLEMENTATION_RACH PARAM_VALUE.RACH_TYPE} {
	set FIFO_Implementation_channel [ get_property value ${PARAM_VALUE.FIFO_IMPLEMENTATION_RACH} ]
	if {[ get_property value ${PARAM_VALUE.RACH_TYPE} ] == "FIFO" } {				   
		if {$FIFO_Implementation_channel == "Common_Clock_Block_RAM" || $FIFO_Implementation_channel == "Independent_Clocks_Block_RAM" } {
			return "Memory Type:	Block RAM"
		} elseif {$FIFO_Implementation_channel == "Common_Clock_Builtin_FIFO" || $FIFO_Implementation_channel == "Independent_Clocks_Builtin_FIFO" } {
			return "Memory Type:	Built-in"
		} else {
			return "Memory Type:	Distributed RAM"
		}		    		
	} 
}

proc LabelOutput_DepthDescription_updated {PARAM_VALUE.ENABLE_ECC PARAM_VALUE.FIFO_IMPLEMENTATION 
PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DEPTH 
PARAM_VALUE.PERFORMANCE_OPTIONS PARAM_VALUE.READ_CLOCK_FREQUENCY PARAM_VALUE.WRITE_CLOCK_FREQUENCY 
IPINST PARAM_VALUE.INPUT_DATA_WIDTH PROJECT_PARAM.ARCHITECTURE} {
	return "Read Depth : [Actual_Read_Depth_updated    ${PARAM_VALUE.ENABLE_ECC} ${PARAM_VALUE.FIFO_IMPLEMENTATION} ${PARAM_VALUE.INPUT_DEPTH} ${PARAM_VALUE.OUTPUT_DATA_WIDTH} ${PARAM_VALUE.OUTPUT_DEPTH} ${PARAM_VALUE.PERFORMANCE_OPTIONS} ${PARAM_VALUE.READ_CLOCK_FREQUENCY} ${PARAM_VALUE.WRITE_CLOCK_FREQUENCY} IPINST ${PARAM_VALUE.INPUT_DATA_WIDTH} ${PROJECT_PARAM.ARCHITECTURE}]"
};

proc table_summary_60_updated {PARAM_VALUE.ENABLE_ECC PARAM_VALUE.FIFO_IMPLEMENTATION 
PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DEPTH 
PARAM_VALUE.PERFORMANCE_OPTIONS PARAM_VALUE.READ_CLOCK_FREQUENCY PARAM_VALUE.WRITE_CLOCK_FREQUENCY 
IPINST PARAM_VALUE.INPUT_DATA_WIDTH PROJECT_PARAM.ARCHITECTURE} {
	return [lindex [split [LabelOutput_DepthDescription_updated ${PARAM_VALUE.ENABLE_ECC} ${PARAM_VALUE.FIFO_IMPLEMENTATION} ${PARAM_VALUE.INPUT_DEPTH} ${PARAM_VALUE.OUTPUT_DATA_WIDTH} ${PARAM_VALUE.OUTPUT_DEPTH} ${PARAM_VALUE.PERFORMANCE_OPTIONS} ${PARAM_VALUE.READ_CLOCK_FREQUENCY} ${PARAM_VALUE.WRITE_CLOCK_FREQUENCY} IPINST ${PARAM_VALUE.INPUT_DATA_WIDTH} ${PROJECT_PARAM.ARCHITECTURE}] :] 0]
}

proc table_summary_61_updated {PARAM_VALUE.ENABLE_ECC PARAM_VALUE.FIFO_IMPLEMENTATION 
PARAM_VALUE.INPUT_DEPTH PARAM_VALUE.OUTPUT_DATA_WIDTH PARAM_VALUE.OUTPUT_DEPTH 
PARAM_VALUE.PERFORMANCE_OPTIONS PARAM_VALUE.READ_CLOCK_FREQUENCY PARAM_VALUE.WRITE_CLOCK_FREQUENCY 
IPINST PARAM_VALUE.INPUT_DATA_WIDTH PROJECT_PARAM.ARCHITECTURE} {
	return [lindex [split [LabelOutput_DepthDescription_updated ${PARAM_VALUE.ENABLE_ECC} ${PARAM_VALUE.FIFO_IMPLEMENTATION} ${PARAM_VALUE.INPUT_DEPTH} ${PARAM_VALUE.OUTPUT_DATA_WIDTH} ${PARAM_VALUE.OUTPUT_DEPTH} ${PARAM_VALUE.PERFORMANCE_OPTIONS} ${PARAM_VALUE.READ_CLOCK_FREQUENCY} ${PARAM_VALUE.WRITE_CLOCK_FREQUENCY} IPINST ${PARAM_VALUE.INPUT_DATA_WIDTH} ${PROJECT_PARAM.ARCHITECTURE}] :] 1]
}

proc LabelOutput_Data_WidthDescription_updated { PARAM_VALUE.OUTPUT_DATA_WIDTH} {
	return "Read Width : [ get_property value ${PARAM_VALUE.OUTPUT_DATA_WIDTH} ]"
}

proc table_summary_50_updated {PARAM_VALUE.OUTPUT_DATA_WIDTH} {
	return [lindex [split [LabelOutput_Data_WidthDescription_updated ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] :] 0]
}

proc table_summary_51_updated {PARAM_VALUE.OUTPUT_DATA_WIDTH} {
	return [lindex [split [LabelOutput_Data_WidthDescription_updated ${PARAM_VALUE.OUTPUT_DATA_WIDTH}] :] 1]
}
proc table_summary_01_updated {PARAM_VALUE.FIFO_IMPLEMENTATION} {
	set text [split [Fifo_Implementation_Info_1_updated ${PARAM_VALUE.FIFO_IMPLEMENTATION}] :]
	return [lindex $text 1]
}

proc table_summary_00_updated {PARAM_VALUE.FIFO_IMPLEMENTATION} {
	set text [split [Fifo_Implementation_Info_1_updated ${PARAM_VALUE.FIFO_IMPLEMENTATION}] :]
	return [lindex $text 0]
}
