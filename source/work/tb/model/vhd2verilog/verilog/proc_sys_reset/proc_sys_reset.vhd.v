// File ../vhd/proc_sys_reset.vhd translated with vhd2vl 3.0 VHDL to Verilog RTL translator
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
// proc_sys_reset - entity/architecture pair
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

module proc_sys_reset#(
// %% C_FAMILY                 : string    := "virtex7";
parameter [31:0] C_EXT_RST_WIDTH=4,
parameter [31:0] C_AUX_RST_WIDTH=4,
parameter C_EXT_RESET_HIGH=1'b0,
parameter C_AUX_RESET_HIGH=1'b1,
parameter [31:0] C_NUM_BUS_RST=1,
parameter [31:0] C_NUM_PERP_RST=1,
parameter [31:0] C_NUM_INTERCONNECT_ARESETN=1,
parameter [31:0] C_NUM_PERP_ARESETN=1
        )(
input wire slowest_sync_clk,
input wire ext_reset_in,
input wire aux_reset_in,
input wire mb_debug_sys_rst,
input wire dcm_locked,
output reg mb_reset,
output reg [0:C_NUM_BUS_RST - 1] bus_struct_reset,
output reg [0:C_NUM_PERP_RST - 1] peripheral_reset,
output reg [0:C_NUM_INTERCONNECT_ARESETN - 1] interconnect_aresetn,
output reg [0:C_NUM_PERP_ARESETN - 1] peripheral_aresetn
);

// %%%% // %% C_FAMILY                 : string    := "virtex7";
// %%%% parameter [31:0] C_EXT_RST_WIDTH=4;
// %%%% parameter [31:0] C_AUX_RST_WIDTH=4;
// %%%% parameter C_EXT_RESET_HIGH=1'b0;
// %%%% parameter C_AUX_RESET_HIGH=1'b1;
// %%%% parameter [31:0] C_NUM_BUS_RST=1;
// %%%% parameter [31:0] C_NUM_PERP_RST=1;
// %%%% parameter [31:0] C_NUM_INTERCONNECT_ARESETN=1;
// %%%% parameter [31:0] C_NUM_PERP_ARESETN=1;
// 3/15/2010
// from MDM
// DCM locked information
// -- from PPC
// Core_Reset_Req_0     : in  std_logic;
// Chip_Reset_Req_0     : in  std_logic;
// System_Reset_Req_0   : in  std_logic;
// Core_Reset_Req_1     : in  std_logic;
// Chip_Reset_Req_1     : in  std_logic;
// System_Reset_Req_1   : in  std_logic;
// RstcPPCresetcore_0   : out std_logic := '0';
// RstcPPCresetchip_0   : out std_logic := '0';
// RstcPPCresetsys_0    : out std_logic := '0';
// RstcPPCresetcore_1   : out std_logic := '0';
// RstcPPCresetchip_1   : out std_logic := '0';
// RstcPPCresetsys_1    : out std_logic := '0';
// to Microblaze active high reset
// active high resets
// active low resets



//-----------------------------------------------------------------------------
// Architecture
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Constant Declarations
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Signal and Type Declarations
// signal Core_Reset_Req_0_d1   : std_logic := '0';  -- delayed Core_Reset_Req
// signal Core_Reset_Req_0_d2   : std_logic := '0';  -- delayed Core_Reset_Req
// signal Core_Reset_Req_0_d3   : std_logic := '0';  -- delayed Core_Reset_Req
// signal Core_Reset_Req_1_d1   : std_logic := '0';  -- delayed Core_Reset_Req
// signal Core_Reset_Req_1_d2   : std_logic := '0';  -- delayed Core_Reset_Req
// signal Core_Reset_Req_1_d3   : std_logic := '0';  -- delayed Core_Reset_Req
wire core_cnt_en_0 = 1'b0;  // Core_Reset_Req_0 counter enable
wire core_cnt_en_1 = 1'b0;  // Core_Reset_Req_1 counter enable
wire core_req_edge_0 = 1'b1;  // Rising edge of Core_Reset_Req_0
wire core_req_edge_1 = 1'b1;  // Rising edge of Core_Reset_Req_1
wire [3:0] core_cnt_0;  // core counter output
wire [3:0] core_cnt_1;  // core counter output
wire lpf_reset;  // Low pass filtered ext or aux
//signal Chip_Reset_Req        : std_logic := '0';
//signal System_Reset_Req      : std_logic := '0';
wire Bsr_out;
wire Pr_out;  // signal Core_out  : std_logic;
// signal Chip_out  : std_logic;
// signal Sys_out   : std_logic;
wire MB_out;  //-----------------------------------------------------------------------------
// Attributes to synthesis
//-----------------------------------------------------------------------------
// %% attribute equivalent_register_removal: string;
// %% attribute equivalent_register_removal of bus_struct_reset : signal is "no";
// %% attribute equivalent_register_removal of peripheral_reset : signal is "no";
// %% 
// %% attribute equivalent_register_removal of interconnect_aresetn : signal is "no";
// %% attribute equivalent_register_removal of peripheral_aresetn : signal is "no";

  //-----------------------------------------------------------------------------
  // ---------------------
  // -- MB_RESET_HIGH_GEN: Generate active high reset for Micro-Blaze
  // ---------------------
  // MB_RESET_HIGH_GEN: if C_INT_RESET_HIGH = 1 generate
  // begin
  always @(posedge slowest_sync_clk) begin
    mb_reset <= MB_out;
  end

  // ----------------------------------------------------------------------------
  // -- This For-generate creates D-Flip Flops for the Bus_Struct_Reset output(s)
  // ----------------------------------------------------------------------------
  genvar i;
  generate for (i=0; i <= C_NUM_BUS_RST - 1; i = i + 1) begin: BSR_OUT_DFF
      always @(posedge slowest_sync_clk) begin
      bus_struct_reset[i] <= Bsr_out;
    end

  end
  endgenerate
  // ---------------------------------------------------------------------------
  // This For-generate creates D-Flip Flops for the Interconnect_aresetn op(s)
  // ---------------------------------------------------------------------------
  genvar i;
  generate for (i=0; i <= C_NUM_INTERCONNECT_ARESETN - 1; i = i + 1) begin: ACTIVE_LOW_BSR_OUT_DFF
      always @(posedge slowest_sync_clk) begin
      interconnect_aresetn[i] <=  ~(Bsr_out);
    end

  end
  endgenerate
  //-----------------------------------------------------------------------------
  // ----------------------------------------------------------------------------
  // -- This For-generate creates D-Flip Flops for the Peripheral_Reset output(s)
  // ----------------------------------------------------------------------------
  genvar i;
  generate for (i=0; i <= C_NUM_PERP_RST - 1; i = i + 1) begin: PR_OUT_DFF
      always @(posedge slowest_sync_clk) begin
      peripheral_reset[i] <= Pr_out;
    end

  end
  endgenerate
  // ----------------------------------------------------------------------------
  // This For-generate creates D-Flip Flops for the Peripheral_aresetn op(s)
  // ----------------------------------------------------------------------------
  genvar i;
  generate for (i=0; i <= C_NUM_PERP_ARESETN - 1; i = i + 1) begin: ACTIVE_LOW_PR_OUT_DFF
      always @(posedge slowest_sync_clk) begin
      peripheral_aresetn[i] <=  ~(Pr_out);
    end

  end
  endgenerate
  //-----------------------------------------------------------------------------
  // This process defines the RstcPPCreset and MB_Reset outputs
  //-----------------------------------------------------------------------------
  // Rstc_output_PROCESS_0: process (Slowest_sync_clk)
  // begin
  //   if (Slowest_sync_clk'event and Slowest_sync_clk = '1') then
  //     RstcPPCresetcore_0  <= not (core_cnt_0(3) and core_cnt_0(2) and
  //                                 core_cnt_0(1) and core_cnt_0(0))
  //                            or Core_out;
  //     RstcPPCresetchip_0  <= Chip_out;
  //     RstcPPCresetsys_0   <= Sys_out;
  //   end if;
  // end process;
  // Rstc_output_PROCESS_1: process (Slowest_sync_clk)
  // begin
  //   if (Slowest_sync_clk'event and Slowest_sync_clk = '1') then
  //     RstcPPCresetcore_1  <= not (core_cnt_1(3) and core_cnt_1(2) and
  //                                 core_cnt_1(1) and core_cnt_1(0))
  //                               or Core_out;
  //     RstcPPCresetchip_1  <= Chip_out;
  //     RstcPPCresetsys_1   <= Sys_out;
  //   end if;
  // end process;
  //-----------------------------------------------------------------------------
  //-------------------------------------------------------------------------------
  //-- This process delays signals so the the edge can be detected and used
  //--  Double register to sync up with slowest_sync_clk
  //-------------------------------------------------------------------------------
  //  DELAY_PROCESS_0: process (Slowest_sync_clk)
  //  begin
  //    if (Slowest_sync_clk'event and Slowest_sync_clk = '1') then
  //      core_reset_req_0_d1   <= Core_Reset_Req_0;
  //      core_reset_req_0_d2   <= core_reset_req_0_d1;
  //      core_reset_req_0_d3   <= core_reset_req_0_d2;
  //    end if;
  //  end process;
  //
  //  DELAY_PROCESS_1: process (Slowest_sync_clk)
  //  begin
  //    if (Slowest_sync_clk'event and Slowest_sync_clk = '1') then
  //      core_reset_req_1_d1   <= Core_Reset_Req_1;
  //      core_reset_req_1_d2   <= core_reset_req_1_d1;
  //      core_reset_req_1_d3   <= core_reset_req_1_d2;
  //    end if;
  //  end process;
  // ** -- -------------------------------------------------------------------------------
  // ** -- -- This instantiates a counter to ensure the Core_Reset_Req_* will genereate a
  // ** -- -- RstcPPCresetcore_* that is a mimimum of 15 clocks
  // ** -- -------------------------------------------------------------------------------
  // ** --   CORE_RESET_0 : entity proc_sys_reset_v5_0.UPCNT_N
  // ** --   generic map (C_SIZE => 4)
  // ** --   port map(
  // ** --     Data     => "0000",                    -- in  STD_LOGIC_VECTOR (C_SIZE-1 downto 0);
  // ** --     Cnt_en   => core_cnt_en_0,             -- in  STD_LOGIC;                           
  // ** --     Load     => '0',                       -- in  STD_LOGIC;                           
  // ** --     Clr      => core_req_edge_0,           -- in  STD_LOGIC;                           
  // ** --     Clk      => Slowest_sync_clk,          -- in  STD_LOGIC;                           
  // ** --     Qout     => core_cnt_0                 -- out STD_LOGIC_VECTOR (C_SIZE-1 downto 0) 
  // ** --   );
  // ** -- 
  // ** --   CORE_RESET_1 : entity proc_sys_reset_v5_0.UPCNT_N
  // ** --   generic map (C_SIZE => 4)
  // ** --   port map(
  // ** --     Data     => "0000",                    -- in  STD_LOGIC_VECTOR (C_SIZE-1 downto 0);
  // ** --     Cnt_en   => core_cnt_en_1,             -- in  STD_LOGIC;                           
  // ** --     Load     => '0',                       -- in  STD_LOGIC;                           
  // ** --     Clr      => core_req_edge_1,           -- in  STD_LOGIC;                           
  // ** --     Clk      => Slowest_sync_clk,          -- in  STD_LOGIC;                           
  // ** --     Qout     => core_cnt_1                 -- out STD_LOGIC_VECTOR (C_SIZE-1 downto 0) 
  // ** --   );
  // ** -- 
  // ** -- -------------------------------------------------------------------------------
  // ** -- -- CORE_RESET_PROCESS
  // ** -- -------------------------------------------------------------------------------
  // ** -- --  This generates the reset pulse and the count enable to core reset counter
  // ** -- --
  // ** --   CORE_RESET_PROCESS_0: process (Slowest_sync_clk)
  // ** --   begin
  // ** --      if (Slowest_sync_clk'event and Slowest_sync_clk = '1') then
  // ** --        core_cnt_en_0   <= not (core_cnt_0(3) and core_cnt_0(2) and core_cnt_0(1));
  // ** --                           --or not core_req_edge_0;
  // ** --        --core_req_edge_0 <= not(Core_Reset_Req_0_d2 and not Core_Reset_Req_0_d3);
  // ** --      end if;
  // ** --   end process;
  // ** -- 
  // ** --   CORE_RESET_PROCESS_1: process (Slowest_sync_clk)
  // ** --   begin
  // ** --     if (Slowest_sync_clk'event and Slowest_sync_clk = '1') then
  // ** --       core_cnt_en_1   <= not (core_cnt_1(3) and core_cnt_1(2) and core_cnt_1(1));
  // ** --                          --or not core_req_edge_1;
  // ** --       --core_req_edge_1 <= not(Core_Reset_Req_1_d2 and not Core_Reset_Req_1_d3);
  // ** --     end if;
  // ** --   end process;
  //-----------------------------------------------------------------------------
  // This instantiates a low pass filter to filter both External and Auxiliary
  // Reset Inputs.
  //-----------------------------------------------------------------------------
  lpf #(
      .C_EXT_RST_WIDTH(C_EXT_RST_WIDTH),
    .C_AUX_RST_WIDTH(C_AUX_RST_WIDTH),
    .C_EXT_RESET_HIGH(C_EXT_RESET_HIGH),
    .C_AUX_RESET_HIGH(C_AUX_RESET_HIGH))
  ext_lpf(
      .MB_Debug_Sys_Rst(mb_debug_sys_rst),
    //  in  std_logic
    .Dcm_locked(dcm_locked),
    //  in  std_logic
    .External_System_Reset(ext_reset_in),
    //  in  std_logic
    .Auxiliary_System_Reset(aux_reset_in),
    //  in  std_logic
    .Slowest_Sync_Clk(slowest_sync_clk),
    //  in  std_logic
    // %%    Lpf_reset              => lpf_reset                --  out std_logic
    .Lpf_reset(lpf_reset));

  //-----------------------------------------------------------------------------
  // This instantiates the sequencer
  //  This controls the time between resets becoming inactive
  //-----------------------------------------------------------------------------
  // System_Reset_Req <= System_Reset_Req_0 or System_Reset_Req_1;
  // Chip_Reset_Req   <= Chip_Reset_Req_0 or Chip_Reset_Req_1;
  sequence seq(
      .Lpf_reset(lpf_reset),
    // in  std_logic
    //System_Reset_Req  => '0', -- System_Reset_Req,     -- in  std_logic
    //Chip_Reset_Req    => '0', -- Chip_Reset_Req,       -- in  std_logic
    .Slowest_Sync_Clk(slowest_sync_clk),
    // in  std_logic
    .Bsr_out(Bsr_out),
    // out std_logic
    .Pr_out(Pr_out),
    // out std_logic
    //Core_out          => open, -- Core_out,            -- out std_logic
    //Chip_out          => open, -- Chip_out,            -- out std_logic
    //Sys_out           => open, -- Sys_out,             -- out std_logic
    .MB_out(MB_out));

    // out std_logic
//END_SINGLE_FILE_TAG

endmodule
