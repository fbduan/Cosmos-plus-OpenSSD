// +FHDR*****************************************************************************
//                 Copyright (c) 2023 Auto-SoC Co., Ltd..
//                       ALL RIGHTS RESERVED
// **********************************************************************************
// Filename     : OpenSSD2_proc_sys_reset_2_0.v
// Author       : orysduan
// Created On   : 2023-12-21 16:56
// Last Modified: 
// ----------------------------------------------------------------------------------
// Description  :  top module of OpenSSD2_proc_sys_reset_2_0.v
//                 1: 
//
// ----------------------------------------------------------------------------------
// Child-module :  
//
//
// -FHDR*****************************************************************************
// **********************************************************************************

module OpenSSD2_proc_sys_reset_2_0(/*AUTOARG*/
    //Outputs
    mb_reset, bus_struct_reset, peripheral_reset, interconnect_aresetn,
    peripheral_aresetn,

    //Inputs
    slowest_sync_clk, ext_reset_in, aux_reset_in, mb_debug_sys_rst,
    dcm_locked
);

//////////////////////////////////////////////////////////////////////////////
// Parameter Definition                                                     //
//////////////////////////////////////////////////////////////////////////////
//--------------------------------------------------------------------------
// Parameters that can be modified/overrided when instance this module
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
// Local Prameters
// Parameters that can NOT be modified/overrided when instance this module
//--------------------------------------------------------------------------

//////////////////////////////////////////////////////////////////////////////
// Input/Output Declaration                                                 //
//////////////////////////////////////////////////////////////////////////////
input    slowest_sync_clk;
input    ext_reset_in;
input    aux_reset_in;
input    mb_debug_sys_rst;
input    dcm_locked;

output   mb_reset;
output   bus_struct_reset;
output   peripheral_reset;
output   interconnect_aresetn;
output   peripheral_aresetn;

//////////////////////////////////////////////////////////////////////////////
// Signal Declaration                                                       //
//////////////////////////////////////////////////////////////////////////////

/*autodefine*/
//auto wires{{{
wire       bus_struct_reset;
wire       interconnect_aresetn;
wire       mb_reset;
wire       peripheral_aresetn;
wire       peripheral_reset;
//}}}
// End of automatic define


//////////////////////////////////////////////////////////////////////////////
// Design Logic                                                             //
//////////////////////////////////////////////////////////////////////////////




proc_sys_reset u_proc_sys_reset( /*AUTOINST*/
         .slowest_sync_clk     ( slowest_sync_clk     )    //I                       u_proc_sys_reset    
        ,.ext_reset_in         ( ext_reset_in         )    //I                       u_proc_sys_reset    
        ,.aux_reset_in         ( aux_reset_in         )    //I                       u_proc_sys_reset    
        ,.mb_debug_sys_rst     ( mb_debug_sys_rst     )    //I                       u_proc_sys_reset    
        ,.dcm_locked           ( dcm_locked           )    //I                       u_proc_sys_reset    
        ,.mb_reset             ( mb_reset             )    //O                       u_proc_sys_reset    
        ,.bus_struct_reset     ( bus_struct_reset     )    //O  [0:C_NUM_BUS_RST-1]  u_proc_sys_reset    
        ,.peripheral_reset     ( peripheral_reset     )    //O  [0:C_NUM_PERP_RST-1] u_proc_sys_reset    
        ,.interconnect_aresetn ( interconnect_aresetn )    //O  [0:C_NUM_INTERCONNECT_ARESETN-1] u_proc_sys_reset    
        ,.peripheral_aresetn   ( peripheral_aresetn   )    //O  [0:C_NUM_PERP_ARESETN-1] u_proc_sys_reset    
);

endmodule

//verilog-library-files: ()
//verilog-library-directories: (".")
//verilog-library-directories: ("$DigitalIP_DIR/common/r1p0/de/rtl/share")
//verilog-library-directories: ("$DigitalIP_DIR/common/r1p0/de/rtl/sig_sync")


