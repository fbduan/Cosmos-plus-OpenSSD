// File ../vhd/proc_sys_reset_v5_0/lpf.vhd translated with vhd2vl 3.0 VHDL to Verilog RTL translator
// vhd2vl settings:
//  * Verilog Module Declaration Style: 2001

// vhd2vl is Free (libre) Software:
//   Copyright (C) 2001-2023 Vincenzo Liguori - Ocean Logic Pty Ltd
//     http://www.ocean-logic.com
//   Modifications Copyright (C) 2006 Mark Gonzales - PMC Sierra Inc
//   Modifications (C) 2010 Shankar Giri
//   Modifications Copyright (C) 2002-2023 Larry Doolittle
//     http://doolittle.icarus.com/~larry/vhd2vl/
//   Modifications (C) 2017 Rodrigo A. Melo
//
//   vhd2vl comes with ABSOLUTELY NO WARRANTY.  Always check the resulting
//   Verilog for correctness, ideally with a formal verification tool.
//
//   You are welcome to redistribute vhd2vl under certain conditions.
//   See the license (GPLv2) file included with the source for details.

// The result of translation follows.  Its copyright status should be
// considered unchanged from the original VHDL.

//-----------------------------------------------------------------------------
// lpf - entity/architecture pair
//-----------------------------------------------------------------------------
//
// ************************************************************************
// ** DISCLAIMER OF LIABILITY                                            **
// **                                                                    **
// ** This file contains proprietary and confidential information of     **
// ** Xilinx, Inc. ("Xilinx"), that is distributed under a license       **
// ** from Xilinx, and may be used, copied and/or disclosed only         **
// ** pursuant to the terms of a valid license agreement with Xilinx.    **
// **                                                                    **
// ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION              **
// ** ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER         **
// ** EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT                **
// ** LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,          **
// ** MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx      **
// ** does not warrant that functions included in the Materials will     **
// ** meet the requirements of Licensee, or that the operation of the    **
// ** Materials will be uninterrupted or error-free, or that defects     **
// ** in the Materials will be corrected. Furthermore, Xilinx does       **
// ** not warrant or make any representations regarding use, or the      **
// ** results of the use, of the Materials in terms of correctness,      **
// ** accuracy, reliability or otherwise.                                **
// **                                                                    **
// ** Xilinx products are not designed or intended to be fail-safe,      **
// ** or for use in any application requiring fail-safe performance,     **
// ** such as life-support or safety devices or systems, Class III       **
// ** medical devices, nuclear facilities, applications related to       **
// ** the deployment of airbags, or any other applications that could    **
// ** lead to death, personal injury or severe property or               **
// ** environmental damage (individually and collectively, "critical     **
// ** applications"). Customer assumes the sole risk and liability       **
// ** of any use of Xilinx products in critical applications,            **
// ** subject only to applicable laws and regulations governing          **
// ** limitations on product liability.                                  **
// **                                                                    **
// ** Copyright 2012 Xilinx, Inc.                                        **
// ** All rights reserved.                                               **
// **                                                                    **
// ** This disclaimer and copyright notice must be retained as part      **
// ** of this file at all times.                                         **
// ************************************************************************
//
//-----------------------------------------------------------------------------
// Filename:        lpf.vhd
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
// Author:      Kurt Conover
// History:
//  Kurt Conover      11/08/01      -- First Release
//
//  KC                02/25/2002    -- Added Dcm_locked as an input
//                                  -- Added Power on reset srl_time_out
//
//  KC                08/26/2003    -- Added attribute statements for power on 
//                                     reset SRL
//
// ~~~~~~~
//  SK          03/11/10
// ^^^^^^^
// 1. Updated the core so support the active low "Interconnect_aresetn" and
//    "Peripheral_aresetn" signals.
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
//      combinatorial signals:                  "*_com" 
//      pipelined or register delay signals:    "*_d#" 
//      counter signals:                        "*cnt*"
//      clock enable signals:                   "*_ce" 
//      internal version of output port         "*_i"
//      device pins:                            "*_pin" 
//      ports:                                  - Names begin with Uppercase 
//      processes:                              "*_PROCESS" 
//      component instantiations:               "<ENTITY_>I_<#|FUNC>
//-----------------------------------------------------------------------------
//use lib_cdc_v1_0.all;
//-----------------------------------------------------------------------------
// Port Declaration
//-----------------------------------------------------------------------------
// Definition of Generics:
//          C_EXT_RST_WIDTH       -- External Reset Low Pass Filter setting
//          C_AUX_RST_WIDTH       -- Auxiliary Reset Low Pass Filter setting   
//          C_EXT_RESET_HIGH      -- External Reset Active High or Active Low
//          C_AUX_RESET_HIGH      -= Auxiliary Reset Active High or Active Low
//
// Definition of Ports:
//          Slowest_sync_clk       -- Clock 
//          External_System_Reset  -- External Reset Input
//          Auxiliary_System_Reset -- Auxiliary Reset Input
//          Dcm_locked             -- DCM Locked, hold system in reset until 1
//          Lpf_reset              -- Low Pass Filtered Output
//
//-----------------------------------------------------------------------------
// no timescale needed

module lpf(
input wire MB_Debug_Sys_Rst,
input wire Dcm_locked,
input wire External_System_Reset,
input wire Auxiliary_System_Reset,
input wire Slowest_Sync_Clk,
output wire Lpf_reset
);

parameter [31:0] C_EXT_RST_WIDTH;
parameter [31:0] C_AUX_RST_WIDTH;
parameter C_EXT_RESET_HIGH;
parameter C_AUX_RESET_HIGH;



parameter CLEAR = 1'b0;
wire exr_d1 = 1'b0;  // delayed External_System_Reset
reg [0:C_EXT_RST_WIDTH - 1] exr_lpf = 1'b0;  // LPF DFF
wire asr_d1 = 1'b0;  // delayed Auxiliary_System_Reset
reg [0:C_AUX_RST_WIDTH - 1] asr_lpf = 1'b0;  // LPF DFF
reg exr_and = 1'b0;  // varible input width "and" gate
reg exr_nand = 1'b0;  // vaiable input width "and" gate
reg asr_and = 1'b0;  // varible input width "and" gate
reg asr_nand = 1'b0;  // vaiable input width "and" gate
reg lpf_int = 1'b0;  // internal Lpf_reset
reg lpf_exr = 1'b0;
reg lpf_asr = 1'b0;
wire srl_time_out;  // %% attribute INIT             : string;
// %% attribute INIT of POR_SRL_I: label is "FFFF";

  assign Lpf_reset = lpf_int;
  //-----------------------------------------------------------------------------
  // Power On Reset Generation
  //-----------------------------------------------------------------------------
  //  This generates a reset for the first 16 clocks after a power up
  //-----------------------------------------------------------------------------
  SRL16 POR_SRL_I(
      .D(1'b0),
    .CLK(Slowest_sync_clk),
    .A0(1'b1),
    .A1(1'b1),
    .A2(1'b1),
    .A3(1'b1),
    .Q(srl_time_out));

  //-----------------------------------------------------------------------------
  // LPF_OUTPUT_PROCESS
  //-----------------------------------------------------------------------------
  //  This generates the reset pulse and the count enable to core reset counter
  //
  //ACTIVE_HIGH_LPF_EXT: if  (C_EXT_RESET_HIGH = '1') generate  
  //begin
  always @(posedge Slowest_sync_clk) begin
    lpf_int <= lpf_exr | lpf_asr | srl_time_out |  ~Dcm_locked;
  end

  //end generate ACTIVE_HIGH_LPF_EXT;
  //ACTIVE_LOW_LPF_EXT: if  (C_EXT_RESET_HIGH = '0') generate  
  //begin
  //LPF_OUTPUT_PROCESS: process (Slowest_sync_clk)
  //   begin
  //      if (Slowest_sync_clk'event and Slowest_sync_clk = '1') then
  //         lpf_int <= not (lpf_exr      or 
  //	                 lpf_asr      or 
  //			 srl_time_out)or 
  //			 not Dcm_locked;
  //      end if;
  //   end process;
  //end generate ACTIVE_LOW_LPF_EXT;
  always @(posedge Slowest_sync_clk) begin
    if(exr_and == 1'b1) begin
      lpf_exr <= 1'b1;
    end
    else if((exr_and == 1'b0 && exr_nand == 1'b1)) begin
      lpf_exr <= 1'b0;
    end
  end

  always @(posedge Slowest_sync_clk) begin
    if(asr_and == 1'b1) begin
      lpf_asr <= 1'b1;
    end
    else if((asr_and == 1'b0 && asr_nand == 1'b1)) begin
      lpf_asr <= 1'b0;
    end
  end

  //-----------------------------------------------------------------------------
  // This If-generate selects an active high input for External System Reset 
  //-----------------------------------------------------------------------------
  generate if ((C_EXT_RESET_HIGH != 1'b0)) begin: ACTIVE_HIGH_EXT
      //---------------------------------
    assign exr_d1 = External_System_Reset | MB_Debug_Sys_Rst;
    cdc_sync #(
          .C_CDC_TYPE(1),
      .C_RESET_STATE(0),
      .C_SINGLE_BIT(1),
      .C_FLOP_INPUT(0),
      .C_VECTOR_WIDTH(2),
      .C_MTBF_STAGES(4))
    ACT_HI_EXT(
          .prmry_aclk(1'b1),
      .prmry_resetn(1'b1),
      //S_AXI_ARESETN,
      .prmry_in(exr_d1),
      .prmry_ack(/* open */),
      .scndry_out(exr_lpf[0]),
      .scndry_aclk(Slowest_Sync_Clk),
      .scndry_resetn(1'b1),
      //S_AXIS_ARESETN,
      .prmry_vect_in(2'b00),
      .scndry_vect_out(/* open */));

        //---------------------------------
  end
  endgenerate
  //-----------------------------------------------------------------------------
  // This If-generate selects an active low input for External System Reset 
  //-----------------------------------------------------------------------------
  generate if ((C_EXT_RESET_HIGH == 1'b0)) begin: ACTIVE_LOW_EXT
      assign exr_d1 =  ~External_System_Reset | MB_Debug_Sys_Rst;
    //-----------------------------------
    cdc_sync #(
          .C_CDC_TYPE(1),
      .C_RESET_STATE(0),
      .C_SINGLE_BIT(1),
      .C_FLOP_INPUT(0),
      .C_VECTOR_WIDTH(2),
      .C_MTBF_STAGES(4))
    ACT_LO_EXT(
          .prmry_aclk(1'b1),
      .prmry_resetn(1'b1),
      //S_AXI_ARESETN,
      .prmry_in(exr_d1),
      .prmry_ack(/* open */),
      .scndry_out(exr_lpf[0]),
      .scndry_aclk(Slowest_Sync_Clk),
      .scndry_resetn(1'b1),
      //S_AXIS_ARESETN,
      .prmry_vect_in(2'b00),
      .scndry_vect_out(/* open */));

        //-----------------------------------
  end
  endgenerate
  //-----------------------------------------------------------------------------
  // This If-generate selects an active high input for Auxiliary System Reset 
  //-----------------------------------------------------------------------------
  generate if ((C_AUX_RESET_HIGH != 1'b0)) begin: ACTIVE_HIGH_AUX
      assign asr_d1 = Auxiliary_System_Reset;
    //-----------------------------------
    cdc_sync #(
          .C_CDC_TYPE(1),
      .C_RESET_STATE(0),
      .C_SINGLE_BIT(1),
      .C_FLOP_INPUT(0),
      .C_VECTOR_WIDTH(2),
      .C_MTBF_STAGES(4))
    ACT_HI_AUX(
          .prmry_aclk(1'b1),
      .prmry_resetn(1'b1),
      //S_AXI_ARESETN,
      .prmry_in(asr_d1),
      .prmry_ack(/* open */),
      .scndry_out(asr_lpf[0]),
      .scndry_aclk(Slowest_Sync_Clk),
      .scndry_resetn(1'b1),
      //S_AXIS_ARESETN,
      .prmry_vect_in(2'b00),
      .scndry_vect_out(/* open */));

        //-----------------------------------
  end
  endgenerate
  //-----------------------------------------------------------------------------
  // This If-generate selects an active low input for Auxiliary System Reset 
  //-----------------------------------------------------------------------------
  generate if ((C_AUX_RESET_HIGH == 1'b0)) begin: ACTIVE_LOW_AUX
      //-----------------------------------
    assign asr_d1 =  ~Auxiliary_System_Reset;
    cdc_sync #(
          .C_CDC_TYPE(1),
      .C_RESET_STATE(0),
      .C_SINGLE_BIT(1),
      .C_FLOP_INPUT(0),
      .C_VECTOR_WIDTH(2),
      .C_MTBF_STAGES(4))
    ACT_LO_AUX(
          .prmry_aclk(1'b1),
      .prmry_resetn(1'b1),
      //S_AXI_ARESETN,
      .prmry_in(asr_d1),
      .prmry_ack(/* open */),
      .scndry_out(asr_lpf[0]),
      .scndry_aclk(Slowest_Sync_Clk),
      .scndry_resetn(1'b1),
      //S_AXIS_ARESETN,
      .prmry_vect_in(2'b00),
      .scndry_vect_out(/* open */));

        //-----------------------------------
  end
  endgenerate
  //-----------------------------------------------------------------------------
  // This For-generate creates the low pass filter D-Flip Flops
  //-----------------------------------------------------------------------------
  genvar i;
  generate for (i=1; i <= C_EXT_RST_WIDTH - 1; i = i + 1) begin: EXT_LPF
      //--------------------------------------
    always @(posedge Slowest_Sync_Clk) begin
      exr_lpf[i] <= exr_lpf[i - 1];
    end

        //--------------------------------------
  end
  endgenerate
  //----------------------------------------------------------------------------------------
  // Implement the 'AND' function on the for the LPF
  //----------------------------------------------------------------------------------------
  always @(exr_lpf) begin : P2
    reg loop_and;
    reg loop_nand;

    loop_and = 1'b1;
    loop_nand = 1'b1;
    for (j=0; j <= C_EXT_RST_WIDTH - 1; j = j + 1) begin
      loop_and = loop_and & exr_lpf[j];
      loop_nand = loop_nand &  ~exr_lpf[j];
    end
    exr_and <= loop_and;
    exr_nand <= loop_nand;
  end

  //-----------------------------------------------------------------------------
  // This For-generate creates the low pass filter D-Flip Flops
  //-----------------------------------------------------------------------------
  genvar k;
  generate for (k=1; k <= C_AUX_RST_WIDTH - 1; k = k + 1) begin: AUX_LPF
      //--------------------------------------
    always @(posedge Slowest_Sync_Clk) begin
      asr_lpf[k] <= asr_lpf[k - 1];
    end

        //--------------------------------------
  end
  endgenerate
  //----------------------------------------------------------------------------------------
  // Implement the 'AND' function on the for the LPF
  //----------------------------------------------------------------------------------------
  always @(asr_lpf) begin : P1
    reg aux_loop_and;
    reg aux_loop_nand;

    aux_loop_and = 1'b1;
    aux_loop_nand = 1'b1;
    for (m=0; m <= C_AUX_RST_WIDTH - 1; m = m + 1) begin
      aux_loop_and = aux_loop_and & asr_lpf[m];
      aux_loop_nand = aux_loop_nand &  ~asr_lpf[m];
    end
    asr_and <= aux_loop_and;
    asr_nand <= aux_loop_nand;
  end


endmodule
