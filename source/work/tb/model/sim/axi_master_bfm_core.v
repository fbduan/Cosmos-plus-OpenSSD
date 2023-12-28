// +FHDR****************************************************************************
// *********************************************************************************
//                 Copyright (c) 2019 Hexintek Inc..
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : axi_master_bfm.v
// Author        : Hulk.shu
// Created On    : 2019-01-20 13:30
// Last Modified : 
// ---------------------------------------------------------------------------------
// Description   : top moudle of axi_master_bfm_core
//                  1: 支持两种方式，一种是单独的single，一种是支持outstanding
//                  2:  由于该模块可能跑很快，因此用DLYU而不用DLY
// ---------------------------------------------------------------------------------
// Child-module:
//
//
// -FHDR****************************************************************************
// *********************************************************************************

`ifndef     DLYU
    `define DLYU 0.01
`endif//    DLYU
`ifndef     DLYN
    `define DLYN 30
`endif//    DLYN
`ifndef     DLY
    `define DLY #(`DLYU*($urandom_range(1,`DLYN)))
`endif//    DLY

module axi_master_bfm_core (/*AUTOARG*/
    //Outputs
    awaddr, awburst, awid, awlen, awsize, awprot, awcache, awlock,
    awqos, awvalid, wvalid, wid, wdata, wstrb, wlast, bready, arvalid,
    arid, araddr, arburst, arlen, arsize, arprot, arcache, arlock,
    arqos, rready,

    //Inputs
    aclk, aresetn, awready, wready, bvalid, bid, bresp, arready,
    rvalid, rid, rdata, rlast, rresp
);
////////////////////////////////////////////////////////////////////////////////////
// Parameter Definition                                                           //
////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------------------------------------------------
//paramters that can be modified when instance this module
//----------------------------------------------------------------------------------
parameter   VERBOSE     = 0;

parameter   [0:0]   ERROR_RESP_FINISH = 1;

//interface
parameter   ADDR_WIDTH  = 8;

parameter   DATA_WIDTH  = 8;

parameter   ID_WIDTH    = 3;
parameter   SIZE_WIDTH  = 3;
parameter   QOS_WIDTH   = 3;

parameter   MAX_CMDNUM      = 16;
parameter   MAX_ID          = 31;

parameter   MAX_BURSTLEN    = 16;   // when change this you must change
                                    // the width of AWLEN/ARLEN

parameter   WLOG_NAME       = "axi_master_write.log";
parameter   RLOG_NAME       = "axi_master_read.log";

parameter   CFG_W_MAX_LATENCY   = 200;  //ns
parameter   CFG_R_MAX_LATENCY   = 200;  //ns

//是否为axi4
parameter   AXI_VERSION = 4;
//----------------------------------------------------------------------------------
//local prameters
//parameters, that can NOT be modified when instance this module
//----------------------------------------------------------------------------------
localparam  LEN_WIDTH   = (AXI_VERSION == 4) ? 8 : 4;    //4 or 8
localparam  LOCK_WIDTH  = (AXI_VERSION == 4) ? 1 : 2;
localparam  PROT_WIDTH  = 3;
localparam  RESP_WIDTH  = 2;
localparam  BURST_WIDTH = 2;
localparam  CACHE_WIDTH = 4;

// AXI Burst Encode
localparam  ABURST_FIXED = 2'b00;
localparam  ABURST_INCR  = 2'b01;
localparam  ABURST_WRAP  = 2'b10;
localparam  ABURST_RESV  = 2'b11;

// AXI Lock Encode
localparam  ALOCK_NORM = 2'b00;
localparam  ALOCK_EXCL = 2'b01;
localparam  ALOCK_LOCK = 2'b10;
localparam  ALOCK_RESV = 2'b11;

// AXI Cache Encode
localparam  ACACHE_NONE = 4'b0000;
localparam  ACACHE_BUF  = 4'b0001;

// AXI Response Encode
localparam  ARESP_OKAY    = 2'b00;
localparam  ARESP_EXOKAY  = 2'b01;
localparam  ARESP_SLVERR  = 2'b10;
localparam  ARESP_DECERR  = 2'b11;

localparam  STRB_WIDTH  = (DATA_WIDTH/8);

localparam  ASIZE_1B    = 3'b000;
localparam  ASIZE_2B    = 3'b001;
localparam  ASIZE_4B    = 3'b010;
localparam  ASIZE_8B    = 3'b011;
localparam  ASIZE_16B   = 3'b100;
localparam  ASIZE_32B   = 3'b101;

////////////////////////////////////////////////////////////////////////////////////
// Input/Output Declaration                                                       //
////////////////////////////////////////////////////////////////////////////////////
input                               aclk;
input                               aresetn;

output  [ADDR_WIDTH-1:0]            awaddr;
output  [BURST_WIDTH-1:0]           awburst;
output  [ID_WIDTH-1:0]              awid;
output  [LEN_WIDTH-1:0]             awlen;
output  [SIZE_WIDTH-1:0]            awsize;
output  [PROT_WIDTH-1:0]            awprot;
output  [CACHE_WIDTH-1:0]           awcache;
output  [LOCK_WIDTH-1:0]            awlock;
output  [QOS_WIDTH-1:0]             awqos;
output                              awvalid;
input                               awready;

output                              wvalid;
input                               wready;
output  [ID_WIDTH-1:0]              wid;
output  [DATA_WIDTH-1:0]            wdata;
output  [STRB_WIDTH-1:0]            wstrb;
output                              wlast;

input                               bvalid;
output                              bready;
input   [ID_WIDTH-1:0]              bid;
input   [RESP_WIDTH-1:0]            bresp;

output                              arvalid;
input                               arready;
output  [ID_WIDTH-1:0]              arid;
output  [ADDR_WIDTH-1:0]            araddr;
output  [BURST_WIDTH-1:0]           arburst;
output  [LEN_WIDTH-1:0]             arlen;
output  [SIZE_WIDTH-1:0]            arsize;
output  [PROT_WIDTH-1:0]            arprot;
output  [CACHE_WIDTH-1:0]           arcache;
output  [LOCK_WIDTH-1:0]            arlock;
output  [QOS_WIDTH-1:0]             arqos;

input                               rvalid;
output                              rready;
input   [ID_WIDTH-1:0]              rid;
input   [DATA_WIDTH-1:0]            rdata;
input                               rlast;
input   [RESP_WIDTH-1:0]            rresp;

////////////////////////////////////////////////////////////////////////////////////
// Signal Declaration                                                             //
////////////////////////////////////////////////////////////////////////////////////
/*autodefine*/
//auto wires{{{
wire [ID_WIDTH-1:0]    arq_id_dbg00;
wire [ID_WIDTH-1:0]    arq_id_dbg01;
wire [ID_WIDTH-1:0]    awq_id_dbg00;
wire [ID_WIDTH-1:0]    awq_id_dbg01;
wire [ADDR_WIDTH-1:0]  buf_waddr_00;
wire [ADDR_WIDTH-1:0]  buf_waddr_01;
wire [ADDR_WIDTH-1:0]  buf_waddr_02;
wire [ADDR_WIDTH-1:0]  buf_waddr_03;
wire [ADDR_WIDTH-1:0]  buf_waddr_04;
wire [ADDR_WIDTH-1:0]  buf_waddr_05;
wire [ADDR_WIDTH-1:0]  buf_waddr_06;
wire [ADDR_WIDTH-1:0]  buf_waddr_07;
wire [ADDR_WIDTH-1:0]  buf_waddr_08;
wire [ADDR_WIDTH-1:0]  buf_waddr_09;
wire [ADDR_WIDTH-1:0]  buf_waddr_0a;
wire [ADDR_WIDTH-1:0]  buf_waddr_0b;
wire [ADDR_WIDTH-1:0]  buf_waddr_0c;
wire [ADDR_WIDTH-1:0]  buf_waddr_0d;
wire [ADDR_WIDTH-1:0]  buf_waddr_0e;
wire [ADDR_WIDTH-1:0]  buf_waddr_0f;
wire [DATA_WIDTH-1:0]  buf_wdata_00;
wire [DATA_WIDTH-1:0]  buf_wdata_01;
wire [DATA_WIDTH-1:0]  buf_wdata_02;
wire [DATA_WIDTH-1:0]  buf_wdata_03;
wire [DATA_WIDTH-1:0]  buf_wdata_04;
wire [DATA_WIDTH-1:0]  buf_wdata_05;
wire [DATA_WIDTH-1:0]  buf_wdata_06;
wire [DATA_WIDTH-1:0]  buf_wdata_07;
wire [DATA_WIDTH-1:0]  buf_wdata_08;
wire [DATA_WIDTH-1:0]  buf_wdata_09;
wire [DATA_WIDTH-1:0]  buf_wdata_0a;
wire [DATA_WIDTH-1:0]  buf_wdata_0b;
wire [DATA_WIDTH-1:0]  buf_wdata_0c;
wire [DATA_WIDTH-1:0]  buf_wdata_0d;
wire [DATA_WIDTH-1:0]  buf_wdata_0e;
wire [DATA_WIDTH-1:0]  buf_wdata_0f;
wire [STRB_WIDTH-1:0]  buf_wstrb_00;
wire [STRB_WIDTH-1:0]  buf_wstrb_01;
wire [STRB_WIDTH-1:0]  buf_wstrb_02;
wire [STRB_WIDTH-1:0]  buf_wstrb_03;
wire [STRB_WIDTH-1:0]  buf_wstrb_04;
wire [STRB_WIDTH-1:0]  buf_wstrb_05;
wire [STRB_WIDTH-1:0]  buf_wstrb_06;
wire [STRB_WIDTH-1:0]  buf_wstrb_07;
wire [STRB_WIDTH-1:0]  buf_wstrb_08;
wire [STRB_WIDTH-1:0]  buf_wstrb_09;
wire [STRB_WIDTH-1:0]  buf_wstrb_0a;
wire [STRB_WIDTH-1:0]  buf_wstrb_0b;
wire [STRB_WIDTH-1:0]  buf_wstrb_0c;
wire [STRB_WIDTH-1:0]  buf_wstrb_0d;
wire [STRB_WIDTH-1:0]  buf_wstrb_0e;
wire [STRB_WIDTH-1:0]  buf_wstrb_0f;
wire [31:0]            r_latency_dbg00;
wire [31:0]            r_latency_dbg01;
wire [31:0]            r_stime_dbg00;
wire [31:0]            r_stime_dbg01;
wire                   trans_done;
wire [31:0]            w_latency_dbg00;
wire [31:0]            w_latency_dbg01;
wire [31:0]            w_stime_dbg00;
wire [31:0]            w_stime_dbg01;
//}}}
// End of automatic define
reg     [ADDR_WIDTH-1:0]            awaddr;
reg     [BURST_WIDTH-1:0]           awburst;
reg     [ID_WIDTH-1:0]              awid;
reg     [LEN_WIDTH-1:0]             awlen;
reg     [SIZE_WIDTH-1:0]            awsize;
reg     [PROT_WIDTH-1:0]            awprot;
reg     [CACHE_WIDTH-1:0]           awcache;
reg     [LOCK_WIDTH-1:0]            awlock;
reg     [QOS_WIDTH-1:0]             awqos;
reg                                 awvalid;
reg                                 wvalid;
reg     [ID_WIDTH-1:0]              wid;
reg     [DATA_WIDTH-1:0]            wdata;
reg     [STRB_WIDTH-1:0]            wstrb;
reg                                 wlast;
reg                                 bready;
reg                                 arvalid;
reg     [ID_WIDTH-1:0]              arid;
reg     [ADDR_WIDTH-1:0]            araddr;
reg     [BURST_WIDTH-1:0]           arburst;
reg     [LEN_WIDTH-1:0]             arlen;
reg     [SIZE_WIDTH-1:0]            arsize;
reg     [PROT_WIDTH-1:0]            arprot;
reg     [CACHE_WIDTH-1:0]           arcache;
reg     [LOCK_WIDTH-1:0]            arlock;
reg     [QOS_WIDTH-1:0]             arqos;
reg                                 rready;

reg                                 check_resp;

reg     [ADDR_WIDTH-1:0]            buf_waddr[MAX_CMDNUM*MAX_BURSTLEN-1:0];

reg     [DATA_WIDTH-1:0]    buf_wdata[MAX_CMDNUM*MAX_BURSTLEN-1:0];

reg     [STRB_WIDTH-1:0]    buf_wstrb[MAX_CMDNUM*MAX_BURSTLEN-1:0];

reg     [ADDR_WIDTH-1:0]    buf_raddr[MAX_CMDNUM*MAX_BURSTLEN-1:0];
reg     [DATA_WIDTH-1:0]    buf_rdata[MAX_CMDNUM*MAX_BURSTLEN-1:0];
reg     [STRB_WIDTH-1:0]    buf_rstrb[MAX_CMDNUM*MAX_BURSTLEN-1:0];
reg     [1:0]               buf_bresp [MAX_CMDNUM-1:0];
reg     [1:0]               buf_rresp [MAX_CMDNUM-1:0];

integer                     aw_idx,w_idx,b_idx;
integer                     b_pop_sidx; //b pop start idx
integer                     r_pop_sidx; //r pop start idx
integer                     aw_push_idx;
integer                     aw_cnt,awq_cnt,b_cnt,b_cnt_for_latency;
reg     [MAX_CMDNUM-1:0]    awq_aw_valid;
reg     [MAX_CMDNUM-1:0]    awq_w_valid;
reg     [MAX_CMDNUM-1:0]    awq_b_valid;
reg     [ID_WIDTH-1:0]      awq_id   [MAX_CMDNUM-1:0];
reg     [ADDR_WIDTH-1:0]    awq_addr [MAX_CMDNUM-1:0];
reg     [BURST_WIDTH-1:0]   awq_burst[MAX_CMDNUM-1:0];
reg     [LEN_WIDTH-1:0]     awq_len  [MAX_CMDNUM-1:0];
wire    [LEN_WIDTH-1:0]     dbg_awq_len_0 = awq_len[0];
reg     [SIZE_WIDTH-1:0]    awq_asize [MAX_CMDNUM-1:0];
reg     [QOS_WIDTH-1:0]     awq_qos  [MAX_CMDNUM-1:0];
reg     [CACHE_WIDTH-1:0]   awq_cache[MAX_CMDNUM-1:0];
reg     [PROT_WIDTH-1:0]    awq_prot [MAX_CMDNUM-1:0];


reg     [31:0]              w_stime[MAX_CMDNUM-1:0];
reg     [31:0]              w_latency_cur;
reg     [31:0]              w_latency[MAX_CMDNUM-1:0];
reg     [63:0]              rcv_w_max_latency;
reg     [63:0]              rcv_w_total_latency;
wire    [63:0]              rcv_w_avg_latency;
integer                     w_latency_vio_cnt;

reg     [31:0]              r_stime[MAX_CMDNUM-1:0];
reg     [31:0]              r_latency_cur;
reg     [31:0]              r_latency[MAX_CMDNUM-1:0];
reg     [63:0]              rcv_r_max_latency;
reg     [63:0]              rcv_r_total_latency;
wire    [63:0]              rcv_r_avg_latency;
integer                     r_latency_vio_cnt;

integer                     ar_idx,r_idx;
integer                     ar_push_idx;
integer                     ar_cnt,arq_cnt,r_cnt,r_cnt_for_latency;
reg     [MAX_CMDNUM-1:0]    arq_ar_valid;
reg     [MAX_CMDNUM-1:0]    arq_r_valid;
reg     [ID_WIDTH-1:0]      arq_id   [MAX_CMDNUM-1:0];
reg     [ADDR_WIDTH-1:0]    arq_addr [MAX_CMDNUM-1:0];
reg     [BURST_WIDTH-1:0]   arq_burst[MAX_CMDNUM-1:0];
reg     [LEN_WIDTH-1:0]     arq_len  [MAX_CMDNUM-1:0];
reg     [SIZE_WIDTH-1:0]    arq_asize [MAX_CMDNUM-1:0];
reg     [QOS_WIDTH-1:0]     arq_qos  [MAX_CMDNUM-1:0];
reg     [CACHE_WIDTH-1:0]   arq_cache[MAX_CMDNUM-1:0];
reg     [PROT_WIDTH-1:0]    arq_prot [MAX_CMDNUM-1:0];


reg     [31:0]              cycles_aw2aw [MAX_CMDNUM-1:0];
reg     [31:0]              cycles_w2w   [MAX_CMDNUM-1:0];
reg     [31:0]              cycles_ar2ar [MAX_CMDNUM-1:0];
reg     [MAX_CMDNUM-1:0]    aw_end;
reg     [MAX_CMDNUM-1:0]    ar_end;
reg     [MAX_CMDNUM-1:0]    w_end;
reg     [MAX_CMDNUM-1:0]    b_end;
reg     [MAX_CMDNUM-1:0]    r_end;

reg                         auto_b_en;
reg                         auto_r_en;
reg                         auto_aw_en;
reg                         auto_ar_en;
reg                         auto_w_en;

reg                         single_b_en;
reg                         single_r_en;

reg    [ADDR_WIDTH-1:0]     tmp_waddr,tmp_raddr;
reg    [DATA_WIDTH-1:0]     tmp_rdata;
reg    [7:0]                byte_rtmp,byte_wtmp;

integer                     fwr,frd;
reg                         aw_piped,w_piped,ar_piped;
event                       accept_aw,accept_w,accept_b,
                            accept_ar,accept_r,
                            start_aw,
                            start_w,
                            start_b,
                            start_ar,
                            start_r;
integer                     bcnt,arcnt,rcnt,wlen,rlen,wbyte,rbyte,windex,rindex,i,j;

reg     [ID_WIDTH-1:0]      bid_rcv;
reg     [ID_WIDTH-1:0]      rid_rcv;
reg                         rlast_rcv;


integer                     b_loop_cnt;
integer                     r_loop_cnt;
integer                     error_cnt;
integer                     hit_awq_id;
integer                     hit_arq_id;
wire                        aclk_delta;

reg     [31:0]              random_num;

reg     [1023:0]            debug_proc;

reg                         wdata_need_shift;
reg                         rdata_need_shift;
////////////////////////////////////////////////////////////////////////////////////
// Architecture                                                                   //
////////////////////////////////////////////////////////////////////////////////////
assign  trans_done  = (awq_cnt == 0) & (arq_cnt == 0);

///////////////////////////////////////////////////////////////
//       TASK DECLARATION
///////////////////////////////////////////////////////////////

//------------------------
// init all the signal
//------------------------
task init;
    begin
        clr_latency_statistic;

        check_resp  = 1;
        error_cnt   = 0;

        disable aw_proc;
        disable w_proc;
        disable b_proc;
        disable ar_proc;
        disable r_proc;
        fwr = $fopen (WLOG_NAME);
        frd = $fopen (RLOG_NAME);

        for (i=0;i<MAX_CMDNUM;i=i+1) begin
            cycles_aw2aw [i] = 0;
            cycles_w2w   [i] = 0;
            cycles_ar2ar [i] = 0;
            aw_end       [i] = 0;
            ar_end       [i] = 0;
            b_end        [i] = 0;
            r_end        [i] = 0;
        end

        for (i=0;i<(MAX_CMDNUM*MAX_BURSTLEN);i=i+1) begin
            for (j=0;j<=((DATA_WIDTH/32)+1);j=j+1) begin
                //random_num      = $random;
                //因为random只会把低32bit random，如果DATA_WIDTH=128时，高位会变成全1或0
                buf_wdata[i]    = (buf_wdata[i]<<32) ^ $random;
            end
        end

        awq_aw_valid        = 0;
        awq_w_valid         = 0;
        awq_b_valid         = 0;
        arq_ar_valid        = 0;
        arq_r_valid         = 0;

        auto_aw_en          = 0;
        auto_w_en           = 0;
        auto_b_en           = 0;
        auto_ar_en          = 0;
        auto_r_en           = 0;

        single_b_en         = 0;
        single_r_en         = 0;

        aw_push_idx         = 0;
        ar_push_idx         = 0;

        b_pop_sidx          = 0;
        r_pop_sidx          = 0;

        awq_cnt             = 0;
        arq_cnt             = 0;

        aw_cnt              = 0;
        b_cnt               = 0;
        ar_cnt              = 0;
        r_cnt               = 0;

        awaddr              = 0;
        awburst             = 0;
        awlen               = 0;
        awsize              = 0;
        awvalid             = 0;
        awcache             = 0;
        awlock              = 0;
        awqos               = 0;
        awid                = 0;
        awprot              = 0;

        wdata               = 0;
        wstrb               = 0;
        wlast               = 0;
        wvalid              = 0;
        wid                 = 0;

        bready              = 0;

        araddr              = 0;
        arburst             = 0;
        arlen               = 0;
        arsize              = 0;
        arvalid             = 0;
        arcache             = 0;
        arlock              = 0;
        arqos               = 0;
        arid                = 0;
        arprot              = 0;

        rready              = 0;

        wdata_need_shift    = 0;
        rdata_need_shift    = 0;
    end
endtask

//task set_idle;
//    begin
//        aw_en               = 0;
//        w_en                = 0;
//        b_en                = 0;
//        ar_en               = 0;
//        r_en                = 0;
//    end
//endtask

task disable_auto_proc;
    input [1023:0]  dbg_info;
    begin
        if (0) begin
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $display("%t\t",$realtime, "[info:%m] disable_auto_proc by %0s", dbg_info);
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
        end

        if (trans_done !== 1) begin
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $display("%t\t",$realtime, "[warn:%m] trans_done !== 1, can not disable auto proc");
            $display("%t\t",$realtime, "[warn:%m] need wait trans done");
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
                    $display("%t\t",$realtime, "[Error:%m] time_out");
                    $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                    #(`DLYU);$finish;
                end
            join
        end

        auto_aw_en               = 0;
        auto_w_en                = 0;
        auto_b_en                = 0;
        auto_ar_en               = 0;
        auto_r_en                = 0;

        aw_push_idx               = 0;
        ar_push_idx               = 0;
    end
endtask

task clr_latency_statistic;
    begin
        w_latency_vio_cnt = 0;
        r_latency_vio_cnt = 0;

        rcv_w_max_latency = 0;
        rcv_r_max_latency = 0;

        rcv_w_total_latency = 0;
        rcv_r_total_latency = 0;

        b_cnt_for_latency   = 0;
        r_cnt_for_latency   = 0;
    end
endtask

//--------------------------------------------------------------------------------------------------
// aw
//--------------------------------------------------------------------------------------------------
task set_aw_en;
    begin
        auto_aw_en   = 1'b1;
    end
endtask

task push_aw;
    input   [ID_WIDTH-1:0]          id;
    input   [ADDR_WIDTH-1:0]        addr;
    input   [BURST_WIDTH-1:0]       burst;
    input   [LEN_WIDTH-1:0]         len;
    input   [9:0]                   size;   //n
    input   [QOS_WIDTH-1:0]         qos;
    input   [CACHE_WIDTH-1:0]       cache;
    input   [PROT_WIDTH-1:0]        prot;

    reg                             busy;
    begin
        busy    = 1; #(`DLYU); //for easy debug

        if (^{id,addr,burst,len,size,qos,cache,prot} === 1'bx) begin
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $display("%t\t",$realtime, "[error:%m] input has z/x");
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $finish;
        end

        //wait pre trans over
        wait ((awq_aw_valid [aw_push_idx] == 1'b0) && 
              (awq_w_valid  [aw_push_idx] == 1'b0) &&
              (awq_b_valid  [aw_push_idx] == 1'b0));

        #(`DLYU);  

        awq_aw_valid [aw_push_idx] = 1'b1;
        awq_w_valid  [aw_push_idx] = 1'b1;
        awq_b_valid  [aw_push_idx] = 1'b1;

        awq_id       [aw_push_idx] = id;
        awq_addr     [aw_push_idx] = addr;
        awq_burst    [aw_push_idx] = burst;
        awq_len      [aw_push_idx] = len;
        awq_asize     [aw_push_idx] = get_asize(size);
        awq_qos      [aw_push_idx] = qos;
        awq_cache    [aw_push_idx] = cache;
        awq_prot     [aw_push_idx] = prot;
        cycles_aw2aw [aw_push_idx] = 0;//aw2aw;
        cycles_w2w   [aw_push_idx] = 0;//w2w;

        decode_addr (aw_push_idx,addr,burst,len,size,1'b1);

        awq_cnt         = awq_cnt     + 1;
        aw_cnt          = aw_cnt      + 1;
        aw_push_idx     = (aw_push_idx == MAX_CMDNUM-1) ? 0 : aw_push_idx   + 1;

        busy    = 0; #(`DLYU); //for easy debug
    end
endtask

always begin
    if (auto_aw_en) begin : aw_proc
        for (aw_idx=0;aw_idx<MAX_CMDNUM;aw_idx=(aw_idx == MAX_CMDNUM-1) ? 0 : aw_idx+1) begin
            if (awq_aw_valid[aw_idx] == 1'b0) begin
                #0.01;    //avoid dead-lock
            end
            else begin
                @ (posedge aclk ); 
                if (VERBOSE) $display ("%t\t",$realtime, "[info:%m] awq_aw_valid[%d] = 1'b1",aw_idx);

                // Timer for delay the next aw
                repeat (cycles_aw2aw[aw_idx]) @(posedge aclk); 
                
                fork
                    begin
                        // Send Command
                        awid         <=#(`DLYU) awq_id    [aw_idx];
                        awaddr       <=#(`DLYU) awq_addr  [aw_idx];
                        awburst      <=#(`DLYU) awq_burst [aw_idx];
                        awlen        <=#(`DLYU) awq_len   [aw_idx];
                        awsize       <=#(`DLYU) awq_asize  [aw_idx];
                        awqos        <=#(`DLYU) awq_qos   [aw_idx];
                        awcache      <=#(`DLYU) awq_cache [aw_idx];
                        awprot       <=#(`DLYU) awq_prot  [aw_idx];
                        awvalid      <=#(`DLYU) 1'b1;
                        
                        // Wait for Slave accept command
                        @ (accept_aw);
                        //这个是posedge 以后，如果要下次loop进来的时候，能连续的话，使用posedge aclk_delta
                        w_stime[aw_idx] = $realtime;
                        disable aw_proc_to;
                    end
                    begin:aw_proc_to
                        #10000;
                        $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                        $display("%t\t",$realtime, "[Error:%m] time_out");
                        $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                        #(`DLYU);$finish;
                    end
                join

                awvalid      <=#(`DLYU) 1'b0;
                aw_end[aw_idx] = 1;

                if (~aw_piped) begin
                  // Wait for finish this transaction
                    wait (aw_end[aw_idx] && b_end[aw_idx]);
                    aw_end[aw_idx] = 0;
                    b_end [aw_idx] = 0;
                end
                
                awq_aw_valid[aw_idx] = 1'b0; //destroy the aw of cmd

            end

        end
    end
    else begin
        #0.01;    //avoid dead-lock
    end
end

//--------------------------------------------------------------------------------------------------
// w
//--------------------------------------------------------------------------------------------------
task set_w_en;
    begin
        auto_w_en   = 1'b1;
    end
endtask

always begin
    if (auto_w_en) begin : w_proc
        for (w_idx=0;w_idx<MAX_CMDNUM;w_idx=(w_idx == MAX_CMDNUM-1) ? 0 : w_idx+1) begin
            if (awq_w_valid[w_idx] == 1'b0) begin
                #0.01;    //avoid dead-lock
            end
            else begin
                @ (posedge aclk );
                if (VERBOSE) $display ("%t\t",$realtime, "[info:%m] awq_w_valid[%d] = 1'b1",w_idx);

                // Timer for delay the next w
                repeat (cycles_w2w[w_idx]) @(posedge aclk);

                for (wlen=0;wlen<=awq_len[w_idx];wlen=wlen+1) begin
                     windex = MAX_BURSTLEN*w_idx+wlen;

                     // Send Data
                     wdata  <=#(`DLYU) buf_wdata[windex];
                     wstrb  <=#(`DLYU) buf_wstrb[windex];

                     wlast  <=#(`DLYU) (wlen==awq_len[w_idx]);
                     wid    <=#(`DLYU) awq_id[w_idx];
                     wvalid <=#(`DLYU) 1;
                   
                     // Wait for Slave accept wdata
                     @ (accept_w);
                     //这个是posedge 以后，如果要下次loop进来的时候，能连续的话，使用posedge aclk_delta
                     // Write to log file
                     tmp_waddr = buf_waddr[windex];
                     for(wbyte=0;wbyte<STRB_WIDTH;wbyte=wbyte+1) begin
                       byte_wtmp = buf_wdata[windex]>>wbyte*8;
                       if (buf_wstrb[windex][wbyte]) 
                         $fdisplay (fwr,"ad[0x%4x] <--- wd[%x]", tmp_waddr+wbyte,byte_wtmp);
                     end

                     wvalid <=#(`DLYU) 0;
                     wlast  <=#(`DLYU) 0;
                end // for

                if (~w_piped) begin
                  // Wait for finish this transaction
                    wait (w_end[w_idx] && b_end[w_idx]);
                    w_end[w_idx] = 0;
                    b_end [w_idx] = 0;
                end

                awq_w_valid[w_idx] = 1'b0; //destroy the w of cmd
            end

        end
    end
    else begin
        #0.01;    //avoid dead-lock
    end
end

//--------------------------------------------------------------------------------------------------
// b
//--------------------------------------------------------------------------------------------------
task set_b_en;
    begin
        auto_b_en   = 1'b1;
    end
endtask

always @ (posedge aclk) begin
    bready   <=#(`DLYU) auto_b_en | single_b_en;
end

always begin
    if (auto_b_en) begin : b_proc
        if (|awq_b_valid == 1'b0) begin
            //没有未完成的b
            #0.01;    //avoid dead-lock
        end
        else begin
            @ (accept_b);
            //这个是posedge 以后，如果要下次loop进来的时候，能连续的话，使用posedge aclk_delta
            bid_rcv = bid;
            if (VERBOSE) $display ("%t\t",$realtime, "[info:%m] bid_rcv = 0x%h",bid_rcv);

            //这里b_idx必须从0开始，
            //因为有可能q里面的id是相同的，这里认为是按照push进q的顺序处理
            //这里只需要循环一次
            hit_awq_id = 0;
            b_loop_cnt = 0;
            //b_pop_sidx才能保证是从第一个push的idx开始检测
            //否则id相同的时候会destroy错误的cmd 顺序
            //每次确保只match一个，因为可能q里面有几个id都match的，确保disable第一个，所有只要match一个就退出loop
            //且无论是否match，只loop一次
            for (b_idx=b_pop_sidx;((b_idx<MAX_CMDNUM) &&(b_loop_cnt<=MAX_CMDNUM)&&(hit_awq_id==0));b_idx=(b_idx == MAX_CMDNUM-1) ? 0 : b_idx+1) begin
                if ((awq_b_valid[b_idx] == 1'b1) && (awq_id[b_idx] == bid_rcv)) begin
                    if (VERBOSE) $display ("%t\t",$realtime, "[info:%m] awq_id[%d] = 0x%h",b_idx,bid_rcv);
                    awq_b_valid[b_idx] = 1'b0; //destroy the b of cmd
                    hit_awq_id = hit_awq_id+1;
                    b_pop_sidx = ((b_idx+1) == MAX_CMDNUM) ? 0 : b_idx+1;

                    //check latency
                    w_latency_cur   = $realtime - w_stime[b_idx];
                    w_latency[b_idx]= w_latency_cur;
                    rcv_w_total_latency = rcv_w_total_latency + w_latency_cur;
                    if (w_latency_cur > CFG_W_MAX_LATENCY) begin
                        if (VERBOSE >= 2) $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                        if (VERBOSE >= 2) $display("%t\t",$realtime, "[Error:%m][ErrBID] wr latency is %d > %d, for id %d", w_latency_cur, CFG_W_MAX_LATENCY, bid_rcv);
                        if (VERBOSE >= 2) $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                        w_latency_vio_cnt = w_latency_vio_cnt + 1;
                    end

                    if (w_latency_cur > rcv_w_max_latency) begin
                        rcv_w_max_latency = w_latency_cur;
                    end
                end

                b_loop_cnt = b_loop_cnt + 1;
                #0.01;    //avoid dead-lock
            end //for

            //check hit or not
            if (hit_awq_id == 0) begin
                $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                $display("%t\t",$realtime, "[Error:%m][ErrBID] receive a not-expt. bid 0x%h, master has not awid match it", bid_rcv);
                $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                error_cnt = error_cnt + 1;
                #100;
                $finish;
            end

            awq_cnt = awq_cnt - 1;      //TODO:suppose b is finished after aw/w
            b_cnt   = b_cnt   + 1;
            b_cnt_for_latency   = b_cnt_for_latency   + 1;
        end
    end
    else begin
        #0.01;    //avoid dead-lock
    end
end

always @ (accept_b) begin
    if ((auto_b_en) && (|awq_b_valid == 1'b0)) begin
        $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
        $display("%t\t",$realtime, "[Error:%m][ErrorB] receive a not-expt. b, master has not aw before");
        $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
        error_cnt = error_cnt + 1;
        #100;
        $finish;
    end
end
//------------------------
// Get write response
//------------------------
task get_bresp;
    input  [31:0]  id;
    output [1:0]   resp;

    begin
        resp = buf_bresp [id];
    end
endtask

//--------------------------------------------------------------------------------------------------
// ar
//--------------------------------------------------------------------------------------------------
task set_ar_en;
    begin
        auto_ar_en   = 1'b1;
    end
endtask

task push_ar;
    input   [ID_WIDTH-1:0]          id;
    input   [ADDR_WIDTH-1:0]        addr;
    input   [BURST_WIDTH-1:0]       burst;
    input   [LEN_WIDTH-1:0]         len;
    input   [9:0]                   size;   //n
    input   [QOS_WIDTH-1:0]         qos;
    input   [CACHE_WIDTH-1:0]       cache;
    input   [PROT_WIDTH-1:0]        prot;

    reg                             busy;
    begin
        busy    = 1; #(`DLYU); //for easy debug

        if (^{id,addr,burst,len,size,qos,cache,prot} === 1'bx) begin
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $display("%t\t",$realtime, "[error:%m] input has z/x");
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $finish;
        end

        //wait pre trans over
        wait ((arq_ar_valid [ar_push_idx] == 1'b0) && 
              (arq_r_valid  [ar_push_idx] == 1'b0));

        arq_ar_valid [ar_push_idx] = 1'b1;
        arq_r_valid  [ar_push_idx] = 1'b1;

        arq_id       [ar_push_idx] = id;
        arq_addr     [ar_push_idx] = addr;
        arq_burst    [ar_push_idx] = burst;
        arq_len      [ar_push_idx] = len;
        arq_asize     [ar_push_idx] = get_asize(size);
        arq_qos      [ar_push_idx] = qos;
        arq_cache    [ar_push_idx] = cache;
        arq_prot     [ar_push_idx] = prot;
        cycles_ar2ar [ar_push_idx] = 0;//ar2ar;
        cycles_w2w   [ar_push_idx] = 0;//w2w;

        decode_addr (ar_push_idx,addr,burst,len,size,1'b1);

        arq_cnt     = arq_cnt     + 1;
        ar_cnt      = ar_cnt      + 1;
        ar_push_idx = (ar_push_idx == MAX_CMDNUM-1) ? 0 : ar_push_idx + 1;

        busy    = 0; #(`DLYU); //for easy debug
    end
endtask

always begin
    if (auto_ar_en) begin : ar_proc
        for (ar_idx=0;ar_idx<MAX_CMDNUM;ar_idx=(ar_idx == MAX_CMDNUM-1) ? 0 : ar_idx+1) begin
            if (arq_ar_valid[ar_idx] == 1'b0) begin
                #0.01;    //avoid dead-lock
            end
            else begin
                @ (posedge aclk );
                if (VERBOSE) $display ("%t\t",$realtime, "[info:%m] arq_ar_valid[%d] = 1'b1",ar_idx);

                // Timer for delay the next ar
                repeat (cycles_ar2ar[ar_idx]) @(posedge aclk);
                
                fork
                    begin
                        // Send Command
                        arid         <=#(`DLYU) arq_id    [ar_idx];
                        araddr       <=#(`DLYU) arq_addr  [ar_idx];
                        arburst      <=#(`DLYU) arq_burst [ar_idx];
                        arlen        <=#(`DLYU) arq_len   [ar_idx];
                        arsize       <=#(`DLYU) arq_asize  [ar_idx];
                        arqos        <=#(`DLYU) arq_qos   [ar_idx];
                        arcache      <=#(`DLYU) arq_cache [ar_idx];
                        arprot       <=#(`DLYU) arq_prot  [ar_idx];
                        arvalid      <=#(`DLYU) 1'b1;
                        
                        // Wait for Slave accept command
                        @ (accept_ar);
                        //这个是posedge 以后，如果要下次loop进来的时候，能连续的话，使用posedge aclk_delta
                        r_stime[ar_idx] = $realtime;
                        disable ar_proc_to;
                    end
                    begin:ar_proc_to
                        #10000;
                        $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                        $display("%t\t",$realtime, "[Error:%m] time_out");
                        $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                        #(`DLYU);$finish;
                    end
                join

                arvalid      <=#(`DLYU) 1'b0;
                ar_end[ar_idx] = 1;

                if (~ar_piped) begin
                  // Wait for finish this transaction
                    wait (ar_end[ar_idx] && r_end[ar_idx]);
                    ar_end[ar_idx] = 0;
                    r_end [ar_idx] = 0;
                end
                
                arq_ar_valid[ar_idx] = 1'b0; //destroy the ar of cmd

            end

        end
    end
    else begin
        #0.01;    //avoid dead-lock
    end
end

//--------------------------------------------------------------------------------------------------
// r
//--------------------------------------------------------------------------------------------------
task set_r_en;
    begin
        auto_r_en   = 1'b1;
    end
endtask

always @ (posedge aclk) begin
    rready   <=#(`DLYU) auto_r_en | single_r_en;
end

//在每次accept_r动作
always begin
    if (auto_r_en) begin : r_proc
        if (|arq_r_valid == 1'b0) begin
            //没有未完成的b
            #0.01;    //avoid dead-lock
        end
        else begin
            @ (accept_r);
            //这个是posedge 以后，如果要下次loop进来的时候，能连续的话，使用posedge aclk_delta
            rid_rcv = rid;
            rlast_rcv = rlast;
            if (VERBOSE) $display ("%t\t",$realtime, "[info:%m] rid_rcv = 0x%h, rlast_rcv = %b",rid_rcv,rlast_rcv);

            //这里r_idx必须从0开始 TODO:转了一圈以后会是什么情况？
            //不一定是从0，应该从第一个有效的开始，而目前是ring-buffer，所以这里还有问题
            //因为有可能q里面的id是相同的，这里认为是按照push进q的顺序处理
            //这里只需要循环一次
            hit_arq_id  = 0;
            r_loop_cnt  = 0;
            //每次(每个accept_r)确保只match一个，因为可能q里面有几个id都match的，确保disable第一个
            for (r_idx=r_pop_sidx;((r_idx<MAX_CMDNUM) &&(r_loop_cnt<=MAX_CMDNUM)&&(hit_arq_id==0));r_idx=(r_idx == MAX_CMDNUM-1) ? 0 : r_idx+1) begin
                if ((arq_r_valid[r_idx] == 1'b1) && (arq_id[r_idx] == rid_rcv)) begin
                    if (VERBOSE) $display ("%t\t",$realtime, "[info:%m] arq_id[%d] = 0x%h",r_idx,rid_rcv);
                    //$display ("%t\t",$realtime, "\t[info:%m] r_idx = %d, rid_rcv = 0x%h, rlast_rcv = %b",r_idx,rid_rcv,rlast_rcv);
                    hit_arq_id = hit_arq_id+1;

                    //注意这里比b多判断一下rlast
                    if (rlast_rcv == 1) begin
                        arq_r_valid[r_idx] = 1'b0; //destroy the r of cmd if it is last
                        r_pop_sidx = ((r_idx+1) == MAX_CMDNUM) ? 0 : r_idx+1;

                        //check latency
                        r_latency_cur   = $realtime - r_stime[r_idx];
                        r_latency[r_idx]= r_latency_cur;
                        rcv_r_total_latency = rcv_r_total_latency + r_latency_cur;
                        if (r_latency_cur > CFG_R_MAX_LATENCY) begin
                            if (VERBOSE >= 2) $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                            if (VERBOSE >= 2) $display("%t\t",$realtime, "[Error:%m][ErrBID] wr latency is %d > %d, for id %d", r_latency_cur, CFG_R_MAX_LATENCY, rid_rcv);
                            if (VERBOSE >= 2) $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                            r_latency_vio_cnt = r_latency_vio_cnt + 1;
                        end

                        if (r_latency_cur > rcv_r_max_latency) begin
                            rcv_r_max_latency = r_latency_cur;
                        end
                    end//if last
                end

                r_loop_cnt = r_loop_cnt + 1;
                #0.01;    //avoid dead-lock
            end //for

            //check hit or not
            if (hit_arq_id == 0) begin
                $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                $display("%t\t",$realtime, "[Error:%m][ErrorID] receive a not-expt. rid 0x%h(0b%b), master has not arid match it", rid_rcv, rid_rcv);
                $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                error_cnt = error_cnt + 1;
                #100;
                $finish;
            end

            arq_cnt = arq_cnt - (rlast_rcv ? 1'b1 : 1'b0);      //destroy the r of cmd if it is last
            r_cnt   = r_cnt   + (rlast_rcv ? 1'b1 : 1'b0);
            r_cnt_for_latency   = r_cnt_for_latency   + (rlast_rcv ? 1'b1 : 1'b0);

        end
    end
    else begin
        #0.01;    //avoid dead-lock
    end
end

always @ (accept_r) begin
    if ((auto_r_en) && (|arq_r_valid == 1'b0)) begin
        $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
        $display("%t\t",$realtime, "[Error:%m][ErrorR] receive a not-expt. r, master has not ar before");
        $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
        error_cnt = error_cnt + 1;
        #100;
        $finish;
    end
end

//------------------------
// Decode the addr
//------------------------
task decode_addr;
    input [31:0]           idx;
    input [ADDR_WIDTH-1:0] addr;
    input [1:0]            burst;
    input [3:0]            len;
    input [9:0]            size;
    input                  write;

    integer                i,n,num_bytes,total_bytes,index;
    reg   [ADDR_WIDTH-1:0] align_addr,wrap_boundary,out_addr;
    reg   [STRB_WIDTH-1:0] out_strb;

    begin
    //    num_bytes     = 2 ** size;
        if (^{idx,addr,burst,len,size,write} === 1'bx) begin
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $display("%t\t",$realtime, "[error:%m] input has z/x");
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $finish;
        end

        num_bytes     = size;
        total_bytes   = num_bytes*(len+1);
        align_addr    = addr-(addr%num_bytes);
        wrap_boundary = addr-(addr%total_bytes);

        for (n=0;n<=len;n=n+1) begin
            out_strb = 0;
            case (burst)
                ABURST_FIXED: begin
                                 out_addr = addr;
                                 for (i=addr%STRB_WIDTH;i<align_addr%STRB_WIDTH+num_bytes;i=i+1)
                                     out_strb[i] = 1;
                               end

                ABURST_INCR:  begin
                                 if (n==0) begin
                                   out_addr = addr;
                                   for (i=addr%STRB_WIDTH;i<align_addr%STRB_WIDTH+num_bytes;i=i+1)
                                     out_strb[i] = 1;
                                 end
                                 else begin
                                   out_addr = align_addr + num_bytes*n;
                                   out_strb = ({STRB_WIDTH{1'b1}} >> (STRB_WIDTH-num_bytes)) << (out_addr%STRB_WIDTH);
                                 end
                               end
                ABURST_WRAP:  begin
                                 if (n==0) begin
                                   out_addr = addr;
                                   for (i=addr%STRB_WIDTH;i<align_addr%STRB_WIDTH+num_bytes;i=i+1)
                                       out_strb[i] = 1;
                                 end
                                 else begin
                                   out_addr = align_addr + num_bytes*n;
                                   if (out_addr >= wrap_boundary+total_bytes)
                                       out_addr = out_addr - total_bytes;
                                   out_strb = ({STRB_WIDTH{1'b1}} >> (STRB_WIDTH-num_bytes)) << (out_addr%STRB_WIDTH);
                                 end
                               end
                default:         begin
                                 out_addr = addr;
                                 out_strb = 0;
                               end
            endcase

            // to word align address
            out_addr = out_addr - (out_addr%STRB_WIDTH);
            
            index = idx*MAX_BURSTLEN + n;
            if (write) begin
                buf_waddr[index] = out_addr;
                buf_wstrb[index] = out_strb;
            end
            else begin
                buf_raddr[index] = out_addr;
                buf_rstrb[index] = out_strb;
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
always @ (negedge aresetn)
begin
    init;
end

//==========================================
// Event Monitor
//==========================================
always @ (posedge aclk) begin  
    if (awvalid & awready) -> accept_aw;
    if (wvalid  & wready ) -> accept_w;
    if (bvalid  & bready ) -> accept_b;
    if (arvalid & arready) -> accept_ar;
    if (rvalid  & rready ) -> accept_r;
end

//   
// single write data to bus
//
initial begin
    single_write.busy   = 0;
end

task single_write;
    input   [9:0]               size;   //n
    input   [ADDR_WIDTH-1:0]    addr;
    //有效data总是从bit0 开始
    input   [DATA_WIDTH-1:0]    din;
    
    reg                         busy;
    begin
        busy = 1;
        if (^{size,addr,din} === 1'bx) begin
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $display("%t\t",$realtime, "[error:%m] input has z/x");
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $finish;
        end

        incr_write  (1, size, addr, din);
        busy = 0;
        #0.01;    //avoid dead-lock
    end
endtask // single_write 

task incr_write;
    input   [9:0]                   len;  //n
    input   [9:0]                   size;   //n
    input   [ADDR_WIDTH-1:0]        addr;
    //有效data总是从bit0 开始
    //还是已经shift到对应的strb位置
    //由wdata_need_shift确定
    //max incr 256
    input   [(DATA_WIDTH*256)-1:0]   din;
    
    reg                             busy;
    reg     [1023:0]                debug_proc;
    reg     [(DATA_WIDTH*256)-1:0]  din_x;
    begin
        if (^{len,size,addr,din} === 1'bx) begin
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $display("%t\t",$realtime, "[error:%m] input has z/x");
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $finish;
        end

        if (len>256) begin
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $display("%t\t",$realtime, "[Error:%m] len(%d)>256", len);
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            #1;
            $finish;
        end

        busy = 1;
        disable_auto_proc("incr_write");
        single_b_en = 1;

        //1st
        repeat(1) @(posedge aclk); #(`DLYU);
        debug_proc  = "aw";
        awid    = (AXI_VERSION == 4) ? 0 :
                  (awid == MAX_ID) ? 0 : awid + 1;
        awlen   = len-1;
        awsize  = get_asize(size);
        awburst = ABURST_INCR;
        awvalid = 1'b1;
        awaddr  = addr;
        
        // Wait for accept aw
        @ (accept_aw); #(`DLYU);
        //$display("Status: %t hs Write data %h to register %h",$time, wdata, awaddr);
        awvalid = 1'b0;
        awaddr  = 0;

        //2nd
        debug_proc  = "w";
        wid     = awid;
        wvalid  = 1'b1;
        wlast   = 1'b0;

        wstrb   = get_strb(size);
        wstrb   = wstrb <<(get_shift_byte(addr)*1);
        if (wdata_need_shift) begin
            din_x   = din   <<(get_shift_byte(addr)*8);
        end
        else begin
            din_x   = din;
        end
        wdata   = din_x;
        
        repeat (len-1) begin
            @ (accept_w); #(`DLYU);
            din_x   = din_x >> DATA_WIDTH;
            wdata   = din_x;
        end

        debug_proc  = "w-last";
        wlast   = 1'b1;

        @ (accept_w); #(`DLYU);

        debug_proc  = "w-done";
        wvalid  = 1'b0;
        wlast   = 1'b0;
        wdata   = {DATA_WIDTH{1'b0}};

        //3rd
        debug_proc  = "b";
        bready  = 1'b1;

        @ (accept_b);
        chk_bresp(addr);
        debug_proc  = "b-done";
        #(`DLYU);
        bready  = 1'b0;

        single_b_en = 0;
        busy = 0;
        #(`DLYU);
    end
endtask // incr_write 

//
// APB read data from bus
//
initial begin
    single_read.busy   = 0;
end

task single_read;
    input   [9:0]               size;   //n
    input   [ADDR_WIDTH-1:0]    addr;
    //有效data总是从bit0 开始
    output  [DATA_WIDTH-1:0]    dout;
    
    reg                         busy;

    begin
        busy = 1;
        if (^{size,addr} === 1'bx) begin
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $display("%t\t",$realtime, "[error:%m] input has z/x");
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $finish;
        end

//        disable_auto_proc;
//        single_r_en = 1;
//
//        //1st
//        repeat(1) @(posedge aclk); #(`DLYU);
//        arid    = (arid == MAX_ID) ? 0 : arid + 1;
//        arlen   = 0;
//        arsize  = get_asize(size);
//        arburst = ABURST_INCR;
//        arvalid = 1'b1;
//        araddr  = addr;
//        
//        // Wait for accept ar
//        @ (accept_ar); #(`DLYU);
//        //$display("Status: %t hs Write data %h to register %h",$time, wdata, araddr);
//        arvalid = 1'b0;
//        araddr  = 0;
//
//        //3rd
//        rready  = 1'b1;
//
//        @ (accept_r); 
//        dout = rdata;
//        //有效data总是从bit0 开始
//        dout = dout >> (get_shift_byte(addr)*8);
//        chk_rresp(addr);
//        #(`DLYU);
//        rready  = 1'b0;
//
//        single_r_en = 0;
        incr_read   (1, size, addr, dout);
        busy = 0;
        #(`DLYU);
    end
endtask // single_read 

task incr_read;
    input   [9:0]                   len;   //n
    input   [9:0]                   size;   //n
    input   [ADDR_WIDTH-1:0]        addr;
    //有效data总是从bit0 开始
    //还是已经shift到对应的strb位置
    //由rdata_need_shift确定
    output  [(DATA_WIDTH*256)-1:0]  dout;
    
    reg                             busy;
    reg     [1023:0]                debug_proc;
    integer                         i;
    reg     [(DATA_WIDTH*256)-1:0]  rdata_x;

    begin
        if (^{len,size,addr} === 1'bx) begin
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $display("%t\t",$realtime, "[error:%m] input has z/x");
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $finish;
        end

        if (len>256) begin
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $display("%t\t",$realtime, "[Error:%m] len(%d)>256", len);
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            #1;
            $finish;
        end
        dout = 0;

        busy = 1;
        disable_auto_proc("incr_read");
        single_r_en = 1;

        //1st
        repeat(1) @(posedge aclk); #(`DLYU);
        debug_proc  = "ar";
        arid    = (arid == MAX_ID) ? 0 : arid + 1;
        arlen   = len-1;
        arsize  = get_asize(size);
        arburst = ABURST_INCR;
        arvalid = 1'b1;
        araddr  = addr;
        
        // Wait for accept ar
        @ (accept_ar); #(`DLYU);
        //$display("Status: %t hs Write data %h to register %h",$time, wdata, araddr);
        arvalid = 1'b0;
        araddr  = 0;

        //3rd
        rready  = 1'b1;

        debug_proc  = "r";
        i=0;
        repeat (len) begin
            @ (accept_r); 
            rdata_x = rdata<<(DATA_WIDTH*i);
//            $display ("%t\t",$realtime, "[info:%m] rdata=0x%h; rdata_x=0x%h",rdata, rdata_x);
            dout = dout | rdata_x;
            chk_rresp(addr);
            #(`DLYU);
            i=i+1;
        end
        rready  = 1'b0;

        if (rdata_need_shift) begin
            //有效data总是从bit0 开始
            dout = dout >> (get_shift_byte(addr)*8);
        end
        else begin
        end


        single_r_en = 0;
        busy = 0;
        #(`DLYU);
    end
endtask // incr_read 

//
// APB read data from bus, and checl
//
initial begin
    single_readc.busy   = 0;
end

task single_readc;
    input   [9:0]               size;
    input   [ADDR_WIDTH-1:0]    addr;
    //有效data总是从bit0 开始
    input   [DATA_WIDTH-1:0]    expt;
    
    reg                         busy;
    //有效data总是从bit0 开始
    reg     [DATA_WIDTH-1:0]    rdata;
    //mask掉不需要比较的data，比如size是32bit，但返回的数据是128bit
    reg     [DATA_WIDTH-1:0]    unmask;

    begin
        busy = 1;
        if (^{size,addr,expt} === 1'bx) begin
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $display("%t\t",$realtime, "[error:%m] input has z/x");
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $finish;
        end

        disable_auto_proc("single_readc");

        single_read (size,  addr,   rdata);

        unmask   = get_strb(size);
        if ((rdata & unmask) !== (expt & unmask)) begin
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $display("%t\t",$realtime, "[Error:%m] addr 0x%h, rdata 0x%h !== expt 0x%h", addr, rdata, expt);
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            #100;
            $finish;
        end

        busy = 0;
        #(`DLYU);
    end
endtask // single_readc 

task chk_bresp;
    input   [63:0]  addr;

    begin
        if (^{addr} === 1'bx) begin
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $display("%t\t",$realtime, "[error:%m] input has z/x");
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $finish;
        end

        if (bresp !== ARESP_OKAY) begin
            if (check_resp) begin
                $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                $display("%t\t",$realtime, "[Error:%m] addr 0x%h, bresp is %h, not success", addr, bresp);
                $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                if (ERROR_RESP_FINISH[0]) begin
                    #100; $finish;
                end
            end
            else begin
                $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                $display("%t\t",$realtime, "[warn:%m] addr 0x%h, bresp is %h, not success", addr, bresp);
                $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            end
        end
        if (bid !== awid) begin
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $display("%t\t",$realtime, "[Error:%m] addr 0x%h, bid is %h, not the same as awid %h", addr, bid,awid);
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            #100;
            $finish;
        end
    end
endtask // chk_bresp

task chk_rresp;
    input   [63:0]  addr;

    begin
        if (^{addr} === 1'bx) begin
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $display("%t\t",$realtime, "[error:%m] input has z/x");
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $finish;
        end

        if (rresp !== ARESP_OKAY) begin
            if (check_resp) begin
                $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                $display("%t\t",$realtime, "[Error:%m] addr 0x%h, rresp is %h, not success", addr, rresp);
                $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                if (ERROR_RESP_FINISH[0]) begin
                    #100; $finish;
                end
            end
            else begin
                $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
                $display("%t\t",$realtime, "[warn:%m] addr 0x%h, rresp is %h, not success", addr, rresp);
                $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            end
        end
        if (rid !== arid) begin
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            $display("%t\t",$realtime, "[Error:%m] addr 0x%h, rid is %h, not the same as arid %h", addr, rid,arid);
            $display("%t\t",$realtime, "////////////////////////////////////////////////////////////////////////////////////////");
            #100;
            $finish;
        end
    end
endtask // chk_rresp

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

//根据size，decode出asize
function [2:0] get_asize;

    input   [9:0]    size;

    reg     [2:0]    asize;
    begin
        case (size[9:0])
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

assign  rcv_w_avg_latency = rcv_w_total_latency/((b_cnt_for_latency == 0) ? 1 : b_cnt_for_latency);
assign  rcv_r_avg_latency = rcv_r_total_latency/((r_cnt_for_latency == 0) ? 1 : r_cnt_for_latency);

//==========================================
// checker
//==========================================
always @ (posedge aclk or negedge aresetn) begin 
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

assign  buf_waddr_00[ADDR_WIDTH-1:0] = buf_waddr['h00];
assign  buf_waddr_01[ADDR_WIDTH-1:0] = buf_waddr['h01];
assign  buf_waddr_02[ADDR_WIDTH-1:0] = buf_waddr['h02];
assign  buf_waddr_03[ADDR_WIDTH-1:0] = buf_waddr['h03];
assign  buf_waddr_04[ADDR_WIDTH-1:0] = buf_waddr['h04];
assign  buf_waddr_05[ADDR_WIDTH-1:0] = buf_waddr['h05];
assign  buf_waddr_06[ADDR_WIDTH-1:0] = buf_waddr['h06];
assign  buf_waddr_07[ADDR_WIDTH-1:0] = buf_waddr['h07];
assign  buf_waddr_08[ADDR_WIDTH-1:0] = buf_waddr['h08];
assign  buf_waddr_09[ADDR_WIDTH-1:0] = buf_waddr['h09];
assign  buf_waddr_0a[ADDR_WIDTH-1:0] = buf_waddr['h0a];
assign  buf_waddr_0b[ADDR_WIDTH-1:0] = buf_waddr['h0b];
assign  buf_waddr_0c[ADDR_WIDTH-1:0] = buf_waddr['h0c];
assign  buf_waddr_0d[ADDR_WIDTH-1:0] = buf_waddr['h0d];
assign  buf_waddr_0e[ADDR_WIDTH-1:0] = buf_waddr['h0e];
assign  buf_waddr_0f[ADDR_WIDTH-1:0] = buf_waddr['h0f];
assign  buf_wdata_00[DATA_WIDTH-1:0] = buf_wdata['h00];
assign  buf_wdata_01[DATA_WIDTH-1:0] = buf_wdata['h01];
assign  buf_wdata_02[DATA_WIDTH-1:0] = buf_wdata['h02];
assign  buf_wdata_03[DATA_WIDTH-1:0] = buf_wdata['h03];
assign  buf_wdata_04[DATA_WIDTH-1:0] = buf_wdata['h04];
assign  buf_wdata_05[DATA_WIDTH-1:0] = buf_wdata['h05];
assign  buf_wdata_06[DATA_WIDTH-1:0] = buf_wdata['h06];
assign  buf_wdata_07[DATA_WIDTH-1:0] = buf_wdata['h07];
assign  buf_wdata_08[DATA_WIDTH-1:0] = buf_wdata['h08];
assign  buf_wdata_09[DATA_WIDTH-1:0] = buf_wdata['h09];
assign  buf_wdata_0a[DATA_WIDTH-1:0] = buf_wdata['h0a];
assign  buf_wdata_0b[DATA_WIDTH-1:0] = buf_wdata['h0b];
assign  buf_wdata_0c[DATA_WIDTH-1:0] = buf_wdata['h0c];
assign  buf_wdata_0d[DATA_WIDTH-1:0] = buf_wdata['h0d];
assign  buf_wdata_0e[DATA_WIDTH-1:0] = buf_wdata['h0e];
assign  buf_wdata_0f[DATA_WIDTH-1:0] = buf_wdata['h0f];
assign  buf_wstrb_00[STRB_WIDTH-1:0] = buf_wstrb['h00];
assign  buf_wstrb_01[STRB_WIDTH-1:0] = buf_wstrb['h01];
assign  buf_wstrb_02[STRB_WIDTH-1:0] = buf_wstrb['h02];
assign  buf_wstrb_03[STRB_WIDTH-1:0] = buf_wstrb['h03];
assign  buf_wstrb_04[STRB_WIDTH-1:0] = buf_wstrb['h04];
assign  buf_wstrb_05[STRB_WIDTH-1:0] = buf_wstrb['h05];
assign  buf_wstrb_06[STRB_WIDTH-1:0] = buf_wstrb['h06];
assign  buf_wstrb_07[STRB_WIDTH-1:0] = buf_wstrb['h07];
assign  buf_wstrb_08[STRB_WIDTH-1:0] = buf_wstrb['h08];
assign  buf_wstrb_09[STRB_WIDTH-1:0] = buf_wstrb['h09];
assign  buf_wstrb_0a[STRB_WIDTH-1:0] = buf_wstrb['h0a];
assign  buf_wstrb_0b[STRB_WIDTH-1:0] = buf_wstrb['h0b];
assign  buf_wstrb_0c[STRB_WIDTH-1:0] = buf_wstrb['h0c];
assign  buf_wstrb_0d[STRB_WIDTH-1:0] = buf_wstrb['h0d];
assign  buf_wstrb_0e[STRB_WIDTH-1:0] = buf_wstrb['h0e];
assign  buf_wstrb_0f[STRB_WIDTH-1:0] = buf_wstrb['h0f];
assign  awq_id_dbg00[ID_WIDTH-1:0] = awq_id[00];
assign  awq_id_dbg01[ID_WIDTH-1:0] = awq_id[01];
assign  w_latency_dbg00[31:0] = w_latency[0];
assign  w_latency_dbg01[31:0] = w_latency[1];
assign  r_latency_dbg00[31:0] = r_latency[0];
assign  r_latency_dbg01[31:0] = r_latency[1];
assign  arq_id_dbg00[ID_WIDTH-1:0] = arq_id[00];
assign  arq_id_dbg01[ID_WIDTH-1:0] = arq_id[01];

assign  w_stime_dbg00[31:0] = w_stime[0];
assign  w_stime_dbg01[31:0] = w_stime[1];
assign  r_stime_dbg00[31:0] = r_stime[0];
assign  r_stime_dbg01[31:0] = r_stime[1];

task READ_BURST;
    input   [ID_WIDTH-1:0]      i_arid;
    input   [ADDR_WIDTH-1:0]    i_araddr;
    input   [LEN_WIDTH-1:0]     i_arlen;
    input   [SIZE_WIDTH-1:0]    i_arsize;
    input   [BURST_WIDTH-1:0]   i_arbrst;
    input   [LOCK_WIDTH-1:0]    i_arlock;
    input   [CACHE_WIDTH-1:0]   i_arcache;
    input   [PROT_WIDTH-1:0]    i_arprot;
    output  [DATA_WIDTH*MAX_BURSTLEN-1:0] temp_rd_data;
    output  [RESP_WIDTH*MAX_BURSTLEN-1:0] temp_rd_resp;
    begin
        temp_rd_resp = {RESP_WIDTH*MAX_BURSTLEN{1'b0}};
        incr_read(i_arid, i_arsize, i_araddr, temp_rd_data);
    end
endtask

task WRITE_BURST;
    input   [ID_WIDTH-1:0]      i_awid;
    input   [ADDR_WIDTH-1:0]    i_awaddr;
    input   [LEN_WIDTH-1:0]     i_awlen;
    input   [SIZE_WIDTH-1:0]    i_awsize;
    input   [BURST_WIDTH-1:0]   i_awbrst;
    input   [LOCK_WIDTH-1:0]    i_awlock;
    input   [CACHE_WIDTH-1:0]   i_awcache;
    input   [PROT_WIDTH-1:0]    i_awprot;
    input   [DATA_WIDTH*MAX_BURSTLEN-1:0] temp_wr_data;
    input   [31:0]                        temp_wr_datasize;
    output  [RESP_WIDTH*MAX_BURSTLEN-1:0] temp_wr_resp;
    begin
        temp_wr_resp = {RESP_WIDTH*MAX_BURSTLEN{1'b0}};
        awid = i_awid;
        incr_write(i_awlen, 2**i_awsize, i_awaddr, temp_wr_data);
    end
endtask

task WRITE_BURST_CONCURRENT;
    input   [ID_WIDTH-1:0]      i_awid;
    input   [ADDR_WIDTH-1:0]    i_awaddr;
    input   [LEN_WIDTH-1:0]     i_awlen;
    input   [SIZE_WIDTH-1:0]    i_awsize;
    input   [BURST_WIDTH-1:0]   i_awbrst;
    input   [LOCK_WIDTH-1:0]    i_awlock;
    input   [CACHE_WIDTH-1:0]   i_awcache;
    input   [PROT_WIDTH-1:0]    i_awprot;
    input   [DATA_WIDTH*MAX_BURSTLEN-1:0] temp_wr_data;
    input   [31:0]                        temp_wr_datasize;
    output  [RESP_WIDTH*MAX_BURSTLEN-1:0] temp_wr_resp;
    begin
        temp_wr_resp = {RESP_WIDTH*MAX_BURSTLEN{1'b0}};
        awid = i_awid;
        incr_write(i_awlen, 2**i_awsize, i_awaddr, temp_wr_data);
    end
endtask

function set_disable_reset_value_checks;
    input LEVEL;
    begin
        set_disable_reset_value_checks = LEVEL;
        $display("[%0d] : %0s : Currently not support set_disable_reset_value_checks(%0b)",$time, "axi_master_bfm_core", LEVEL);
    end
endfunction

function set_stop_on_error;
    input LEVEL;
    begin
        set_stop_on_error = LEVEL;
        $display("[%0d] : %0s : Currently not support set_stop_on_error(%0b)",$time, "axi_master_bfm_core", LEVEL);
    end
endfunction

function set_channel_level_info;
    input LEVEL;
    begin
        set_channel_level_info = LEVEL;
        $display("[%0d] : %0s : Currently not support set_channel_level_info(%0b)",$time, "axi_master_bfm_core", LEVEL);
    end
endfunction

function set_function_level_info;
    input LEVEL;
    begin
        set_function_level_info = LEVEL;
        $display("[%0d] : %0s : Currently not support set_function_level_info(%0b)",$time, "axi_master_bfm_core", LEVEL);
    end
endfunction

endmodule
