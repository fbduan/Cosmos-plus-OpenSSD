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

`ifdef B_OSERDESE3_DEFINES_VH
`else
`define B_OSERDESE3_DEFINES_VH

// Look-up table parameters
//

`define OSERDESE3_ADDR_N  9
`define OSERDESE3_ADDR_SZ 32
`define OSERDESE3_DATA_SZ 64

// Attribute addresses
//

`define OSERDESE3__DATA_WIDTH   	32'h0000	// Type=DECIMAL; Values=8,4
`define OSERDESE3__DATA_WIDTH_SZ	32

`define OSERDESE3__INIT   	32'h0001	// Type=BINARY; Values=1'b0,1'b1
`define OSERDESE3__INIT_SZ	1

`define OSERDESE3__IS_CLKDIV_INVERTED   	32'h0002	// Type=BINARY; Min=1'b0, Max=1'b1
`define OSERDESE3__IS_CLKDIV_INVERTED_SZ	1

`define OSERDESE3__IS_CLK_INVERTED   	32'h0003	// Type=BINARY; Min=1'b0, Max=1'b1
`define OSERDESE3__IS_CLK_INVERTED_SZ	1

`define OSERDESE3__IS_RST_INVERTED   	32'h0004	// Type=BINARY; Min=1'b0, Max=1'b1
`define OSERDESE3__IS_RST_INVERTED_SZ	1

`define OSERDESE3__ODDR_MODE   	32'h0005	// Type=BOOLSTRING; Values=FALSE,TRUE
`define OSERDESE3__ODDR_MODE_SZ	40

`define OSERDESE3__OSERDES_D_BYPASS   	32'h0006	// Type=BOOLSTRING; Values=FALSE,TRUE
`define OSERDESE3__OSERDES_D_BYPASS_SZ	40

`define OSERDESE3__OSERDES_T_BYPASS   	32'h0007	// Type=BOOLSTRING; Values=FALSE,TRUE
`define OSERDESE3__OSERDES_T_BYPASS_SZ	40

`define OSERDESE3__SIM_VERSION   	32'h0008	// Type=FLOAT; Values=2.0,1.0
`define OSERDESE3__SIM_VERSION_SZ	64

`endif  // B_OSERDESE3_DEFINES_VH
