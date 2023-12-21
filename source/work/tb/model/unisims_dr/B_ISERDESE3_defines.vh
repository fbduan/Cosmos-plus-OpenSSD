// BLH dynamic attribute configuration look-up table addresses
//
// Build Summary:
//    Built By:     mk_defines_vh 3.0001
//    Built On:     Tue Feb  4 11:52:00 2014
//    Bundle:       XIPHY
//    Architecture: olympus
//    Snapshot Dir: /tmp/5e_29D6xXh
// Environment Variables:
//    XILENV="/build/xfndry/HEAD/env"
//    MYXILENV=""
//

`ifdef B_ISERDESE3_DEFINES_VH
`else
`define B_ISERDESE3_DEFINES_VH

// Look-up table parameters
//

`define ISERDESE3_ADDR_N  9
`define ISERDESE3_ADDR_SZ 32
`define ISERDESE3_DATA_SZ 152

// Attribute addresses
//

`define ISERDESE3__DATA_WIDTH   	32'h0000	// Type=DECIMAL; Values=8,4
`define ISERDESE3__DATA_WIDTH_SZ	32

`define ISERDESE3__DDR_CLK_EDGE   	32'h0001	// Type=STRING; Values=OPPOSITE_EDGE,SAME_EDGE,SAME_EDGE_PIPELINED
`define ISERDESE3__DDR_CLK_EDGE_SZ	152

`define ISERDESE3__FIFO_ENABLE   	32'h0002	// Type=BOOLSTRING; Values=FALSE,TRUE
`define ISERDESE3__FIFO_ENABLE_SZ	40

`define ISERDESE3__FIFO_SYNC_MODE   	32'h0003	// Type=BOOLSTRING; Values=FALSE,TRUE
`define ISERDESE3__FIFO_SYNC_MODE_SZ	40

`define ISERDESE3__IDDR_MODE   	32'h0004	// Type=BOOLSTRING; Values=FALSE,TRUE
`define ISERDESE3__IDDR_MODE_SZ	40

`define ISERDESE3__IS_CLK_B_INVERTED   	32'h0005	// Type=BINARY; Min=1'b0, Max=1'b1
`define ISERDESE3__IS_CLK_B_INVERTED_SZ	1

`define ISERDESE3__IS_CLK_INVERTED   	32'h0006	// Type=BINARY; Min=1'b0, Max=1'b1
`define ISERDESE3__IS_CLK_INVERTED_SZ	1

`define ISERDESE3__IS_RST_INVERTED   	32'h0007	// Type=BINARY; Min=1'b0, Max=1'b1
`define ISERDESE3__IS_RST_INVERTED_SZ	1

`define ISERDESE3__SIM_VERSION   	32'h0008	// Type=FLOAT; Values=2.0,1.0
`define ISERDESE3__SIM_VERSION_SZ	64

`endif  // B_ISERDESE3_DEFINES_VH
