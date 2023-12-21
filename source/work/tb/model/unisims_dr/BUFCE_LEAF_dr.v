`include "B_BUFCE_LEAF_defines.vh"

reg [`BUFCE_LEAF_DATA_SZ-1:0] ATTR [0:`BUFCE_LEAF_ADDR_N-1];
reg [8*5:1] CE_TYPE_REG;
reg [0:0] IS_CE_INVERTED_REG;
reg [0:0] IS_I_INVERTED_REG;

initial begin
  ATTR[`BUFCE_LEAF__CE_TYPE] = CE_TYPE;
  ATTR[`BUFCE_LEAF__IS_CE_INVERTED] = IS_CE_INVERTED;
  ATTR[`BUFCE_LEAF__IS_I_INVERTED] = IS_I_INVERTED;
end

always @(trig_attr) begin
  CE_TYPE_REG = ATTR[`BUFCE_LEAF__CE_TYPE];
  IS_CE_INVERTED_REG = ATTR[`BUFCE_LEAF__IS_CE_INVERTED];
  IS_I_INVERTED_REG = ATTR[`BUFCE_LEAF__IS_I_INVERTED];
end

// procedures to override, read attribute values

task write_attr;
  input  [`BUFCE_LEAF_ADDR_SZ-1:0] addr;
  input  [`BUFCE_LEAF_DATA_SZ-1:0] data;
  begin
    ATTR[addr] = data;
    trig_attr = ~trig_attr; // to be removed
  end
endtask

function [`BUFCE_LEAF_DATA_SZ-1:0] read_attr;
  input  [`BUFCE_LEAF_ADDR_SZ-1:0] addr;
  begin
    read_attr = ATTR[addr];
  end
endfunction

task commit_attr;
  begin
    trig_attr = ~trig_attr;
  end
endtask
