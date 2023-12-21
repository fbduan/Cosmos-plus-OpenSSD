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

`ifdef B_IDELAYE3_DEFINES_VH
`else
`define B_IDELAYE3_DEFINES_VH

// Look-up table parameters
//

`define IDELAYE3_ADDR_N  11
`define IDELAYE3_ADDR_SZ 32
`define IDELAYE3_DATA_SZ 96

// Attribute addresses
//

`define IDELAYE3__CASCADE   	32'h0000	// Type=STRING; Values=NONE,MASTER,SLAVE_END,SLAVE_MIDDLE
`define IDELAYE3__CASCADE_SZ	96

`define IDELAYE3__DELAY_FORMAT   	32'h0001	// Type=STRING; Values=TIME,COUNT
`define IDELAYE3__DELAY_FORMAT_SZ	40

`define IDELAYE3__DELAY_SRC   	32'h0002	// Type=STRING; Values=IDATAIN,DATAIN
`define IDELAYE3__DELAY_SRC_SZ	56

`define IDELAYE3__DELAY_TYPE   	32'h0003	// Type=STRING; Values=FIXED,VAR_LOAD,VARIABLE
`define IDELAYE3__DELAY_TYPE_SZ	64

`define IDELAYE3__DELAY_VALUE   	32'h0004	// Type=DECIMAL; Min=0, Max=1250
`define IDELAYE3__DELAY_VALUE_SZ	32

`define IDELAYE3__IS_CLK_INVERTED   	32'h0005	// Type=BINARY; Min=1'b0, Max=1'b1
`define IDELAYE3__IS_CLK_INVERTED_SZ	1

`define IDELAYE3__IS_RST_INVERTED   	32'h0006	// Type=BINARY; Min=1'b0, Max=1'b1
`define IDELAYE3__IS_RST_INVERTED_SZ	1

`define IDELAYE3__LOOPBACK   	32'h0007	// Type=BOOLSTRING; Values=FALSE,TRUE
`define IDELAYE3__LOOPBACK_SZ	40

`define IDELAYE3__REFCLK_FREQUENCY   	32'h0008	// Type=FLOAT; Min=200.0, Max=2400.0
`define IDELAYE3__REFCLK_FREQUENCY_SZ	64

`define IDELAYE3__SIM_VERSION   	32'h0009	// Type=FLOAT; Values=2.0,1.0
`define IDELAYE3__SIM_VERSION_SZ	64

`define IDELAYE3__UPDATE_MODE   	32'h000a	// Type=STRING; Values=ASYNC,MANUAL,SYNC
`define IDELAYE3__UPDATE_MODE_SZ	48

`endif  // B_IDELAYE3_DEFINES_VH
