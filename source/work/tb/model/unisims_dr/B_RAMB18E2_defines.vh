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

`ifdef B_RAMB18E2_DEFINES_VH
`else
`define B_RAMB18E2_DEFINES_VH

// Look-up table parameters
//

`define RAMB18E2_ADDR_N  105
`define RAMB18E2_ADDR_SZ 32
`define RAMB18E2_DATA_SZ 256

// Attribute addresses
//

`define RAMB18E2__CASCADE_ORDER_A   	32'h0000	// Type=STRING; Values=NONE,FIRST,LAST,MIDDLE,PARALLEL
`define RAMB18E2__CASCADE_ORDER_A_SZ	64

`define RAMB18E2__CASCADE_ORDER_B   	32'h0001	// Type=STRING; Values=NONE,FIRST,LAST,MIDDLE,PARALLEL
`define RAMB18E2__CASCADE_ORDER_B_SZ	64

`define RAMB18E2__CLOCK_DOMAINS   	32'h0002	// Type=STRING; Values=INDEPENDENT,COMMON
`define RAMB18E2__CLOCK_DOMAINS_SZ	88

`define RAMB18E2__DOA_REG   	32'h0003	// Type=DECIMAL; Values=1,0
`define RAMB18E2__DOA_REG_SZ	32

`define RAMB18E2__DOB_REG   	32'h0004	// Type=DECIMAL; Values=1,0
`define RAMB18E2__DOB_REG_SZ	32

`define RAMB18E2__ENADDRENA   	32'h0005	// Type=BOOLSTRING; Values=FALSE,TRUE
`define RAMB18E2__ENADDRENA_SZ	40

`define RAMB18E2__ENADDRENB   	32'h0006	// Type=BOOLSTRING; Values=FALSE,TRUE
`define RAMB18E2__ENADDRENB_SZ	40

`define RAMB18E2__INITP_00   	32'h0007	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INITP_00_SZ	256

`define RAMB18E2__INITP_01   	32'h0008	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INITP_01_SZ	256

`define RAMB18E2__INITP_02   	32'h0009	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INITP_02_SZ	256

`define RAMB18E2__INITP_03   	32'h000a	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INITP_03_SZ	256

`define RAMB18E2__INITP_04   	32'h000b	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INITP_04_SZ	256

`define RAMB18E2__INITP_05   	32'h000c	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INITP_05_SZ	256

`define RAMB18E2__INITP_06   	32'h000d	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INITP_06_SZ	256

`define RAMB18E2__INITP_07   	32'h000e	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INITP_07_SZ	256

`define RAMB18E2__INIT_00   	32'h000f	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_00_SZ	256

`define RAMB18E2__INIT_01   	32'h0010	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_01_SZ	256

`define RAMB18E2__INIT_02   	32'h0011	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_02_SZ	256

`define RAMB18E2__INIT_03   	32'h0012	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_03_SZ	256

`define RAMB18E2__INIT_04   	32'h0013	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_04_SZ	256

`define RAMB18E2__INIT_05   	32'h0014	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_05_SZ	256

`define RAMB18E2__INIT_06   	32'h0015	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_06_SZ	256

`define RAMB18E2__INIT_07   	32'h0016	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_07_SZ	256

`define RAMB18E2__INIT_08   	32'h0017	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_08_SZ	256

`define RAMB18E2__INIT_09   	32'h0018	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_09_SZ	256

`define RAMB18E2__INIT_0A   	32'h0019	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_0A_SZ	256

`define RAMB18E2__INIT_0B   	32'h001a	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_0B_SZ	256

`define RAMB18E2__INIT_0C   	32'h001b	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_0C_SZ	256

`define RAMB18E2__INIT_0D   	32'h001c	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_0D_SZ	256

`define RAMB18E2__INIT_0E   	32'h001d	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_0E_SZ	256

`define RAMB18E2__INIT_0F   	32'h001e	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_0F_SZ	256

`define RAMB18E2__INIT_10   	32'h001f	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_10_SZ	256

`define RAMB18E2__INIT_11   	32'h0020	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_11_SZ	256

`define RAMB18E2__INIT_12   	32'h0021	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_12_SZ	256

`define RAMB18E2__INIT_13   	32'h0022	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_13_SZ	256

`define RAMB18E2__INIT_14   	32'h0023	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_14_SZ	256

`define RAMB18E2__INIT_15   	32'h0024	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_15_SZ	256

`define RAMB18E2__INIT_16   	32'h0025	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_16_SZ	256

`define RAMB18E2__INIT_17   	32'h0026	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_17_SZ	256

`define RAMB18E2__INIT_18   	32'h0027	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_18_SZ	256

`define RAMB18E2__INIT_19   	32'h0028	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_19_SZ	256

`define RAMB18E2__INIT_1A   	32'h0029	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_1A_SZ	256

`define RAMB18E2__INIT_1B   	32'h002a	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_1B_SZ	256

`define RAMB18E2__INIT_1C   	32'h002b	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_1C_SZ	256

`define RAMB18E2__INIT_1D   	32'h002c	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_1D_SZ	256

`define RAMB18E2__INIT_1E   	32'h002d	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_1E_SZ	256

`define RAMB18E2__INIT_1F   	32'h002e	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_1F_SZ	256

`define RAMB18E2__INIT_20   	32'h002f	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_20_SZ	256

`define RAMB18E2__INIT_21   	32'h0030	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_21_SZ	256

`define RAMB18E2__INIT_22   	32'h0031	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_22_SZ	256

`define RAMB18E2__INIT_23   	32'h0032	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_23_SZ	256

`define RAMB18E2__INIT_24   	32'h0033	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_24_SZ	256

`define RAMB18E2__INIT_25   	32'h0034	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_25_SZ	256

`define RAMB18E2__INIT_26   	32'h0035	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_26_SZ	256

`define RAMB18E2__INIT_27   	32'h0036	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_27_SZ	256

`define RAMB18E2__INIT_28   	32'h0037	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_28_SZ	256

`define RAMB18E2__INIT_29   	32'h0038	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_29_SZ	256

`define RAMB18E2__INIT_2A   	32'h0039	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_2A_SZ	256

`define RAMB18E2__INIT_2B   	32'h003a	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_2B_SZ	256

`define RAMB18E2__INIT_2C   	32'h003b	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_2C_SZ	256

`define RAMB18E2__INIT_2D   	32'h003c	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_2D_SZ	256

`define RAMB18E2__INIT_2E   	32'h003d	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_2E_SZ	256

`define RAMB18E2__INIT_2F   	32'h003e	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_2F_SZ	256

`define RAMB18E2__INIT_30   	32'h003f	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_30_SZ	256

`define RAMB18E2__INIT_31   	32'h0040	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_31_SZ	256

`define RAMB18E2__INIT_32   	32'h0041	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_32_SZ	256

`define RAMB18E2__INIT_33   	32'h0042	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_33_SZ	256

`define RAMB18E2__INIT_34   	32'h0043	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_34_SZ	256

`define RAMB18E2__INIT_35   	32'h0044	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_35_SZ	256

`define RAMB18E2__INIT_36   	32'h0045	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_36_SZ	256

`define RAMB18E2__INIT_37   	32'h0046	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_37_SZ	256

`define RAMB18E2__INIT_38   	32'h0047	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_38_SZ	256

`define RAMB18E2__INIT_39   	32'h0048	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_39_SZ	256

`define RAMB18E2__INIT_3A   	32'h0049	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_3A_SZ	256

`define RAMB18E2__INIT_3B   	32'h004a	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_3B_SZ	256

`define RAMB18E2__INIT_3C   	32'h004b	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_3C_SZ	256

`define RAMB18E2__INIT_3D   	32'h004c	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_3D_SZ	256

`define RAMB18E2__INIT_3E   	32'h004d	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_3E_SZ	256

`define RAMB18E2__INIT_3F   	32'h004e	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB18E2__INIT_3F_SZ	256

`define RAMB18E2__INIT_A   	32'h004f	// Type=HEX; Min=18'h00000, Max=18'h3ffff
`define RAMB18E2__INIT_A_SZ	18

`define RAMB18E2__INIT_B   	32'h0050	// Type=HEX; Min=18'h00000, Max=18'h3ffff
`define RAMB18E2__INIT_B_SZ	18

`define RAMB18E2__INIT_FILE   	32'h0051	// Type=STRING; Min=, Max=
`define RAMB18E2__INIT_FILE_SZ	192

`define RAMB18E2__IS_CLKARDCLK_INVERTED   	32'h0052	// Type=BINARY; Min=1'b0, Max=1'b1
`define RAMB18E2__IS_CLKARDCLK_INVERTED_SZ	1

`define RAMB18E2__IS_CLKBWRCLK_INVERTED   	32'h0053	// Type=BINARY; Min=1'b0, Max=1'b1
`define RAMB18E2__IS_CLKBWRCLK_INVERTED_SZ	1

`define RAMB18E2__IS_ENARDEN_INVERTED   	32'h0054	// Type=BINARY; Min=1'b0, Max=1'b1
`define RAMB18E2__IS_ENARDEN_INVERTED_SZ	1

`define RAMB18E2__IS_ENBWREN_INVERTED   	32'h0055	// Type=BINARY; Min=1'b0, Max=1'b1
`define RAMB18E2__IS_ENBWREN_INVERTED_SZ	1

`define RAMB18E2__IS_RSTRAMARSTRAM_INVERTED   	32'h0056	// Type=BINARY; Min=1'b0, Max=1'b1
`define RAMB18E2__IS_RSTRAMARSTRAM_INVERTED_SZ	1

`define RAMB18E2__IS_RSTRAMB_INVERTED   	32'h0057	// Type=BINARY; Min=1'b0, Max=1'b1
`define RAMB18E2__IS_RSTRAMB_INVERTED_SZ	1

`define RAMB18E2__IS_RSTREGARSTREG_INVERTED   	32'h0058	// Type=BINARY; Min=1'b0, Max=1'b1
`define RAMB18E2__IS_RSTREGARSTREG_INVERTED_SZ	1

`define RAMB18E2__IS_RSTREGB_INVERTED   	32'h0059	// Type=BINARY; Min=1'b0, Max=1'b1
`define RAMB18E2__IS_RSTREGB_INVERTED_SZ	1

`define RAMB18E2__RDADDRCHANGEA   	32'h005a	// Type=BOOLSTRING; Values=FALSE,TRUE
`define RAMB18E2__RDADDRCHANGEA_SZ	40

`define RAMB18E2__RDADDRCHANGEB   	32'h005b	// Type=BOOLSTRING; Values=FALSE,TRUE
`define RAMB18E2__RDADDRCHANGEB_SZ	40

`define RAMB18E2__READ_WIDTH_A   	32'h005d	// Type=DECIMAL; Values=0,1,2,4,9,18,36
`define RAMB18E2__READ_WIDTH_A_SZ	32

`define RAMB18E2__READ_WIDTH_B   	32'h005e	// Type=DECIMAL; Values=0,1,2,4,9,18
`define RAMB18E2__READ_WIDTH_B_SZ	32

`define RAMB18E2__RSTREG_PRIORITY_A   	32'h005f	// Type=STRING; Values=RSTREG,REGCE
`define RAMB18E2__RSTREG_PRIORITY_A_SZ	48

`define RAMB18E2__RSTREG_PRIORITY_B   	32'h0060	// Type=STRING; Values=RSTREG,REGCE
`define RAMB18E2__RSTREG_PRIORITY_B_SZ	48

`define RAMB18E2__SIM_COLLISION_CHECK   	32'h0061	// Type=STRING; Values=ALL,GENERATE_X_ONLY,NONE,WARNING_ONLY
`define RAMB18E2__SIM_COLLISION_CHECK_SZ	120

`define RAMB18E2__SLEEP_ASYNC   	32'h0062	// Type=BOOLSTRING; Values=FALSE,TRUE
`define RAMB18E2__SLEEP_ASYNC_SZ	40

`define RAMB18E2__SRVAL_A   	32'h0063	// Type=HEX; Min=18'h00000, Max=18'h3ffff
`define RAMB18E2__SRVAL_A_SZ	18

`define RAMB18E2__SRVAL_B   	32'h0064	// Type=HEX; Min=18'h00000, Max=18'h3ffff
`define RAMB18E2__SRVAL_B_SZ	18

`define RAMB18E2__WRITE_MODE_A   	32'h0065	// Type=STRING; Values=NO_CHANGE,READ_FIRST,WRITE_FIRST
`define RAMB18E2__WRITE_MODE_A_SZ	88

`define RAMB18E2__WRITE_MODE_B   	32'h0066	// Type=STRING; Values=NO_CHANGE,READ_FIRST,WRITE_FIRST
`define RAMB18E2__WRITE_MODE_B_SZ	88

`define RAMB18E2__WRITE_WIDTH_A   	32'h0067	// Type=DECIMAL; Values=0,1,2,4,9,18
`define RAMB18E2__WRITE_WIDTH_A_SZ	32

`define RAMB18E2__WRITE_WIDTH_B   	32'h0068	// Type=DECIMAL; Values=0,1,2,4,9,18,36
`define RAMB18E2__WRITE_WIDTH_B_SZ	32

`endif  // B_RAMB18E2_DEFINES_VH
