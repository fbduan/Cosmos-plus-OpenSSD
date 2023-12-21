`include "B_INBUF_defines.vh"

reg [`INBUF_DATA_SZ-1:0] ATTR [0:`INBUF_ADDR_N-1];

initial begin
  ATTR[`INBUF__DQS_BIAS] = DQS_BIAS;
  ATTR[`INBUF__IBUF_LOW_PWR] = IBUF_LOW_PWR;
  ATTR[`INBUF__IOB_TYPE] = IOB_TYPE;
  ATTR[`INBUF__IO_TYPE] = IO_TYPE;
  ATTR[`INBUF__ISTANDARD] = ISTANDARD;
end

always @(trig_attr) begin
  DQS_BIAS_REG = ATTR[`INBUF__DQS_BIAS];
  IBUF_LOW_PWR_REG = ATTR[`INBUF__IBUF_LOW_PWR];
  IOB_TYPE_REG = ATTR[`INBUF__IOB_TYPE];
  IO_TYPE_REG = ATTR[`INBUF__IO_TYPE];
  ISTANDARD_REG = ATTR[`INBUF__ISTANDARD];
end

// procedures to override, read attribute values

task write_attr;
  input  [`INBUF_ADDR_SZ-1:0] addr;
  input  [`INBUF_DATA_SZ-1:0] data;
  begin
    ATTR[addr] = data;
    trig_attr = ~trig_attr; // to be removed
  end
endtask

function [`INBUF_DATA_SZ-1:0] read_attr;
  input  [`INBUF_ADDR_SZ-1:0] addr;
  begin
    read_attr = ATTR[addr];
  end
endfunction

task commit_attr;
  begin
    trig_attr = ~trig_attr;
  end
endtask
