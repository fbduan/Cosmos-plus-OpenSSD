namespace eval fifo_generator_v12_0_utils { 

     proc update_threshold_parameters {valueArray} {

       upvar $valueArray xco

       namespace import ::xcoUpgradeLib::*

       switch [getParameter Programmable_Empty_Type_axis xco] {
         "Empty"        {setParameter Programmable_Empty_Type_axis No_Programmable_Empty_Threshold xco}
         "Almost_Empty" {setParameter Programmable_Empty_Type_axis No_Programmable_Empty_Threshold xco}
       }

       switch [getParameter Programmable_Empty_Type_rach xco] {
         "Empty"        {setParameter Programmable_Empty_Type_rach No_Programmable_Empty_Threshold xco}
         "Almost_Empty" {setParameter Programmable_Empty_Type_rach No_Programmable_Empty_Threshold xco}
       }

       switch [getParameter Programmable_Empty_Type_rdch xco] {
         "Empty"        {setParameter Programmable_Empty_Type_rdch No_Programmable_Empty_Threshold xco}
         "Almost_Empty" {setParameter Programmable_Empty_Type_rdch No_Programmable_Empty_Threshold xco}
       }

       switch [getParameter Programmable_Empty_Type_wach xco] {
         "Empty"        {setParameter Programmable_Empty_Type_wach No_Programmable_Empty_Threshold xco}
         "Almost_Empty" {setParameter Programmable_Empty_Type_wach No_Programmable_Empty_Threshold xco}
       }

       switch [getParameter Programmable_Empty_Type_wdch xco] {
         "Empty"        {setParameter Programmable_Empty_Type_wdch No_Programmable_Empty_Threshold xco}
         "Almost_Empty" {setParameter Programmable_Empty_Type_wdch No_Programmable_Empty_Threshold xco}
       }

       switch [getParameter Programmable_Empty_Type_wrch xco] {
         "Empty"        {setParameter Programmable_Empty_Type_wrch No_Programmable_Empty_Threshold xco}
         "Almost_Empty" {setParameter Programmable_Empty_Type_wrch No_Programmable_Empty_Threshold xco}
       }

       switch [getParameter Programmable_Full_Type_axis xco] {
         "Full"        {setParameter Programmable_Full_Type_axis No_Programmable_Full_Threshold xco}
         "Almost_Full" {setParameter Programmable_Full_Type_axis No_Programmable_Full_Threshold xco}
       }

       switch [getParameter Programmable_Full_Type_rach xco] {
         "Full"        {setParameter Programmable_Full_Type_rach No_Programmable_Full_Threshold xco}
         "Almost_Full" {setParameter Programmable_Full_Type_rach No_Programmable_Full_Threshold xco}
       }

       switch [getParameter Programmable_Full_Type_rdch xco] {
         "Full"        {setParameter Programmable_Full_Type_rdch No_Programmable_Full_Threshold xco}
         "Almost_Full" {setParameter Programmable_Full_Type_rdch No_Programmable_Full_Threshold xco}
       }

       switch [getParameter Programmable_Full_Type_wach xco] {
         "Full"        {setParameter Programmable_Full_Type_wach No_Programmable_Full_Threshold xco}
         "Almost_Full" {setParameter Programmable_Full_Type_wach No_Programmable_Full_Threshold xco}
       }

       switch [getParameter Programmable_Full_Type_wdch xco] {
         "Full"        {setParameter Programmable_Full_Type_wdch No_Programmable_Full_Threshold xco}
         "Almost_Full" {setParameter Programmable_Full_Type_wdch No_Programmable_Full_Threshold xco}
       }

       switch [getParameter Programmable_Full_Type_wrch xco] {
         "Full"        {setParameter Programmable_Full_Type_wrch No_Programmable_Full_Threshold xco}
         "Almost_Full" {setParameter Programmable_Full_Type_wrch No_Programmable_Full_Threshold xco}
       }

       return 
     }


     proc update_axi_ipi_parameters {valueArray} {

       upvar $valueArray xco

       namespace import ::xcoUpgradeLib::*

       renameParameter AXI_Address_Width ADDRESS_WIDTH  xco
       renameParameter Interface_Type    INTERFACE_TYPE xco

       if {[getParameter AXI_Type xco] != "AXI4_Lite"} {
         addParameter DATA_WIDTH 64 xco
       } else {
         switch [getParameter AXI_Data_Width xco] {
           "8"       {addParameter DATA_WIDTH 32 xco}
           "16"      {addParameter DATA_WIDTH 32 xco}
           "32"      {addParameter DATA_WIDTH 32 xco}
           "default" {addParameter DATA_WIDTH 64 xco}
         }
       }
       if {[getParameter INTERFACE_TYPE xco] == "Native"} {
         addParameter PROTOCOL AXI4 xco
         setParameter ID_WIDTH 0 xco
         setParameter ADDRESS_WIDTH 32 xco
       } else {
         switch [getParameter AXI_Type xco] {
           "AXI4_Full"   {setParameter INTERFACE_TYPE AXI_MEMORY_MAPPED xco; addParameter PROTOCOL AXI4     xco}
           "AXI4_Lite"   {setParameter INTERFACE_TYPE AXI_MEMORY_MAPPED xco; addParameter PROTOCOL AXI4LITE xco}
           "AXI4_Stream" {setParameter INTERFACE_TYPE AXI_STREAM        xco; addParameter PROTOCOL AXI4     xco}
           "default"     {setParameter INTERFACE_TYPE AXI_STREAM        xco; addParameter PROTOCOL AXI4     xco}
         }
       }
       removeParameter AXI_Data_Width xco
       removeParameter AXI_Type       xco
       

       set readEnabled  [getParameter Enable_Read_Channel  xco]
       set writeEnabled [getParameter Enable_Write_Channel xco]

       if       {($readEnabled == "true")  && ($writeEnabled == "false") } {
          addParameter READ_WRITE_MODE READ_ONLY xco
       } elseif {($readEnabled == "false") && ($writeEnabled == "true") } {
          addParameter READ_WRITE_MODE WRITE_ONLY xco
       } else {
          addParameter READ_WRITE_MODE READ_WRITE xco
       }
       removeParameter Enable_Read_Channel  xco
       removeParameter Enable_Write_Channel xco


       renameParameter TID_Width TID_WIDTH xco
       renameParameter TKEEP_Width TKEEP_WIDTH xco
       renameParameter TDEST_Width TDEST_WIDTH xco
       renameParameter TSTRB_Width TSTRB_WIDTH xco
       renameParameter Enable_TSTROBE HAS_TSTRB xco
       renameParameter Enable_TKEEP HAS_TKEEP xco
       if {[getParameter INTERFACE_TYPE xco] == "AXI_STREAM"} {
         setParameter ID_WIDTH 0 xco
         setParameter ADDRESS_WIDTH 32 xco

           set num_bytes [expr [getParameter TDATA_Width xco] / 8 ]
           switch [getParameter Enable_TDATA xco] {
             "false" {addParameter TDATA_NUM_BYTES 0          xco}
             "true"  {addParameter TDATA_NUM_BYTES $num_bytes xco}
           }
    

           switch [getParameter Enable_TID xco] {
             "false" {setParameter TID_WIDTH 0 xco}
           }

           switch [getParameter Enable_TDEST xco] {
             "false" {setParameter TDEST_WIDTH 0 xco}
           }
       } else {
           addParameter TDATA_NUM_BYTES 0 xco
           setParameter TSTRB_WIDTH 0 xco
           setParameter TKEEP_WIDTH 0 xco
           setParameter TID_WIDTH 0 xco
           setParameter TDEST_WIDTH 0 xco
       }
       removeParameter TDATA_Width  xco
       removeParameter Enable_TDATA xco

       switch [getParameter Use_Clock_Enable xco] {
         "false" {addParameter HAS_ACLKEN false xco}
         "true"  {addParameter HAS_ACLKEN true xco}
       }
       removeParameter Use_Clock_Enable xco

       removeParameter Enable_TID xco
       removeParameter Enable_TDEST xco

       renameParameter TUSER_Width TUSER_WIDTH xco
       switch [getParameter Enable_TUSER xco] {
         "false" {setParameter TUSER_WIDTH 4 xco}
       }
       removeParameter Enable_TUSER xco


       switch [getParameter Enable_AWUSER xco] {
         "false" {setParameter AWUSER_Width 0 xco}
       }
       removeParameter Enable_AWUSER xco

       switch [getParameter Enable_WUSER xco] {
         "false" {setParameter WUSER_Width 0 xco}
       }
       removeParameter Enable_WUSER xco

       switch [getParameter Enable_BUSER xco] {
         "false" {setParameter BUSER_Width 0 xco}
       }
       removeParameter Enable_BUSER xco

       switch [getParameter Enable_ARUSER xco] {
         "false" {setParameter ARUSER_Width 0 xco}
       }
       removeParameter Enable_ARUSER xco

       switch [getParameter Enable_RUSER xco] {
         "false" {setParameter RUSER_Width 0 xco}
       }
       removeParameter Enable_RUSER xco

       return 
     }

    
     proc update_fifo_parameters_pre_12_0 {valueArray} {
       upvar $valueArray xco

       namespace import ::xcoUpgradeLib::*

       addParameter asymmetric_port_width false xco
       addParameter ecc_pipeline_reg false xco
       addParameter dynamic_power_saving false xco
       
       if { ([string equal -nocase  native [getParameter INTERFACE_TYPE  xco] ]) &&
	    ([string equal -nocase Common_Clock_Builtin_FIFO [getParameter Fifo_Implementation xco] ] || 
	    [string equal -nocase Independent_Clocks_Builtin_FIFO [getParameter Fifo_Implementation xco] ]) &&
	    ([string equal -nocase kintexu [getOption architecture xco] ] ||
	    [string equal -nocase virtexu [getOption architecture xco]  ]) } {

	    setParameter Reset_Type Synchronous_Reset xco
	  }

       return
     }

     proc fifo_warnings_pre_12_0 {valueArray} {
       upvar $valueArray xco

       namespace import ::xcoUpgradeLib::*
       
       set warningString ""
       # Using condtion as not of 7-series for original project option as UltraScale family name 
       #   changed from virtex8/kintex8 to virtexu/kintexu
       if { (!([string equal -nocase virtex7 [getOriginalOption architecture xco] ] ||
           [string equal -nocase kintex7 [getOriginalOption architecture xco] ] ||
           [string equal -nocase artix7 [getOriginalOption architecture xco]  ] ||
           [string equal -nocase zynq [getOriginalOption architecture xco] ])) && 
           ([string equal -nocase  native [getParameter INTERFACE_TYPE  xco] ]) &&
           ([string equal -nocase Common_Clock_Builtin_FIFO [getParameter Fifo_Implementation xco] ] || 
	    [string equal -nocase Independent_Clocks_Builtin_FIFO [getParameter Fifo_Implementation xco] ]) &&
	    ([string equal -nocase kintexu [getOption architecture xco] ] ||
	    [string equal -nocase virtexu [getOption architecture xco]  ])
         } {
         append warningString "Asynchronous reset port (rst) for Built-in FIFO configurations is removed \
	 for UltraScale Built-in FIFO configurations. 'rst' port will be replaced by 'srst' port in the upgraded FIFO core. \
	 Please update the FIFO instances with this port name changes in your design\n"
         }
       
	 if { (!([string equal -nocase virtex7 [getOriginalOption architecture xco] ] ||
           [string equal -nocase kintex7 [getOriginalOption architecture xco] ] ||
           [string equal -nocase artix7 [getOriginalOption architecture xco]  ] ||
           [string equal -nocase zynq [getOriginalOption architecture xco] ])) && 
           ([string equal -nocase  native [getParameter INTERFACE_TYPE  xco] ]) &&
           ([string equal -nocase  Synchronous_Reset [getParameter Reset_Type  xco] ]) &&
           ([string equal -nocase Common_Clock_Block_RAM [getParameter Fifo_Implementation xco] ] || 
            [string equal -nocase Common_Clock_Distributed_RAM [getParameter Fifo_Implementation xco] ] || 
	    [string equal -nocase Common_Clock_Shift_Register [getParameter Fifo_Implementation xco] ]) &&
	    ([string equal -nocase kintexu [getOption architecture xco] ] ||
	    [string equal -nocase virtexu [getOption architecture xco]  ])
         } {
         append warningString "Synchronous reset (srst) mechanism has been changed for UltraScale devices.\
	 FIFO Generator provides wr_rst_busy and rd_rst_busy output ports. \
	 FIFO Generator is in reset state if these signals are asserted 'high'.\n"
         }

  	 return $warningString;
     }


     proc upgrade_from_fifo_generator_v8_5 {valueArray} {
       upvar $valueArray xco

       namespace import ::xcoUpgradeLib::*

       update_threshold_parameters xco
       update_axi_ipi_parameters xco
       update_fifo_parameters_pre_12_0 xco

       namespace forget ::xcoUpgradeLib::*
     }
     
     proc upgrade_from_fifo_generator_v9_1 {valueArray} {
       upvar $valueArray xco

       namespace import ::xcoUpgradeLib::*

       update_axi_ipi_parameters xco
       update_fifo_parameters_pre_12_0 xco

       namespace forget ::xcoUpgradeLib::*
     }
    

     proc upgrade_from_fifo_generator_v9_2 {valueArray} {
       upvar $valueArray xco

       namespace import ::xcoUpgradeLib::*

       update_axi_ipi_parameters xco
       update_fifo_parameters_pre_12_0 xco

       namespace forget ::xcoUpgradeLib::*
     }

     proc upgrade_from_fifo_generator_v9_3 {valueArray} {
       upvar $valueArray xco

       namespace import ::xcoUpgradeLib::*

       update_axi_ipi_parameters xco
       update_fifo_parameters_pre_12_0 xco

       namespace forget ::xcoUpgradeLib::*
     }


     proc upgrade_from_fifo_generator_v10_0 {valueArray} {
       upvar $valueArray xco

       namespace import ::xcoUpgradeLib::*

       update_axi_ipi_parameters xco
       update_fifo_parameters_pre_12_0 xco

       namespace forget ::xcoUpgradeLib::*
     }
    
     proc warning_for_upgrade_from_fifo_generator_v10_0 {valueArray} {
       namespace import ::xcoUpgradeLib::*
       upvar $valueArray xco
       
       set warningString [fifo_warnings_pre_12_0 xco]

       namespace forget ::xcoUpgradeLib::*
        
       return $warningString
     }

     proc upgrade_from_fifo_generator_v11_0 {valueArray} {
       upvar $valueArray xco

       namespace import ::xcoUpgradeLib::*
       
       update_fifo_parameters_pre_12_0 xco
       
       namespace forget ::xcoUpgradeLib::*
     }
     
     proc warning_for_upgrade_from_fifo_generator_v11_0 {valueArray} {
       namespace import ::xcoUpgradeLib::*
       upvar $valueArray xco
       
       set warningString [fifo_warnings_pre_12_0 xco]


       namespace forget ::xcoUpgradeLib::*
        
       return $warningString
     }

 }
