// +FHDR*****************************************************************************
//                 Copyright (c) 2023 Auto-SoC Co., Ltd..
//                       ALL RIGHTS RESERVED
// **********************************************************************************
// Filename     : proc_sys_reset.v
// Author       : orysduan
// Created On   : 2023-12-21 17:54
// Last Modified: 
// ----------------------------------------------------------------------------------
// Description  :  top module of proc_sys_reset.v
//-----------------------------------------------------------------------------
// Filename:        proc_sys_reset.vhd
// Version:         v4.00a
// Description:     Parameterizeable top level processor reset module.
// VHDL-Standard:   VHDL'93
//-----------------------------------------------------------------------------
// Structure:   This section should show the hierarchical structure of the
//              designs.Separate lines with blank lines if necessary to improve
//              readability.
//
//              proc_sys_reset.vhd
//                  upcnt_n.vhd
//                  lpf.vhd
//                  sequence.vhd
//-----------------------------------------------------------------------------
// Author:      rolandp
// History:
//  kc           11/07/01      -- First version
//
//  kc           02/25/2002    -- Changed generic names C_EXT_RST_ACTIVE to
//                                C_EXT_RESET_HIGH and C_AUX_RST_ACTIVE to
//                                C_AUX_RESET_HIGH to match generics used in
//                                MicroBlaze.  Added the DCM Lock as an input
//                                to keep reset active until after the Lock
//                                is valid.
// lcw          10/11/2004  -- Updated for NCSim
// Ravi         09/14/2006  -- Added Attributes for synthesis
// rolandp      04/16/2007  -- version 2.00a
// ~~~~~~~
//  SK          03/11/10
// ^^^^^^^
// 1. Updated the core so support the active low "Interconnect_aresetn" and
//    "Peripheral_aresetn" signals.
// ^^^^^^^
// ~~~~~~~
//  SK          05/12/11
// ^^^^^^^
// 1. Updated the core so remove the support for PPC related functionality.
// ^^^^^^^
//-----------------------------------------------------------------------------
// Naming Conventions:
//      active low signals:                     "*_n"
//      clock signals:                          "clk", "clk_div#", "clk_#x"
//      reset signals:                          "rst", "rst_n"
//      generics:                               "C_*"
//      user defined types:                     "*_TYPE"
//      state machine next state:               "*_ns"
//      state machine current state:            "*_cs"
//      combinatorial signals:                  "*_cmb"
//      pipelined or register delay signals:    "*_d#"
//      counter signals:                        "*cnt*"
//      clock enable signals:                   "*_ce"
//      internal version of output port         "*_i"
//      device pins:                            "*_pin"
//      ports:                                  - Names begin with Uppercase
//      processes:                              "*_PROCESS"
//      component instantiations:               "<ENTITY_>I_<#|FUNC>
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Port Declaration
//-----------------------------------------------------------------------------
// Definition of Generics:
//      C_EXT_RST_WIDTH       -- External Reset Low Pass Filter setting
//      C_AUX_RST_WIDTH       -- Auxiliary Reset Low Pass Filter setting
//      C_EXT_RESET_HIGH      -- External Reset Active High or Active Low
//      C_AUX_RESET_HIGH      -= Auxiliary Reset Active High or Active Low
//      C_NUM_BUS_RST         -- Number of Bus Structures reset to generate
//      C_NUM_PERP_RST        -- Number of Peripheral resets to generate
//
//      C_NUM_INTERCONNECT_ARESETN -- No. of Active low reset to interconnect
//      C_NUM_PERP_ARESETN         -- No. of Active low reset to peripheral
// Definition of Ports:
//      slowest_sync_clk       -- Clock
//      ext_reset_in           -- External Reset Input
//      aux_reset_in           -- Auxiliary Reset Input
//      mb_debug_sys_rst       -- MDM Reset Input
//      dcm_locked             -- DCM Locked, hold system in reset until 1
//      mb_reset               -- MB core reset out
//      bus_struct_reset       -- Bus structure reset out
//      peripheral_reset       -- Peripheral reset out
//      interconnect_aresetn   -- Interconnect Bus structure registered rst out
//      peripheral_aresetn     -- Active Low Peripheral registered reset out
//-----------------------------------------------------------------------------
// no timescale needed
//
// ----------------------------------------------------------------------------------
// Child-module :  
//
//
// -FHDR*****************************************************************************
// **********************************************************************************

module proc_sys_reset(/*AUTOARG*/
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

parameter [31:0] C_EXT_RST_WIDTH=4;
parameter [31:0] C_AUX_RST_WIDTH=4;
parameter        C_EXT_RESET_HIGH=1'b0;
parameter        C_AUX_RESET_HIGH=1'b1;
parameter [31:0] C_NUM_BUS_RST=1;
parameter [31:0] C_NUM_PERP_RST=1;
parameter [31:0] C_NUM_INTERCONNECT_ARESETN=1;
parameter [31:0] C_NUM_PERP_ARESETN=1;


localparam       C_BUS_RESET_WAIT = 10;
localparam       C_PER_RESET_WAIT = 10;
localparam       C_MB_RESET_WAIT  = 10;

//--------------------------------------------------------------------------
// Local Prameters
// Parameters that can NOT be modified/overrided when instance this module
//--------------------------------------------------------------------------

//////////////////////////////////////////////////////////////////////////////
// Input/Output Declaration                                                 //
//////////////////////////////////////////////////////////////////////////////
input                           slowest_sync_clk;
input                           ext_reset_in;
input                           aux_reset_in;
input                           mb_debug_sys_rst;
input                           dcm_locked;

output                          mb_reset;
output [0:C_NUM_BUS_RST - 1]    bus_struct_reset;
output [0:C_NUM_PERP_RST - 1]   peripheral_reset;
output [0:C_NUM_INTERCONNECT_ARESETN - 1]  interconnect_aresetn;
output [0:C_NUM_PERP_ARESETN - 1]  peripheral_aresetn;

//////////////////////////////////////////////////////////////////////////////
// Signal Declaration                                                       //
//////////////////////////////////////////////////////////////////////////////

/*autodefine*/
//auto wires{{{
wire                         Slowest_sync_clk;
wire                         asr_rst_n;
wire                         asr_sync_rst_n;
wire                         aux_rst_n;
wire [0:C_NUM_BUS_RST-1]     bus_struct_reset;
wire                         exr_rst_n;
wire                         exr_sync_rst_n;
wire                         ext_rst_n;
wire [0:C_NUM_INTERCONNECT_ARESETN-1] interconnect_aresetn;
wire                         mb_reset;
wire                         mbdbg_rst_n;
wire [0:C_NUM_PERP_ARESETN-1] peripheral_aresetn;
wire [0:C_NUM_PERP_RST-1]    peripheral_reset;
//}}}
//auto regs{{{
reg  [C_AUX_RST_WIDTH-1:0]   asr_rst_n_sync;
reg  [C_BUS_RESET_WAIT-1:0]  bus_rst_n_dly;
reg  [C_EXT_RST_WIDTH-1:0]   exr_rst_n_sync;
reg                          lpf_rst_n;
reg  [C_MB_RESET_WAIT-1:0]   mb_rst_n_dly;
reg  [C_PRI_RESET_WAIT-1:0]  pri_rst_n_dly;
//}}}
// End of automatic define


//////////////////////////////////////////////////////////////////////////////
// Design Logic                                                             //
//////////////////////////////////////////////////////////////////////////////



assign mb_reset                                               = ~mb_rst_n_dly[0];
assign bus_struct_reset[0:C_NUM_BUS_RST - 1]                  = {C_NUM_BUS_RST{~bus_rst_n_dly[0]}};
assign peripheral_reset[0:C_NUM_PERP_RST - 1]                 = {C_NUM_PERP_ARESETN{~pri_rst_n_dly[0]}};
assign interconnect_aresetn[0:C_NUM_INTERCONNECT_ARESETN - 1] = {C_NUM_INTERCONNECT_ARESETN{ bus_rst_n_dly[0]}};
assign peripheral_aresetn[0:C_NUM_PERP_ARESETN - 1]           = {C_NUM_PERP_ARESETN{ pri_rst_n_dly[0]}};

always @(posedge slowest_sync_clk or negedge lpf_rst_n) begin
    if(!rstn) begin
        bus_rst_n_dly[C_BUS_RESET_WAIT-1:0] <= {1'b1, {(C_BUS_RESET_WAIT-1){1'b0}}};
    end
    else begin
        bus_rst_n_dly[C_BUS_RESET_WAIT-1:0] <= {bus_rst_n_dly[C_BUS_RESET_WAIT-1], bus_rst_n_dly[C_BUS_RESET_WAIT-1:1]};
    end
end

always @(posedge slowest_sync_clk or negedge bus_rst_n_dly[0]) begin
    if(!rstn) begin
        pri_rst_n_dly[C_PRI_RESET_WAIT-1:0] <= {1'b1, {(C_PRI_RESET_WAIT-1){1'b0}}};
    end
    else begin
        pri_rst_n_dly[C_PRI_RESET_WAIT-1:0] <= {pri_rst_n_dly[C_PRI_RESET_WAIT-1], pri_rst_n_dly[C_PRI_RESET_WAIT-1:1]};
    end
end

always @(posedge slowest_sync_clk or negedge mb_rst_n_dly[0]) begin
    if(!rstn) begin
        mb_rst_n_dly[C_MB_RESET_WAIT-1:0] <= {1'b1, {(C_MB_RESET_WAIT-1){1'b0}}};
    end
    else begin
        mb_rst_n_dly[C_MB_RESET_WAIT-1:0] <= {mb_rst_n_dly[C_MB_RESET_WAIT-1], mb_rst_n_dly[C_MB_RESET_WAIT-1:1]};
    end
end




always @(posedge slowest_sync_clk) begin
    lpf_rst_n <= exr_sync_rst_n & asr_sync_rst_n & (~srl_time_out) & dcm_locked;
end


assign ext_rst_n   = (C_EXT_RESET_HIGH == 0) ? ext_reset_in : ~ext_reset_in;
assign aux_rst_n   = (C_AUX_RESET_HIGH == 0) ? aux_reset_in : ~aux_reset_in;
assign mbdbg_rst_n = ~mb_debug_sys_rst;

assign exr_rst_n = ext_reset_in & mbdbg_rst_n;
assign asr_rst_n = aux_rst_n;

assign exr_sync_rst_n = exr_rst_n_sync[0];
always @(posedge slowest_sync_clk or negedge exr_rst_n) begin
    if(!rstn) begin
        exr_rst_n_sync[C_EXT_RST_WIDTH-1:0] <= {1'b1, {(C_EXT_RST_WIDTH-1){1'b0}}};
    end
    else begin
        exr_rst_n_sync[C_EXT_RST_WIDTH-1:0] <= {exr_rst_n_sync[C_EXT_RST_WIDTH-1], exr_rst_n_sync[C_EXT_RST_WIDTH-1:1]};
    end
end

assign asr_sync_rst_n = asr_rst_n_sync[0];
always @(posedge slowest_sync_clk or negedge asr_rst_n) begin
    if(!rstn) begin
        asr_rst_n_sync[C_AUX_RST_WIDTH-1:0] <= {1'b1, {(C_AUX_RST_WIDTH-1){1'b0}}};
    end
    else begin
        asr_rst_n_sync[C_AUX_RST_WIDTH-1:0] <= {asr_rst_n_sync[C_AUX_RST_WIDTH-1], asr_rst_n_sync[C_AUX_RST_WIDTH-1:1]};
    end
end

SRL16 POR_SRL_I(
  .D(1'b0),
  .CLK(Slowest_sync_clk),
  .A0(1'b1),
  .A1(1'b1),
  .A2(1'b1),
  .A3(1'b1),
  .Q(srl_time_out));

endmodule

//verilog-library-files: ()
//verilog-library-directories: (".")
//verilog-library-directories: ("$DigitalIP_DIR/common/r1p0/de/rtl/share")
//verilog-library-directories: ("$DigitalIP_DIR/common/r1p0/de/rtl/sig_sync")


