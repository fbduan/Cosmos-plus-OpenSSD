///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2014 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : Version : 2014.4
//  \   \         Description : Xilinx Unified Simulation Library Component
//  /   /                  5-input Dynamically Reconfigurable Look-Up-Table with Carry and Clock Enable
// /___/   /\     Filename : CFGLUT5.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    12/27/05 - Initial version.
//    12/13/11 - Added `celldefine and `endcelldefine (CR 524859).
//    05/13/13 - add IS_CLK_INVERTED
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps/1 ps

`celldefine

module CFGLUT5 #(
  `ifdef XIL_TIMING
  parameter LOC = "UNPLACED",
  `endif
  parameter [31:0] INIT = 32'h00000000,
  parameter [0:0] IS_CLK_INVERTED = 1'b0
)(
  output CDO,
  output O5,
  output O6,
  
  input CDI,
  input CE,
  input CLK,
  input I0,
  input I1,
  input I2,
  input I3,
  input I4
);
  
  wire IS_CLK_INVERTED_BIN;

  wire [4:0] A_in;
  wire CDI_in;
  wire CE_in;
  wire CLK_in;

`ifdef XIL_TIMING
  wire CDI_dly;
  wire CE_dly;
  wire CLK_dly;

  assign CDI_in = CDI_dly;
  assign CE_in = CE_dly;
  assign CLK_in = IS_CLK_INVERTED_BIN ^ CLK_dly;

  reg notifier;
    
  wire sh_clk_en_p;
  wire sh_clk_en_n;
  wire sh_ce_clk_en_p;
  wire sh_ce_clk_en_n;
`else
  assign CDI_in = CDI;
  assign CE_in = CE ;
  assign CLK_in = IS_CLK_INVERTED_BIN ^ CLK;
`endif

  assign A_in = {I4, I3, I2, I1, I0};
  assign IS_CLK_INVERTED_BIN = IS_CLK_INVERTED;

  reg  [31:0] data;
  reg first_time = 1'b1;

  initial
  begin
    assign  data = INIT;
    first_time <= #100000 1'b0;
    while ((CLK_in !== 1'b0) && (first_time == 1'b1)) #1000;
    deassign data;
  end

  always @(posedge CLK_in) 
    if (CE_in == 1'b1) 
      data[31:0] <=  #100 {data[30:0], CDI_in};

  assign  O6 = data[A_in[4:0]];
  assign  O5 = data[A_in[3:0]];
  assign  CDO = data[31];

`ifdef XIL_TIMING

  always @(notifier) 
    data[0] = 1'bx;

  assign sh_clk_en_p = ~IS_CLK_INVERTED_BIN;
  assign sh_clk_en_n = IS_CLK_INVERTED_BIN;
  assign sh_ce_clk_en_p = CE_in && ~IS_CLK_INVERTED_BIN;
  assign sh_ce_clk_en_n = CE_in && IS_CLK_INVERTED_BIN;

  specify
    (CLK => CDO) = (0:0:0, 0:0:0);
    (CLK => O5) = (0:0:0, 0:0:0);
    (CLK => O6) = (0:0:0, 0:0:0);
    (I0 => CDO) = (0:0:0, 0:0:0);
    (I0 => O5) = (0:0:0, 0:0:0);
    (I0 => O6) = (0:0:0, 0:0:0);
    (I1 => CDO) = (0:0:0, 0:0:0);
    (I1 => O5) = (0:0:0, 0:0:0);
    (I1 => O6) = (0:0:0, 0:0:0);
    (I2 => CDO) = (0:0:0, 0:0:0);
    (I2 => O5) = (0:0:0, 0:0:0);
    (I2 => O6) = (0:0:0, 0:0:0);
    (I3 => CDO) = (0:0:0, 0:0:0);
    (I3 => O5) = (0:0:0, 0:0:0);
    (I3 => O6) = (0:0:0, 0:0:0);
    (I4 => CDO) = (0:0:0, 0:0:0);
    (I4 => O5) = (0:0:0, 0:0:0);
    (I4 => O6) = (0:0:0, 0:0:0);
    $period (negedge CLK, 0:0:0, notifier);
    $period (posedge CLK, 0:0:0, notifier);
    $setuphold (negedge CLK, negedge CDI, 0:0:0, 0:0:0, notifier,sh_ce_clk_en_n,sh_ce_clk_en_n,CLK_dly,CDI_dly);
    $setuphold (negedge CLK, negedge CE, 0:0:0, 0:0:0, notifier,sh_clk_en_n,sh_clk_en_n,CLK_dly,CE_dly);
    $setuphold (negedge CLK, posedge CDI, 0:0:0, 0:0:0, notifier,sh_ce_clk_en_n,sh_ce_clk_en_n,CLK_dly,CDI_dly);
    $setuphold (negedge CLK, posedge CE, 0:0:0, 0:0:0, notifier,sh_clk_en_n,sh_clk_en_n,CLK_dly,CE_dly);
    $setuphold (posedge CLK, negedge CDI, 0:0:0, 0:0:0, notifier,sh_ce_clk_en_p,sh_ce_clk_en_p,CLK_dly,CDI_dly);
    $setuphold (posedge CLK, negedge CE, 0:0:0, 0:0:0, notifier,sh_clk_en_p,sh_clk_en_p,CLK_dly,CE_dly);
    $setuphold (posedge CLK, posedge CDI, 0:0:0, 0:0:0, notifier,sh_ce_clk_en_p,sh_ce_clk_en_p,CLK_dly,CDI_dly);
    $setuphold (posedge CLK, posedge CE, 0:0:0, 0:0:0, notifier,sh_clk_en_p,sh_clk_en_p,CLK_dly,CE_dly);
    $width (negedge CLK, 0:0:0, 0, notifier);
    $width (posedge CLK, 0:0:0, 0, notifier);
    specparam PATHPULSE$ = 0;
  endspecify
`endif

endmodule

`endcelldefine
