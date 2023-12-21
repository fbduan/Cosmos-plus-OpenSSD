// BLH dynamic attribute configuration look-up table addresses
//
// Build Summary:
//    Built By:     mk_defines_vh 3.0001
//    Built On:     Wed Feb 13 14:45:11 2013
//    Bundle:       HRIO
//    Architecture: olympus
//    Snapshot Dir: /tmp/a1MdrmkDvi
// Environment Variables:
//    XILENV="/build/xfndry/HEAD/env"
//    MYXILENV=""
//

`ifdef B_INBUF_DEFINES_VH
`else
`define B_INBUF_DEFINES_VH

// Look-up table parameters
//

`define INBUF_ADDR_N  6
`define INBUF_ADDR_SZ 32
`define INBUF_DATA_SZ 192

// Attribute addresses
//

`define INBUF__DQS_BIAS   	32'h0000	// Type=BOOLSTRING; Values=FALSE,TRUE
`define INBUF__DQS_BIAS_SZ	40

`define INBUF__IBUF_LOW_PWR   	32'h0001	// Type=BOOLSTRING; Values=TRUE,FALSE
`define INBUF__IBUF_LOW_PWR_SZ	40

`define INBUF__IOB_TYPE   	32'h0002	// Type=STRING; Values=MASTER,SLAVE
`define INBUF__IOB_TYPE_SZ	48

`define INBUF__IO_TYPE   	32'h0003	// Type=STRING; Values=OFF_TYPE,BIDIR,INPUT,IPAD,OUTPUT,REFIO,SYSMON_AUX,VR,VREF,VRN,VRP
`define INBUF__IO_TYPE_SZ	80

`define INBUF__IPROGRAMMING   	32'h0004	// Type=BINARY; Min=9'b000000000, Max=9'b111111111
`define INBUF__IPROGRAMMING_SZ	9

`define INBUF__ISTANDARD   	32'h0005	// Type=STRING; Min=, Max=
`define INBUF__ISTANDARD_SZ	192

`endif  // B_INBUF_DEFINES_VH
