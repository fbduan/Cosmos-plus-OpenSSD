`include "B_BUFGCTRL_defines.vh"

reg [`BUFGCTRL_DATA_SZ-1:0] ATTR [0:`BUFGCTRL_ADDR_N-1];
reg INIT_OUT_REG = INIT_OUT;
reg IS_CE0_INVERTED_REG = IS_CE0_INVERTED;
reg IS_CE1_INVERTED_REG = IS_CE1_INVERTED;
reg IS_I0_INVERTED_REG = IS_I0_INVERTED;
reg IS_I1_INVERTED_REG = IS_I1_INVERTED;
reg IS_IGNORE0_INVERTED_REG = IS_IGNORE0_INVERTED;
reg IS_IGNORE1_INVERTED_REG = IS_IGNORE1_INVERTED;
reg IS_S0_INVERTED_REG = IS_S0_INVERTED;
reg IS_S1_INVERTED_REG = IS_S1_INVERTED;
reg [40:1] PRESELECT_I0_REG = PRESELECT_I0;
reg [40:1] PRESELECT_I1_REG = PRESELECT_I1;

initial begin
  ATTR[`BUFGCTRL__INIT_OUT] = INIT_OUT;
  ATTR[`BUFGCTRL__IS_CE0_INVERTED] = IS_CE0_INVERTED;
  ATTR[`BUFGCTRL__IS_CE1_INVERTED] = IS_CE1_INVERTED;
  ATTR[`BUFGCTRL__IS_I0_INVERTED] = IS_I0_INVERTED;
  ATTR[`BUFGCTRL__IS_I1_INVERTED] = IS_I1_INVERTED;
  ATTR[`BUFGCTRL__IS_IGNORE0_INVERTED] = IS_IGNORE0_INVERTED;
  ATTR[`BUFGCTRL__IS_IGNORE1_INVERTED] = IS_IGNORE1_INVERTED;
  ATTR[`BUFGCTRL__IS_S0_INVERTED] = IS_S0_INVERTED;
  ATTR[`BUFGCTRL__IS_S1_INVERTED] = IS_S1_INVERTED;
  ATTR[`BUFGCTRL__PRESELECT_I0] = PRESELECT_I0;
  ATTR[`BUFGCTRL__PRESELECT_I1] = PRESELECT_I1;
end

always @(trig_attr) begin
  INIT_OUT_REG = ATTR[`BUFGCTRL__INIT_OUT];
  IS_CE0_INVERTED_REG = ATTR[`BUFGCTRL__IS_CE0_INVERTED];
  IS_CE1_INVERTED_REG = ATTR[`BUFGCTRL__IS_CE1_INVERTED];
  IS_I0_INVERTED_REG = ATTR[`BUFGCTRL__IS_I0_INVERTED];
  IS_I1_INVERTED_REG = ATTR[`BUFGCTRL__IS_I1_INVERTED];
  IS_IGNORE0_INVERTED_REG = ATTR[`BUFGCTRL__IS_IGNORE0_INVERTED];
  IS_IGNORE1_INVERTED_REG = ATTR[`BUFGCTRL__IS_IGNORE1_INVERTED];
  IS_S0_INVERTED_REG = ATTR[`BUFGCTRL__IS_S0_INVERTED];
  IS_S1_INVERTED_REG = ATTR[`BUFGCTRL__IS_S1_INVERTED];
  PRESELECT_I0_REG = ATTR[`BUFGCTRL__PRESELECT_I0];
  PRESELECT_I1_REG = ATTR[`BUFGCTRL__PRESELECT_I1];
end

// procedures to override, read attribute values

task write_attr;
  input  [`BUFGCTRL_ADDR_SZ-1:0] addr;
  input  [`BUFGCTRL_DATA_SZ-1:0] data;
  begin
    ATTR[addr] = data;
    trig_attr = ~trig_attr; // to be removed
  end
endtask

function [`BUFGCTRL_DATA_SZ-1:0] read_attr;
  input  [`BUFGCTRL_ADDR_SZ-1:0] addr;
  begin
    read_attr = ATTR[addr];
  end
endfunction

task commit_attr;
  begin
    trig_attr = ~trig_attr;
  end
endtask