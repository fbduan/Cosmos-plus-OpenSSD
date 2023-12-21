`include "B_DSP_A_B_DATA_defines.vh"

reg [`DSP_A_B_DATA_DATA_SZ-1:0] ATTR [0:`DSP_A_B_DATA_ADDR_N-1];
reg [1:0] ACASCREG_REG = ACASCREG;
reg [1:0] AREG_REG = AREG;
reg [8*7:1] A_INPUT_REG = A_INPUT;
reg [1:0] BCASCREG_REG = BCASCREG;
reg [1:0] BREG_REG = BREG;
reg [8*7:1] B_INPUT_REG = B_INPUT;
reg [0:0] IS_CLK_INVERTED_REG = IS_CLK_INVERTED;
reg [0:0] IS_RSTA_INVERTED_REG = IS_RSTA_INVERTED;
reg [0:0] IS_RSTB_INVERTED_REG = IS_RSTB_INVERTED;

initial begin
  ATTR[`DSP_A_B_DATA__ACASCREG] = ACASCREG;
  ATTR[`DSP_A_B_DATA__AREG] = AREG;
  ATTR[`DSP_A_B_DATA__A_INPUT] = A_INPUT;
  ATTR[`DSP_A_B_DATA__BCASCREG] = BCASCREG;
  ATTR[`DSP_A_B_DATA__BREG] = BREG;
  ATTR[`DSP_A_B_DATA__B_INPUT] = B_INPUT;
  ATTR[`DSP_A_B_DATA__IS_CLK_INVERTED] = IS_CLK_INVERTED;
  ATTR[`DSP_A_B_DATA__IS_RSTA_INVERTED] = IS_RSTA_INVERTED;
  ATTR[`DSP_A_B_DATA__IS_RSTB_INVERTED] = IS_RSTB_INVERTED;
end

always @(trig_attr) begin
  ACASCREG_REG = ATTR[`DSP_A_B_DATA__ACASCREG];
  AREG_REG = ATTR[`DSP_A_B_DATA__AREG];
  A_INPUT_REG = ATTR[`DSP_A_B_DATA__A_INPUT];
  BCASCREG_REG = ATTR[`DSP_A_B_DATA__BCASCREG];
  BREG_REG = ATTR[`DSP_A_B_DATA__BREG];
  B_INPUT_REG = ATTR[`DSP_A_B_DATA__B_INPUT];
  IS_CLK_INVERTED_REG = ATTR[`DSP_A_B_DATA__IS_CLK_INVERTED];
  IS_RSTA_INVERTED_REG = ATTR[`DSP_A_B_DATA__IS_RSTA_INVERTED];
  IS_RSTB_INVERTED_REG = ATTR[`DSP_A_B_DATA__IS_RSTB_INVERTED];
end

// procedures to override, read attribute values

task write_attr;
  input  [`DSP_A_B_DATA_ADDR_SZ-1:0] addr;
  input  [`DSP_A_B_DATA_DATA_SZ-1:0] data;
  begin
    ATTR[addr] = data;
    trig_attr = ~trig_attr; // to be removed
  end
endtask

function [`DSP_A_B_DATA_DATA_SZ-1:0] read_attr;
  input  [`DSP_A_B_DATA_ADDR_SZ-1:0] addr;
  begin
    read_attr = ATTR[addr];
  end
endfunction

task commit_attr;
  begin
    trig_attr = ~trig_attr;
  end
endtask
