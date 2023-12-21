`include "B_DIFFINBUF_defines.vh"

reg [`DIFFINBUF_DATA_SZ-1:0] ATTR [0:`DIFFINBUF_ADDR_N-1];

initial begin
  ATTR[`DIFFINBUF__CAPACITANCE] = CAPACITANCE;
  ATTR[`DIFFINBUF__DIFF_TERM] = DIFF_TERM;
  ATTR[`DIFFINBUF__DQS_BIAS] = DQS_BIAS;
  ATTR[`DIFFINBUF__IBUF_DELAY_VALUE] = IBUF_DELAY_VALUE;
  ATTR[`DIFFINBUF__IBUF_LOW_PWR] = IBUF_LOW_PWR;
  ATTR[`DIFFINBUF__IFD_DELAY_VALUE] = IFD_DELAY_VALUE;
  ATTR[`DIFFINBUF__IOB_TYPE] = IOB_TYPE;
  ATTR[`DIFFINBUF__IO_TYPE] = IO_TYPE;
  ATTR[`DIFFINBUF__ISTANDARD] = ISTANDARD;
end

always @(trig_attr) begin
  CAPACITANCE_REG = ATTR[`DIFFINBUF__CAPACITANCE];
  DIFF_TERM_REG = ATTR[`DIFFINBUF__DIFF_TERM];
  DQS_BIAS_REG = ATTR[`DIFFINBUF__DQS_BIAS];
  IBUF_DELAY_VALUE_REG = ATTR[`DIFFINBUF__IBUF_DELAY_VALUE];
  IBUF_LOW_PWR_REG = ATTR[`DIFFINBUF__IBUF_LOW_PWR];
  IFD_DELAY_VALUE_REG = ATTR[`DIFFINBUF__IFD_DELAY_VALUE];
  IOB_TYPE_REG = ATTR[`DIFFINBUF__IOB_TYPE];
  IO_TYPE_REG = ATTR[`DIFFINBUF__IO_TYPE];
  ISTANDARD_REG = ATTR[`DIFFINBUF__ISTANDARD];
end

// procedures to override, read attribute values

task write_attr;
  input  [`DIFFINBUF_ADDR_SZ-1:0] addr;
  input  [`DIFFINBUF_DATA_SZ-1:0] data;
  begin
    ATTR[addr] = data;
    trig_attr = ~trig_attr; // to be removed
  end
endtask

function [`DIFFINBUF_DATA_SZ-1:0] read_attr;
  input  [`DIFFINBUF_ADDR_SZ-1:0] addr;
  begin
    read_attr = ATTR[addr];
  end
endfunction

task commit_attr;
  begin
    trig_attr = ~trig_attr;
  end
endtask
