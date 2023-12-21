`include "B_BUFGCE_DIV_defines.vh"

reg [`BUFGCE_DIV_DATA_SZ-1:0] ATTR [0:`BUFGCE_DIV_ADDR_N-1];
reg [3:0] BUFGCE_DIVIDE_REG;
reg [0:0] IS_CE_INVERTED_REG;
reg [0:0] IS_CLR_INVERTED_REG;
reg [0:0] IS_I_INVERTED_REG;

initial begin
  ATTR[`BUFGCE_DIV__BUFGCE_DIVIDE] = BUFGCE_DIVIDE;
  ATTR[`BUFGCE_DIV__IS_CE_INVERTED] = IS_CE_INVERTED;
  ATTR[`BUFGCE_DIV__IS_CLR_INVERTED] = IS_CLR_INVERTED;
  ATTR[`BUFGCE_DIV__IS_I_INVERTED] = IS_I_INVERTED;
end

always @(trig_attr) begin
  BUFGCE_DIVIDE_REG = ATTR[`BUFGCE_DIV__BUFGCE_DIVIDE];
  IS_CE_INVERTED_REG = ATTR[`BUFGCE_DIV__IS_CE_INVERTED];
  IS_CLR_INVERTED_REG = ATTR[`BUFGCE_DIV__IS_CLR_INVERTED];
  IS_I_INVERTED_REG = ATTR[`BUFGCE_DIV__IS_I_INVERTED];
end

// procedures to override, read attribute values

task write_attr;
  input  [`BUFGCE_DIV_ADDR_SZ-1:0] addr;
  input  [`BUFGCE_DIV_DATA_SZ-1:0] data;
  begin
    ATTR[addr] = data;
    trig_attr = ~trig_attr; // to be removed
  end
endtask

function [`BUFGCE_DIV_DATA_SZ-1:0] read_attr;
  input  [`BUFGCE_DIV_ADDR_SZ-1:0] addr;
  begin
    read_attr = ATTR[addr];
  end
endfunction

task commit_attr;
  begin
    trig_attr = ~trig_attr;
  end
endtask
