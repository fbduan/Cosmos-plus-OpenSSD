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

module axi_slave_bfm_core(/*autoarg*/);

//////////////////////////////////////////////////////////////////////////////
// Parameter Definition                                                     //
//////////////////////////////////////////////////////////////////////////////
//--------------------------------------------------------------------------
// Parameters that can be modified/overrided when instance this module
//--------------------------------------------------------------------------

parameter   VERBOSE     = 1;

parameter   ADDR_WIDTH  = 8;

parameter   BASE_ADDR   = 0;
parameter   ADDR_SPACE  = 2**ADDR_WIDTH;

parameter   DATA_WIDTH  = 8; 

parameter   ID_WIDTH    = 3;
parameter   SIZE_WIDTH  = 3;
parameter   QOS_WIDTH   = 3;

parameter   MAX_CMDNUM   = 16;

////parameter   MEM_ADDR_WIDTH  = (ADDR_WIDTH >= 31) ? 31 : ADDR_WIDTH;   //max 31, No Internal memory
////parameter  MAX_MEM_ADDR  = 4095; //No Internal Memory

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

////localparam  [63:0]  MEM_ARRAY_DEPTH = (2**MEM_ADDR_WIDTH)-1; //No internal memory

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


//////////////////////////////////////////////////////////////////////////////
// Design Logic                                                             //
//////////////////////////////////////////////////////////////////////////////


task RECEIVE_WRITE_ADDRESS;
    input [ID_WIDTH-1:0]        i_rcv_aw_awid;
    input                       i_rcv_aw_id_invalid;
    output  [ADDR_WIDTH-1:0]    o_rcv_aw_awaddr;
    output  [LEN_WIDTH-1:0]     o_rcv_aw_awlen;
    output  [SIZE_WIDTH-1:0]    o_rcv_aw_awsize;
    output  [BURST_WIDTH-1:0]   o_rcv_aw_awburst;
    output  [LOCK_WIDTH-1:0]    o_rcv_aw_awlock;
    output  [CACHE_WIDTH-1:0]   o_rcv_aw_awcache;
    output  [PROT_WIDTH-1:0]    o_rcv_aw_awprot;
    output  [ID_WIDTH-1:0]      o_rcv_aw_awid;
    output  [QOS_WIDTH-1:0]     o_rcv_aw_awqos;

    reg                         id_invalid;

    begin

    end
endtask

endmodule

//verilog-library-files: ()
//verilog-library-directories: (".")
//verilog-library-directories: ("$DigitalIP_DIR/common/r1p0/de/rtl/share")
//verilog-library-directories: ("$DigitalIP_DIR/common/r1p0/de/rtl/sig_sync")


