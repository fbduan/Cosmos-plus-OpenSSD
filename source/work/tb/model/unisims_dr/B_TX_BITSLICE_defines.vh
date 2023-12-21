// BLH dynamic attribute configuration look-up table addresses
//
// Build Summary:
//    Built By:     mk_defines_vh 3.0001
//    Built On:     Wed May 21 17:07:22 2014
//    Bundle:       XIPHY
//    Architecture: olympus
//    Snapshot Dir: /tmp/MgzBFkdK57
// Environment Variables:
//    XILENV="/build/xfndry/HEAD/env"
//    MYXILENV=""
//

`ifdef B_TX_BITSLICE_DEFINES_VH
`else
`define B_TX_BITSLICE_DEFINES_VH

// Look-up table parameters
//

`define TX_BITSLICE_ADDR_N  15
`define TX_BITSLICE_ADDR_SZ 32
`define TX_BITSLICE_DATA_SZ 64

// Attribute addresses
//

`define TX_BITSLICE__DATA_WIDTH   	32'h0000	// Type=DECIMAL; Values=8,4
`define TX_BITSLICE__DATA_WIDTH_SZ	32

`define TX_BITSLICE__DELAY_FORMAT   	32'h0001	// Type=STRING; Values=TIME,COUNT
`define TX_BITSLICE__DELAY_FORMAT_SZ	40

`define TX_BITSLICE__DELAY_TYPE   	32'h0002	// Type=STRING; Values=FIXED,VAR_LOAD,VARIABLE
`define TX_BITSLICE__DELAY_TYPE_SZ	64

`define TX_BITSLICE__DELAY_VALUE   	32'h0003	// Type=DECIMAL; Min=0, Max=1250
`define TX_BITSLICE__DELAY_VALUE_SZ	32

`define TX_BITSLICE__ENABLE_PRE_EMPHASIS   	32'h0004	// Type=BOOLSTRING; Values=FALSE,TRUE
`define TX_BITSLICE__ENABLE_PRE_EMPHASIS_SZ	40

`define TX_BITSLICE__INIT   	32'h0005	// Type=BINARY; Values=1'b1,1'b0
`define TX_BITSLICE__INIT_SZ	1

`define TX_BITSLICE__IS_CLK_INVERTED   	32'h0006	// Type=BINARY; Min=1'b0, Max=1'b1
`define TX_BITSLICE__IS_CLK_INVERTED_SZ	1

`define TX_BITSLICE__IS_RST_DLY_INVERTED   	32'h0007	// Type=BINARY; Min=1'b0, Max=1'b1
`define TX_BITSLICE__IS_RST_DLY_INVERTED_SZ	1

`define TX_BITSLICE__IS_RST_INVERTED   	32'h0008	// Type=BINARY; Min=1'b0, Max=1'b1
`define TX_BITSLICE__IS_RST_INVERTED_SZ	1

`define TX_BITSLICE__NATIVE_ODELAY_BYPASS   	32'h0009	// Type=BOOLSTRING; Values=FALSE,TRUE
`define TX_BITSLICE__NATIVE_ODELAY_BYPASS_SZ	40

`define TX_BITSLICE__OUTPUT_PHASE_90   	32'h000a	// Type=BOOLSTRING; Values=FALSE,TRUE
`define TX_BITSLICE__OUTPUT_PHASE_90_SZ	40

`define TX_BITSLICE__REFCLK_FREQUENCY   	32'h000b	// Type=FLOAT; Min=200.0, Max=2400.0
`define TX_BITSLICE__REFCLK_FREQUENCY_SZ	64

`define TX_BITSLICE__SIM_VERSION   	32'h000c	// Type=FLOAT; Values=2.0,1.0
`define TX_BITSLICE__SIM_VERSION_SZ	64

`define TX_BITSLICE__TBYTE_CTL   	32'h000d	// Type=STRING; Values=TBYTE_IN,T
`define TX_BITSLICE__TBYTE_CTL_SZ	64

`define TX_BITSLICE__UPDATE_MODE   	32'h000e	// Type=STRING; Values=ASYNC,MANUAL,SYNC
`define TX_BITSLICE__UPDATE_MODE_SZ	48

`endif  // B_TX_BITSLICE_DEFINES_VH
