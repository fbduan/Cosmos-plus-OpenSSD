// +FHDR*****************************************************************************
//                 Copyright (c) 2023 Auto-SoC Co., Ltd..
//                       ALL RIGHTS RESERVED
// **********************************************************************************
// Filename     : VCC.v
// Author       : orysduan
// Created On   : 2023-12-19 15:31
// Last Modified: 
// ----------------------------------------------------------------------------------
// Description  :  top module of VCC.v
//                 1: 
//
// ----------------------------------------------------------------------------------
// Child-module :  
//
//
// -FHDR*****************************************************************************
// **********************************************************************************

module VCC(/*AUTOARG*/
    //Outputs
    P
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

output                          P;

//////////////////////////////////////////////////////////////////////////////
// Signal Declaration                                                       //
//////////////////////////////////////////////////////////////////////////////

/*autodefine*/
//auto wires{{{
wire       P;
//}}}
// End of automatic define


//////////////////////////////////////////////////////////////////////////////
// Design Logic                                                             //
//////////////////////////////////////////////////////////////////////////////

assign P = 1'b1;

endmodule

//verilog-library-files: ()
//verilog-library-directories: (".")
//verilog-library-directories: ("$DigitalIP_DIR/common/r1p0/de/rtl/share")
//verilog-library-directories: ("$DigitalIP_DIR/common/r1p0/de/rtl/sig_sync")

