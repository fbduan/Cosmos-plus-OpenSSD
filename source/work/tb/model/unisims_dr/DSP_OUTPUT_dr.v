`include "B_DSP_OUTPUT_defines.vh"

reg [`DSP_OUTPUT_DATA_SZ-1:0] ATTR [0:`DSP_OUTPUT_ADDR_N-1];
reg [8*15:1] AUTORESET_PATDET_REG = AUTORESET_PATDET;
reg [8*5:1] AUTORESET_PRIORITY_REG = AUTORESET_PRIORITY;
reg [0:0] IS_CLK_INVERTED_REG = IS_CLK_INVERTED;
reg [0:0] IS_RSTP_INVERTED_REG = IS_RSTP_INVERTED;
reg [47:0] MASK_REG = MASK;
reg [47:0] PATTERN_REG = PATTERN;
reg PREG_REG = PREG;
reg [8*14:1] SEL_MASK_REG = SEL_MASK;
reg [8*7:1] SEL_PATTERN_REG = SEL_PATTERN;
reg [8*9:1] USE_PATTERN_DETECT_REG = USE_PATTERN_DETECT;

initial begin
  ATTR[`DSP_OUTPUT__AUTORESET_PATDET] = AUTORESET_PATDET;
  ATTR[`DSP_OUTPUT__AUTORESET_PRIORITY] = AUTORESET_PRIORITY;
  ATTR[`DSP_OUTPUT__IS_CLK_INVERTED] = IS_CLK_INVERTED;
  ATTR[`DSP_OUTPUT__IS_RSTP_INVERTED] = IS_RSTP_INVERTED;
  ATTR[`DSP_OUTPUT__MASK] = MASK;
  ATTR[`DSP_OUTPUT__PATTERN] = PATTERN;
  ATTR[`DSP_OUTPUT__PREG] = PREG;
  ATTR[`DSP_OUTPUT__SEL_MASK] = SEL_MASK;
  ATTR[`DSP_OUTPUT__SEL_PATTERN] = SEL_PATTERN;
  ATTR[`DSP_OUTPUT__USE_PATTERN_DETECT] = USE_PATTERN_DETECT;
end

always @(trig_attr) begin
  AUTORESET_PATDET_REG = ATTR[`DSP_OUTPUT__AUTORESET_PATDET];
  AUTORESET_PRIORITY_REG = ATTR[`DSP_OUTPUT__AUTORESET_PRIORITY];
  IS_CLK_INVERTED_REG = ATTR[`DSP_OUTPUT__IS_CLK_INVERTED];
  IS_RSTP_INVERTED_REG = ATTR[`DSP_OUTPUT__IS_RSTP_INVERTED];
  MASK_REG = ATTR[`DSP_OUTPUT__MASK];
  PATTERN_REG = ATTR[`DSP_OUTPUT__PATTERN];
  PREG_REG = ATTR[`DSP_OUTPUT__PREG];
  SEL_MASK_REG = ATTR[`DSP_OUTPUT__SEL_MASK];
  SEL_PATTERN_REG = ATTR[`DSP_OUTPUT__SEL_PATTERN];
  USE_PATTERN_DETECT_REG = ATTR[`DSP_OUTPUT__USE_PATTERN_DETECT];
end

// procedures to override, read attribute values

task write_attr;
  input  [`DSP_OUTPUT_ADDR_SZ-1:0] addr;
  input  [`DSP_OUTPUT_DATA_SZ-1:0] data;
  begin
    ATTR[addr] = data;
    trig_attr = ~trig_attr; // to be removed
  end
endtask

function [`DSP_OUTPUT_DATA_SZ-1:0] read_attr;
  input  [`DSP_OUTPUT_ADDR_SZ-1:0] addr;
  begin
    read_attr = ATTR[addr];
  end
endfunction

task commit_attr;
  begin
    trig_attr = ~trig_attr;
  end
endtask