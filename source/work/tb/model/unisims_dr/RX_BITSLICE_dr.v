`include "B_RX_BITSLICE_defines.vh"

reg [`RX_BITSLICE_DATA_SZ-1:0] ATTR [0:`RX_BITSLICE_ADDR_N-1];
reg [40:1] CASCADE_REG = CASCADE;
reg [112:1] DATA_TYPE_REG = DATA_TYPE;
reg [3:0] DATA_WIDTH_REG = DATA_WIDTH;
reg [40:1] DELAY_FORMAT_REG = DELAY_FORMAT;
reg [64:1] DELAY_TYPE_REG = DELAY_TYPE;
reg [10:0] DELAY_VALUE_REG = DELAY_VALUE;
reg [10:0] DELAY_VALUE_EXT_REG = DELAY_VALUE_EXT;
reg [40:1] FIFO_SYNC_MODE_REG = FIFO_SYNC_MODE;
reg IS_CLK_EXT_INVERTED_REG = IS_CLK_EXT_INVERTED;
reg IS_CLK_INVERTED_REG = IS_CLK_INVERTED;
reg IS_RST_DLY_EXT_INVERTED_REG = IS_RST_DLY_EXT_INVERTED;
reg IS_RST_DLY_INVERTED_REG = IS_RST_DLY_INVERTED;
reg IS_RST_INVERTED_REG = IS_RST_INVERTED;
real REFCLK_FREQUENCY_REG = REFCLK_FREQUENCY;
real SIM_VERSION_REG = SIM_VERSION;
reg [48:1] UPDATE_MODE_REG = UPDATE_MODE;
reg [48:1] UPDATE_MODE_EXT_REG = UPDATE_MODE_EXT;

initial begin
  ATTR[`RX_BITSLICE__CASCADE] = CASCADE;
  ATTR[`RX_BITSLICE__DATA_TYPE] = DATA_TYPE;
  ATTR[`RX_BITSLICE__DATA_WIDTH] = DATA_WIDTH;
  ATTR[`RX_BITSLICE__DELAY_FORMAT] = DELAY_FORMAT;
  ATTR[`RX_BITSLICE__DELAY_TYPE] = DELAY_TYPE;
  ATTR[`RX_BITSLICE__DELAY_VALUE] = DELAY_VALUE;
  ATTR[`RX_BITSLICE__DELAY_VALUE_EXT] = DELAY_VALUE_EXT;
  ATTR[`RX_BITSLICE__FIFO_SYNC_MODE] = FIFO_SYNC_MODE;
  ATTR[`RX_BITSLICE__IS_CLK_EXT_INVERTED] = IS_CLK_EXT_INVERTED;
  ATTR[`RX_BITSLICE__IS_CLK_INVERTED] = IS_CLK_INVERTED;
  ATTR[`RX_BITSLICE__IS_RST_DLY_EXT_INVERTED] = IS_RST_DLY_EXT_INVERTED;
  ATTR[`RX_BITSLICE__IS_RST_DLY_INVERTED] = IS_RST_DLY_INVERTED;
  ATTR[`RX_BITSLICE__IS_RST_INVERTED] = IS_RST_INVERTED;
  ATTR[`RX_BITSLICE__REFCLK_FREQUENCY] = $realtobits(REFCLK_FREQUENCY);
  ATTR[`RX_BITSLICE__SIM_VERSION] = $realtobits(SIM_VERSION);
  ATTR[`RX_BITSLICE__UPDATE_MODE] = UPDATE_MODE;
  ATTR[`RX_BITSLICE__UPDATE_MODE_EXT] = UPDATE_MODE_EXT;
end

always @(trig_attr) begin
  CASCADE_REG = ATTR[`RX_BITSLICE__CASCADE];
  DATA_TYPE_REG = ATTR[`RX_BITSLICE__DATA_TYPE];
  DATA_WIDTH_REG = ATTR[`RX_BITSLICE__DATA_WIDTH];
  DELAY_FORMAT_REG = ATTR[`RX_BITSLICE__DELAY_FORMAT];
  DELAY_TYPE_REG = ATTR[`RX_BITSLICE__DELAY_TYPE];
  DELAY_VALUE_EXT_REG = ATTR[`RX_BITSLICE__DELAY_VALUE_EXT];
  DELAY_VALUE_REG = ATTR[`RX_BITSLICE__DELAY_VALUE];
  FIFO_SYNC_MODE_REG = ATTR[`RX_BITSLICE__FIFO_SYNC_MODE];
  IS_CLK_EXT_INVERTED_REG = ATTR[`RX_BITSLICE__IS_CLK_EXT_INVERTED];
  IS_CLK_INVERTED_REG = ATTR[`RX_BITSLICE__IS_CLK_INVERTED];
  IS_RST_DLY_EXT_INVERTED_REG = ATTR[`RX_BITSLICE__IS_RST_DLY_EXT_INVERTED];
  IS_RST_DLY_INVERTED_REG = ATTR[`RX_BITSLICE__IS_RST_DLY_INVERTED];
  IS_RST_INVERTED_REG = ATTR[`RX_BITSLICE__IS_RST_INVERTED];
  REFCLK_FREQUENCY_REG = $bitstoreal(ATTR[`RX_BITSLICE__REFCLK_FREQUENCY]);
  SIM_VERSION_REG = $bitstoreal(ATTR[`RX_BITSLICE__SIM_VERSION]);
  UPDATE_MODE_EXT_REG = ATTR[`RX_BITSLICE__UPDATE_MODE_EXT];
  UPDATE_MODE_REG = ATTR[`RX_BITSLICE__UPDATE_MODE];
end

// procedures to override, read attribute values

task write_attr;
  input  [`RX_BITSLICE_ADDR_SZ-1:0] addr;
  input  [`RX_BITSLICE_DATA_SZ-1:0] data;
  begin
    ATTR[addr] = data;
    trig_attr = ~trig_attr; // to be removed
  end
endtask

function [`RX_BITSLICE_DATA_SZ-1:0] read_attr;
  input  [`RX_BITSLICE_ADDR_SZ-1:0] addr;
  begin
    read_attr = ATTR[addr];
  end
endfunction

task commit_attr;
  begin
trig_attr = ~trig_attr;
  end
endtask