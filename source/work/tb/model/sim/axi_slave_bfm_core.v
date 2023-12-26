// +FHDR*****************************************************************************
//                 Copyright (c) 2023 Auto-SoC Co., Ltd..
//                       ALL RIGHTS RESERVED
// **********************************************************************************
// Filename     : axi_slave_bfm_core.v
// Author       : orysduan
// Created On   : 2023-12-25 17:13
// Last Modified: 
// ----------------------------------------------------------------------------------
// Description  :  top module of axi_slave_bfm_core.v
//                 1:  No internal memory!!!!!!
//
// ----------------------------------------------------------------------------------
// Child-module :  
//
//
// -FHDR*****************************************************************************
// **********************************************************************************

`ifndef     DLYU
    `define DLYU 0.01
`endif//    DLYU
`ifndef     DLYN
    `define DLYN 30
`endif//    DLYN
`ifndef     DLY
    `define DLY #(`DLYU*($urandom_range(1,`DLYN)))
`endif//    DLY

module axi_slave_bfm_core(/*AUTOARG*/
    //Outputs
    awready, wready, bvalid, bid, bresp, arready, rvalid, rid, rdata,
    rlast, rresp,

    //Inputs
    aclk, aresetn, awaddr, awburst, awid, awlen, awsize, awprot,
    awcache, awlock, awqos, awvalid, wvalid, wid, wdata, wstrb, wlast,
    bready, arvalid, arid, araddr, arburst, arlen, arsize, arprot,
    arcache, arlock, arqos, rready
);

//////////////////////////////////////////////////////////////////////////////
// Parameter Definition                                                     //
//////////////////////////////////////////////////////////////////////////////
//--------------------------------------------------------------------------
// Parameters that can be modified/overrided when instance this module
//--------------------------------------------------------------------------

parameter   VERBOSE     = 1;

parameter   ADDR_WIDTH  = 8;

parameter   MEM_ADDR_WIDTH  = (ADDR_WIDTH >= 31) ? 31 : ADDR_WIDTH;   //max 31, No Internal memory

//vvvvvvvvvvvvvvvvv
parameter   BASE_ADDR   = 0;
parameter   ADDR_SPACE  = 2**MEM_ADDR_WIDTH;
//^^^^^^^^^^^^^^^^^

parameter   DATA_WIDTH  = 8; 

parameter   ID_WIDTH    = 3;
parameter   SIZE_WIDTH  = 3;
parameter   QOS_WIDTH   = 3;

parameter   MAX_CMDNUM   = 16;

parameter   MAX_MEM_ADDR  = 4095; //No Internal Memory

parameter   MAX_BURSTLEN = 16; // when change this you must change
                               // the width of AWLEN/ARLEN

parameter   BYTEEN_WIDTH   = DATA_WIDTH/8;

parameter   AXI_VERSION  = 4;

//--------------------------------------------------------------------------
// Local Prameters
// Parameters that can NOT be modified/overrided when instance this module
//--------------------------------------------------------------------------

localparam  LEN_WIDTH   = (AXI_VERSION == 4) ? 8 : 4;    //4 or 8
localparam  LOCK_WIDTH  = (AXI_VERSION == 4) ? 1 : 2;
localparam  PROT_WIDTH  = 3;
localparam  RESP_WIDTH  = 2;
localparam  BURST_WIDTH = 2;
localparam  CACHE_WIDTH = 4;

localparam  [63:0]  MEM_ARRAY_DEPTH = (2**MEM_ADDR_WIDTH)-1; //No internal memory

localparam  [31:0]  STRB_WIDTH    = (DATA_WIDTH/8);

// AXI Burst Encode
localparam  AXI_BURST_FIXED = 2'b00;
localparam  AXI_BURST_INCR  = 2'b01;
localparam  AXI_BURST_WRAP  = 2'b10;
localparam  AXI_BURST_RESV  = 2'b11;

// AXI Lock Encode
localparam  AXI_LOCK_NORM = 2'b00;
localparam  AXI_LOCK_EXCL = 2'b01;
localparam  AXI_LOCK_LOCK = 2'b10;
localparam  AXI_LOCK_RESV = 2'b11;

// AXI Cache Encode
localparam  AXI_CACHE_NONE = 4'b0000;
localparam  AXI_CACHE_BUF  = 4'b0001;

// AXI Response Encode
localparam  AXI_RESP_OKAY    = 2'b00;
localparam  AXI_RESP_EXOKAY  = 2'b01;
localparam  AXI_RESP_SLVERR  = 2'b10;
localparam  AXI_RESP_DECERR  = 2'b11;

//////////////////////////////////////////////////////////////////////////////
// Input/Output Declaration                                                 //
//////////////////////////////////////////////////////////////////////////////
input                               aclk;
input                               aresetn;

input   [ADDR_WIDTH-1:0]            awaddr;
input   [BURST_WIDTH-1:0]           awburst;
input   [ID_WIDTH-1:0]              awid;
input   [LEN_WIDTH-1:0]             awlen;
input   [SIZE_WIDTH-1:0]            awsize;
input   [PROT_WIDTH-1:0]            awprot;
input   [CACHE_WIDTH-1:0]           awcache;
input   [LOCK_WIDTH-1:0]            awlock;
input   [QOS_WIDTH-1:0]             awqos;
input                               awvalid;
output                              awready;

input                               wvalid;
output                              wready;
input   [ID_WIDTH-1:0]              wid;
input   [DATA_WIDTH-1:0]            wdata;
input   [STRB_WIDTH-1:0]            wstrb;
input                               wlast;

output                              bvalid;
input                               bready;
output  [ID_WIDTH-1:0]              bid;
output  [RESP_WIDTH-1:0]            bresp;

input                               arvalid;
output                              arready;
input   [ID_WIDTH-1:0]              arid;
input   [ADDR_WIDTH-1:0]            araddr;
input   [BURST_WIDTH-1:0]           arburst;
input   [LEN_WIDTH-1:0]             arlen;
input   [SIZE_WIDTH-1:0]            arsize;
input   [PROT_WIDTH-1:0]            arprot;
input   [CACHE_WIDTH-1:0]           arcache;
input   [LOCK_WIDTH-1:0]            arlock;
input   [QOS_WIDTH-1:0]             arqos;

output                              rvalid;
input                               rready;
output  [ID_WIDTH-1:0]              rid;
output  [DATA_WIDTH-1:0]            rdata;
output                              rlast;
output  [RESP_WIDTH-1:0]            rresp;

//////////////////////////////////////////////////////////////////////////////
// Signal Declaration                                                       //
//////////////////////////////////////////////////////////////////////////////

/*autodefine*/
//auto wires{{{
wire [ID_WIDTH-1:0]     arq_id_dbg00;
wire [ID_WIDTH-1:0]     arq_id_dbg01;
wire                    arready;
wire [ID_WIDTH-1:0]     awq_id_dbg00;
wire [ID_WIDTH-1:0]     awq_id_dbg01;
wire [ID_WIDTH-1:0]     awq_id_dbg02;
wire [ID_WIDTH-1:0]     awq_id_dbg03;
wire [ID_WIDTH-1:0]     awq_id_dbg04;
wire [ID_WIDTH-1:0]     awq_id_dbg05;
wire [ID_WIDTH-1:0]     awq_id_dbg06;
wire [ID_WIDTH-1:0]     awq_id_dbg07;
wire [ID_WIDTH-1:0]     awq_id_dbg08;
wire [ID_WIDTH-1:0]     awq_id_dbg09;
wire [ID_WIDTH-1:0]     awq_id_dbg10;
wire [ID_WIDTH-1:0]     awq_id_dbg11;
wire [ID_WIDTH-1:0]     awq_id_dbg12;
wire                    awready;
wire [7:0]              mem_00;
wire [7:0]              mem_01;
wire [7:0]              mem_02;
wire [7:0]              mem_03;
wire [7:0]              mem_04;
wire [7:0]              mem_05;
wire [7:0]              mem_06;
wire [7:0]              mem_07;
wire [7:0]              mem_08;
wire [7:0]              mem_09;
wire [7:0]              mem_0a;
wire [7:0]              mem_0b;
wire [7:0]              mem_0c;
wire [7:0]              mem_0d;
wire [7:0]              mem_0e;
wire [7:0]              mem_0f;
wire [7:0]              mem_10;
wire [7:0]              mem_100;
wire [7:0]              mem_101;
wire [7:0]              mem_102;
wire [7:0]              mem_103;
wire [7:0]              mem_104;
wire [7:0]              mem_105;
wire [7:0]              mem_106;
wire [7:0]              mem_107;
wire [7:0]              mem_108;
wire [7:0]              mem_109;
wire [7:0]              mem_10a;
wire [7:0]              mem_10b;
wire [7:0]              mem_10c;
wire [7:0]              mem_10d;
wire [7:0]              mem_10e;
wire [7:0]              mem_10f;
wire [7:0]              mem_11;
wire [7:0]              mem_12;
wire [7:0]              mem_120;
wire [7:0]              mem_121;
wire [7:0]              mem_122;
wire [7:0]              mem_123;
wire [7:0]              mem_124;
wire [7:0]              mem_125;
wire [7:0]              mem_126;
wire [7:0]              mem_127;
wire [7:0]              mem_128;
wire [7:0]              mem_129;
wire [7:0]              mem_12a;
wire [7:0]              mem_12b;
wire [7:0]              mem_12c;
wire [7:0]              mem_12d;
wire [7:0]              mem_12e;
wire [7:0]              mem_12f;
wire [7:0]              mem_13;
wire [7:0]              mem_130;
wire [7:0]              mem_131;
wire [7:0]              mem_132;
wire [7:0]              mem_133;
wire [7:0]              mem_134;
wire [7:0]              mem_135;
wire [7:0]              mem_136;
wire [7:0]              mem_137;
wire [7:0]              mem_138;
wire [7:0]              mem_139;
wire [7:0]              mem_13a;
wire [7:0]              mem_13b;
wire [7:0]              mem_13c;
wire [7:0]              mem_13d;
wire [7:0]              mem_13e;
wire [7:0]              mem_13f;
wire [7:0]              mem_14;
wire [7:0]              mem_15;
wire [7:0]              mem_16;
wire [7:0]              mem_160;
wire [7:0]              mem_161;
wire [7:0]              mem_162;
wire [7:0]              mem_163;
wire [7:0]              mem_164;
wire [7:0]              mem_165;
wire [7:0]              mem_166;
wire [7:0]              mem_167;
wire [7:0]              mem_168;
wire [7:0]              mem_169;
wire [7:0]              mem_16a;
wire [7:0]              mem_16b;
wire [7:0]              mem_16c;
wire [7:0]              mem_16d;
wire [7:0]              mem_16e;
wire [7:0]              mem_16f;
wire [7:0]              mem_17;
wire [7:0]              mem_18;
wire [7:0]              mem_19;
wire [7:0]              mem_1a;
wire [7:0]              mem_1b;
wire [7:0]              mem_1c;
wire [7:0]              mem_1d;
wire [7:0]              mem_1e;
wire [7:0]              mem_1f;
wire [7:0]              mem_1f0;
wire [7:0]              mem_1f1;
wire [7:0]              mem_1f2;
wire [7:0]              mem_1f3;
wire [7:0]              mem_1f4;
wire [7:0]              mem_1f5;
wire [7:0]              mem_1f6;
wire [7:0]              mem_1f7;
wire [7:0]              mem_1f8;
wire [7:0]              mem_1f9;
wire [7:0]              mem_1fa;
wire [7:0]              mem_1fb;
wire [7:0]              mem_1fc;
wire [7:0]              mem_1fd;
wire [7:0]              mem_1fe;
wire [7:0]              mem_1ff;
wire [7:0]              mem_20;
wire [7:0]              mem_21;
wire [7:0]              mem_22;
wire [7:0]              mem_220;
wire [7:0]              mem_221;
wire [7:0]              mem_222;
wire [7:0]              mem_223;
wire [7:0]              mem_224;
wire [7:0]              mem_225;
wire [7:0]              mem_226;
wire [7:0]              mem_227;
wire [7:0]              mem_228;
wire [7:0]              mem_229;
wire [7:0]              mem_22a;
wire [7:0]              mem_22b;
wire [7:0]              mem_22c;
wire [7:0]              mem_22d;
wire [7:0]              mem_22e;
wire [7:0]              mem_22f;
wire [7:0]              mem_23;
wire [7:0]              mem_24;
wire [7:0]              mem_25;
wire [7:0]              mem_26;
wire [7:0]              mem_27;
wire [7:0]              mem_28;
wire [7:0]              mem_29;
wire [7:0]              mem_2a;
wire [7:0]              mem_2b;
wire [7:0]              mem_2c;
wire [7:0]              mem_2d;
wire [7:0]              mem_2e;
wire [7:0]              mem_2f;
wire [7:0]              mem_30;
wire [7:0]              mem_31;
wire [7:0]              mem_32;
wire [7:0]              mem_33;
wire [7:0]              mem_34;
wire [7:0]              mem_35;
wire [7:0]              mem_36;
wire [7:0]              mem_37;
wire [7:0]              mem_38;
wire [7:0]              mem_380;
wire [7:0]              mem_381;
wire [7:0]              mem_382;
wire [7:0]              mem_383;
wire [7:0]              mem_384;
wire [7:0]              mem_385;
wire [7:0]              mem_386;
wire [7:0]              mem_387;
wire [7:0]              mem_388;
wire [7:0]              mem_389;
wire [7:0]              mem_38a;
wire [7:0]              mem_38b;
wire [7:0]              mem_38c;
wire [7:0]              mem_38d;
wire [7:0]              mem_38e;
wire [7:0]              mem_38f;
wire [7:0]              mem_39;
wire [7:0]              mem_3a;
wire [7:0]              mem_3b;
wire [7:0]              mem_3c;
wire [7:0]              mem_3d;
wire [7:0]              mem_3e;
wire [7:0]              mem_3f;
wire [7:0]              mem_40;
wire [7:0]              mem_41;
wire [7:0]              mem_42;
wire [7:0]              mem_43;
wire [7:0]              mem_44;
wire [7:0]              mem_45;
wire [7:0]              mem_46;
wire [7:0]              mem_47;
wire [7:0]              mem_48;
wire [7:0]              mem_49;
wire [7:0]              mem_4a;
wire [7:0]              mem_4b;
wire [7:0]              mem_4c;
wire [7:0]              mem_4d;
wire [7:0]              mem_4e;
wire [7:0]              mem_4f;
wire [7:0]              mem_50;
wire [7:0]              mem_51;
wire [7:0]              mem_52;
wire [7:0]              mem_53;
wire [7:0]              mem_54;
wire [7:0]              mem_55;
wire [7:0]              mem_56;
wire [7:0]              mem_57;
wire [7:0]              mem_58;
wire [7:0]              mem_59;
wire [7:0]              mem_5a;
wire [7:0]              mem_5b;
wire [7:0]              mem_5c;
wire [7:0]              mem_5d;
wire [7:0]              mem_5e;
wire [7:0]              mem_5f;
wire [7:0]              mem_90;
wire [7:0]              mem_91;
wire [7:0]              mem_92;
wire [7:0]              mem_93;
wire [7:0]              mem_94;
wire [7:0]              mem_95;
wire [7:0]              mem_96;
wire [7:0]              mem_97;
wire [7:0]              mem_98;
wire [7:0]              mem_99;
wire [7:0]              mem_9a;
wire [7:0]              mem_9b;
wire [7:0]              mem_9c;
wire [7:0]              mem_9d;
wire [7:0]              mem_9e;
wire [7:0]              mem_9f;
wire [7:0]              mem_a0;
wire [7:0]              mem_a1;
wire [7:0]              mem_a2;
wire [7:0]              mem_a3;
wire [7:0]              mem_a4;
wire [7:0]              mem_a5;
wire [7:0]              mem_a6;
wire [7:0]              mem_a7;
wire [7:0]              mem_a8;
wire [7:0]              mem_a9;
wire [7:0]              mem_aa;
wire [7:0]              mem_ab;
wire [7:0]              mem_ac;
wire [7:0]              mem_ad;
wire [7:0]              mem_ae;
wire [7:0]              mem_af;
wire [7:0]              mem_array_0aaa_0000;
wire [7:0]              mem_array_0aaa_0001;
wire [7:0]              mem_array_0aaa_0002;
wire [7:0]              mem_array_0aaa_0003;
wire [7:0]              mem_array_0aaa_0004;
wire [7:0]              mem_array_0aaa_0005;
wire [7:0]              mem_array_0aaa_0006;
wire [7:0]              mem_array_0aaa_0007;
wire [7:0]              mem_array_0aaa_0008;
wire [7:0]              mem_array_0aaa_0009;
wire [7:0]              mem_array_0aaa_000a;
wire [7:0]              mem_array_0aaa_000b;
wire [7:0]              mem_array_0aaa_000c;
wire [7:0]              mem_array_0aaa_000d;
wire [7:0]              mem_array_0aaa_000e;
wire [7:0]              mem_array_0aaa_000f;
wire [7:0]              mem_array_0bbb_0000;
wire [7:0]              mem_array_0bbb_0001;
wire [7:0]              mem_array_0bbb_0002;
wire [7:0]              mem_array_0bbb_0003;
wire [7:0]              mem_array_0bbb_0004;
wire [7:0]              mem_array_0bbb_0005;
wire [7:0]              mem_array_0bbb_0006;
wire [7:0]              mem_array_0bbb_0007;
wire [7:0]              mem_array_0bbb_0008;
wire [7:0]              mem_array_0bbb_0009;
wire [7:0]              mem_array_0bbb_000a;
wire [7:0]              mem_array_0bbb_000b;
wire [7:0]              mem_array_0bbb_000c;
wire [7:0]              mem_array_0bbb_000d;
wire [7:0]              mem_array_0bbb_000e;
wire [7:0]              mem_array_0bbb_000f;
wire [7:0]              mem_array_0bbb_0010;
wire [7:0]              mem_array_0bbb_0011;
wire [7:0]              mem_array_0bbb_0012;
wire [7:0]              mem_array_0bbb_0013;
wire [7:0]              mem_array_0bbb_0014;
wire [7:0]              mem_array_0bbb_0015;
wire [7:0]              mem_array_0bbb_0016;
wire [7:0]              mem_array_0bbb_0017;
wire [7:0]              mem_array_0bbb_0018;
wire [7:0]              mem_array_0bbb_0019;
wire [7:0]              mem_array_0bbb_001a;
wire [7:0]              mem_array_0bbb_001b;
wire [7:0]              mem_array_0bbb_001c;
wire [7:0]              mem_array_0bbb_001d;
wire [7:0]              mem_array_0bbb_001e;
wire [7:0]              mem_array_0bbb_001f;
wire [7:0]              mem_b0;
wire [7:0]              mem_b1;
wire [7:0]              mem_b2;
wire [7:0]              mem_b3;
wire [7:0]              mem_b4;
wire [7:0]              mem_b5;
wire [7:0]              mem_b6;
wire [7:0]              mem_b7;
wire [7:0]              mem_b8;
wire [7:0]              mem_b9;
wire [7:0]              mem_ba;
wire [7:0]              mem_bb;
wire [7:0]              mem_bc;
wire [7:0]              mem_bd;
wire [7:0]              mem_be;
wire [7:0]              mem_bf;
wire [7:0]              mem_c0;
wire [7:0]              mem_c1;
wire [7:0]              mem_c2;
wire [7:0]              mem_c3;
wire [7:0]              mem_c4;
wire [7:0]              mem_c5;
wire [7:0]              mem_c6;
wire [7:0]              mem_c7;
wire [7:0]              mem_c8;
wire [7:0]              mem_c9;
wire [7:0]              mem_ca;
wire [7:0]              mem_cb;
wire [7:0]              mem_cc;
wire [7:0]              mem_cd;
wire [7:0]              mem_ce;
wire [7:0]              mem_cf;
wire [7:0]              mem_d0;
wire [7:0]              mem_d1;
wire [7:0]              mem_d2;
wire [7:0]              mem_d3;
wire [7:0]              mem_d4;
wire [7:0]              mem_d5;
wire [7:0]              mem_d6;
wire [7:0]              mem_d7;
wire [7:0]              mem_d8;
wire [7:0]              mem_d9;
wire [7:0]              mem_da;
wire [7:0]              mem_db;
wire [7:0]              mem_dc;
wire [7:0]              mem_dd;
wire [7:0]              mem_de;
wire [7:0]              mem_df;
wire [7:0]              mem_e0;
wire [7:0]              mem_e1;
wire [7:0]              mem_e2;
wire [7:0]              mem_e3;
wire [7:0]              mem_e4;
wire [7:0]              mem_e5;
wire [7:0]              mem_e6;
wire [7:0]              mem_e7;
wire [7:0]              mem_e8;
wire [7:0]              mem_e9;
wire [7:0]              mem_ea;
wire [7:0]              mem_eb;
wire [7:0]              mem_ec;
wire [7:0]              mem_ed;
wire [7:0]              mem_ee;
wire [7:0]              mem_ef;
wire [7:0]              mem_f0;
wire [7:0]              mem_f1;
wire [7:0]              mem_f2;
wire [7:0]              mem_f3;
wire [7:0]              mem_f4;
wire [7:0]              mem_f5;
wire [7:0]              mem_f6;
wire [7:0]              mem_f7;
wire [7:0]              mem_f8;
wire [7:0]              mem_f9;
wire [7:0]              mem_fa;
wire [7:0]              mem_fb;
wire [7:0]              mem_fc;
wire [7:0]              mem_fd;
wire [7:0]              mem_fe;
wire [7:0]              mem_ff;
wire [ADDR_WIDTH-1:0]   r_addr_00;
wire [ADDR_WIDTH-1:0]   r_addr_01;
wire [ADDR_WIDTH-1:0]   r_addr_02;
wire [ADDR_WIDTH-1:0]   r_addr_03;
wire [ADDR_WIDTH-1:0]   r_addr_04;
wire [ADDR_WIDTH-1:0]   r_addr_05;
wire [ADDR_WIDTH-1:0]   r_addr_06;
wire [ADDR_WIDTH-1:0]   r_addr_07;
wire [ADDR_WIDTH-1:0]   r_addr_08;
wire [ADDR_WIDTH-1:0]   r_addr_09;
wire [ADDR_WIDTH-1:0]   r_addr_0a;
wire [ADDR_WIDTH-1:0]   r_addr_0b;
wire [ADDR_WIDTH-1:0]   r_addr_0c;
wire [ADDR_WIDTH-1:0]   r_addr_0d;
wire [ADDR_WIDTH-1:0]   r_addr_0e;
wire [ADDR_WIDTH-1:0]   r_addr_0f;
wire                    trans_done;
wire [ADDR_WIDTH-1:0]   w_addr_00;
wire [ADDR_WIDTH-1:0]   w_addr_01;
wire [ADDR_WIDTH-1:0]   w_addr_02;
wire [ADDR_WIDTH-1:0]   w_addr_03;
wire [ADDR_WIDTH-1:0]   w_addr_04;
wire [ADDR_WIDTH-1:0]   w_addr_05;
wire [ADDR_WIDTH-1:0]   w_addr_06;
wire [ADDR_WIDTH-1:0]   w_addr_07;
wire [ADDR_WIDTH-1:0]   w_addr_08;
wire [ADDR_WIDTH-1:0]   w_addr_09;
wire [ADDR_WIDTH-1:0]   w_addr_0a;
wire [ADDR_WIDTH-1:0]   w_addr_0b;
wire [ADDR_WIDTH-1:0]   w_addr_0c;
wire [ADDR_WIDTH-1:0]   w_addr_0d;
wire [ADDR_WIDTH-1:0]   w_addr_0e;
wire [ADDR_WIDTH-1:0]   w_addr_0f;
wire [ADDR_WIDTH-1:0]   w_data_00;
wire [ADDR_WIDTH-1:0]   w_data_01;
wire [ADDR_WIDTH-1:0]   w_data_02;
wire [ADDR_WIDTH-1:0]   w_data_03;
wire [ADDR_WIDTH-1:0]   w_data_04;
wire [ADDR_WIDTH-1:0]   w_data_05;
wire [ADDR_WIDTH-1:0]   w_data_06;
wire [ADDR_WIDTH-1:0]   w_data_07;
wire [ADDR_WIDTH-1:0]   w_data_08;
wire [ADDR_WIDTH-1:0]   w_data_09;
wire [ADDR_WIDTH-1:0]   w_data_0a;
wire [ADDR_WIDTH-1:0]   w_data_0b;
wire [ADDR_WIDTH-1:0]   w_data_0c;
wire [ADDR_WIDTH-1:0]   w_data_0d;
wire [ADDR_WIDTH-1:0]   w_data_0e;
wire [ADDR_WIDTH-1:0]   w_data_0f;
wire [BYTEEN_WIDTH-1:0] w_strb_00;
wire [BYTEEN_WIDTH-1:0] w_strb_01;
wire [BYTEEN_WIDTH-1:0] w_strb_02;
wire [BYTEEN_WIDTH-1:0] w_strb_03;
wire [BYTEEN_WIDTH-1:0] w_strb_04;
wire [BYTEEN_WIDTH-1:0] w_strb_05;
wire [BYTEEN_WIDTH-1:0] w_strb_06;
wire [BYTEEN_WIDTH-1:0] w_strb_07;
wire [BYTEEN_WIDTH-1:0] w_strb_08;
wire [BYTEEN_WIDTH-1:0] w_strb_09;
wire [BYTEEN_WIDTH-1:0] w_strb_0a;
wire [BYTEEN_WIDTH-1:0] w_strb_0b;
wire [BYTEEN_WIDTH-1:0] w_strb_0c;
wire [BYTEEN_WIDTH-1:0] w_strb_0d;
wire [BYTEEN_WIDTH-1:0] w_strb_0e;
wire [BYTEEN_WIDTH-1:0] w_strb_0f;
//}}}
//auto regs{{{
reg  [SIZE_WIDTH-1:0]   arsize_data_phase;
reg  [ID_WIDTH-1:0]     bid_loc;
reg  [RESP_WIDTH-1:0]   bresp_loc;
reg                     bvalid;
reg  [ADDR_WIDTH-1:0]   raddr_data_phase_align;
reg  [DATA_WIDTH-1:0]   rdata_loc;
reg  [ID_WIDTH-1:0]     rid_loc;
reg                     rlast_loc;
reg  [RESP_WIDTH-1:0]   rresp_loc;
reg  [STRB_WIDTH-1:0]   rstrb;
reg                     rvalid;
reg  [DATA_WIDTH-1:0]   tmp_rdata;
reg  [ADDR_WIDTH-1:0]   waddr_data_phase;
reg  [ADDR_WIDTH-1:0]   waddr_data_phase_align;
reg                     wready;
//}}}
// End of automatic define

reg [ID_WIDTH-1:0]     bid;
reg [RESP_WIDTH-1:0]   bresp;

reg [DATA_WIDTH-1:0]   rdata;
reg [ID_WIDTH-1:0]     rid;
reg                    rlast;
reg [RESP_WIDTH-1:0]   rresp;

reg  [ADDR_WIDTH-1:0]   raddr_data_phase;

integer                 error_cnt;
integer                 i2,i3;
integer                 j2,j3;

reg    [7:0]              mem_array   [0:MEM_ARRAY_DEPTH[63:0]];

reg    [ADDR_WIDTH-1:0]   w_addr[MAX_BURSTLEN-1:0];
reg    [ADDR_WIDTH-1:0]   r_addr[MAX_BURSTLEN-1:0];
reg    [DATA_WIDTH-1:0]   w_data[MAX_BURSTLEN-1:0];
reg    [BYTEEN_WIDTH-1:0] w_strb[MAX_BURSTLEN-1:0];
reg    [ADDR_WIDTH-1:0]             start_waddr,start_raddr;
reg    [1:0]                        w_burst,r_burst;
reg    [3:0]                        w_len,r_len;
reg    [2:0]                        w_size,r_size;
reg    [DATA_WIDTH-1:0]             rdata_tmp;

integer                             cnt_wlen,cnt_rlen,wbyte,rbyte,i;
event                               accept_aw,accept_w,accept_b,
                                    accept_ar,accept_r;

reg    [ADDR_WIDTH-1:0]             debug_waddr,debug_raddr;
reg    [7:0]                        debug_wdata,debug_rdata;

reg    [ADDR_WIDTH-1:0]             read_addr_start,read_addr_end;
reg                                 read_start_flag;
integer                             read_bytes;
reg                                 aw_en,w_en,b_en,ar_en,r_en;
integer                             bcnt,arcnt,rcnt,wlen_i,rlen_i,windex,rindex;

integer                             aw_idx,w_idx,b_idx;
integer                             aw_push_idx;
integer                             awq_cnt;
integer                             awq_cnt_dbg0;
integer                             awq_cnt_dbg1;
reg     [MAX_CMDNUM-1:0]            awq_aw_valid;
reg     [MAX_CMDNUM-1:0]            awq_w_valid;
reg     [MAX_CMDNUM-1:0]            awq_b_valid;
reg     [ADDR_WIDTH-1:0]            awq_addr [MAX_CMDNUM-1:0];
reg     [BURST_WIDTH-1:0]           awq_burst[MAX_CMDNUM-1:0];
reg     [ID_WIDTH-1:0]              awq_id   [MAX_CMDNUM-1:0];
reg     [LEN_WIDTH-1:0]             awq_len  [MAX_CMDNUM-1:0];
reg     [SIZE_WIDTH-1:0]            awq_asize [MAX_CMDNUM-1:0];

integer                             ar_idx,r_idx;
integer                             ar_push_idx;
integer                             arq_cnt;
integer                             arq_cnt_dbg0;
integer                             arq_cnt_dbg1;
reg     [MAX_CMDNUM-1:0]            arq_ar_valid;
reg     [MAX_CMDNUM-1:0]            arq_r_valid;
reg     [ADDR_WIDTH-1:0]            arq_addr [MAX_CMDNUM-1:0];
reg     [BURST_WIDTH-1:0]           arq_burst[MAX_CMDNUM-1:0];
reg     [ID_WIDTH-1:0]              arq_id   [MAX_CMDNUM-1:0];
reg     [LEN_WIDTH-1:0]             arq_len  [MAX_CMDNUM-1:0];
reg     [SIZE_WIDTH-1:0]            arq_asize [MAX_CMDNUM-1:0];


//////////////////////////////////////////////////////////////////////////////
// Design Logic                                                             //
//////////////////////////////////////////////////////////////////////////////

assign  trans_done  = (awq_cnt == 0) & (arq_cnt == 0);

//------------------------
// init all the signal
//------------------------
task init;
begin
    disable aw_proc;
    disable w_proc;
    disable b_proc;
    disable ar_proc;
//    disable rdata_proc;

    error_cnt = 0;

    push_aw.busy    = 0;
    push_ar.busy    = 0;

    for (i=0;i<MAX_BURSTLEN;i=i+1) begin
    w_addr          [i] = 0;
    r_addr          [i] = 0;
    w_data          [i] = 0;
    w_strb          [i] = 0;
    end

    aw_en   = 1'b0;
    w_en    = 1'b0;
    b_en    = 1'b0;
    ar_en   = 1'b0;
    r_en    = 1'b0;

    cnt_wlen           = 0;
    cnt_rlen           = 0;
    wbyte              = 0;
    rbyte              = 0;
    start_waddr        = 0;
    start_raddr        = 0;
    w_burst            = 0;
    r_burst            = 0;
    w_len              = 0;
    r_len              = 0;
    w_size             = 0;
    r_size             = 0;
    read_start_flag    = 0;
    read_bytes         = 0;
    read_addr_start    = 0;
    read_addr_end      = 0;

    aw_push_idx         = 0;
    ar_push_idx         = 0;

    awq_cnt             = 0;
    arq_cnt             = 0;

    awq_cnt_dbg0        = 0;
    awq_cnt_dbg1        = 0;

    awq_aw_valid        = 0;
    awq_w_valid         = 0;
    awq_b_valid         = 0;
    arq_ar_valid        = 0;
    arq_r_valid         = 0;

    wready                      = 0;  //default is 0
    bvalid                      = 0;
    bid_loc[ID_WIDTH-1:0]       = 0;
    rvalid                      = 0;
    rdata_loc[DATA_WIDTH-1:0]   = 0;
    rlast_loc                   = 0;
    rid_loc[ID_WIDTH-1:0]       = 0;
end
endtask

task disable_auto_proc;
    begin
        if (trans_done !== 1) begin
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $display("%t\t",$realtime, "[error:%m] trans_done !== 1, can not disable auto proc");
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");

            fork
                begin
                    $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                    $display("%t\t",$realtime, "[info:%m] wait trans_done == 1");
                    $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                    wait (trans_done == 1);
                    disable wait_trans_done;
                end
                begin:wait_trans_done
                    #10000;
                    $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                    $display ("%t\t",$realtime, "\t[error:%m] time_out");
                    $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                    #(`DLYU);$finish;
                end
            join
        end

        aw_en               = 0;
        w_en                = 0;
        b_en                = 0;
        ar_en               = 0;
        r_en                = 0;
    end
endtask

//------------------------
// Decode the addr
//------------------------
task decode_address;
    input [ADDR_WIDTH-1:0] addr;
    input [1:0]            burst;
    input [3:0]            len;
    input [2:0]            size;
    input                  write;
    integer                n,num_bytes,total_bytes;
    reg   [ADDR_WIDTH-1:0] tmp,align_addr,wrap_boundary;

    begin
        num_bytes     = 2 ** size;
        total_bytes   = num_bytes*(len+1);

        tmp           = addr / num_bytes;
        align_addr    = tmp  * num_bytes;
    //    $display ($time,"\t tmp=%h; addr=%h",tmp,addr,num_bytes);

        tmp           = addr /  total_bytes;
        wrap_boundary = tmp  *  total_bytes;

        for (n=0;n<=len;n=n+1) begin
            case (burst)
            AXI_BURST_FIXED:        begin
              if (write) w_addr[n] = align_addr;
              else       r_addr[n] = align_addr;
            end

            AXI_BURST_INCR:         begin
              if (write) w_addr[n] = align_addr + n*num_bytes;
              else       r_addr[n] = align_addr + n*num_bytes;
            end

            AXI_BURST_WRAP:         begin
              if (write) begin
    //            $display ($time,"\t w_addr[%d]; align_addr=%h; num_bytes=%d",n,align_addr,num_bytes);
                w_addr[n] = align_addr + n*num_bytes;
                if (w_addr[n]>=(wrap_boundary+total_bytes))
                    w_addr[n] = w_addr[n] - total_bytes;
              end
              else begin
                r_addr[n] = align_addr + n*num_bytes;
                if (r_addr[n]>=(wrap_boundary+total_bytes))
                    r_addr[n] = r_addr[n] - total_bytes;
              end
            end

            default:                begin
              if (write) w_addr[n] = 0;
              else       r_addr[n] = 0;
            end

            endcase
        end

        // read strb calculate
        if (!write) begin
            if (read_start_flag) begin
            read_start_flag = 0;
            read_addr_start = r_addr[0];
            end
            read_bytes    = read_bytes + total_bytes;
            read_addr_end = r_addr[len]+num_bytes-1;
        end

        // Byte address to bus word address
        for (n=0;n<=len;n=n+1) begin
            if (write) begin
            tmp       = w_addr[n] / BYTEEN_WIDTH;
            w_addr[n] = tmp       * BYTEEN_WIDTH;
            end
            else begin
            tmp       = r_addr[n] / BYTEEN_WIDTH;
            r_addr[n] = tmp       * BYTEEN_WIDTH;
            end
        end

    end
endtask


///////////////////////////////////////////////////////////////
//       MAIN STATE MACHINE
///////////////////////////////////////////////////////////////
//==========================================
// Init
//==========================================
initial begin
    init;
end

//==========================================
// Reset Process
//==========================================
always @ (negedge aresetn) begin
    init;
end

//==========================================
// Event Monitor
//==========================================
always @ (posedge aclk ) begin  //may be 2x speed
    if (awvalid & awready) -> accept_aw;
    if (wvalid  & wready ) -> accept_w;
    if (bvalid  & bready ) -> accept_b;
    if (arvalid & arready) -> accept_ar;
    if (rvalid  & rready ) -> accept_r;
end

//--------------------------------------------------------------------------------------------------
// aw
//--------------------------------------------------------------------------------------------------
task set_aw_en;
    begin
        aw_en   = 1'b1;
    end
endtask

task push_aw;

    reg                         busy;
    reg     [ADDR_WIDTH-1:0]    awaddr_latch;
    reg     [BURST_WIDTH-1:0]   awburst_latch;
    reg     [ID_WIDTH-1:0]      awid_latch;
    reg     [LEN_WIDTH-1:0]     awlen_latch;
    reg     [SIZE_WIDTH-1:0]    awsize_latch;
    reg     [PROT_WIDTH-1:0]    awprot_latch;
    reg     [CACHE_WIDTH-1:0]   awcache_latch;
    reg     [LOCK_WIDTH-1:0]    awlock_latch;
    reg     [QOS_WIDTH-1:0]     awqos_latch;

    begin
        busy    = 1; #(`DLYU); //for easy debug
        //ÒòÎªºóÃæÓÐwaitµÄ¶¯×÷£¬¶øaw½Ó¿Ú¿ÉÄÜ»á±ä»¯£¬ËùÒÔÕâÀïÏÈ»º´æÏÂÀ´
        awaddr_latch    = awaddr;
        awburst_latch   = awburst;
        awid_latch      = awid;
        awlen_latch     = awlen;
        awsize_latch    = awsize;
        awprot_latch    = awprot;
        awcache_latch   = awcache;
        awlock_latch    = awlock;
        awqos_latch     = awqos;

        //wait pre trans over
        //ÓÉÓÚwºÍb¶¼ÐèÒªawqÀïÃæµÄÐÅÏ¢£¬ËùÒÔ±ØÐëµÈaw/w/b¶¼Íê³Éºó²ÅÄÜpushÐÂµÄ
        wait ((awq_aw_valid [aw_push_idx] == 1'b0) && 
              (awq_w_valid  [aw_push_idx] == 1'b0) &&
              (awq_b_valid  [aw_push_idx] == 1'b0));

        awq_aw_valid [aw_push_idx] = 1'b1;
        awq_w_valid  [aw_push_idx] = 1'b1;

        awq_id       [aw_push_idx] = awid_latch;
        awq_addr     [aw_push_idx] = awaddr_latch;
        awq_burst    [aw_push_idx] = awburst_latch;
        awq_len      [aw_push_idx] = awlen_latch;
        awq_asize     [aw_push_idx] = awsize_latch;
//        cycles_aw2aw [aw_push_idx] = 0;//aw2aw;
//        cycles_w2w   [aw_push_idx] = 0;//w2w;
//
//        decode_addr (id,addr,burst,len,size,1'b1);
//
        
        awq_cnt_dbg0    = awq_cnt_dbg0  + 1;
        awq_cnt         = awq_cnt       + 1;
        aw_push_idx     = (aw_push_idx == MAX_CMDNUM-1) ? 0 : aw_push_idx   + 1;
//        aw_push_idx     = (aw_push_idx == MAX_CMDNUM-1) ? 0 : aw_push_idx + 1;

        busy    = 0; #(`DLYU); //for easy debug
    end
endtask

always begin : aw_proc
    if (aw_en) begin
        // Wait for Slave accept command
        @ (accept_aw);
        push_aw;
    end
    else begin
//        @(posedge aclk);    //avoid dead-lock
        #(`DLYU);    //avoid dead-lock
    end
end

//ÕâÀï±ØÐëµÈ£º
//1£ºqÃ»Âú
//2£ºÉÏÒ»´ÎpushÍê³É
assign  awready = aw_en & (awq_cnt<MAX_CMDNUM) & (push_aw.busy == 0);

//--------------------------------------------------------------------------------------------------
// w
//--------------------------------------------------------------------------------------------------
task set_w_en;
    begin
        w_en   = 1'b1;
    end
endtask

always begin
    if (w_en) begin : w_proc
//        finish_wdata = 0;
        //ÕâÀïw_idx±ØÐë´Ó0¿ªÊ¼£¬
        //ÒòÎªÓÐ¿ÉÄÜqÀïÃæµÄidÊÇÏàÍ¬µÄ£¬±ØÐë°´ÕÕpush½øqµÄË³Ðò´¦Àí
        for (w_idx=0;w_idx<MAX_CMDNUM;w_idx=(w_idx == MAX_CMDNUM-1) ? 0 : w_idx+1) begin
            if (awq_w_valid[w_idx] == 1'b0) begin
                #(`DLYU);    //avoid dead-lock
            end
            else begin
                @ (posedge aclk );
                if (VERBOSE) $display ("%t\t",$realtime, "\t[info:%m] awq_w_valid[%d] = 1, len = '%d",w_idx,awq_len[w_idx]);

//                // Timer for delay the next w
//                repeat (cycles_w2w[w_idx]) @(posedge ACLK);
                wready <= #(`DLYU) 1;

                for (wlen_i=0;wlen_i<=awq_len[w_idx];wlen_i=wlen_i+1) begin

                    // Wait for Slave accept wdata
                    @ (accept_w);
                    if (VERBOSE) $display ("%t\t",$realtime, "\t[info:%m] accept_w = '%h'",wdata);

                    // Get Data
                    //20220310£¬¸ÄÎªÊµ¼ÊÐ´µ½Ò»¸ösramµÄµØÖ·
                    //µØÖ·¾ÍÊÇawµÃµ½µÄ
                    //windex = MAX_BURSTLEN*w_idx+wlen_i;
//                    windex = (awq_addr[w_idx] + (wlen_i*BYTEEN_WIDTH))/BYTEEN_WIDTH;

                    waddr_data_phase[ADDR_WIDTH-1:0] = awq_addr[w_idx] + (wlen_i*BYTEEN_WIDTH);
                    if (DATA_WIDTH == 32) begin
                        waddr_data_phase_align [ADDR_WIDTH-1:0] = {waddr_data_phase[ADDR_WIDTH-1:2], 2'b0};
                    end
                    else if (DATA_WIDTH == 64) begin
                        waddr_data_phase_align [ADDR_WIDTH-1:0] = {waddr_data_phase[ADDR_WIDTH-1:3], 3'b0};
                    end

//20220330 remove
//                    if (VERBOSE) $display ("%t\t",$realtime, "\t[info:%m] windex = ox%h; wdata = ox%h",windex, wdata);
//                    mem_array[windex]  = wdata;

//20220330 add
                    if (VERBOSE == 1) begin
                        $display("%t\t",$realtime, "[info:%m] 0x%h -> 0x%h ~ (%d) (wstrb = 0b%b)", wdata, waddr_data_phase, STRB_WIDTH, wstrb);
                    end

                    if (waddr_data_phase_align >= (2**MEM_ADDR_WIDTH)) begin
                        $display ("%t\t",$realtime, "[error:%m] //////////////////////////////////////////////////////////////");
                        $display ("%t\t",$realtime, "[error:%m] this data write to addr. '0x%h' will not write in mem-araay, because of out-of-range",waddr_data_phase_align);
                        $display ("%t\t",$realtime, "[error:%m] //////////////////////////////////////////////////////////////");
                    end

                    for (i2=0;i2<STRB_WIDTH;i2=i2+1) begin
                        //´ÓÐ¡µ½´ó
                        if (wstrb[i2] == 1'b1) begin
                            mem_array[waddr_data_phase_align[ADDR_WIDTH-1:0]+i2] <= #(`DLYU) wdata[DATA_WIDTH-1:0]>>(8*i2);
                        end
                    end
//                    WSTRB  <= #(`DLYU) buf_wstrb[windex];

//                     // Write to log file
//                     tmp_waddr = buf_waddr[windex];
//                     for(wbyte=0;wbyte<STRB_WIDTH;wbyte=wbyte+1) begin
//                       byte_wtmp = buf_wdata[windex]>>wbyte*8;
//                       if (buf_wstrb[windex][wbyte]) 
//                         $fdisplay (FWR,"ad[0x%4x] <--- wd[%x]", tmp_waddr+wbyte,byte_wtmp);
//                     end

                end // for
                wready <= #(`DLYU) 0;

//                b_en[w_idx]=1;
//
//                if (~w_piped) begin
//                  // Wait for finish this transaction
//                    wait (w_end[w_idx] && b_end[w_idx]);
//                    w_end[w_idx] = 0;
//                    b_end [w_idx] = 0;
//                end

//                finish_wdata = 1;
                awq_aw_valid[w_idx] = 1'b0; //destroy the aw of cmd
                awq_w_valid[w_idx]  = 1'b0; //destroy the w of cmd
                awq_b_valid[w_idx]  = 1'b1; //enable b after w finish
            end
        end
    end
    else begin
        #(`DLYU);    //avoid dead-lock
    end
end

//--------------------------------------------------------------------------------------------------
// b
//--------------------------------------------------------------------------------------------------
task set_b_en;
    begin
        b_en   = 1'b1;
    end
endtask

always begin
    if (b_en) begin : b_proc
        //        finish_wdata = 0;
        //ÕâÀïb_idx¿ÉÒÔ²»ÓÃ´Ó0¿ªÊ¼£¬ÒòÎªwÒÑ¾­ÊÇ°´ÕÕË³ÐòÍê³ÉµÄÁË
        //ÕâÀïÖÁÉÙ»Øresponse
        //TODO »¹ÐèÒªÈ·ÈÏidÊÇÏàÍ¬µÄÇé¿öÏÂµÄÓ°Ïì
`ifdef  AXI_SLAVE_BFM_B_OOO
        for (b_idx=MAX_CMDNUM-1;    b_idx>=0;           b_idx=(b_idx == 0) ? MAX_CMDNUM-1 : b_idx-1) begin
`else
        for (b_idx=0;               b_idx<MAX_CMDNUM;   b_idx=(b_idx == MAX_CMDNUM-1) ? 0 : b_idx+1) begin
`endif
            if (awq_b_valid[b_idx] == 1'b0) begin
                #(`DLYU);    //avoid dead-lock
            end
            else begin
                @ (posedge aclk );
                if (VERBOSE) $display ("%t\t",$realtime, "\t[info:%m] awq_b_valid[%d] = 1, id = '%d",b_idx,awq_id[b_idx]);

//                // Timer for delay the next w
//                repeat (cycles_w2w[b_idx]) @(posedge ACLK);
                bvalid <= #(`DLYU) 1'b1;
                bid_loc[ID_WIDTH-1:0]    <= #(`DLYU) awq_id[b_idx];
                bresp_loc[RESP_WIDTH-1:0]  <= #(`DLYU) AXI_RESP_OKAY;

//                for (wlen_i=0;wlen_i<=awq_len[b_idx];wlen_i=wlen_i+1) begin
//                    windex = MAX_BURSTLEN*b_idx+wlen_i;
//
//                    // Get Data
//                    mem_array[windex]  <= #(`DLYU) WDATA;
////                    WSTRB  <= #(`DLYU) buf_wstrb[windex];
//
//                    // Wait for Slave accept wdata
                @ (accept_b);
                if (VERBOSE) $display ("%t\t",$realtime, "\t[info:%m] accept_b");
//                     // Write to log file
//                     tmp_waddr = buf_waddr[windex];
//                     for(wbyte=0;wbyte<STRB_WIDTH;wbyte=wbyte+1) begin
//                       byte_wtmp = buf_wdata[windex]>>wbyte*8;
//                       if (buf_wstrb[windex][wbyte]) 
//                         $fdisplay (FWR,"ad[0x%4x] <--- wd[%x]", tmp_waddr+wbyte,byte_wtmp);
//                     end

//                end // for
                bvalid <= #(`DLYU) 1'b0;
                bresp_loc[RESP_WIDTH-1:0]  <= #(`DLYU) 'hz;

//                b_en[b_idx]=1;
//
//                if (~b_piped) begin
//                  // Wait for finish this transaction
//                    wait (b_end[b_idx] && b_end[b_idx]);
//                    b_end[b_idx] = 0;
//                    b_end [b_idx] = 0;
//                end

//                //wrap to the beginning
//                if (b_idx == MAX_CMDNUM-1) begin
//                    b_idx = 0;
//                end

//                finish_wdata = 1;
                awq_b_valid[b_idx]  = 1'b0; //destroy the b of cmd
                awq_cnt_dbg1     = awq_cnt_dbg1     - 1;
                awq_cnt = awq_cnt - 1;      //b is always after aw/w
            end

            //½øÈëforÒÔºó£¬b_en±ä³É0ÒÔºóÒ²²»»áÍË³ö
            //ËùÒÔÕâÀï¼ì²éµ½b_en=0£¬Ç¿ÖÆÍË³öfor
            if (b_en == 0) begin
                disable b_proc;
            end
        end //for
    end
    else begin
        #(`DLYU);    //avoid dead-lock
    end
end

//ÎÞÐ§ÆÚ¼äÉèÎªz£¬ÄÜ×î´óÏÞ¶È¼à²â¶Ô·½ÊÇ²»ÊÇÍµÍµ¿´ÁË·ÇÓÐÐ§ÆÚ¼äµÄÖµ
// %%: assign  bid[ID_WIDTH-1:0]     = (bvalid === 1'b1) ? bid_loc[ID_WIDTH-1:0]     : 'hz;
// %%: assign  bresp[RESP_WIDTH-1:0] = (bvalid === 1'b1) ? bresp_loc[RESP_WIDTH-1:0] : 'hz;
//--------------------------------------------------------------------------------------------------
// ar
//--------------------------------------------------------------------------------------------------
task set_ar_en;
    begin
        ar_en   = 1'b1;
    end
endtask

task push_ar;

    reg                         busy;
    reg     [ADDR_WIDTH-1:0]    araddr_latch;
    reg     [BURST_WIDTH-1:0]   arburst_latch;
    reg     [ID_WIDTH-1:0]      arid_latch;
    reg     [LEN_WIDTH-1:0]     arlen_latch;
    reg     [SIZE_WIDTH-1:0]    arsize_latch;
    reg     [PROT_WIDTH-1:0]    arprot_latch;
    reg     [CACHE_WIDTH-1:0]   arcache_latch;
    reg     [LOCK_WIDTH-1:0]    arlock_latch;
    reg     [QOS_WIDTH-1:0]     arqos_latch;

    begin
        busy    = 1; #(`DLYU); //for easy debug
        //ÒòÎªºóÃæÓÐwaitµÄ¶¯×÷£¬¶øar½Ó¿Ú¿ÉÄÜ»á±ä»¯£¬ËùÒÔÕâÀïÏÈ»º´æÏÂÀ´
        araddr_latch    = araddr;
        arburst_latch   = arburst;
        arid_latch      = arid;
        arlen_latch     = arlen;
        arsize_latch    = arsize;
        arprot_latch    = arprot;
        arcache_latch   = arcache;
        arlock_latch    = arlock;
        arqos_latch     = arqos;

        //wait pre trans over
        //ÓÉÓÚrÐèÒªarqÀïÃæµÄÐÅÏ¢£¬ËùÒÔ±ØÐëµÈar/r¶¼Íê³Éºó²ÅÄÜpushÐÂµÄ
        wait ((arq_ar_valid [ar_push_idx] == 1'b0) && 
              (arq_r_valid  [ar_push_idx] == 1'b0));

        arq_ar_valid [ar_push_idx] = 1'b1;
        arq_r_valid  [ar_push_idx] = 1'b1;

        arq_id       [ar_push_idx] = arid_latch;
        arq_addr     [ar_push_idx] = araddr_latch;
        arq_burst    [ar_push_idx] = arburst_latch;
        arq_len      [ar_push_idx] = arlen_latch;
        arq_asize     [ar_push_idx] = arsize_latch;
//        cycles_ar2ar [ar_push_idx] = 0;//ar2ar;
//        cycles_w2w   [ar_push_idx] = 0;//w2w;
//
//        decode_addr (id,addr,burst,len,size,1'b1);
//
        
        arq_cnt_dbg0    = arq_cnt_dbg0  + 1;
        arq_cnt         = arq_cnt       + 1;
        ar_push_idx     = (ar_push_idx == MAX_CMDNUM-1) ? 0 : ar_push_idx   + 1;
//        ar_push_idx     = (ar_push_idx == MAX_CMDNUM-1) ? 0 : ar_push_idx + 1;

        busy    = 0; #(`DLYU); //for easy debug
    end
endtask

always begin : ar_proc
    if (ar_en) begin
        // Wait for Slave accept command
        @ (accept_ar);
        push_ar;
    end
    else begin
        //@(posedge aclk);    //avoid dead-lock
        #(`DLYU);    //avoid dead-lock
    end
end

//ÕâÀï±ØÐëµÈ£º
//1£ºqÃ»Âú
//2£ºÉÏÒ»´ÎpushÍê³É
assign  arready = ar_en & (arq_cnt<MAX_CMDNUM) & (push_ar.busy == 0);

//--------------------------------------------------------------------------------------------------
// r
//--------------------------------------------------------------------------------------------------
task set_r_en;
    begin
        r_en   = 1'b1;
    end
endtask

always begin
    if (r_en) begin : r_proc
        //        finish_wdata = 0;
        //ÕâÀïr_idx¿ÉÒÔ²»ÓÃ´Ó0¿ªÊ¼£¬ÒòÎªwÒÑ¾­ÊÇ°´ÕÕË³ÐòÍê³ÉµÄÁË
        //ÕâÀïÖÁÉÙ»Øresponse
        //TODO »¹ÐèÒªÈ·ÈÏidÊÇÏàÍ¬µÄÇé¿öÏÂµÄÓ°Ïì
`ifdef  AXI_SLAVE_BFM_R_OOO
        for (r_idx=MAX_CMDNUM-1;    r_idx>=0;           r_idx=(r_idx == 0) ? MAX_CMDNUM-1 : r_idx-1) begin
`else
        for (r_idx=0;               r_idx<MAX_CMDNUM;   r_idx=(r_idx == MAX_CMDNUM-1) ? 0 : r_idx+1) begin
`endif
            if (arq_r_valid[r_idx] == 1'b0) begin
                #(`DLYU);    //avoid dead-lock
            end
            else begin
                @ (posedge aclk );
                if (VERBOSE) $display ("%t\t",$realtime, "\t[info:%m] arq_r_valid[%d] = 1, id = '%d",r_idx,arq_id[r_idx]);

//                // Timer for delay the next w
//                repeat (cycles_w2w[r_idx]) @(posedge ACLK);
                //--------------------------------------------------------------------------------------------------
                //  1st
                //--------------------------------------------------------------------------------------------------
                rvalid <= #(`DLYU) 1'b1;
                rresp_loc[RESP_WIDTH-1:0] <= #(`DLYU) AXI_RESP_OKAY;
                if (arq_len[r_idx] == 0) begin
                    rlast_loc  <= #(`DLYU) 1'b1;           //TODO, suppose len = single
                end
                else begin
                    rlast_loc  <= #(`DLYU) 1'b0;           //TODO, suppose len = single
                end
                rid_loc[ID_WIDTH-1:0]    <= #(`DLYU) arq_id[r_idx];
//20220330 remove
//                rindex = (arq_addr[r_idx])/BYTEEN_WIDTH;
//                if (VERBOSE) $display ("%t\t",$realtime, "\t[info:%m] rindex = ox%h; rdata = ox%h",rindex, mem_array[rindex]);
//                rdata[DATA_WIDTH-1:0]              <= #(`DLYU) mem_array[rindex];

//20220330 add
//                raddr_data_phase [ADDR_WIDTH-1:0] = (arq_addr[r_idx]);
//                arsize_data_phase [SIZE_WIDTH-1:0] = (arq_asize[r_idx]);
//
//                if (DATA_WIDTH == 32) begin
//                    raddr_data_phase_align [ADDR_WIDTH-1:0] = {raddr_data_phase [ADDR_WIDTH-1:2], 2'b0};
//                end
//                else if (DATA_WIDTH == 64) begin
//                    raddr_data_phase_align [ADDR_WIDTH-1:0] = {raddr_data_phase [ADDR_WIDTH-1:3], 3'b0};
//                end
//
//                rstrb[STRB_WIDTH-1:0]  = get_strb(get_size(arsize_data_phase));
//                rstrb   = rstrb <<(get_shift_byte(raddr_data_phase)*1);
//
//                tmp_rdata[DATA_WIDTH-1:0] = 0;
//
//                for (j2=0;j2<STRB_WIDTH;j2=j2+1) begin
//                    if (rstrb[STRB_WIDTH-1-j2] == 1'b1) begin
//                        tmp_rdata[DATA_WIDTH-1:0] = (tmp_rdata[DATA_WIDTH-1:0]<<8) | mem_array[raddr_data_phase_align[ADDR_WIDTH-1:0]+STRB_WIDTH-1-j2];
//                    end
//                    else begin
//                        tmp_rdata[DATA_WIDTH-1:0] = (tmp_rdata[DATA_WIDTH-1:0]<<8);
//                    end
//                end
//
//                if (VERBOSE == 1) begin
//                    $display("%t\t",$realtime, "[info:%m] 0x%h <- 0x%h", tmp_rdata[DATA_WIDTH-1:0], raddr_data_phase);
//                end
//
//                rdata_loc[DATA_WIDTH-1:0] <= #(`DLYU) tmp_rdata[DATA_WIDTH-1:0];
//
//
//
//
//                for (wlen_i=0;wlen_i<=arq_len[r_idx];wlen_i=wlen_i+1) begin
//                    rindex = MAX_BURSTLEN*r_idx+wlen_i;
//
//                    // Get Data
//                    mem_array[rindex]  <= #(`DLYU) WDATA;
////                    WSTRB  <= #(`DLYU) buf_wstrb[rindex];
//
//                    // Wait for Slave accept wdata
//                @ (accept_r);



                //--------------------------------------------------------------------------------------------------
                //--------------------------------------------------------------------------------------------------
                for (rlen_i=0;rlen_i<=arq_len[r_idx];rlen_i=rlen_i+1) begin
//20220330 remove
//                    rindex = MAX_BURSTLEN*r_idx+rlen_i;
//                    //20220310£¬¸ÄÎªÊµ¼ÊÐ´µ½Ò»¸ösramµÄµØÖ·
//                    //µØÖ·¾ÍÊÇawµÃµ½µÄ
//                    //rindex = MAX_BURSTLEN*w_idx+wlen_i;
//                    rindex = (arq_addr[r_idx] + (rlen_i*BYTEEN_WIDTH))/BYTEEN_WIDTH;
//                    if (VERBOSE) $display ("%t\t",$realtime, "\t[info:%m] rindex = ox%h; rdata_loc = ox%h",rindex, mem_array[rindex]);
//                    rdata_loc[DATA_WIDTH-1:0]              <= #(`DLYU) mem_array[rindex];


//20220330 add
                    raddr_data_phase [ADDR_WIDTH-1:0] = (arq_addr[r_idx]) + (rlen_i*BYTEEN_WIDTH);
                    arsize_data_phase [SIZE_WIDTH-1:0] = (arq_asize[r_idx]);

                    if (DATA_WIDTH == 32) begin
                        raddr_data_phase_align [ADDR_WIDTH-1:0] = {raddr_data_phase [ADDR_WIDTH-1:2], 2'b0};
                    end
                    else if (DATA_WIDTH == 64) begin
                        raddr_data_phase_align [ADDR_WIDTH-1:0] = {raddr_data_phase [ADDR_WIDTH-1:3], 3'b0};
                    end

                    rstrb[STRB_WIDTH-1:0]  = get_strb(get_size(arsize_data_phase));
                    rstrb   = rstrb <<(get_shift_byte(raddr_data_phase)*1);

                    tmp_rdata[DATA_WIDTH-1:0] = 0;

                    if (raddr_data_phase_align >= (2**MEM_ADDR_WIDTH)) begin
                        $display ("%t\t",$realtime, "[error:%m] //////////////////////////////////////////////////////////////");
                        $display ("%t\t",$realtime, "[error:%m] this data read from addr. '0x%h' will not read from mem-araay, because of out-of-range",raddr_data_phase_align);
                        $display ("%t\t",$realtime, "[error:%m] //////////////////////////////////////////////////////////////");
                    end

                    for (j2=0;j2<STRB_WIDTH;j2=j2+1) begin
                        if (rstrb[STRB_WIDTH-1-j2] == 1'b1) begin
                            tmp_rdata[DATA_WIDTH-1:0] = (tmp_rdata[DATA_WIDTH-1:0]<<8) | mem_array[raddr_data_phase_align[ADDR_WIDTH-1:0]+STRB_WIDTH-1-j2];
                        end
                        else begin
                            tmp_rdata[DATA_WIDTH-1:0] = (tmp_rdata[DATA_WIDTH-1:0]<<8);
                        end
                    end

                    if (VERBOSE == 1) begin
                        $display("%t\t",$realtime, "[info:%m] 0x%h <- 0x%h", tmp_rdata[DATA_WIDTH-1:0], raddr_data_phase);
                    end

                    rdata_loc[DATA_WIDTH-1:0] <= #(`DLYU) tmp_rdata[DATA_WIDTH-1:0];



                    // Get Data
//                    mem_array[rindex]  <= #(`DLYU) wdata;
//                    WSTRB  <= #(`DLYU) buf_wstrb[rindex];

                    // Wait for Slave accept wdata
                    @ (accept_r);
                    if (VERBOSE) $display ("%t\t",$realtime, "\t[info:%m] accept_r = '%h'",wdata);
//                     // Write to log file
//                     tmp_waddr = buf_waddr[rindex];
//                     for(wbyte=0;wbyte<STRB_WIDTH;wbyte=wbyte+1) begin
//                       byte_wtmp = buf_wdata[rindex]>>wbyte*8;
//                       if (buf_wstrb[rindex][wbyte]) 
//                         $fdisplay (FWR,"ad[0x%4x] <--- wd[%x]", tmp_waddr+wbyte,byte_wtmp);
//                     end
                    if (rlen_i==arq_len[r_idx]-1) begin
                        rlast_loc  <= #(`DLYU) 1'b1;           //TODO, suppose len = single
                    end

                end // for



//                if (VERBOSE) $display ("%t\t",$realtime, "\t[info:%m] accept_r");
//                     // Write to log file
//                     tmp_waddr = buf_waddr[rindex];
//                     for(wbyte=0;wbyte<STRB_WIDTH;wbyte=wbyte+1) begin
//                       byte_wtmp = buf_wdata[rindex]>>wbyte*8;
//                       if (buf_wstrb[rindex][wbyte]) 
//                         $fdisplay (FWR,"ad[0x%4x] <--- wd[%x]", tmp_waddr+wbyte,byte_wtmp);
//                     end

//                end // for
                rvalid <= #(`DLYU) 1'b0;
                rresp_loc[RESP_WIDTH-1:0] <= #(`DLYU) 'hz;

//                r_en[r_idx]=1;
//
//                if (~r_piped) begin
//                  // Wait for finish this transaction
//                    wait (r_end[r_idx] && r_end[r_idx]);
//                    r_end[r_idx] = 0;
//                    r_end [r_idx] = 0;
//                end

//                //wrap to the beginning
//                if (r_idx == MAX_CMDNUM-1) begin
//                    r_idx = 0;
//                end

//                finish_wdata = 1;
                arq_r_valid[r_idx]  = 1'b0; //destroy the r of cmd
                arq_ar_valid[r_idx] = 1'b0; //destroy the ar of cmd
                arq_cnt_dbg1     = arq_cnt_dbg1     - 1;
                arq_cnt = arq_cnt - 1;      //b is always after aw/w
            end

            //½øÈëforÒÔºó£¬r_en±ä³É0ÒÔºóÒ²²»»áÍË³ö
            //ËùÒÔÕâÀï¼ì²éµ½r_en=0£¬Ç¿ÖÆÍË³öfor
            if (r_en == 0) begin
                disable r_proc;
            end
        end //for
    end
    else begin
        #(`DLYU);    //avoid dead-lock
    end
end

// %%: assign  rid[ID_WIDTH-1:0]       = (rvalid === 1'b1) ? rid_loc[ID_WIDTH-1:0]     : 'hz;
// %%: assign  rdata[DATA_WIDTH-1:0]   = (rvalid === 1'b1) ? rdata_loc[DATA_WIDTH-1:0] : 'hz;
// %%: assign  rlast                   = (rvalid === 1'b1) ? rlast_loc                 : 'hz;
// %%: assign  rresp[RESP_WIDTH-1:0]   = (rvalid === 1'b1) ? rresp_loc[RESP_WIDTH-1:0] : 'hz;
////==========================================
//// Read Command Process
////==========================================
//always @ (posedge aclk) begin : rcmd_proc
//    if (arvalid & arready) 
//    begin
//    start_raddr =  araddr;
//    r_burst     =  arburst;
//    r_len       =  arlen;
//    r_size      =  arsize;
//
//    arready     <= #(`DLYU) 1'b0;
//
//    // decode read addr
//    decode_address(start_raddr,r_burst,r_len,r_size,1'b0);
//    
//    -> accept_ar;
//    end
//end
//
////==========================================
//// Read Data and Respons Process
////==========================================
//always @ (accept_ar) begin : rdata_proc
//    rvalid <= #(`DLYU) 1'b1;
//    for (cnt_rlen=0;cnt_rlen<=r_len;cnt_rlen=cnt_rlen+1) begin
//    for (rbyte=0;rbyte<BYTEEN_WIDTH;rbyte=rbyte+1) begin
//        rdata_tmp = {mem_array[r_addr[cnt_rlen]+rbyte],rdata_tmp} >> 8;
//      // For debug
//        debug_raddr = r_addr[cnt_rlen]+rbyte;
//        debug_rdata = mem_array[debug_raddr];
//      //$display ("Read [%03d] -> %02h",debug_raddr,debug_rdata);
//    end
//
//    rdata  <= #(`DLYU) rdata_tmp;
//    rlast  <= #(`DLYU) (cnt_rlen==r_len);
//    @(accept_r);
//    end
//    rvalid  <= #(`DLYU) 1'b0;
//    rlast   <= #(`DLYU) 1'b0;
//    arready <= #(`DLYU) 1'b1;
//end

//==========================================
// checker
//==========================================
always @ (posedge aclk  or negedge aresetn) begin 
    if (aresetn) begin
        if (awq_cnt >= {32{1'b1}}) begin    //un-signed
            $display ($time,"\t [Error][OVF] awq_cnt = 0x%h",awq_cnt);
            #100;
            $finish;
        end
        if (arq_cnt >= {32{1'b1}}) begin    //un-signed
            $display ($time,"\t [Error][OVF] arq_cnt = 0x%h",arq_cnt);
            #100;
            $finish;
        end
    end
end

 
assign	w_strb_00[BYTEEN_WIDTH-1:0]=w_strb['h00];
assign	w_strb_01[BYTEEN_WIDTH-1:0]=w_strb['h01];
assign	w_strb_02[BYTEEN_WIDTH-1:0]=w_strb['h02];
assign	w_strb_03[BYTEEN_WIDTH-1:0]=w_strb['h03];
assign	w_strb_04[BYTEEN_WIDTH-1:0]=w_strb['h04];
assign	w_strb_05[BYTEEN_WIDTH-1:0]=w_strb['h05];
assign	w_strb_06[BYTEEN_WIDTH-1:0]=w_strb['h06];
assign	w_strb_07[BYTEEN_WIDTH-1:0]=w_strb['h07];
assign	w_strb_08[BYTEEN_WIDTH-1:0]=w_strb['h08];
assign	w_strb_09[BYTEEN_WIDTH-1:0]=w_strb['h09];
assign	w_strb_0a[BYTEEN_WIDTH-1:0]=w_strb['h0a];
assign	w_strb_0b[BYTEEN_WIDTH-1:0]=w_strb['h0b];
assign	w_strb_0c[BYTEEN_WIDTH-1:0]=w_strb['h0c];
assign	w_strb_0d[BYTEEN_WIDTH-1:0]=w_strb['h0d];
assign	w_strb_0e[BYTEEN_WIDTH-1:0]=w_strb['h0e];
assign	w_strb_0f[BYTEEN_WIDTH-1:0]=w_strb['h0f];

assign	mem_00[7:0]=mem_array['h00];
assign	mem_01[7:0]=mem_array['h01];
assign	mem_02[7:0]=mem_array['h02];
assign	mem_03[7:0]=mem_array['h03];
assign	mem_04[7:0]=mem_array['h04];
assign	mem_05[7:0]=mem_array['h05];
assign	mem_06[7:0]=mem_array['h06];
assign	mem_07[7:0]=mem_array['h07];
assign	mem_08[7:0]=mem_array['h08];
assign	mem_09[7:0]=mem_array['h09];
assign	mem_0a[7:0]=mem_array['h0a];
assign	mem_0b[7:0]=mem_array['h0b];
assign	mem_0c[7:0]=mem_array['h0c];
assign	mem_0d[7:0]=mem_array['h0d];
assign	mem_0e[7:0]=mem_array['h0e];
assign	mem_0f[7:0]=mem_array['h0f];

assign	mem_10[7:0]=mem_array['h10];
assign	mem_11[7:0]=mem_array['h11];
assign	mem_12[7:0]=mem_array['h12];
assign	mem_13[7:0]=mem_array['h13];
assign	mem_14[7:0]=mem_array['h14];
assign	mem_15[7:0]=mem_array['h15];
assign	mem_16[7:0]=mem_array['h16];
assign	mem_17[7:0]=mem_array['h17];
assign	mem_18[7:0]=mem_array['h18];
assign	mem_19[7:0]=mem_array['h19];
assign	mem_1a[7:0]=mem_array['h1a];
assign	mem_1b[7:0]=mem_array['h1b];
assign	mem_1c[7:0]=mem_array['h1c];
assign	mem_1d[7:0]=mem_array['h1d];
assign	mem_1e[7:0]=mem_array['h1e];
assign	mem_1f[7:0]=mem_array['h1f];

assign	mem_20[7:0]=mem_array['h20];
assign	mem_21[7:0]=mem_array['h21];
assign	mem_22[7:0]=mem_array['h22];
assign	mem_23[7:0]=mem_array['h23];
assign	mem_24[7:0]=mem_array['h24];
assign	mem_25[7:0]=mem_array['h25];
assign	mem_26[7:0]=mem_array['h26];
assign	mem_27[7:0]=mem_array['h27];
assign	mem_28[7:0]=mem_array['h28];
assign	mem_29[7:0]=mem_array['h29];
assign	mem_2a[7:0]=mem_array['h2a];
assign	mem_2b[7:0]=mem_array['h2b];
assign	mem_2c[7:0]=mem_array['h2c];
assign	mem_2d[7:0]=mem_array['h2d];
assign	mem_2e[7:0]=mem_array['h2e];
assign	mem_2f[7:0]=mem_array['h2f];

assign	mem_30[7:0]=mem_array['h30];
assign	mem_31[7:0]=mem_array['h31];
assign	mem_32[7:0]=mem_array['h32];
assign	mem_33[7:0]=mem_array['h33];
assign	mem_34[7:0]=mem_array['h34];
assign	mem_35[7:0]=mem_array['h35];
assign	mem_36[7:0]=mem_array['h36];
assign	mem_37[7:0]=mem_array['h37];
assign	mem_38[7:0]=mem_array['h38];
assign	mem_39[7:0]=mem_array['h39];
assign	mem_3a[7:0]=mem_array['h3a];
assign	mem_3b[7:0]=mem_array['h3b];
assign	mem_3c[7:0]=mem_array['h3c];
assign	mem_3d[7:0]=mem_array['h3d];
assign	mem_3e[7:0]=mem_array['h3e];
assign	mem_3f[7:0]=mem_array['h3f];

assign	mem_40[7:0]=mem_array['h40];
assign	mem_41[7:0]=mem_array['h41];
assign	mem_42[7:0]=mem_array['h42];
assign	mem_43[7:0]=mem_array['h43];
assign	mem_44[7:0]=mem_array['h44];
assign	mem_45[7:0]=mem_array['h45];
assign	mem_46[7:0]=mem_array['h46];
assign	mem_47[7:0]=mem_array['h47];
assign	mem_48[7:0]=mem_array['h48];
assign	mem_49[7:0]=mem_array['h49];
assign	mem_4a[7:0]=mem_array['h4a];
assign	mem_4b[7:0]=mem_array['h4b];
assign	mem_4c[7:0]=mem_array['h4c];
assign	mem_4d[7:0]=mem_array['h4d];
assign	mem_4e[7:0]=mem_array['h4e];
assign	mem_4f[7:0]=mem_array['h4f];

assign	mem_50[7:0]=mem_array['h50];
assign	mem_51[7:0]=mem_array['h51];
assign	mem_52[7:0]=mem_array['h52];
assign	mem_53[7:0]=mem_array['h53];
assign	mem_54[7:0]=mem_array['h54];
assign	mem_55[7:0]=mem_array['h55];
assign	mem_56[7:0]=mem_array['h56];
assign	mem_57[7:0]=mem_array['h57];
assign	mem_58[7:0]=mem_array['h58];
assign	mem_59[7:0]=mem_array['h59];
assign	mem_5a[7:0]=mem_array['h5a];
assign	mem_5b[7:0]=mem_array['h5b];
assign	mem_5c[7:0]=mem_array['h5c];
assign	mem_5d[7:0]=mem_array['h5d];
assign	mem_5e[7:0]=mem_array['h5e];
assign	mem_5f[7:0]=mem_array['h5f];

assign	mem_90[7:0]=mem_array['h90];
assign	mem_91[7:0]=mem_array['h91];
assign	mem_92[7:0]=mem_array['h92];
assign	mem_93[7:0]=mem_array['h93];
assign	mem_94[7:0]=mem_array['h94];
assign	mem_95[7:0]=mem_array['h95];
assign	mem_96[7:0]=mem_array['h96];
assign	mem_97[7:0]=mem_array['h97];
assign	mem_98[7:0]=mem_array['h98];
assign	mem_99[7:0]=mem_array['h99];
assign	mem_9a[7:0]=mem_array['h9a];
assign	mem_9b[7:0]=mem_array['h9b];
assign	mem_9c[7:0]=mem_array['h9c];
assign	mem_9d[7:0]=mem_array['h9d];
assign	mem_9e[7:0]=mem_array['h9e];
assign	mem_9f[7:0]=mem_array['h9f];

assign	mem_a0[7:0]=mem_array['ha0];
assign	mem_a1[7:0]=mem_array['ha1];
assign	mem_a2[7:0]=mem_array['ha2];
assign	mem_a3[7:0]=mem_array['ha3];
assign	mem_a4[7:0]=mem_array['ha4];
assign	mem_a5[7:0]=mem_array['ha5];
assign	mem_a6[7:0]=mem_array['ha6];
assign	mem_a7[7:0]=mem_array['ha7];
assign	mem_a8[7:0]=mem_array['ha8];
assign	mem_a9[7:0]=mem_array['ha9];
assign	mem_aa[7:0]=mem_array['haa];
assign	mem_ab[7:0]=mem_array['hab];
assign	mem_ac[7:0]=mem_array['hac];
assign	mem_ad[7:0]=mem_array['had];
assign	mem_ae[7:0]=mem_array['hae];
assign	mem_af[7:0]=mem_array['haf];

assign	mem_b0[7:0]=mem_array['hb0];
assign	mem_b1[7:0]=mem_array['hb1];
assign	mem_b2[7:0]=mem_array['hb2];
assign	mem_b3[7:0]=mem_array['hb3];
assign	mem_b4[7:0]=mem_array['hb4];
assign	mem_b5[7:0]=mem_array['hb5];
assign	mem_b6[7:0]=mem_array['hb6];
assign	mem_b7[7:0]=mem_array['hb7];
assign	mem_b8[7:0]=mem_array['hb8];
assign	mem_b9[7:0]=mem_array['hb9];
assign	mem_ba[7:0]=mem_array['hba];
assign	mem_bb[7:0]=mem_array['hbb];
assign	mem_bc[7:0]=mem_array['hbc];
assign	mem_bd[7:0]=mem_array['hbd];
assign	mem_be[7:0]=mem_array['hbe];
assign	mem_bf[7:0]=mem_array['hbf];

assign	mem_c0[7:0]=mem_array['hc0];
assign	mem_c1[7:0]=mem_array['hc1];
assign	mem_c2[7:0]=mem_array['hc2];
assign	mem_c3[7:0]=mem_array['hc3];
assign	mem_c4[7:0]=mem_array['hc4];
assign	mem_c5[7:0]=mem_array['hc5];
assign	mem_c6[7:0]=mem_array['hc6];
assign	mem_c7[7:0]=mem_array['hc7];
assign	mem_c8[7:0]=mem_array['hc8];
assign	mem_c9[7:0]=mem_array['hc9];
assign	mem_ca[7:0]=mem_array['hca];
assign	mem_cb[7:0]=mem_array['hcb];
assign	mem_cc[7:0]=mem_array['hcc];
assign	mem_cd[7:0]=mem_array['hcd];
assign	mem_ce[7:0]=mem_array['hce];
assign	mem_cf[7:0]=mem_array['hcf];

assign	mem_d0[7:0]=mem_array['hd0];
assign	mem_d1[7:0]=mem_array['hd1];
assign	mem_d2[7:0]=mem_array['hd2];
assign	mem_d3[7:0]=mem_array['hd3];
assign	mem_d4[7:0]=mem_array['hd4];
assign	mem_d5[7:0]=mem_array['hd5];
assign	mem_d6[7:0]=mem_array['hd6];
assign	mem_d7[7:0]=mem_array['hd7];
assign	mem_d8[7:0]=mem_array['hd8];
assign	mem_d9[7:0]=mem_array['hd9];
assign	mem_da[7:0]=mem_array['hda];
assign	mem_db[7:0]=mem_array['hdb];
assign	mem_dc[7:0]=mem_array['hdc];
assign	mem_dd[7:0]=mem_array['hdd];
assign	mem_de[7:0]=mem_array['hde];
assign	mem_df[7:0]=mem_array['hdf];

assign	mem_e0[7:0]=mem_array['he0];
assign	mem_e1[7:0]=mem_array['he1];
assign	mem_e2[7:0]=mem_array['he2];
assign	mem_e3[7:0]=mem_array['he3];
assign	mem_e4[7:0]=mem_array['he4];
assign	mem_e5[7:0]=mem_array['he5];
assign	mem_e6[7:0]=mem_array['he6];
assign	mem_e7[7:0]=mem_array['he7];
assign	mem_e8[7:0]=mem_array['he8];
assign	mem_e9[7:0]=mem_array['he9];
assign	mem_ea[7:0]=mem_array['hea];
assign	mem_eb[7:0]=mem_array['heb];
assign	mem_ec[7:0]=mem_array['hec];
assign	mem_ed[7:0]=mem_array['hed];
assign	mem_ee[7:0]=mem_array['hee];
assign	mem_ef[7:0]=mem_array['hef];

assign	mem_f0[7:0]=mem_array['hf0];
assign	mem_f1[7:0]=mem_array['hf1];
assign	mem_f2[7:0]=mem_array['hf2];
assign	mem_f3[7:0]=mem_array['hf3];
assign	mem_f4[7:0]=mem_array['hf4];
assign	mem_f5[7:0]=mem_array['hf5];
assign	mem_f6[7:0]=mem_array['hf6];
assign	mem_f7[7:0]=mem_array['hf7];
assign	mem_f8[7:0]=mem_array['hf8];
assign	mem_f9[7:0]=mem_array['hf9];
assign	mem_fa[7:0]=mem_array['hfa];
assign	mem_fb[7:0]=mem_array['hfb];
assign	mem_fc[7:0]=mem_array['hfc];
assign	mem_fd[7:0]=mem_array['hfd];
assign	mem_fe[7:0]=mem_array['hfe];
assign	mem_ff[7:0]=mem_array['hff];

assign	mem_100[7:0]=mem_array['h100];
assign	mem_101[7:0]=mem_array['h101];
assign	mem_102[7:0]=mem_array['h102];
assign	mem_103[7:0]=mem_array['h103];
assign	mem_104[7:0]=mem_array['h104];
assign	mem_105[7:0]=mem_array['h105];
assign	mem_106[7:0]=mem_array['h106];
assign	mem_107[7:0]=mem_array['h107];
assign	mem_108[7:0]=mem_array['h108];
assign	mem_109[7:0]=mem_array['h109];
assign	mem_10a[7:0]=mem_array['h10a];
assign	mem_10b[7:0]=mem_array['h10b];
assign	mem_10c[7:0]=mem_array['h10c];
assign	mem_10d[7:0]=mem_array['h10d];
assign	mem_10e[7:0]=mem_array['h10e];
assign	mem_10f[7:0]=mem_array['h10f];

assign	mem_120[7:0]=mem_array['h120];
assign	mem_121[7:0]=mem_array['h121];
assign	mem_122[7:0]=mem_array['h122];
assign	mem_123[7:0]=mem_array['h123];
assign	mem_124[7:0]=mem_array['h124];
assign	mem_125[7:0]=mem_array['h125];
assign	mem_126[7:0]=mem_array['h126];
assign	mem_127[7:0]=mem_array['h127];
assign	mem_128[7:0]=mem_array['h128];
assign	mem_129[7:0]=mem_array['h129];
assign	mem_12a[7:0]=mem_array['h12a];
assign	mem_12b[7:0]=mem_array['h12b];
assign	mem_12c[7:0]=mem_array['h12c];
assign	mem_12d[7:0]=mem_array['h12d];
assign	mem_12e[7:0]=mem_array['h12e];
assign	mem_12f[7:0]=mem_array['h12f];

assign	mem_130[7:0]=mem_array['h130];
assign	mem_131[7:0]=mem_array['h131];
assign	mem_132[7:0]=mem_array['h132];
assign	mem_133[7:0]=mem_array['h133];
assign	mem_134[7:0]=mem_array['h134];
assign	mem_135[7:0]=mem_array['h135];
assign	mem_136[7:0]=mem_array['h136];
assign	mem_137[7:0]=mem_array['h137];
assign	mem_138[7:0]=mem_array['h138];
assign	mem_139[7:0]=mem_array['h139];
assign	mem_13a[7:0]=mem_array['h13a];
assign	mem_13b[7:0]=mem_array['h13b];
assign	mem_13c[7:0]=mem_array['h13c];
assign	mem_13d[7:0]=mem_array['h13d];
assign	mem_13e[7:0]=mem_array['h13e];
assign	mem_13f[7:0]=mem_array['h13f];

assign	mem_160[7:0]=mem_array['h160];
assign	mem_161[7:0]=mem_array['h161];
assign	mem_162[7:0]=mem_array['h162];
assign	mem_163[7:0]=mem_array['h163];
assign	mem_164[7:0]=mem_array['h164];
assign	mem_165[7:0]=mem_array['h165];
assign	mem_166[7:0]=mem_array['h166];
assign	mem_167[7:0]=mem_array['h167];
assign	mem_168[7:0]=mem_array['h168];
assign	mem_169[7:0]=mem_array['h169];
assign	mem_16a[7:0]=mem_array['h16a];
assign	mem_16b[7:0]=mem_array['h16b];
assign	mem_16c[7:0]=mem_array['h16c];
assign	mem_16d[7:0]=mem_array['h16d];
assign	mem_16e[7:0]=mem_array['h16e];
assign	mem_16f[7:0]=mem_array['h16f];

assign	mem_1f0[7:0]=mem_array['h1f0];
assign	mem_1f1[7:0]=mem_array['h1f1];
assign	mem_1f2[7:0]=mem_array['h1f2];
assign	mem_1f3[7:0]=mem_array['h1f3];
assign	mem_1f4[7:0]=mem_array['h1f4];
assign	mem_1f5[7:0]=mem_array['h1f5];
assign	mem_1f6[7:0]=mem_array['h1f6];
assign	mem_1f7[7:0]=mem_array['h1f7];
assign	mem_1f8[7:0]=mem_array['h1f8];
assign	mem_1f9[7:0]=mem_array['h1f9];
assign	mem_1fa[7:0]=mem_array['h1fa];
assign	mem_1fb[7:0]=mem_array['h1fb];
assign	mem_1fc[7:0]=mem_array['h1fc];
assign	mem_1fd[7:0]=mem_array['h1fd];
assign	mem_1fe[7:0]=mem_array['h1fe];
assign	mem_1ff[7:0]=mem_array['h1ff];

assign	mem_220[7:0]=mem_array['h220];
assign	mem_221[7:0]=mem_array['h221];
assign	mem_222[7:0]=mem_array['h222];
assign	mem_223[7:0]=mem_array['h223];
assign	mem_224[7:0]=mem_array['h224];
assign	mem_225[7:0]=mem_array['h225];
assign	mem_226[7:0]=mem_array['h226];
assign	mem_227[7:0]=mem_array['h227];
assign	mem_228[7:0]=mem_array['h228];
assign	mem_229[7:0]=mem_array['h229];
assign	mem_22a[7:0]=mem_array['h22a];
assign	mem_22b[7:0]=mem_array['h22b];
assign	mem_22c[7:0]=mem_array['h22c];
assign	mem_22d[7:0]=mem_array['h22d];
assign	mem_22e[7:0]=mem_array['h22e];
assign	mem_22f[7:0]=mem_array['h22f];

assign	mem_380[7:0]=mem_array['h380];
assign	mem_381[7:0]=mem_array['h381];
assign	mem_382[7:0]=mem_array['h382];
assign	mem_383[7:0]=mem_array['h383];
assign	mem_384[7:0]=mem_array['h384];
assign	mem_385[7:0]=mem_array['h385];
assign	mem_386[7:0]=mem_array['h386];
assign	mem_387[7:0]=mem_array['h387];
assign	mem_388[7:0]=mem_array['h388];
assign	mem_389[7:0]=mem_array['h389];
assign	mem_38a[7:0]=mem_array['h38a];
assign	mem_38b[7:0]=mem_array['h38b];
assign	mem_38c[7:0]=mem_array['h38c];
assign	mem_38d[7:0]=mem_array['h38d];
assign	mem_38e[7:0]=mem_array['h38e];
assign	mem_38f[7:0]=mem_array['h38f];

assign      mem_array_0aaa_0000[7:0]       = mem_array[32'h0aaa_0000];
assign      mem_array_0aaa_0001[7:0]       = mem_array[32'h0aaa_0001];
assign      mem_array_0aaa_0002[7:0]       = mem_array[32'h0aaa_0002];
assign      mem_array_0aaa_0003[7:0]       = mem_array[32'h0aaa_0003];
assign      mem_array_0aaa_0004[7:0]       = mem_array[32'h0aaa_0004];
assign      mem_array_0aaa_0005[7:0]       = mem_array[32'h0aaa_0005];
assign      mem_array_0aaa_0006[7:0]       = mem_array[32'h0aaa_0006];
assign      mem_array_0aaa_0007[7:0]       = mem_array[32'h0aaa_0007];
assign      mem_array_0aaa_0008[7:0]       = mem_array[32'h0aaa_0008];
assign      mem_array_0aaa_0009[7:0]       = mem_array[32'h0aaa_0009];
assign      mem_array_0aaa_000a[7:0]       = mem_array[32'h0aaa_000a];
assign      mem_array_0aaa_000b[7:0]       = mem_array[32'h0aaa_000b];
assign      mem_array_0aaa_000c[7:0]       = mem_array[32'h0aaa_000c];
assign      mem_array_0aaa_000d[7:0]       = mem_array[32'h0aaa_000d];
assign      mem_array_0aaa_000e[7:0]       = mem_array[32'h0aaa_000e];
assign      mem_array_0aaa_000f[7:0]       = mem_array[32'h0aaa_000f];

assign      mem_array_0bbb_0000[7:0]       = mem_array[32'h0bbb_0000];
assign      mem_array_0bbb_0001[7:0]       = mem_array[32'h0bbb_0001];
assign      mem_array_0bbb_0002[7:0]       = mem_array[32'h0bbb_0002];
assign      mem_array_0bbb_0003[7:0]       = mem_array[32'h0bbb_0003];
assign      mem_array_0bbb_0004[7:0]       = mem_array[32'h0bbb_0004];
assign      mem_array_0bbb_0005[7:0]       = mem_array[32'h0bbb_0005];
assign      mem_array_0bbb_0006[7:0]       = mem_array[32'h0bbb_0006];
assign      mem_array_0bbb_0007[7:0]       = mem_array[32'h0bbb_0007];
assign      mem_array_0bbb_0008[7:0]       = mem_array[32'h0bbb_0008];
assign      mem_array_0bbb_0009[7:0]       = mem_array[32'h0bbb_0009];
assign      mem_array_0bbb_000a[7:0]       = mem_array[32'h0bbb_000a];
assign      mem_array_0bbb_000b[7:0]       = mem_array[32'h0bbb_000b];
assign      mem_array_0bbb_000c[7:0]       = mem_array[32'h0bbb_000c];
assign      mem_array_0bbb_000d[7:0]       = mem_array[32'h0bbb_000d];
assign      mem_array_0bbb_000e[7:0]       = mem_array[32'h0bbb_000e];
assign      mem_array_0bbb_000f[7:0]       = mem_array[32'h0bbb_000f];

assign      mem_array_0bbb_0010[7:0]       = mem_array[32'h0bbb_0010];
assign      mem_array_0bbb_0011[7:0]       = mem_array[32'h0bbb_0011];
assign      mem_array_0bbb_0012[7:0]       = mem_array[32'h0bbb_0012];
assign      mem_array_0bbb_0013[7:0]       = mem_array[32'h0bbb_0013];
assign      mem_array_0bbb_0014[7:0]       = mem_array[32'h0bbb_0014];
assign      mem_array_0bbb_0015[7:0]       = mem_array[32'h0bbb_0015];
assign      mem_array_0bbb_0016[7:0]       = mem_array[32'h0bbb_0016];
assign      mem_array_0bbb_0017[7:0]       = mem_array[32'h0bbb_0017];
assign      mem_array_0bbb_0018[7:0]       = mem_array[32'h0bbb_0018];
assign      mem_array_0bbb_0019[7:0]       = mem_array[32'h0bbb_0019];
assign      mem_array_0bbb_001a[7:0]       = mem_array[32'h0bbb_001a];
assign      mem_array_0bbb_001b[7:0]       = mem_array[32'h0bbb_001b];
assign      mem_array_0bbb_001c[7:0]       = mem_array[32'h0bbb_001c];
assign      mem_array_0bbb_001d[7:0]       = mem_array[32'h0bbb_001d];
assign      mem_array_0bbb_001e[7:0]       = mem_array[32'h0bbb_001e];
assign      mem_array_0bbb_001f[7:0]       = mem_array[32'h0bbb_001f];

assign	w_addr_00[ADDR_WIDTH-1:0] = w_addr['h00];
assign	w_addr_01[ADDR_WIDTH-1:0] = w_addr['h01];
assign	w_addr_02[ADDR_WIDTH-1:0] = w_addr['h02];
assign	w_addr_03[ADDR_WIDTH-1:0] = w_addr['h03];
assign	w_addr_04[ADDR_WIDTH-1:0] = w_addr['h04];
assign	w_addr_05[ADDR_WIDTH-1:0] = w_addr['h05];
assign	w_addr_06[ADDR_WIDTH-1:0] = w_addr['h06];
assign	w_addr_07[ADDR_WIDTH-1:0] = w_addr['h07];
assign	w_addr_08[ADDR_WIDTH-1:0] = w_addr['h08];
assign	w_addr_09[ADDR_WIDTH-1:0] = w_addr['h09];
assign	w_addr_0a[ADDR_WIDTH-1:0] = w_addr['h0a];
assign	w_addr_0b[ADDR_WIDTH-1:0] = w_addr['h0b];
assign	w_addr_0c[ADDR_WIDTH-1:0] = w_addr['h0c];
assign	w_addr_0d[ADDR_WIDTH-1:0] = w_addr['h0d];
assign	w_addr_0e[ADDR_WIDTH-1:0] = w_addr['h0e];
assign	w_addr_0f[ADDR_WIDTH-1:0] = w_addr['h0f];

assign	w_data_00[ADDR_WIDTH-1:0] = w_data['h00];
assign	w_data_01[ADDR_WIDTH-1:0] = w_data['h01];
assign	w_data_02[ADDR_WIDTH-1:0] = w_data['h02];
assign	w_data_03[ADDR_WIDTH-1:0] = w_data['h03];
assign	w_data_04[ADDR_WIDTH-1:0] = w_data['h04];
assign	w_data_05[ADDR_WIDTH-1:0] = w_data['h05];
assign	w_data_06[ADDR_WIDTH-1:0] = w_data['h06];
assign	w_data_07[ADDR_WIDTH-1:0] = w_data['h07];
assign	w_data_08[ADDR_WIDTH-1:0] = w_data['h08];
assign	w_data_09[ADDR_WIDTH-1:0] = w_data['h09];
assign	w_data_0a[ADDR_WIDTH-1:0] = w_data['h0a];
assign	w_data_0b[ADDR_WIDTH-1:0] = w_data['h0b];
assign	w_data_0c[ADDR_WIDTH-1:0] = w_data['h0c];
assign	w_data_0d[ADDR_WIDTH-1:0] = w_data['h0d];
assign	w_data_0e[ADDR_WIDTH-1:0] = w_data['h0e];
assign	w_data_0f[ADDR_WIDTH-1:0] = w_data['h0f];

assign	r_addr_00[ADDR_WIDTH-1:0] = r_addr['h00];
assign	r_addr_01[ADDR_WIDTH-1:0] = r_addr['h01];
assign	r_addr_02[ADDR_WIDTH-1:0] = r_addr['h02];
assign	r_addr_03[ADDR_WIDTH-1:0] = r_addr['h03];
assign	r_addr_04[ADDR_WIDTH-1:0] = r_addr['h04];
assign	r_addr_05[ADDR_WIDTH-1:0] = r_addr['h05];
assign	r_addr_06[ADDR_WIDTH-1:0] = r_addr['h06];
assign	r_addr_07[ADDR_WIDTH-1:0] = r_addr['h07];
assign	r_addr_08[ADDR_WIDTH-1:0] = r_addr['h08];
assign	r_addr_09[ADDR_WIDTH-1:0] = r_addr['h09];
assign	r_addr_0a[ADDR_WIDTH-1:0] = r_addr['h0a];
assign	r_addr_0b[ADDR_WIDTH-1:0] = r_addr['h0b];
assign	r_addr_0c[ADDR_WIDTH-1:0] = r_addr['h0c];
assign	r_addr_0d[ADDR_WIDTH-1:0] = r_addr['h0d];
assign	r_addr_0e[ADDR_WIDTH-1:0] = r_addr['h0e];
assign	r_addr_0f[ADDR_WIDTH-1:0] = r_addr['h0f];


assign	awq_id_dbg00[ID_WIDTH-1:0]   =   awq_id   ['d00];
assign	awq_id_dbg01[ID_WIDTH-1:0]   =   awq_id   ['d01];
assign	awq_id_dbg02[ID_WIDTH-1:0]   =   awq_id   ['d02];
assign	awq_id_dbg03[ID_WIDTH-1:0]   =   awq_id   ['d03];
assign	awq_id_dbg04[ID_WIDTH-1:0]   =   awq_id   ['d04];
assign	awq_id_dbg05[ID_WIDTH-1:0]   =   awq_id   ['d05];
assign	awq_id_dbg06[ID_WIDTH-1:0]   =   awq_id   ['d06];
assign	awq_id_dbg07[ID_WIDTH-1:0]   =   awq_id   ['d07];
assign	awq_id_dbg08[ID_WIDTH-1:0]   =   awq_id   ['d08];
assign	awq_id_dbg09[ID_WIDTH-1:0]   =   awq_id   ['d09];
assign	awq_id_dbg10[ID_WIDTH-1:0]   =   awq_id   ['d10];
assign	awq_id_dbg11[ID_WIDTH-1:0]   =   awq_id   ['d11];
assign	awq_id_dbg12[ID_WIDTH-1:0]   =   awq_id   ['d12];

assign	arq_id_dbg00[ID_WIDTH-1:0]   =   arq_id   ['d00];
assign	arq_id_dbg01[ID_WIDTH-1:0]   =   arq_id   ['d01];

function [31:0] get_shift_byte;

    input   [ADDR_WIDTH-1:0]    addr;

    integer                     shift_byte;
    begin
        case (DATA_WIDTH)
            1*8 :  shift_byte  = 0;
            2*8 :  shift_byte  = addr[0];
            4*8 :  shift_byte  = addr[1:0];
            8*8 :  shift_byte  = addr[2:0];
            16*8:  shift_byte  = addr[3:0];
            32*8:  shift_byte  = addr[4:0];
        endcase

    get_shift_byte = shift_byte;
    end

endfunction

function [127:0] get_strb;

    input   [9:0]               size;   //real size, not axi size

    reg     [STRB_WIDTH-1:0]    strb;
    begin
        case (size[9:0])
            1 :  strb  = {1{1'b1}};
            2 :  strb  = {2{1'b1}};
            4 :  strb  = {4{1'b1}};
            8 :  strb  = {8{1'b1}};
            16:  strb  = {16{1'b1}};
            32:  strb  = {32{1'b1}};
            64:  strb  = {64{1'b1}};
            128: strb  = {128{1'b1}};

           default: begin
                        $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                        $display("%t\t",$realtime, "[error:%m] not supported size %d", size);
                        $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                        error_cnt = error_cnt + 1;
                        $finish;
                    end
        endcase

    get_strb = strb;
    end

endfunction

//¸ù¾Ýsize£¬decode³öasize
function [2:0] get_asize;

    input   [9:0]    size;

    reg     [2:0]    asize;
    begin
        case (size)
            1 :  asize  = 3'b000;
            2 :  asize  = 3'b001;
            4 :  asize  = 3'b010;
            8 :  asize  = 3'b011;
            16:  asize  = 3'b100;
            32:  asize  = 3'b101;
            64:  asize  = 3'b110;
           128:  asize  = 3'b111;
           default: begin
                        $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                        $display("%t\t",$realtime, "[error:%m] not supported size %d", size);
                        $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                        error_cnt = error_cnt + 1;
                        $finish;
                    end
        endcase

    get_asize = asize;
    end

endfunction

//¸ù¾Ýasize£¬decode³ösize
//ºÍget_asizeÊÇ·´µÄ
function [9:0] get_size;

    input   [2:0]    asize;

    reg     [9:0]    size;
    begin
        case (asize[2:0])
           3'b000:  size  =  1 ;
           3'b001:  size  =  2 ;
           3'b010:  size  =  4 ;
           3'b011:  size  =  8 ;
           3'b100:  size  =  16;
           3'b101:  size  =  32;
           3'b110:  size  =  64;
           3'b111:  size  = 128;
           default: begin
                        $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                        $display("%t\t",$realtime, "[error:%m] not supported size %d", size);
                        $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                        error_cnt = error_cnt + 1;
                        $finish;
                    end
        endcase

    get_size = size;
    end

endfunction

////////////////////////////////////////////////////////////////////////////////////
// Assertion check                                                                //
// not synthesizable, only for simulation                                         //
////////////////////////////////////////////////////////////////////////////////////
`ifdef  HXD_SIM_EN
    //when synthesis & collect coverage, need `undef HXD_SIM_EN_MONITOR
    //×ÛºÏºÍÊÕ¼¯coverageÊ±ÐèÒªundefine HXD_SIM_EN_MONITOR
    `ifdef  HXD_SIM_EN_MONITOR
        //{{{1
        //synopsys translate_off

        initial begin:disp_cfg
            #0;
            $display ("%t\t",$realtime, "[info:%m] //////////////////////////////////////////////////////////////");
            $display ("%t\t",$realtime, "[info:%m] ADDR_WIDTH      = %d", ADDR_WIDTH);
            $display ("%t\t",$realtime, "[info:%m] MEM_ARRAY_DEPTH = 0x%h", MEM_ARRAY_DEPTH[63:0]);
            $display ("%t\t",$realtime, "[info:%m] //////////////////////////////////////////////////////////////");
        end

        initial begin:chk_cfg
            #0;
            if (1) begin:disp_cfg
                $display ("%t\t",$realtime, "[info:%m] //////////////////////////////////////////////////////////////");
                $display ("%t\t",$realtime, "[info:%m] ADDR_WIDTH      = %d", ADDR_WIDTH);
                $display ("%t\t",$realtime, "[info:%m] MEM_ARRAY_DEPTH = 0x%h", MEM_ARRAY_DEPTH[63:0]);
                $display ("%t\t",$realtime, "[info:%m] //////////////////////////////////////////////////////////////");
            end

            //Ä¿Ç°MEM_ADDR_WIDTH×î´óÖ»Ö§³Ö31bit£¬ ³¬¹ý31£¬ÄÚ²¿2Î¬Êý×éÎÞ·¨³É¹¦
            //Òò´Ë¼ì²âÁ½ÕßÖ®¼ä²»Ò»ÖÂ
            if (ADDR_WIDTH > MEM_ADDR_WIDTH) begin:chk_addr_width
                $display ("%t\t",$realtime, "[error:%m] //////////////////////////////////////////////////////////////");
                $display ("%t\t",$realtime, "[error:%m] (ADDR_WIDTH(%d) > MEM_ADDR_WIDTH(%d))", ADDR_WIDTH, MEM_ADDR_WIDTH);
                $display ("%t\t",$realtime, "[error:%m] this will cause some address can not be written into/read from");
                $display ("%t\t",$realtime, "[error:%m] //////////////////////////////////////////////////////////////");
            end

            if ((DATA_WIDTH != 32) && (DATA_WIDTH != 32)) begin:chk_data_width
                $display ("%t\t",$realtime, "[error:%m] //////////////////////////////////////////////////////////////");
                $display ("%t\t",$realtime, "[error:%m] ((DATA_WIDTH != 32) && (DATA_WIDTH != 32))");
                $display ("%t\t",$realtime, "[error:%m]  DATA_WIDTH  = %d", DATA_WIDTH);
                $display ("%t\t",$realtime, "[error:%m] //////////////////////////////////////////////////////////////");
                #1;$finish; //must finish
            end
        end

        //synopsys translate_on
        //}}}1
    `endif//HXD_SIM_EN_MONITOR
`endif//HXD_SIM_EN


task RECEIVE_WRITE_ADDRESS;
    input   [ID_WIDTH-1:0]      i_awid;
    input                       i_id_invalid;
    output  [ADDR_WIDTH-1:0]    o_rcv_awaddr;
    output  [LEN_WIDTH-1:0]     o_rcv_awlen;
    output  [SIZE_WIDTH-1:0]    o_rcv_awsize;
    output  [BURST_WIDTH-1:0]   o_rcv_awburst;
    output  [LOCK_WIDTH-1:0]    o_rcv_awlock;
    output  [CACHE_WIDTH-1:0]   o_rcv_awcache;
    output  [PROT_WIDTH-1:0]    o_rcv_awprot;
    output  [ID_WIDTH-1:0]      o_rcv_awid;
    ////output  [QOS_WIDTH-1:0]     o_rcv_awqos;

    begin
        //@(accept_aw && (i_id_invalid || (i_awid == awid)));
        forever begin: check_acc_aw
            @(accept_aw);
            if(AXI_VERSION==4 || (i_id_invalid || (i_awid == awid))) disable check_acc_aw;
        end
        o_rcv_awaddr  = awaddr ;
        o_rcv_awlen   = awlen  ;
        o_rcv_awsize  = awsize ;
        o_rcv_awburst = awburst;
        o_rcv_awlock  = awlock ;
        o_rcv_awcache = awcache;
        o_rcv_awprot  = awprot ;
        o_rcv_awid    = awid   ;
        ////o_rcv_awqos   = awqos  ;
    end
endtask

task RECEIVE_WRITE_BURST_NO_CHECKS;
    input   [ID_WIDTH-1:0]      i_wid;
    output  [DATA_WIDTH-1:0]    o_rcv_wdata;
    output  [STRB_WIDTH-1:0]    o_rcv_wstrb;

    begin
        //@(accept_w && (i_wid == wid));
        forever begin: check_acc_w
            @(accept_w);
            if(AXI_VERSION==4 || (i_wid == wid)) disable check_acc_w;
        end
        o_rcv_wdata  = wdata ;
        o_rcv_wstrb  = wstrb  ;
    end
endtask

task SEND_WRITE_RESPONSE;
    input   [ID_WIDTH-1:0]      i_bid;
    input   [RESP_WIDTH-1:0]    i_bresp;

    begin
        bvalid = 1;
        bid    = i_bid;
        bresp  = i_bresp;
        @(accept_b);
    end
endtask

task RECEIVE_READ_ADDRESS;
    input   [ID_WIDTH-1:0]      i_arid;
    input                       i_id_invalid;
    output  [ADDR_WIDTH-1:0]    o_rcv_araddr;
    output  [LEN_WIDTH-1:0]     o_rcv_arlen;
    output  [SIZE_WIDTH-1:0]    o_rcv_arsize;
    output  [BURST_WIDTH-1:0]   o_rcv_arburst;
    output  [LOCK_WIDTH-1:0]    o_rcv_arlock;
    output  [CACHE_WIDTH-1:0]   o_rcv_arcache;
    output  [PROT_WIDTH-1:0]    o_rcv_arprot;
    output  [ID_WIDTH-1:0]      o_rcv_arid;

    begin
        ///@(accept_ar && (i_id_invalid || (i_arid == arid)));
        forever begin: check_acc_ar
            @(accept_ar);
            if(AXI_VERSION==4 || (i_id_invalid || (i_arid == arid))) disable check_acc_ar;
        end
        o_rcv_araddr  = araddr ;
        o_rcv_arlen   = arlen  ;
        o_rcv_arsize  = arsize ;
        o_rcv_arburst = arburst;
        o_rcv_arlock  = arlock ;
        o_rcv_arcache = arcache;
        o_rcv_arprot  = arprot ;
        o_rcv_arid    = arid   ;
    end
endtask

task SEND_READ_BURST_RESP_CTRL;
    input   [ID_WIDTH-1:0]      i_arid;
    input   [RESP_WIDTH-1:0]    i_araddr;
    input   [LEN_WIDTH-1:0]     i_arlen;
    input   [SIZE_WIDTH-1:0]    i_arsize;
    input   [BURST_WIDTH-1:0]   i_arbrst;
    input   [DATA_WIDTH*MAX_BURSTLEN-1:0] i_temp_read_data;
    input   [RESP_WIDTH*MAX_BURSTLEN-1:0] i_temp_read_rsp;

    integer i;
    begin
        // only support incr and fixed arsize
        for(i=0; i<=i_arlen; i=i+1) begin
            rvalid = 1'b1;
            rid    = i_arid;
            rdata  = i_temp_read_data[DATA_WIDTH*i +: DATA_WIDTH];
            rlast  = (i == i_arlen) ? 1'b1 : 1'b0;
            rresp  = i_temp_read_rsp[RESP_WIDTH*i +: RESP_WIDTH];
            @(accept_r);
        end
    end
endtask

function set_stop_on_error;
    input LEVEL;
    begin
        set_stop_on_error = LEVEL;
        $display("[%0d] : %0s : Currently not support set_stop_on_error(%0b)",$time, "axi_slave_bfm_core", LEVEL);
    end
endfunction

function set_channel_level_info;
    input LEVEL;
    begin
        set_channel_level_info = LEVEL;
        $display("[%0d] : %0s : Currently not support set_channel_level_info(%0b)",$time, "axi_slave_bfm_core", LEVEL);
    end
endfunction

function set_function_level_info;
    input LEVEL;
    begin
        set_function_level_info = LEVEL;
        $display("[%0d] : %0s : Currently not support set_function_level_info(%0b)",$time, "axi_slave_bfm_core", LEVEL);
    end
endfunction


endmodule

//verilog-library-files: ()
//verilog-library-directories: (".")
//verilog-library-directories: ("$DigitalIP_DIR/common/r1p0/de/rtl/share")
//verilog-library-directories: ("$DigitalIP_DIR/common/r1p0/de/rtl/sig_sync")


