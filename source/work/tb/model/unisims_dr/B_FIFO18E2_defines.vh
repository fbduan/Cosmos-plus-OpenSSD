// BLH dynamic attribute configuration look-up table addresses
//
// Build Summary:
//    Built By:     mk_defines_vh 3.0001
//    Built On:     Tue Apr 23 09:49:30 2013
//    Bundle:       RAMBFIFO36E2
//    Architecture: olympus
//    Snapshot Dir: /tmp/dxA44HKkQO
// Environment Variables:
//    XILENV="/build/xfndry/HEAD/env"
//    MYXILENV=""
//

`ifdef B_FIFO18E2_DEFINES_VH
`else
`define B_FIFO18E2_DEFINES_VH

// Look-up table parameters
//

`define FIFO18E2_ADDR_N  20
`define FIFO18E2_ADDR_SZ 32
`define FIFO18E2_DATA_SZ 144

// Attribute addresses
//

`define FIFO18E2__CASCADE_ORDER   	32'h0000	// Type=STRING; Values=NONE,FIRST,LAST,MIDDLE,PARALLEL
`define FIFO18E2__CASCADE_ORDER_SZ	64

`define FIFO18E2__CLOCK_DOMAINS   	32'h0001	// Type=STRING; Values=INDEPENDENT,COMMON
`define FIFO18E2__CLOCK_DOMAINS_SZ	88

`define FIFO18E2__FIRST_WORD_FALL_THROUGH   	32'h0002	// Type=BOOLSTRING; Values=FALSE,TRUE
`define FIFO18E2__FIRST_WORD_FALL_THROUGH_SZ	40

`define FIFO18E2__INIT   	32'h0003	// Type=HEX; Min=36'h000000000, Max=36'hfffffffff
`define FIFO18E2__INIT_SZ	36

`define FIFO18E2__IS_RDCLK_INVERTED   	32'h0004	// Type=BINARY; Min=1'b0, Max=1'b1
`define FIFO18E2__IS_RDCLK_INVERTED_SZ	1

`define FIFO18E2__IS_RDEN_INVERTED   	32'h0005	// Type=BINARY; Min=1'b0, Max=1'b1
`define FIFO18E2__IS_RDEN_INVERTED_SZ	1

`define FIFO18E2__IS_RSTREG_INVERTED   	32'h0006	// Type=BINARY; Min=1'b0, Max=1'b1
`define FIFO18E2__IS_RSTREG_INVERTED_SZ	1

`define FIFO18E2__IS_RST_INVERTED   	32'h0007	// Type=BINARY; Min=1'b0, Max=1'b1
`define FIFO18E2__IS_RST_INVERTED_SZ	1

`define FIFO18E2__IS_WRCLK_INVERTED   	32'h0008	// Type=BINARY; Min=1'b0, Max=1'b1
`define FIFO18E2__IS_WRCLK_INVERTED_SZ	1

`define FIFO18E2__IS_WREN_INVERTED   	32'h0009	// Type=BINARY; Min=1'b0, Max=1'b1
`define FIFO18E2__IS_WREN_INVERTED_SZ	1

`define FIFO18E2__PROG_EMPTY_THRESH   	32'h000a	// Type=DECIMAL; Min=1, Max=8191
`define FIFO18E2__PROG_EMPTY_THRESH_SZ	32

`define FIFO18E2__PROG_FULL_THRESH   	32'h000b	// Type=DECIMAL; Min=1, Max=8191
`define FIFO18E2__PROG_FULL_THRESH_SZ	32

`define FIFO18E2__RDCOUNT_TYPE   	32'h000c	// Type=STRING; Values=RAW_PNTR,EXTENDED_DATACOUNT,SIMPLE_DATACOUNT,SYNC_PNTR
`define FIFO18E2__RDCOUNT_TYPE_SZ	144

`define FIFO18E2__READ_WIDTH   	32'h000d	// Type=DECIMAL; Values=4,9,18,36
`define FIFO18E2__READ_WIDTH_SZ	32

`define FIFO18E2__REGISTER_MODE   	32'h000e	// Type=STRING; Values=UNREGISTERED,DO_PIPELINED,REGISTERED
`define FIFO18E2__REGISTER_MODE_SZ	96

`define FIFO18E2__RSTREG_PRIORITY   	32'h000f	// Type=STRING; Values=RSTREG,REGCE
`define FIFO18E2__RSTREG_PRIORITY_SZ	48

`define FIFO18E2__SLEEP_ASYNC   	32'h0010	// Type=BOOLSTRING; Values=FALSE,TRUE
`define FIFO18E2__SLEEP_ASYNC_SZ	40

`define FIFO18E2__SRVAL   	32'h0011	// Type=HEX; Min=36'h000000000, Max=36'hfffffffff
`define FIFO18E2__SRVAL_SZ	36

`define FIFO18E2__WRCOUNT_TYPE   	32'h0012	// Type=STRING; Values=RAW_PNTR,EXTENDED_DATACOUNT,SIMPLE_DATACOUNT,SYNC_PNTR
`define FIFO18E2__WRCOUNT_TYPE_SZ	144

`define FIFO18E2__WRITE_WIDTH   	32'h0013	// Type=DECIMAL; Values=4,9,18,36
`define FIFO18E2__WRITE_WIDTH_SZ	32

`endif  // B_FIFO18E2_DEFINES_VH