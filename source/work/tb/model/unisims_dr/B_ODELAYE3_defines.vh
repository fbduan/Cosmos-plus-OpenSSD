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

`ifdef B_ODELAYE3_DEFINES_VH
`else
`define B_ODELAYE3_DEFINES_VH

// Look-up table parameters
//

`define ODELAYE3_ADDR_N  9
`define ODELAYE3_ADDR_SZ 32
`define ODELAYE3_DATA_SZ 96

// Attribute addresses
//

`define ODELAYE3__CASCADE   	32'h0000	// Type=STRING; Values=NONE,MASTER,SLAVE_END,SLAVE_MIDDLE
`define ODELAYE3__CASCADE_SZ	96

`define ODELAYE3__DELAY_FORMAT   	32'h0001	// Type=STRING; Values=TIME,COUNT
`define ODELAYE3__DELAY_FORMAT_SZ	40

`define ODELAYE3__DELAY_TYPE   	32'h0002	// Type=STRING; Values=FIXED,VAR_LOAD,VARIABLE
`define ODELAYE3__DELAY_TYPE_SZ	64

`define ODELAYE3__DELAY_VALUE   	32'h0003	// Type=DECIMAL; Min=0, Max=1250
`define ODELAYE3__DELAY_VALUE_SZ	32

`define ODELAYE3__IS_CLK_INVERTED   	32'h0004	// Type=BINARY; Min=1'b0, Max=1'b1
`define ODELAYE3__IS_CLK_INVERTED_SZ	1

`define ODELAYE3__IS_RST_INVERTED   	32'h0005	// Type=BINARY; Min=1'b0, Max=1'b1
`define ODELAYE3__IS_RST_INVERTED_SZ	1

`define ODELAYE3__REFCLK_FREQUENCY   	32'h0006	// Type=FLOAT; Min=200.0, Max=2400.0
`define ODELAYE3__REFCLK_FREQUENCY_SZ	64

`define ODELAYE3__SIM_VERSION   	32'h0007	// Type=FLOAT; Values=2.0,1.0
`define ODELAYE3__SIM_VERSION_SZ	64

`define ODELAYE3__UPDATE_MODE   	32'h0008	// Type=STRING; Values=ASYNC,MANUAL,SYNC
`define ODELAYE3__UPDATE_MODE_SZ	48

`endif  // B_ODELAYE3_DEFINES_VH
