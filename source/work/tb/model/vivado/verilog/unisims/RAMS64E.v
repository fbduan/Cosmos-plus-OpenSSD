///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 1995/2014 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /     Vendor      : Xilinx
// \   \   \/      Version     : 2014.3
//  \   \          Description : Xilinx Timing Simulation Library Component
//  /   /                   Static Single Port Synchronous RAM 64-Deep by 1-Wide
// /___/   /\      Filename    : RAMS64E.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    07/02/10 - Initial version.
//    12/13/11 - Added `celldefine and `endcelldefine (CR 524859).
//    03/21/12 - CR649330 - Add RAM_ADDRESS_MASK to allow floating WADR6/7
//    04/16/13 - PR683925 - add invertible pin support.
// End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps

`celldefine

module RAMS64E #(
`ifdef XIL_TIMING
  parameter LOC = "UNPLACED",
`endif
  parameter [63:0] INIT = 64'h0000000000000000,
  parameter [0:0] IS_CLK_INVERTED = 1'b0,
  parameter [1:0] RAM_ADDRESS_MASK = 2'b00,
  parameter [1:0] RAM_ADDRESS_SPACE = 2'b00
)(
  output O,

  input ADR0,
  input ADR1,
  input ADR2,
  input ADR3,
  input ADR4,
  input ADR5,
  input CLK,
  input I,
  input WADR6,
  input WADR7,
  input WE
);
  
// define constants
  localparam MODULE_NAME = "RAMS64E";

  reg trig_attr = 1'b0;

`ifdef XIL_ATTR_TEST
  reg attr_test = 1'b1;
`else
  reg attr_test = 1'b0;
`endif
  reg attr_err = 1'b0;

  wire IS_CLK_INVERTED_BIN;

  wire [5:0] ADR_in;
  wire CLK_in;
  wire I_in;
  wire [1:0] WADR_in;
  wire WE_in;

  assign  IS_CLK_INVERTED_BIN = IS_CLK_INVERTED;

`ifdef XIL_TIMING
  wire [5:0] ADR_dly;
  wire CLK_dly;
  wire I_dly;
  wire [1:0] WADR_dly;
  wire WE_dly;

  reg notifier;

  wire sh_clk_en_p;
  wire sh_clk_en_n;
  wire sh_we_clk_en_p;
  wire sh_we_clk_en_n;

  assign ADR_in = ADR_dly;
  assign CLK_in = CLK_dly ^ IS_CLK_INVERTED_BIN;
  assign I_in = I_dly;
  assign WADR_in = WADR_dly;
  assign WE_in = (WE === 1'bz) || WE_dly; // rv 1
`else
  assign ADR_in = {ADR5, ADR4, ADR3, ADR2, ADR1, ADR0};
  assign CLK_in = CLK ^ IS_CLK_INVERTED_BIN;
  assign I_in = I;
  assign WADR_in = {WADR7, WADR6};
  assign WE_in = (WE === 1'bz) || WE; // rv 1
`endif

  reg [63:0] mem;

  initial begin
    mem = INIT;
`ifndef XIL_TIMING
    $display("Error: [Unisim %s-105] SIMPRIM primitive is not intended for direct instantiation in RTL or functional netlists. This primitive is only available in the SIMPRIM library for implemented netlists, please ensure you are pointing to the correct library. Instance %m", MODULE_NAME);
    #100;
    $finish;
`endif
  end

  initial begin
    #1;
    trig_attr = ~trig_attr;
  end

  always @ (trig_attr) begin
  #1;
    if ((attr_test == 1'b1) ||
        ((INIT < 64'h0000000000000000) || (INIT > 64'hFFFFFFFFFFFFFFFF))) begin
      $display("Error: [Unisim %s-101] INIT attribute is set to %h.  Legal values for this attribute are 64'h0000000000000000 to 64'hFFFFFFFFFFFFFFFF. Instance: %m", MODULE_NAME, INIT);
      attr_err = 1'b1;
    end

    if ((attr_test == 1'b1) ||
        ((IS_CLK_INVERTED !== 1'b0) && (IS_CLK_INVERTED !== 1'b1))) begin
      $display("Error: [Unisim %s-102] IS_CLK_INVERTED attribute is set to %b.  Legal values for this attribute are 1'b0 to 1'b1. Instance: %m", MODULE_NAME, IS_CLK_INVERTED);
      attr_err = 1'b1;
    end

    if ((attr_test == 1'b1) ||
        ((RAM_ADDRESS_MASK < 2'b00) || (RAM_ADDRESS_MASK > 2'b11))) begin
      $display("Error: [Unisim %s-103] RAM_ADDRESS_MASK attribute is set to %b.  Legal values for this attribute are 2'b00 to 2'b11. Instance: %m", MODULE_NAME, RAM_ADDRESS_MASK);
      attr_err = 1'b1;
    end

    if ((attr_test == 1'b1) ||
        ((RAM_ADDRESS_SPACE < 2'b00) || (RAM_ADDRESS_SPACE > 2'b11))) begin
      $display("Error: [Unisim %s-104] RAM_ADDRESS_SPACE attribute is set to %b.  Legal values for this attribute are 2'b00 to 2'b11. Instance: %m", MODULE_NAME, RAM_ADDRESS_SPACE);
      attr_err = 1'b1;
    end

    if (attr_err == 1'b1) $finish;
  end


  always @(posedge CLK_in)
    if (WE_in == 1'b1 &&
        (RAM_ADDRESS_MASK[1] || WADR_in[1] == RAM_ADDRESS_SPACE[1]) &&
        (RAM_ADDRESS_MASK[0] || WADR_in[0] == RAM_ADDRESS_SPACE[0]) )
      mem[ADR_in] <= #100 I_in;

   assign O = mem[ADR_in];

`ifdef XIL_TIMING
  always @(notifier) mem[ADR_in] <= 1'bx;
  assign sh_clk_en_p = ~IS_CLK_INVERTED_BIN;
  assign sh_clk_en_n = IS_CLK_INVERTED_BIN;
  assign sh_we_clk_en_p = WE_in && ~IS_CLK_INVERTED_BIN;
  assign sh_we_clk_en_n = WE_in && IS_CLK_INVERTED_BIN;

  specify
    (ADR0 => O) = (0:0:0, 0:0:0);
    (ADR1 => O) = (0:0:0, 0:0:0);
    (ADR2 => O) = (0:0:0, 0:0:0);
    (ADR3 => O) = (0:0:0, 0:0:0);
    (ADR4 => O) = (0:0:0, 0:0:0);
    (ADR5 => O) = (0:0:0, 0:0:0);
    (CLK => O) = (0:0:0, 0:0:0);
    $period (negedge CLK &&& WE, 0:0:0, notifier);
    $period (posedge CLK &&& WE, 0:0:0, notifier);
    $setuphold (negedge CLK, negedge ADR0, 0:0:0, 0:0:0, notifier,sh_we_clk_en_n,sh_we_clk_en_n, CLK_dly, ADR_dly[0]);
    $setuphold (negedge CLK, negedge ADR1, 0:0:0, 0:0:0, notifier,sh_we_clk_en_n,sh_we_clk_en_n, CLK_dly, ADR_dly[1]);
    $setuphold (negedge CLK, negedge ADR2, 0:0:0, 0:0:0, notifier,sh_we_clk_en_n,sh_we_clk_en_n, CLK_dly, ADR_dly[2]);
    $setuphold (negedge CLK, negedge ADR3, 0:0:0, 0:0:0, notifier,sh_we_clk_en_n,sh_we_clk_en_n, CLK_dly, ADR_dly[3]);
    $setuphold (negedge CLK, negedge ADR4, 0:0:0, 0:0:0, notifier,sh_we_clk_en_n,sh_we_clk_en_n, CLK_dly, ADR_dly[4]);
    $setuphold (negedge CLK, negedge ADR5, 0:0:0, 0:0:0, notifier,sh_we_clk_en_n,sh_we_clk_en_n, CLK_dly, ADR_dly[5]);
    $setuphold (negedge CLK, negedge I, 0:0:0, 0:0:0, notifier,sh_we_clk_en_n,sh_we_clk_en_n, CLK_dly, I_dly);
    $setuphold (negedge CLK, negedge WADR6, 0:0:0, 0:0:0, notifier,sh_we_clk_en_n,sh_we_clk_en_n, CLK_dly, WADR_dly[0]);
    $setuphold (negedge CLK, negedge WADR7, 0:0:0, 0:0:0, notifier,sh_we_clk_en_n,sh_we_clk_en_n, CLK_dly, WADR_dly[1]);
    $setuphold (negedge CLK, negedge WE, 0:0:0, 0:0:0, notifier,sh_clk_en_n,sh_clk_en_n, CLK_dly, WE_dly);
    $setuphold (negedge CLK, posedge ADR0, 0:0:0, 0:0:0, notifier,sh_we_clk_en_n,sh_we_clk_en_n, CLK_dly, ADR_dly[0]);
    $setuphold (negedge CLK, posedge ADR1, 0:0:0, 0:0:0, notifier,sh_we_clk_en_n,sh_we_clk_en_n, CLK_dly, ADR_dly[1]);
    $setuphold (negedge CLK, posedge ADR2, 0:0:0, 0:0:0, notifier,sh_we_clk_en_n,sh_we_clk_en_n, CLK_dly, ADR_dly[2]);
    $setuphold (negedge CLK, posedge ADR3, 0:0:0, 0:0:0, notifier,sh_we_clk_en_n,sh_we_clk_en_n, CLK_dly, ADR_dly[3]);
    $setuphold (negedge CLK, posedge ADR4, 0:0:0, 0:0:0, notifier,sh_we_clk_en_n,sh_we_clk_en_n, CLK_dly, ADR_dly[4]);
    $setuphold (negedge CLK, posedge ADR5, 0:0:0, 0:0:0, notifier,sh_we_clk_en_n,sh_we_clk_en_n, CLK_dly, ADR_dly[5]);
    $setuphold (negedge CLK, posedge I, 0:0:0, 0:0:0, notifier,sh_we_clk_en_n,sh_we_clk_en_n, CLK_dly, I_dly);
    $setuphold (negedge CLK, posedge WADR6, 0:0:0, 0:0:0, notifier,sh_we_clk_en_n,sh_we_clk_en_n, CLK_dly, WADR_dly[0]);
    $setuphold (negedge CLK, posedge WADR7, 0:0:0, 0:0:0, notifier,sh_we_clk_en_n,sh_we_clk_en_n, CLK_dly, WADR_dly[1]);
    $setuphold (negedge CLK, posedge WE, 0:0:0, 0:0:0, notifier,sh_clk_en_n,sh_clk_en_n, CLK_dly, WE_dly);
    $setuphold (posedge CLK, negedge ADR0, 0:0:0, 0:0:0, notifier,sh_we_clk_en_p,sh_we_clk_en_p, CLK_dly, ADR_dly[0]);
    $setuphold (posedge CLK, negedge ADR1, 0:0:0, 0:0:0, notifier,sh_we_clk_en_p,sh_we_clk_en_p, CLK_dly, ADR_dly[1]);
    $setuphold (posedge CLK, negedge ADR2, 0:0:0, 0:0:0, notifier,sh_we_clk_en_p,sh_we_clk_en_p, CLK_dly, ADR_dly[2]);
    $setuphold (posedge CLK, negedge ADR3, 0:0:0, 0:0:0, notifier,sh_we_clk_en_p,sh_we_clk_en_p, CLK_dly, ADR_dly[3]);
    $setuphold (posedge CLK, negedge ADR4, 0:0:0, 0:0:0, notifier,sh_we_clk_en_p,sh_we_clk_en_p, CLK_dly, ADR_dly[4]);
    $setuphold (posedge CLK, negedge ADR5, 0:0:0, 0:0:0, notifier,sh_we_clk_en_p,sh_we_clk_en_p, CLK_dly, ADR_dly[5]);
    $setuphold (posedge CLK, negedge I, 0:0:0, 0:0:0, notifier,sh_we_clk_en_p,sh_we_clk_en_p, CLK_dly, I_dly);
    $setuphold (posedge CLK, negedge WADR6, 0:0:0, 0:0:0, notifier,sh_we_clk_en_p,sh_we_clk_en_p, CLK_dly, WADR_dly[0]);
    $setuphold (posedge CLK, negedge WADR7, 0:0:0, 0:0:0, notifier,sh_we_clk_en_p,sh_we_clk_en_p, CLK_dly, WADR_dly[1]);
    $setuphold (posedge CLK, negedge WE, 0:0:0, 0:0:0, notifier,sh_clk_en_p,sh_clk_en_p, CLK_dly, WE_dly);
    $setuphold (posedge CLK, posedge ADR0, 0:0:0, 0:0:0, notifier,sh_we_clk_en_p,sh_we_clk_en_p, CLK_dly, ADR_dly[0]);
    $setuphold (posedge CLK, posedge ADR1, 0:0:0, 0:0:0, notifier,sh_we_clk_en_p,sh_we_clk_en_p, CLK_dly, ADR_dly[1]);
    $setuphold (posedge CLK, posedge ADR2, 0:0:0, 0:0:0, notifier,sh_we_clk_en_p,sh_we_clk_en_p, CLK_dly, ADR_dly[2]);
    $setuphold (posedge CLK, posedge ADR3, 0:0:0, 0:0:0, notifier,sh_we_clk_en_p,sh_we_clk_en_p, CLK_dly, ADR_dly[3]);
    $setuphold (posedge CLK, posedge ADR4, 0:0:0, 0:0:0, notifier,sh_we_clk_en_p,sh_we_clk_en_p, CLK_dly, ADR_dly[4]);
    $setuphold (posedge CLK, posedge ADR5, 0:0:0, 0:0:0, notifier,sh_we_clk_en_p,sh_we_clk_en_p, CLK_dly, ADR_dly[5]);
    $setuphold (posedge CLK, posedge I, 0:0:0, 0:0:0, notifier,sh_we_clk_en_p,sh_we_clk_en_p, CLK_dly, I_dly);
    $setuphold (posedge CLK, posedge WADR6, 0:0:0, 0:0:0, notifier,sh_we_clk_en_p,sh_we_clk_en_p, CLK_dly, WADR_dly[0]);
    $setuphold (posedge CLK, posedge WADR7, 0:0:0, 0:0:0, notifier,sh_we_clk_en_p,sh_we_clk_en_p, CLK_dly, WADR_dly[1]);
    $setuphold (posedge CLK, posedge WE, 0:0:0, 0:0:0, notifier,sh_clk_en_p,sh_clk_en_p, CLK_dly, WE_dly);
    $width (negedge CLK, 0:0:0, 0, notifier);
    $width (posedge CLK, 0:0:0, 0, notifier);
    specparam PATHPULSE$ = 0;
  endspecify
`endif

endmodule

`endcelldefine