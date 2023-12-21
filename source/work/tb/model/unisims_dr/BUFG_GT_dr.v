`include "B_BUFG_GT_defines.vh"

reg [`BUFG_GT_DATA_SZ-1:0] ATTR [0:`BUFG_GT_ADDR_N-1];
reg [0:0] IS_CLR_INVERTED_REG;

initial begin
  ATTR[`BUFG_GT__IS_CLR_INVERTED] = IS_CLR_INVERTED;
end

always @(trig_attr) begin
  IS_CLR_INVERTED_REG = ATTR[`BUFG_GT__IS_CLR_INVERTED];
end

// procedures to override, read attribute values

task write_attr;
  input  [`BUFG_GT_ADDR_SZ-1:0] addr;
  input  [`BUFG_GT_DATA_SZ-1:0] data;
  begin
    ATTR[addr] = data;
    trig_attr = ~trig_attr; // to be removed
  end
endtask

function [`BUFG_GT_DATA_SZ-1:0] read_attr;
  input  [`BUFG_GT_ADDR_SZ-1:0] addr;
  begin
    read_attr = ATTR[addr];
  end
endfunction

task commit_attr;
  begin
    trig_attr = ~trig_attr;
  end
endtask
