// File ../vhd/proc_sys_reset_v5_0/sequence.vhd translated with vhd2vl 3.0 VHDL to Verilog RTL translator
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
// sequence - entity/architecture pair
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
//              -- proc_sys_reset.vhd
//                 -- upcnt_n.vhd
//                 -- lpf.vhd
//                 -- sequence.vhd
//-----------------------------------------------------------------------------
// Filename:        sequence.vhd
//
// Description:
//                  This file control the sequencing coming out of a reset.
//                  The sequencing is as follows:
//                  Bus_Struct_Reset comes out of reset first.  Either when the
//                     external or auxiliary reset goes inactive or 16 clocks
//                     after a PPC Chip_Reset_Request, or 30 clocks after a PPC
//                     System_Reset_Request.
//                  Peripheral_Reset comes out of reset 16 clocks after
//                     Bus_Struct_Reset.
//                  The PPC resetcore, comes out of reset
//                     16 clocks after Peripheral_Reset.
//                  The PPC resetchip and resetsystem come out of reset
//                     at the same time as Bus_Struct_Reset.
//-----------------------------------------------------------------------------
// Author:      Kurt Conover
// History:
//  Kurt Conover      11/12/01      -- First Release
//  LC Whittle	     10/11/2004	-- Update for NCSim
//  rolandp          04/16/2007         -- v2.00a
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
//-----------------------------------------------------------------------------
// Port Declaration
//-----------------------------------------------------------------------------
// Definition of Generics:
//
// Definition of Ports:
//          Lpf_reset            -- Low Pass Filtered in
//          System_Reset_Req     -- System Reset Request
//          Chip_Reset_Req       -- Chip Reset Request
//          Slowest_Sync_Clk     -- Clock
//          Bsr_out              -- Bus Structure Reset out
//          Pr_out               -- Peripheral Reset out
//          Core_out             -- Core reset out
//          Chip_out             -- Chip reset out
//          Sys_out              -- System reset out
//          MB_out               -- MB reset out
//
//-----------------------------------------------------------------------------
// no timescale needed

module sequence(
input wire Lpf_reset,
input wire Slowest_Sync_Clk,
output wire Bsr_out,
output wire Pr_out,
output wire MB_out
);

// System_Reset_Req  : in  std_logic;
// Chip_Reset_Req    : in  std_logic;
// Core_out          : out std_logic;
// Chip_out          : out std_logic;
// Sys_out           : out std_logic;



parameter CLEAR = 1'b0;
parameter BSR_END_LPF_CHIP = 6'b001100;  // 12
parameter BSR_END_SYS = 6'b011001;  // 25
parameter PR_END_LPF_CHIP = 6'b011100;  // 28
parameter PR_END_SYS = 6'b101001;  // 41
parameter CORE_END_LPF_CHIP = 6'b101100;  // 44
parameter CORE_END_SYS = 6'b111001;  // 57
parameter CHIP_END_LPF_CHIP = BSR_END_LPF_CHIP;
parameter CHIP_END_SYS = BSR_END_SYS;
parameter SYS_END_LPF = BSR_END_LPF_CHIP;
parameter SYS_END_SYS = BSR_END_SYS;
reg bsr = 1'b0;
reg [2:0] bsr_dec = 1'b0;
reg pr = 1'b0;
reg [2:0] pr_dec = 1'b0;
reg  core = 1'b0;
reg [2:0] core_dec;
//%%wire Chip = 1'b0;
//%%wire [2:0] chip_dec = 1'b0;
//%%wire Sys = 1'b0;
//%%wire [2:0] sys_dec = 1'b0;
//%%wire chip_Reset_Req_d1 = 1'b0;  // delayed Chip_Reset_Req
//%%wire chip_Reset_Req_d2 = 1'b0;  // delayed Chip_Reset_Req
//%%wire chip_Reset_Req_d3 = 1'b0;  // delayed Chip_Reset_Req
//%%wire system_Reset_Req_d1 = 1'b0;  // delayed System_Reset_Req
//%%wire system_Reset_Req_d2 = 1'b0;  // delayed System_Reset_Req
//%%wire system_Reset_Req_d3 = 1'b0;  // delayed System_Reset_Req
wire [5:0] seq_cnt;
reg seq_cnt_en = 1'b0;
reg seq_clr = 1'b0;
//%%wire ris_edge = 1'b0;
//%%wire sys_edge = 1'b0;
reg from_sys;

initial begin
    bsr = 1'b0;
    bsr_dec = 2'b0;
    pr = 1'b0;
    pr_dec = 2'b0;
    core = 1'b0;
    core_dec = 2'b0;
    seq_cnt_en = 1'b0;
    seq_clr = 1'b0;
end
//-----------------------------------------------------------------------------
// Component Declarations
//-----------------------------------------------------------------------------

  assign Pr_out = pr;
  assign Bsr_out = bsr;
  assign MB_out = core;
  // Core_out <= core;
  // Chip_out <= chip or sys;
  // Sys_out  <= sys;
  //-----------------------------------------------------------------------------
  // This process remembers that the reset was caused be 
  // System_Reset_Req
  //-----------------------------------------------------------------------------
  always @(posedge Slowest_sync_clk) begin
    //if Lpf_reset='1' or system_reset_req_d3='1' then
    if((Lpf_reset == 1'b1)) begin
      from_sys <= 1'b1;
      //elsif Chip_Reset_Req_d3='1' then
      //  from_sys <= '0';
    end
    else if((core == 1'b0)) begin
      from_sys <= 1'b0;
    end
  end

  //-----------------------------------------------------------------------------
  // This instantiates a counter to control the sequencing
  //-----------------------------------------------------------------------------
  upcnt_n #(
      .C_SIZE(6))
  SEQ_COUNTER(
      .Data(6'b000000),
    .Cnt_en(seq_cnt_en),
    .Load(1'b0),
    .Clr(seq_clr),
    .Clk(Slowest_sync_clk),
    .Qout(seq_cnt));

  //-----------------------------------------------------------------------------
  // SEQ_CNT_EN_PROCESS
  //-----------------------------------------------------------------------------
  //  This generates the reset pulse and the count enable to core reset counter
  //  count until all outputs are inactive
  //-----------------------------------------------------------------------------
  always @(posedge Slowest_sync_clk) begin
    // %%       if (Lpf_reset='1'           --or 
    // %%           --System_Reset_Req_d3='1' or
    // %%           --Chip_Reset_Req_d3='1'   or 
    // %% 	  --ris_edge = '1'
    // %% 	  ) then
    if((Lpf_reset == 1'b1)) begin
      seq_cnt_en <= 1'b1;
    end
    else if((core == 1'b0)) begin
      // Core always present and always last 
      seq_cnt_en <= 1'b0;
    end
  end

  //-----------------------------------------------------------------------------
  // SEQ_CLR_PROCESS
  //-----------------------------------------------------------------------------
  //  This generates the reset to the sequence counter
  //  Clear the counter on a rising edge of chip or system request or low pass
  //  filter output
  //-----------------------------------------------------------------------------
  always @(posedge Slowest_sync_clk) begin
    // if  ris_edge = '1' or Lpf_reset = '1' then
    if((Lpf_reset == 1'b1)) begin
      seq_clr <= 1'b0;
    end
    else begin
      seq_clr <= 1'b1;
    end
  end

  //-----------------------------------------------------------------------------
  // This process defines the Peripheral_Reset output signal
  //-----------------------------------------------------------------------------
  always @(posedge Slowest_sync_clk) begin
    //if  ris_edge = '1' or Lpf_reset = '1' then
    if((Lpf_reset == 1'b1)) begin
      pr <= 1'b1;
    end
    else if((pr_dec[2] == 1'b1)) begin
      pr <= 1'b0;
    end
  end

  //-----------------------------------------------------------------------------
  // This process decodes the sequence counter for PR to use
  //-----------------------------------------------------------------------------
  always @(posedge Slowest_sync_clk) begin
    if(((seq_cnt[5:3] == PR_END_LPF_CHIP[5:3] && from_sys == 1'b0) || (seq_cnt[5:3] == PR_END_SYS[5:3] && from_sys == 1'b1))) begin
      pr_dec[0] <= 1'b1;
    end
    else begin
      pr_dec[0] <= 1'b0;
    end
    if(((seq_cnt[2:0] == PR_END_LPF_CHIP[2:0] && from_sys == 1'b0) || (seq_cnt[2:0] == PR_END_SYS[2:0] && from_sys == 1'b1))) begin
      pr_dec[1] <= 1'b1;
    end
    else begin
      pr_dec[1] <= 1'b0;
    end
    pr_dec[2] <= pr_dec[1] & pr_dec[0];
  end

  //-----------------------------------------------------------------------------
  // This process defines the Bus_Struct_Reset output signal
  //-----------------------------------------------------------------------------
  always @(posedge Slowest_sync_clk) begin
    //if ris_edge = '1' or Lpf_reset = '1' then
    if((Lpf_reset == 1'b1)) begin
      bsr <= 1'b1;
    end
    else if((bsr_dec[2] == 1'b1)) begin
      bsr <= 1'b0;
    end
  end

  //-----------------------------------------------------------------------------
  // This process decodes the sequence counter for BSR to use
  //-----------------------------------------------------------------------------
  always @(posedge Slowest_sync_clk) begin
    if(((seq_cnt[5:3] == BSR_END_LPF_CHIP[5:3] && from_sys == 1'b0) || (seq_cnt[5:3] == BSR_END_SYS[5:3] && from_sys == 1'b1))) begin
      bsr_dec[0] <= 1'b1;
    end
    else begin
      bsr_dec[0] <= 1'b0;
    end
    if(((seq_cnt[2:0] == BSR_END_LPF_CHIP[2:0] && from_sys == 1'b0) || (seq_cnt[2:0] == BSR_END_SYS[2:0] && from_sys == 1'b1))) begin
      bsr_dec[1] <= 1'b1;
    end
    else begin
      bsr_dec[1] <= 1'b0;
    end
    bsr_dec[2] <= bsr_dec[1] & bsr_dec[0];
  end

  //-----------------------------------------------------------------------------
  // This process defines the Peripheral_Reset output signal
  //-----------------------------------------------------------------------------
  always @(posedge Slowest_sync_clk) begin
    // if  ris_edge = '1' or Lpf_reset = '1' then
    if((Lpf_reset == 1'b1)) begin
      core <= 1'b1;
    end
    else if((core_dec[2] == 1'b1)) begin
      core <= 1'b0;
    end
  end

  //-----------------------------------------------------------------------------
  // This process decodes the sequence counter for PR to use
  //-----------------------------------------------------------------------------
  always @(posedge Slowest_sync_clk) begin
    if(((seq_cnt[5:3] == CORE_END_LPF_CHIP[5:3] && from_sys == 1'b0) || (seq_cnt[5:3] == CORE_END_SYS[5:3] && from_sys == 1'b1))) begin
      core_dec[0] <= 1'b1;
    end
    else begin
      core_dec[0] <= 1'b0;
    end
    if(((seq_cnt[2:0] == CORE_END_LPF_CHIP[2:0] && from_sys == 1'b0) || (seq_cnt[2:0] == CORE_END_SYS[2:0] && from_sys == 1'b1))) begin
      core_dec[1] <= 1'b1;
    end
    else begin
      core_dec[1] <= 1'b0;
    end
    core_dec[2] <= core_dec[1] & core_dec[0];
  end

    //-------------------------------------------------------------------------------
  //-- This process defines the Chip output signal
  //-------------------------------------------------------------------------------
  //  CHIP_PROCESS: process (Slowest_sync_clk)
  //  begin
  //    if (Slowest_sync_clk'event and Slowest_sync_clk = '1') then
  //      -- if ris_edge = '1' or Lpf_reset = '1' then
  //      if Lpf_reset = '1' then
  //        chip <= '1';
  //      elsif chip_dec(2) = '1' then
  //        chip <= '0';
  //      end if;
  //    end if;
  //  end process;
  //
  //-------------------------------------------------------------------------------
  //-- This process decodes the sequence counter for Chip to use
  //-- sys is overlapping the chip reset and thus no need to decode this here
  //-------------------------------------------------------------------------------
  //  CHIP_DECODE_PROCESS: process (Slowest_sync_clk)
  //  begin
  //    if (Slowest_sync_clk'event and Slowest_sync_clk = '1') then
  //      if (seq_cnt(5 downto 2) = CHIP_END_LPF_CHIP(5 downto 2))  then
  //         chip_dec(0) <= '1';
  //      else
  //         chip_dec(0) <= '0';
  //      end if;
  //      if (seq_cnt(1 downto 0) = CHIP_END_LPF_CHIP(1 downto 0)) then
  //         chip_dec(1) <= '1';
  //      else
  //         chip_dec(1) <= '0';
  //      end if;
  //      chip_dec(2) <= chip_dec(1) and chip_dec(0);
  //    end if;
  //  end process;
  //-------------------------------------------------------------------------------
  //-- This process defines the Sys output signal
  //-------------------------------------------------------------------------------
  //  SYS_PROCESS: process (Slowest_sync_clk)
  //  begin
  //    if (Slowest_sync_clk'event and Slowest_sync_clk = '1') then
  //      if sys_edge = '1' or Lpf_reset = '1' then
  //        sys <= '1';
  //      elsif sys_dec(2) = '1' then
  //        sys <= '0';
  //      end if;
  //    end if;
  //  end process;
  //  
  //-------------------------------------------------------------------------------
  //-- This process decodes the sequence counter for Sys to use
  //-------------------------------------------------------------------------------
  //  SYS_DECODE_PROCESS: process (Slowest_sync_clk)
  //  begin
  //    if (Slowest_sync_clk'event and Slowest_sync_clk = '1') then
  //      if (seq_cnt(5 downto 3) = SYS_END_LPF(5 downto 3) and from_sys = '0') or
  //         (seq_cnt(5 downto 3) = SYS_END_SYS(5 downto 3) and from_sys = '1')  then
  //        sys_dec(0) <= '1';
  //      else
  //        sys_dec(0) <= '0';
  //      end if;
  //      if (seq_cnt(2 downto 0) = SYS_END_LPF(2 downto 0) and from_sys = '0') or
  //         (seq_cnt(2 downto 0) = SYS_END_SYS(2 downto 0) and from_sys = '1')  then
  //        sys_dec(1) <= '1';
  //      else
  //        sys_dec(1) <= '0';
  //      end if;
  //      sys_dec(2) <= sys_dec(1) and sys_dec(0);
  //    end if;
  //  end process;
  //
  //-------------------------------------------------------------------------------
  //-- This process delays signals so the the edge can be detected and used
  //-------------------------------------------------------------------------------
  //  DELAY_PROCESS: process (Slowest_sync_clk)
  //  begin
  //    if (Slowest_sync_clk'event and Slowest_sync_clk = '1') then
  //      chip_reset_req_d1   <= Chip_Reset_Req  ;
  //      chip_reset_req_d2   <= chip_Reset_Req_d1  ;
  //      chip_reset_req_d3   <= chip_Reset_Req_d2  ;
  //      system_reset_req_d1 <= System_Reset_Req;
  //      system_reset_req_d2 <= system_Reset_Req_d1;
  //      system_reset_req_d3 <= system_Reset_Req_d2;
  //    end if;
  //  end process;
  //-----------------------------------------------------------------------------
  // This process creates a signal that goes high on the rising edge of either
  // Chip_Reset_Req or System_Reset_Req
  //-----------------------------------------------------------------------------
  //  RIS_EDGE_PROCESS: process (Slowest_sync_clk)
  //  begin
  //    if (Slowest_sync_clk'event and Slowest_sync_clk = '1') then
  //      if (chip_reset_req_d3='0'   and chip_Reset_Req_d2= '1') -- rising edge
  //         or (system_reset_req_d3='0' and system_Reset_Req_d2='1') then
  //        ris_edge <= '1';
  //      else
  //        ris_edge <='0';
  //      end if;
  //    end if;
  //  end process;
  //-----------------------------------------------------------------------------
  // This process creates a signal that goes high on the rising edge of
  // System_Reset_Req
  //-----------------------------------------------------------------------------
  //  SYS_EDGE_PROCESS: process (Slowest_sync_clk)
  //  begin
  //    if (Slowest_sync_clk'event and Slowest_sync_clk = '1') then
  //      if (system_reset_req_d3='0' and system_reset_req_d2='1') then
  //         sys_edge <= '1';
  //      else
  //         sys_edge <='0';
  //      end if;
  //    end if;
  //  end process;

endmodule
