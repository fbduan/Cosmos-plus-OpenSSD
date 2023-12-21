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

`ifdef B_TX_BITSLICE_TRI_DEFINES_VH
`else
`define B_TX_BITSLICE_TRI_DEFINES_VH

// Look-up table parameters
//

`define TX_BITSLICE_TRI_ADDR_N  13
`define TX_BITSLICE_TRI_ADDR_SZ 32
`define TX_BITSLICE_TRI_DATA_SZ 64

// Attribute addresses
//

`define TX_BITSLICE_TRI__DATA_WIDTH   	32'h0000	// Type=DECIMAL; Values=8,4
`define TX_BITSLICE_TRI__DATA_WIDTH_SZ	32

`define TX_BITSLICE_TRI__DELAY_FORMAT   	32'h0001	// Type=STRING; Values=TIME,COUNT
`define TX_BITSLICE_TRI__DELAY_FORMAT_SZ	40

`define TX_BITSLICE_TRI__DELAY_TYPE   	32'h0002	// Type=STRING; Values=FIXED,VAR_LOAD,VARIABLE
`define TX_BITSLICE_TRI__DELAY_TYPE_SZ	64

`define TX_BITSLICE_TRI__DELAY_VALUE   	32'h0003	// Type=DECIMAL; Min=0, Max=1250
`define TX_BITSLICE_TRI__DELAY_VALUE_SZ	32

`define TX_BITSLICE_TRI__INIT   	32'h0004	// Type=BINARY; Values=1'b1,1'b0
`define TX_BITSLICE_TRI__INIT_SZ	1

`define TX_BITSLICE_TRI__IS_CLK_INVERTED   	32'h0005	// Type=BINARY; Min=1'b0, Max=1'b1
`define TX_BITSLICE_TRI__IS_CLK_INVERTED_SZ	1

`define TX_BITSLICE_TRI__IS_RST_DLY_INVERTED   	32'h0006	// Type=BINARY; Min=1'b0, Max=1'b1
`define TX_BITSLICE_TRI__IS_RST_DLY_INVERTED_SZ	1

`define TX_BITSLICE_TRI__IS_RST_INVERTED   	32'h0007	// Type=BINARY; Min=1'b0, Max=1'b1
`define TX_BITSLICE_TRI__IS_RST_INVERTED_SZ	1

`define TX_BITSLICE_TRI__NATIVE_ODELAY_BYPASS   	32'h0008	// Type=BOOLSTRING; Values=FALSE,TRUE
`define TX_BITSLICE_TRI__NATIVE_ODELAY_BYPASS_SZ	40

`define TX_BITSLICE_TRI__OUTPUT_PHASE_90   	32'h0009	// Type=BOOLSTRING; Values=FALSE,TRUE
`define TX_BITSLICE_TRI__OUTPUT_PHASE_90_SZ	40

`define TX_BITSLICE_TRI__REFCLK_FREQUENCY   	32'h000a	// Type=FLOAT; Min=200.0, Max=2400.0
`define TX_BITSLICE_TRI__REFCLK_FREQUENCY_SZ	64

`define TX_BITSLICE_TRI__SIM_VERSION   	32'h000b	// Type=FLOAT; Values=2.0,1.0
`define TX_BITSLICE_TRI__SIM_VERSION_SZ	64

`define TX_BITSLICE_TRI__UPDATE_MODE   	32'h000c	// Type=STRING; Values=ASYNC,MANUAL,SYNC
`define TX_BITSLICE_TRI__UPDATE_MODE_SZ	48

`endif  // B_TX_BITSLICE_TRI_DEFINES_VH
