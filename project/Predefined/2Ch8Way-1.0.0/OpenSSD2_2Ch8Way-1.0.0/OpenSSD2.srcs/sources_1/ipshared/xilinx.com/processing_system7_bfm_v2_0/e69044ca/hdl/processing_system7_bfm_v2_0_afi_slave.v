/*****************************************************************************
 * File : processing_system7_bfm_v2_0_afi_slave.v
 *
 * Date : 2012-11
 *
 * Description : Model that acts as AFI port interface. It uses AXI3 Slave BFM
 *               from Cadence.
 *****************************************************************************/

module processing_system7_bfm_v2_0_afi_slave (
  S_RESETN,

  S_ARREADY,
  S_AWREADY,
  S_BVALID,
  S_RLAST,
  S_RVALID,
  S_WREADY,
  S_BRESP,
  S_RRESP,
  S_RDATA,
  S_BID,
  S_RID,
  S_ACLK,
  S_ARVALID,
  S_AWVALID,
  S_BREADY,
  S_RREADY,
  S_WLAST,
  S_WVALID,
  S_ARBURST,
  S_ARLOCK,
  S_ARSIZE,
  S_AWBURST,
  S_AWLOCK,
  S_AWSIZE,
  S_ARPROT,
  S_AWPROT,
  S_ARADDR,
  S_AWADDR,
  S_WDATA,
  S_ARCACHE,
  S_ARLEN,
  S_AWCACHE,
  S_AWLEN,
  S_WSTRB,
  S_ARID,
  S_AWID,
  S_WID,
  
  S_AWQOS,
  S_ARQOS,

  SW_CLK,
  WR_DATA_ACK_OCM,
  WR_DATA_ACK_DDR,
  WR_ADDR,
  WR_DATA,
  WR_BYTES,
  WR_DATA_VALID_OCM,
  WR_DATA_VALID_DDR,
  WR_QOS,
  
  RD_REQ_DDR,
  RD_REQ_OCM,
  RD_ADDR,
  RD_DATA_OCM,
  RD_DATA_DDR,
  RD_BYTES,
  RD_QOS,
  RD_DATA_VALID_OCM,
  RD_DATA_VALID_DDR,
  S_RDISSUECAP1_EN,
  S_WRISSUECAP1_EN,
  S_RCOUNT,
  S_WCOUNT,
  S_RACOUNT,
  S_WACOUNT

);
  parameter enable_this_port = 0;  
  parameter slave_name = "Slave";
  parameter data_bus_width = 32;
  parameter address_bus_width = 32;
  parameter id_bus_width = 6;
  parameter slave_base_address = 0;
  parameter slave_high_address = 4;
  parameter max_outstanding_transactions = 8;
  parameter exclusive_access_supported = 0;

  `include "processing_system7_bfm_v2_0_local_params.v"

  /* Local parameters only for this module */
  /* Internal counters that are used as Read/Write pointers to the fifo's that store all the transaction info on all channles.
     This parameter is used to define the width of these pointers --> depending on Maximum outstanding transactions supported.
     1-bit extra width than the no.of.bits needed to represent the outstanding transactions
     Extra bit helps in generating the empty and full flags
  */
  parameter int_cntr_width = clogb2(max_outstanding_transactions)+1;

  /* RESP data */
  parameter rsp_fifo_bits = axi_rsp_width+id_bus_width; 
  parameter rsp_lsb = 0;
  parameter rsp_msb = axi_rsp_width-1;
  parameter rsp_id_lsb = rsp_msb + 1;  
  parameter rsp_id_msb = rsp_id_lsb + id_bus_width-1;  

  input  S_RESETN;

  output  S_ARREADY;
  output  S_AWREADY;
  output  S_BVALID;
  output  S_RLAST;
  output  S_RVALID;
  output  S_WREADY;
  output  [axi_rsp_width-1:0] S_BRESP;
  output  [axi_rsp_width-1:0] S_RRESP;
  output  [data_bus_width-1:0] S_RDATA;
  output  [id_bus_width-1:0] S_BID;
  output  [id_bus_width-1:0] S_RID;
  input S_ACLK;
  input S_ARVALID;
  input S_AWVALID;
  input S_BREADY;
  input S_RREADY;
  input S_WLAST;
  input S_WVALID;
  input [axi_brst_type_width-1:0] S_ARBURST;
  input [axi_lock_width-1:0] S_ARLOCK;
  input [axi_size_width-1:0] S_ARSIZE;
  input [axi_brst_type_width-1:0] S_AWBURST;
  input [axi_lock_width-1:0] S_AWLOCK;
  input [axi_size_width-1:0] S_AWSIZE;
  input [axi_prot_width-1:0] S_ARPROT;
  input [axi_prot_width-1:0] S_AWPROT;
  input [address_bus_width-1:0] S_ARADDR;
  input [address_bus_width-1:0] S_AWADDR;
  input [data_bus_width-1:0] S_WDATA;
  input [axi_cache_width-1:0] S_ARCACHE;
  input [axi_cache_width-1:0] S_ARLEN;
  
  input [axi_qos_width-1:0] S_ARQOS;
 
  input [axi_cache_width-1:0] S_AWCACHE;
  input [axi_len_width-1:0] S_AWLEN;

  input [axi_qos_width-1:0] S_AWQOS;
  input [(data_bus_width/8)-1:0] S_WSTRB;
  input [id_bus_width-1:0] S_ARID;
  input [id_bus_width-1:0] S_AWID;
  input [id_bus_width-1:0] S_WID;

  input SW_CLK;
  input WR_DATA_ACK_DDR, WR_DATA_ACK_OCM;
  output WR_DATA_VALID_DDR, WR_DATA_VALID_OCM;
  output [max_burst_bits-1:0] WR_DATA;
  output [addr_width-1:0] WR_ADDR;
  output [max_transfer_bytes_width:0] WR_BYTES;
  output reg RD_REQ_OCM, RD_REQ_DDR;
  output reg [addr_width-1:0] RD_ADDR;
  input [max_burst_bits-1:0] RD_DATA_DDR,RD_DATA_OCM;
  output reg[max_transfer_bytes_width:0] RD_BYTES;
  input RD_DATA_VALID_OCM,RD_DATA_VALID_DDR;
  output [axi_qos_width-1:0] WR_QOS;
  output reg [axi_qos_width-1:0] RD_QOS;
 
  input S_RDISSUECAP1_EN;
  input S_WRISSUECAP1_EN;

  output [7:0] S_RCOUNT;
  output [7:0] S_WCOUNT;
  output [2:0] S_RACOUNT;
  output [5:0] S_WACOUNT;

  wire net_ARVALID;
  wire net_AWVALID;
  wire net_WVALID;

  real s_aclk_period;

`ifdef ORIGINAL_CDN_AXI3_MASTER_BFM
  cdn_axi3_slave_bfm #(slave_name,
                       data_bus_width,
                       address_bus_width,
                       id_bus_width, 
                       slave_base_address,
                       (slave_high_address- slave_base_address),
                       max_outstanding_transactions,
                       0, ///MEMORY_MODEL_MODE,
                       exclusive_access_supported)
  slave   (.ACLK    (S_ACLK),
           .ARESETn (S_RESETN), /// confirm this
           // Write Address Channel
           .AWID    (S_AWID),
           .AWADDR  (S_AWADDR),
           .AWLEN   (S_AWLEN),
           .AWSIZE  (S_AWSIZE),
           .AWBURST (S_AWBURST),
           .AWLOCK  (S_AWLOCK),
           .AWCACHE (S_AWCACHE),
           .AWPROT  (S_AWPROT),
           .AWVALID (net_AWVALID),
           .AWREADY (S_AWREADY),
           // Write Data Channel Signals.
           .WID    (S_WID),
           .WDATA  (S_WDATA),
           .WSTRB  (S_WSTRB), 
           .WLAST  (S_WLAST), 
           .WVALID (net_WVALID),
           .WREADY (S_WREADY),
           // Write Response Channel Signals.
           .BID    (S_BID),
           .BRESP  (S_BRESP),
           .BVALID (S_BVALID),
           .BREADY (S_BREADY),
           // Read Address Channel Signals.
           .ARID    (S_ARID),
           .ARADDR  (S_ARADDR),
           .ARLEN   (S_ARLEN),
           .ARSIZE  (S_ARSIZE),
           .ARBURST (S_ARBURST),
           .ARLOCK  (S_ARLOCK),
           .ARCACHE (S_ARCACHE),
           .ARPROT  (S_ARPROT),
           .ARVALID (net_ARVALID),
           .ARREADY (S_ARREADY),
           // Read Data Channel Signals.
           .RID    (S_RID),
           .RDATA  (S_RDATA),
           .RRESP  (S_RRESP),
           .RLAST  (S_RLAST),
           .RVALID (S_RVALID),
           .RREADY (S_RREADY));
`elsif VIP_AXI3_MASTER_BFM
  vip_axi3_slave_bfm slave   (
           .aclk    (S_ACLK),
           .aresetn (S_RESETN), /// confirm this
           // Write Address Channel
           .s_axi_awid    (S_AWID),
           .s_axi_awaddr  (S_AWADDR),
           .s_axi_awlen   (S_AWLEN),
           .s_axi_awsize  (S_AWSIZE),
           .s_axi_awburst (S_AWBURST),
           .s_axi_awlock  (S_AWLOCK),
           .s_axi_awcache (S_AWCACHE),
           .s_axi_awprot  (S_AWPROT),
           .s_axi_awvalid (net_AWVALID),
           .s_axi_awready (S_AWREADY),
           // Write Data Channel Signals.
           .s_axi_wid    (S_WID),
           .s_axi_wdata  (S_WDATA),
           .s_axi_wstrb  (S_WSTRB), 
           .s_axi_wlast  (S_WLAST), 
           .s_axi_wvalid (net_WVALID),
           .s_axi_wready (S_WREADY),
           // Write Response Channel Signals.
           .s_axi_bid    (S_BID),
           .s_axi_bresp  (S_BRESP),
           .s_axi_bvalid (S_BVALID),
           .s_axi_bready (S_BREADY),
           // Read Address Channel Signals.
           .s_axi_arid    (S_ARID),
           .s_axi_araddr  (S_ARADDR),
           .s_axi_arlen   (S_ARLEN),
           .s_axi_arsize  (S_ARSIZE),
           .s_axi_arburst (S_ARBURST),
           .s_axi_arlock  (S_ARLOCK),
           .s_axi_arcache (S_ARCACHE),
           .s_axi_arprot  (S_ARPROT),
           .s_axi_arvalid (net_ARVALID),
           .s_axi_arready (S_ARREADY),
           // Read Data Channel Signals.
           .s_axi_rid    (S_RID),
           .s_axi_rdata  (S_RDATA),
           .s_axi_rresp  (S_RRESP),
           .s_axi_rlast  (S_RLAST),
           .s_axi_rvalid (S_RVALID),
           .s_axi_rready (S_RREADY));
`elsif USE_AXI_BFM_CORE
  axi_slave_bfm_core #(
           .VERBOSE         ( 1                                    ),
           .ADDR_WIDTH      ( address_bus_width                    ),
           .BASE_ADDR       ( slave_base_address                   ),
           .ADDR_SPACE      ( slave_high_address-slave_high_address),
           .MEM_ADDR_WIDTH  ( 8                                    ),   //max 31 
           .DATA_WIDTH      ( data_bus_width                       ), 
           .ID_WIDTH        ( id_bus_width                         ),
           .SIZE_WIDTH      ( 3                                    ),
           .QOS_WIDTH       ( 3                                    ),
           .MAX_CMDNUM      ( max_outstanding_transactions         ),
           .MAX_MEM_ADDR    ( 4095                                 ),
           .MAX_BURSTLEN    ( 16                                   ), // when change this you must change
           .BYTEEN_WIDTH    ( data_bus_width/8                     ),
           .AXI_VERSION     ( 3                                    )
          ) slave   (
           .aclk    (S_ACLK),
           .aresetn (S_RESETN), /// confirm this
           // Write Address Channel
           .awid    (S_AWID),
           .awaddr  (S_AWADDR),
           .awlen   (S_AWLEN),
           .awsize  (S_AWSIZE),
           .awburst (S_AWBURST),
           .awlock  (S_AWLOCK),
           .awcache (S_AWCACHE),
           .awprot  (S_AWPROT),
           .awvalid (net_AWVALID),
           .awready (S_AWREADY),
           // Write Data Channel Signals.
           .wid    (S_WID),
           .wdata  (S_WDATA),
           .wstrb  (S_WSTRB), 
           .wlast  (S_WLAST), 
           .wvalid (net_WVALID),
           .wready (S_WREADY),
           // Write Response Channel Signals.
           .bid    (S_BID),
           .bresp  (S_BRESP),
           .bvalid (S_BVALID),
           .bready (S_BREADY),
           // Read Address Channel Signals.
           .arid    (S_ARID),
           .araddr  (S_ARADDR),
           .arlen   (S_ARLEN),
           .arsize  (S_ARSIZE),
           .arburst (S_ARBURST),
           .arlock  (S_ARLOCK),
           .arcache (S_ARCACHE),
           .arprot  (S_ARPROT),
           .arvalid (net_ARVALID),
           .arready (S_ARREADY),
           // Read Data Channel Signals.
           .rid    (S_RID),
           .rdata  (S_RDATA),
           .rresp  (S_RRESP),
           .rlast  (S_RLAST),
           .rvalid (S_RVALID),
           .rready (S_RREADY));
`else
    reg     S_AWREADY;
    reg     S_WREADY;
    reg     S_BVALID;
    reg     S_ARREADY;
    reg     S_RVALID;
    reg     S_RLAST; 
    reg  [id_bus_width-1:0] S_BID;
    reg  [axi_rsp_width-1:0] S_BRESP;
    reg  [id_bus_width-1:0] S_RID;
    reg  [axi_rsp_width-1:0] S_RRESP;
    reg  [data_bus_width-1:0] S_RDATA;
    integer temp_write_resp_i;
    integer temp_read_burst_i;
    initial begin
        S_AWREADY = 1'b0;
        S_WREADY  = 1'b0;
        S_BVALID  = 1'b0;
        S_ARREADY = 1'b0;
        S_RVALID  = 1'b0;
        S_RLAST   = 1'b0;
    end
`endif //endif ORIGINAL_CDN_AXI3_SLAVE_BFM


  wire wr_intr_fifo_full;
  reg temp_wr_intr_fifo_full; 

  /* Interconnect WR_FIFO model instance */
  processing_system7_bfm_v2_0_intr_wr_mem wr_intr_fifo(SW_CLK, S_RESETN, wr_intr_fifo_full, WR_DATA_ACK_OCM, WR_DATA_ACK_DDR, WR_ADDR, WR_DATA, WR_BYTES, WR_QOS, WR_DATA_VALID_OCM, WR_DATA_VALID_DDR);

  /* Register the async 'full' signal to S_ACLK clock */
  always@(posedge S_ACLK) temp_wr_intr_fifo_full = wr_intr_fifo_full;

  /* Latency type and Debug/Error Control */
  reg[1:0] latency_type = RANDOM_CASE;
  reg DEBUG_INFO = 1; 
  reg STOP_ON_ERROR = 1'b1; 

  /* Internal nets/regs for calling slave BFM API's*/
  reg [wr_afi_fifo_data_bits-1:0] wr_fifo [0:max_outstanding_transactions-1];
  reg [int_cntr_width-1:0] wr_fifo_wr_ptr = 0, wr_fifo_rd_ptr = 0;
  wire wr_fifo_empty;

  /* Store the awvalid receive time --- necessary for calculating the bresp latency */
  reg [7:0] aw_time_cnt = 0,bresp_time_cnt = 0;
  real awvalid_receive_time[0:max_outstanding_transactions]; // store the time when a new awvalid is received
  reg  awvalid_flag[0:max_outstanding_transactions]; // store the time when a new awvalid is received

  /* Address Write Channel handshake*/
  reg[int_cntr_width-1:0] aw_cnt = 0;//

  /* various FIFOs for storing the ADDR channel info */
  reg [axi_size_width-1:0]  awsize [0:max_outstanding_transactions-1];
  reg [axi_prot_width-1:0]  awprot [0:max_outstanding_transactions-1];
  reg [axi_lock_width-1:0]  awlock [0:max_outstanding_transactions-1];
  reg [axi_cache_width-1:0]  awcache [0:max_outstanding_transactions-1];
  reg [axi_brst_type_width-1:0]  awbrst [0:max_outstanding_transactions-1];
  reg [axi_len_width-1:0]  awlen [0:max_outstanding_transactions-1];
  reg aw_flag [0:max_outstanding_transactions-1];
  reg [addr_width-1:0] awaddr [0:max_outstanding_transactions-1];
  reg [id_bus_width-1:0] awid [0:max_outstanding_transactions-1];
  reg [axi_qos_width-1:0]  awqos [0:max_outstanding_transactions-1];
  wire aw_fifo_full; // indicates awvalid_fifo is full (max outstanding transactions reached)

  /* internal fifos to store burst write data, ID & strobes*/
  reg [(data_bus_width*axi_burst_len)-1:0] burst_data [0:max_outstanding_transactions-1];
  reg [max_burst_bytes_width:0] burst_valid_bytes [0:max_outstanding_transactions-1]; /// total valid bytes received in a complete burst transfer
  reg wlast_flag [0:max_outstanding_transactions-1]; // flag  to indicate WLAST received
  wire wd_fifo_full;

  /* Write Data Channel and Write Response handshake signals*/
  reg [int_cntr_width-1:0] wd_cnt = 0;
  reg [(data_bus_width*axi_burst_len)-1:0] aligned_wr_data;
  reg [addr_width-1:0] aligned_wr_addr;
  reg [max_burst_bytes_width:0] valid_data_bytes;
  reg [int_cntr_width-1:0] wr_bresp_cnt = 0;
  reg [axi_rsp_width-1:0] bresp;
  reg [rsp_fifo_bits-1:0] fifo_bresp [0:max_outstanding_transactions-1]; // store the ID and its corresponding response
  reg enable_write_bresp;
  reg [int_cntr_width-1:0] rd_bresp_cnt = 0;
  integer wr_latency_count;
  reg  wr_delayed;
  wire bresp_fifo_empty;

  /* keep track of count values */
  reg[7:0] wcount;
  reg[5:0] wacount;

  /* Qos*/
  reg [axi_qos_width-1:0] ar_qos, aw_qos;

  initial begin
   if(DEBUG_INFO) begin
    if(enable_this_port)
     $display("[%0d] : %0s : %0s : Port is ENABLED.",$time, DISP_INFO, slave_name);
    else
     $display("[%0d] : %0s : %0s : Port is DISABLED.",$time, DISP_INFO, slave_name);
   end
  end
 /*--------------------------------------------------------------------------------*/

  /* Store the Clock cycle time period */
          
  always@(S_RESETN)
  begin
   if(S_RESETN) begin
    @(posedge S_ACLK);
    s_aclk_period = $time;
    @(posedge S_ACLK);
    s_aclk_period = $time - s_aclk_period;
   end
  end
 /*--------------------------------------------------------------------------------*/

`ifdef ORIGINAL_CDN_AXI3_MASTER_BFM
  initial slave.set_disable_reset_value_checks(1); 
  initial begin
     repeat(2) @(posedge S_ACLK);
     if(!enable_this_port) begin
        slave.set_channel_level_info(0);
        slave.set_function_level_info(0);
     end 
     slave.RESPONSE_TIMEOUT = 0;
  end
`endif //endif ORIGINAL_CDN_AXI3_MASTER_BFM
 /*--------------------------------------------------------------------------------*/

  /* Set Latency type to be used */
  task set_latency_type;
    input[1:0] lat;
  begin
   if(enable_this_port) 
    latency_type = lat;
   else begin
    //if(DEBUG_INFO)
     $display("[%0d] : %0s : %0s : Port is disabled. 'Latency Profile' will not be set...",$time, DISP_WARN, slave_name);
   end
  end
  endtask
 /*--------------------------------------------------------------------------------*/
  /* Set ARQoS to be used */
  task set_arqos;
    input[axi_qos_width-1:0] qos;
  begin
   if(enable_this_port) 
    ar_qos = qos;
   else begin
    if(DEBUG_INFO)
     $display("[%0d] : %0s : %0s : Port is disabled. 'ARQOS' will not be set...",$time, DISP_WARN, slave_name);
   end
  end
  endtask
  /*--------------------------------------------------------------------------------*/

  /* Set AWQoS to be used */
  task set_awqos;
    input[axi_qos_width-1:0] qos;
  begin
   if(enable_this_port) 
    aw_qos = qos;
   else begin
    if(DEBUG_INFO)
     $display("[%0d] : %0s : %0s : Port is disabled. 'AWQOS' will not be set...",$time, DISP_WARN, slave_name);
   end
  end
  endtask
  /*--------------------------------------------------------------------------------*/

  /* get the wr latency number */
  function [31:0] get_wr_lat_number;
  input dummy;
  reg[1:0] temp;
  begin 
   case(latency_type)
    BEST_CASE   : get_wr_lat_number = afi_wr_min;            
    AVG_CASE    : get_wr_lat_number = afi_wr_avg;            
    WORST_CASE  : get_wr_lat_number = afi_wr_max;            
    default     : begin  // RANDOM_CASE
                   temp = $random;
                   case(temp) 
                    2'b00   : get_wr_lat_number = ($random()%10+ afi_wr_min); 
                    2'b01   : get_wr_lat_number = ($random()%40+ afi_wr_avg); 
                    default : get_wr_lat_number = ($random()%60+ afi_wr_max); 
                   endcase        
                  end
   endcase
  end
  endfunction
 /*--------------------------------------------------------------------------------*/

  /* get the rd latency number */
  function [31:0] get_rd_lat_number;
  input dummy;
  reg[1:0] temp;
  begin 
   case(latency_type)
    BEST_CASE   : get_rd_lat_number = afi_rd_min;            
    AVG_CASE    : get_rd_lat_number = afi_rd_avg;            
    WORST_CASE  : get_rd_lat_number = afi_rd_max;            
    default     : begin  // RANDOM_CASE
                   temp = $random;
                   case(temp) 
                    2'b00   : get_rd_lat_number = ($random()%10+ afi_rd_min); 
                    2'b01   : get_rd_lat_number = ($random()%40+ afi_rd_avg); 
                    default : get_rd_lat_number = ($random()%60+ afi_rd_max); 
                   endcase        
                  end
   endcase
  end
  endfunction
 /*--------------------------------------------------------------------------------*/
 /* Check for any WRITE/READs when this port is disabled */
 always@(S_AWVALID or S_WVALID or S_ARVALID)
 begin
  if((S_AWVALID | S_WVALID | S_ARVALID) && !enable_this_port) begin
    $display("[%0d] : %0s : %0s : Port is disabled. AXI transaction is initiated on this port ...\nSimulation will halt ..",$time, DISP_ERR, slave_name);
    $stop;
  end
 end

 /*--------------------------------------------------------------------------------*/

  assign net_ARVALID = enable_this_port ? S_ARVALID : 1'b0;
  assign net_AWVALID = enable_this_port ? S_AWVALID : 1'b0;
  assign net_WVALID  = enable_this_port ? S_WVALID : 1'b0;

  assign wr_fifo_empty = (wr_fifo_wr_ptr === wr_fifo_rd_ptr)?1'b1: 1'b0;
  assign bresp_fifo_empty = (wr_bresp_cnt === rd_bresp_cnt)?1'b1:1'b0;
  assign bresp_fifo_full  = ((wr_bresp_cnt[int_cntr_width-1] !== rd_bresp_cnt[int_cntr_width-1]) && (wr_bresp_cnt[int_cntr_width-2:0] === rd_bresp_cnt[int_cntr_width-2:0]))?1'b1:1'b0;

  assign S_WCOUNT = wcount;
  assign S_WACOUNT = wacount;

 // FIFO_STATUS (only if AFI port) 1- full 
 function automatic wrfifo_full ;
 input [axi_len_width-1:0] fifo_space_exp;
 integer fifo_space_left; 
 begin
   fifo_space_left = afi_fifo_locations - wcount;
   if(fifo_space_left < fifo_space_exp) 
     wrfifo_full = 1;
   else
     wrfifo_full = 0;
 end
 endfunction
 /*--------------------------------------------------------------------------------*/

 /* Store the awvalid receive time --- necessary for calculating the bresp latency */
 always@(negedge S_RESETN or S_AWID or S_AWADDR or S_AWVALID )
 begin
 if(!S_RESETN)
  aw_time_cnt <= 0;
 else begin
  if(S_AWVALID) begin
    awvalid_receive_time[aw_time_cnt] <= $time;
    awvalid_flag[aw_time_cnt] <= 1'b1;
    aw_time_cnt <= aw_time_cnt + 1;
  end
 end // else
 end /// always
 /*--------------------------------------------------------------------------------*/
  always@(posedge S_ACLK)
  begin
  if(net_AWVALID && S_AWREADY) begin
    if(S_AWQOS === 0) awqos[aw_cnt[int_cntr_width-2:0]] = aw_qos; 
    else awqos[aw_cnt[int_cntr_width-2:0]] = S_AWQOS; 
  end
  end

 /* Address Write Channel handshake*/
 always@(negedge S_RESETN or posedge S_ACLK)
 begin
 if(!S_RESETN) begin
   aw_cnt <= 0;
   wacount <= 0;
 end else begin
   if(S_AWVALID && !wrfifo_full(S_AWLEN+1)) begin 
      `ifdef USE_AXI_BFM_CORE
       slave.RECEIVE_WRITE_ADDRESS(0,
                                   id_invalid,
                                   awaddr[aw_cnt[int_cntr_width-2:0]],
                                   awlen[aw_cnt[int_cntr_width-2:0]],
                                   awsize[aw_cnt[int_cntr_width-2:0]],
                                   awbrst[aw_cnt[int_cntr_width-2:0]],
                                   awlock[aw_cnt[int_cntr_width-2:0]],
                                   awcache[aw_cnt[int_cntr_width-2:0]],
                                   awprot[aw_cnt[int_cntr_width-2:0]],
                                   awid[aw_cnt[int_cntr_width-2:0]]); /// sampled valid ID.
      `else
        #1;
        if(id_invalid || (0 == S_AWID)) begin
            S_AWREADY        = 1'b1   ;
          @(posedge S_ACLK);
            #1;
            awaddr[aw_cnt[int_cntr_width-2:0]]  = S_AWADDR ;
            awlen[aw_cnt[int_cntr_width-2:0]]   = S_AWLEN  ;
            awsize[aw_cnt[int_cntr_width-2:0]]  = S_AWSIZE ;
            awbrst[aw_cnt[int_cntr_width-2:0]]  = S_AWBURST;
            awlock[aw_cnt[int_cntr_width-2:0]]  = S_AWLOCK ;
            awcache[aw_cnt[int_cntr_width-2:0]] = S_AWCACHE;
            awprot[aw_cnt[int_cntr_width-2:0]]  = S_AWPROT ;
            awid[aw_cnt[int_cntr_width-2:0]]    = S_AWID   ;
            S_AWREADY        = 1'b0   ;
        end
      `endif //USE_AXI_BFM_CORE
       aw_flag[aw_cnt[int_cntr_width-2:0]] <= 1'b1;
       aw_cnt                              <= aw_cnt + 1;
       wacount                             <= wacount + 1;
   end // if (!aw_fifo_full)
 end /// if else
 end /// always
 /*--------------------------------------------------------------------------------*/
 
 /* Write Data Channel Handshake */
 always@(negedge S_RESETN or posedge S_ACLK)
 begin
 if(!S_RESETN) begin
  wd_cnt <= 0;
 end else begin
  if(aw_flag[wd_cnt[int_cntr_width-2:0]]) begin
    if(S_WVALID && !wrfifo_full(awlen[wd_cnt[int_cntr_width-2:0]] + 1)) begin
   `ifdef USE_AXI_BFM_CORE
     slave.RECEIVE_WRITE_BURST_NO_CHECKS(S_WID, burst_data[wd_cnt[int_cntr_width-2:0]], burst_valid_bytes[wd_cnt[int_cntr_width-2:0]]); 
   `else
     #1;
     if(S_WID == S_WID) begin
        S_WREADY = 1'b1;
        burst_data[wd_cnt[int_cntr_width-2:0]]        = S_WDATA;
        burst_valid_bytes[wd_cnt[int_cntr_width-2:0]] = S_WSTRB;
        @(posedge S_ACLK);
        #1
        S_WREADY = 1'b0;
     end else begin
        S_WREADY = 1'b0;
     end
   `endif //USE_AXI_BFM_CORE
     wlast_flag[wd_cnt[int_cntr_width-2:0]] <= 1'b1;
     wd_cnt   <= wd_cnt + 1;
    end  
  end else begin
    if(!wrfifo_full(axi_burst_len) && S_WVALID) begin
   `ifdef USE_AXI_BFM_CORE
      slave.RECEIVE_WRITE_BURST_NO_CHECKS(S_WID, burst_data[wd_cnt[int_cntr_width-2:0]], burst_valid_bytes[wd_cnt[int_cntr_width-2:0]]); 
   `else
      #1;
      if(S_WID == S_WID) begin
        S_WREADY = 1'b1;
        burst_data[wd_cnt[int_cntr_width-2:0]]        = S_WDATA;
        burst_valid_bytes[wd_cnt[int_cntr_width-2:0]] = S_WSTRB;
      end else begin
         S_WREADY = 1'b0;
      end
   `endif //USE_AXI_BFM_CORE
      wlast_flag[wd_cnt[int_cntr_width-2:0]] <= 1'b1;
      wd_cnt   <= wd_cnt + 1;
    end
  end /// if
 end /// else
 end /// always
 /*--------------------------------------------------------------------------------*/
 
 /* Align the wrap data for write transaction */
 task automatic get_wrap_aligned_wr_data;
 output [(data_bus_width*axi_burst_len)-1:0] aligned_data;
 output [addr_width-1:0] start_addr; /// aligned start address
 input  [addr_width-1:0] addr;
 input  [(data_bus_width*axi_burst_len)-1:0] b_data;
 input  [max_burst_bytes_width:0] v_bytes;
 reg    [(data_bus_width*axi_burst_len)-1:0] temp_data, wrp_data;
 integer wrp_bytes;
 integer i;
 begin
   start_addr = (addr/v_bytes) * v_bytes;
   wrp_bytes = addr - start_addr;
   wrp_data = b_data;
   temp_data = 0;
   wrp_data = wrp_data << ((data_bus_width*axi_burst_len) - (v_bytes*8));
   while(wrp_bytes > 0) begin /// get the data that is wrapped
     temp_data = temp_data << 8;
     temp_data[7:0] = wrp_data[(data_bus_width*axi_burst_len)-1 : (data_bus_width*axi_burst_len)-8];
     wrp_data = wrp_data << 8;
     wrp_bytes = wrp_bytes - 1;
   end
   wrp_bytes = addr - start_addr;
   wrp_data = b_data << (wrp_bytes*8);
   
   aligned_data = (temp_data | wrp_data);
 end
 endtask
 /*--------------------------------------------------------------------------------*/
  
 /* Calculate the Response for each read/write transaction */
 function [axi_rsp_width-1:0] calculate_resp;
 input [addr_width-1:0] awaddr; 
 input [axi_prot_width-1:0] awprot;
 reg [axi_rsp_width-1:0] rsp;
 begin
   rsp = AXI_OK;
   /* Address Decode */
   if(decode_address(awaddr) === INVALID_MEM_TYPE) begin
    rsp = AXI_SLV_ERR; //slave error
    $display("[%0d] : %0s : %0s : AXI Access to Invalid location(0x%0h) ",$time, DISP_ERR, slave_name, awaddr);
   end
   else if(decode_address(awaddr) === REG_MEM) begin
    rsp = AXI_SLV_ERR; //slave error
    $display("[%0d] : %0s : %0s : AXI Access to Register Map(0x%0h) is not allowed through this port.",$time, DISP_ERR, slave_name, awaddr);
   end
   if(secure_access_enabled && awprot[1])
    rsp = AXI_DEC_ERR; // decode error
   calculate_resp = rsp;
 end
 endfunction
 /*--------------------------------------------------------------------------------*/
 reg[max_burst_bits-1:0] temp_wr_data;
 /* Store the Write response for each write transaction */
 always@(negedge S_RESETN or posedge S_ACLK)
 begin
 if(!S_RESETN) begin
  wr_fifo_wr_ptr <= 0;
  wcount <= 0;
 end else begin
  enable_write_bresp = aw_flag[wr_fifo_wr_ptr[int_cntr_width-2:0]] && wlast_flag[wr_fifo_wr_ptr[int_cntr_width-2:0]];
  /* calculate bresp only when AWVALID && WLAST is received */
  if(enable_write_bresp) begin
    aw_flag[wr_fifo_wr_ptr[int_cntr_width-2:0]]    <= 0;
    wlast_flag[wr_fifo_wr_ptr[int_cntr_width-2:0]] <= 0;
 
    bresp = calculate_resp(awaddr[wr_fifo_wr_ptr[int_cntr_width-2:0]], awprot[wr_fifo_wr_ptr[int_cntr_width-2:0]]);
    /* Fill AFI_WR_data FIFO */
    if(bresp === AXI_OK ) begin
      if(awbrst[wr_fifo_wr_ptr[int_cntr_width-2:0]]=== AXI_WRAP) begin /// wrap type? then align the data
        get_wrap_aligned_wr_data(aligned_wr_data, aligned_wr_addr, awaddr[wr_fifo_wr_ptr[int_cntr_width-2:0]], burst_data[wr_fifo_wr_ptr[int_cntr_width-2:0]],burst_valid_bytes[wr_fifo_wr_ptr[int_cntr_width-2:0]]);      /// gives wrapped start address
      end else begin
        aligned_wr_data = burst_data[wr_fifo_wr_ptr[int_cntr_width-2:0]]; 
        aligned_wr_addr = awaddr[wr_fifo_wr_ptr[int_cntr_width-2:0]] ;
      end
      valid_data_bytes = burst_valid_bytes[wr_fifo_wr_ptr[int_cntr_width-2:0]];
    end else
      valid_data_bytes = 0;
    temp_wr_data = aligned_wr_data;
    wr_fifo[wr_fifo_wr_ptr[int_cntr_width-2:0]] = {awqos[wr_fifo_wr_ptr[int_cntr_width-2:0]], awlen[wr_fifo_wr_ptr[int_cntr_width-2:0]], awid[wr_fifo_wr_ptr[int_cntr_width-2:0]], bresp, temp_wr_data, aligned_wr_addr, valid_data_bytes};
    wcount <= wcount + awlen[wr_fifo_wr_ptr[int_cntr_width-2:0]]+1;
    wr_fifo_wr_ptr <= wr_fifo_wr_ptr + 1;
  end
 end // else
 end // always
 /*--------------------------------------------------------------------------------*/
 
 /* Send Write Response Channel handshake */
 always@(negedge S_RESETN or posedge S_ACLK)
 begin
 if(!S_RESETN) begin
  rd_bresp_cnt <= 0;
  wr_latency_count = get_wr_lat_number(1);
  wr_delayed = 0;
  bresp_time_cnt <= 0; 
 end else begin
  wr_delayed = 1'b0;
  if(awvalid_flag[bresp_time_cnt] && (($time - awvalid_receive_time[bresp_time_cnt])/s_aclk_period >= wr_latency_count))
    wr_delayed = 1;
  if(!bresp_fifo_empty && wr_delayed) begin
   `ifdef USE_AXI_BFM_CORE
    slave.SEND_WRITE_RESPONSE(fifo_bresp[rd_bresp_cnt[int_cntr_width-2:0]][rsp_id_msb : rsp_id_lsb],  // ID
                              fifo_bresp[rd_bresp_cnt[int_cntr_width-2:0]][rsp_msb : rsp_lsb]   // Response
                             );
   `else
     begin
       #1;
          S_BID    = fifo_bresp[rd_bresp_cnt[int_cntr_width-2:0]][rsp_id_msb : rsp_id_lsb];
          S_BRESP  = fifo_bresp[rd_bresp_cnt[int_cntr_width-2:0]][rsp_msb : rsp_lsb];
          S_BVALID = 1'b1;
          for(temp_write_resp_i=0; temp_write_resp_i<1;) begin
              @(posedge S_ACLK);
              #1;
              if(S_BREADY && S_BVALID) temp_write_resp_i = temp_write_resp_i + 1;
          end
          S_BVALID = 1'b0;
     end
   `endif //USE_AXI_BFM_CORE
    wr_delayed = 0;
    awvalid_flag[bresp_time_cnt] = 1'b0;
    bresp_time_cnt <= bresp_time_cnt+1;
    rd_bresp_cnt   <= rd_bresp_cnt + 1;
    wr_latency_count = get_wr_lat_number(1);
  end 
 end // else
 end//always
 /*--------------------------------------------------------------------------------*/
 
 /* Write Response Channel handshake */
 reg wr_int_state;
 /* Reading from the wr_fifo and sending to Interconnect fifo*/
 always@(negedge S_RESETN or posedge S_ACLK) 
 begin
 if(!S_RESETN) begin
  wr_int_state <= 1'b0;
  wr_bresp_cnt <= 0;
  wr_fifo_rd_ptr <= 0;
 end else begin
  case(wr_int_state)
  1'b0 : begin
    wr_int_state <= 1'b0;
    if(!temp_wr_intr_fifo_full && !bresp_fifo_full && !wr_fifo_empty) begin
      wr_intr_fifo.write_mem({wr_fifo[wr_fifo_rd_ptr[int_cntr_width-2:0]][wr_afi_qos_msb:wr_afi_qos_lsb], wr_fifo[wr_fifo_rd_ptr[int_cntr_width-2:0]][wr_afi_data_msb:wr_afi_bytes_lsb]}); /// qos, data, address and valid_bytes
      wr_int_state <= 1'b1;
      /* start filling the write response fifo at the same time */
      fifo_bresp[wr_bresp_cnt[int_cntr_width-2:0]] <= wr_fifo[wr_fifo_rd_ptr[int_cntr_width-2:0]][wr_afi_id_msb:wr_afi_rsp_lsb]; // ID and Resp
      wcount  <= wcount  - (wr_fifo[wr_fifo_rd_ptr[int_cntr_width-2:0]][wr_afi_ln_msb:wr_afi_ln_lsb] + 1); /// burst length
      wacount <= wacount - 1;
      wr_fifo_rd_ptr <= wr_fifo_rd_ptr + 1;
      wr_bresp_cnt   <= wr_bresp_cnt+1;
    end
  end
  1'b1 : begin
    wr_int_state <= 0;
  end
  endcase
 end
 end
  /*--------------------------------------------------------------------------------*/
/*-------------------------------- WRITE HANDSHAKE END ----------------------------------------*/
 
/*-------------------------------- READ HANDSHAKE ---------------------------------------------*/

/* READ CHANNELS */
/* Store the arvalid receive time --- necessary for calculating latency in sending the rresp latency */
  reg [7:0] ar_time_cnt = 0,rresp_time_cnt = 0;
  real arvalid_receive_time[0:max_outstanding_transactions]; // store the time when a new arvalid is received
  reg arvalid_flag[0:max_outstanding_transactions]; // store the time when a new arvalid is received
  reg [int_cntr_width-1:0] ar_cnt = 0;// counter for arvalid info

/* various FIFOs for storing the ADDR channel info */
  reg [axi_size_width-1:0]  arsize [0:max_outstanding_transactions-1];
  reg [axi_prot_width-1:0]  arprot [0:max_outstanding_transactions-1];
  reg [axi_brst_type_width-1:0]  arbrst [0:max_outstanding_transactions-1];
  reg [axi_len_width-1:0]  arlen [0:max_outstanding_transactions-1];
  reg [axi_cache_width-1:0]  arcache [0:max_outstanding_transactions-1];
  reg [axi_lock_width-1:0]  arlock [0:max_outstanding_transactions-1];
  reg ar_flag [0:max_outstanding_transactions-1];
  reg [addr_width-1:0] araddr [0:max_outstanding_transactions-1];
  reg [id_bus_width-1:0]  arid [0:max_outstanding_transactions-1];
  reg [axi_qos_width-1:0]  arqos [0:max_outstanding_transactions-1];
  wire ar_fifo_full; // indicates arvalid_fifo is full (max outstanding transactions reached)

  reg [int_cntr_width-1:0] wr_rresp_cnt = 0;
  reg [axi_rsp_width-1:0] rresp;
  reg [rsp_fifo_bits-1:0] fifo_rresp [0:max_outstanding_transactions-1]; // store the ID and its corresponding response
  reg enable_write_rresp;

  /* Send Read Response & Data Channel handshake */
  integer rd_latency_count;
  reg  rd_delayed;

  reg [rd_afi_fifo_bits-1:0] read_fifo[0:max_outstanding_transactions-1]; /// Read Burst Data, addr, size, burst, len, RID, RRESP, valid_bytes
  reg [int_cntr_width-1:0] rd_fifo_wr_ptr = 0, rd_fifo_rd_ptr = 0;
  wire read_fifo_full; 

  reg [7:0] rcount;
  reg [2:0] racount;
  
  wire rd_intr_fifo_full, rd_intr_fifo_empty;
  wire read_fifo_empty;

  /* signals to communicate with interconnect RD_FIFO model */
  reg rd_req, invalid_rd_req;
  
  /* REad control Info 
    56:25 : Address (32)
    24:22 : Size (3)
    21:20 : BRST (2)
    19:16 : LEN (4)
    15:10 : RID (6)
    9:8 : RRSP (2)
    7:0 : byte cnt (8)
  */
  reg [rd_info_bits-1:0] read_control_info;   
  reg [(data_bus_width*axi_burst_len)-1:0] aligned_rd_data;
  reg temp_rd_intr_fifo_empty;

  processing_system7_bfm_v2_0_intr_rd_mem rd_intr_fifo(SW_CLK, S_RESETN, rd_intr_fifo_full, rd_intr_fifo_empty, rd_req, invalid_rd_req, read_control_info , RD_DATA_OCM, RD_DATA_DDR, RD_DATA_VALID_OCM, RD_DATA_VALID_DDR);

  assign read_fifo_empty = (rd_fifo_wr_ptr === rd_fifo_rd_ptr)?1'b1: 1'b0;
  assign S_RCOUNT = rcount;
  assign S_RACOUNT = racount;

  /* Register the asynch signal empty coming from Interconnect READ FIFO */
  always@(posedge S_ACLK) temp_rd_intr_fifo_empty = rd_intr_fifo_empty;
   
  // FIFO_STATUS (only if AFI port) 1- full 
   function automatic rdfifo_full ;
   input [axi_len_width-1:0] fifo_space_exp;
   integer fifo_space_left; 
   begin
     fifo_space_left = afi_fifo_locations - rcount;
     if(fifo_space_left < fifo_space_exp) 
       rdfifo_full = 1;
     else
       rdfifo_full = 0;
   end
   endfunction

  /* Store the arvalid receive time --- necessary for calculating the bresp latency */
  always@(negedge S_RESETN or S_ARID or S_ARADDR or S_ARVALID )
  begin
  if(!S_RESETN)
   ar_time_cnt <= 0;
  else begin
   if(S_ARVALID) begin
     arvalid_receive_time[ar_time_cnt] <= $time;
     arvalid_flag[ar_time_cnt] <= 1'b1;
     ar_time_cnt <= ar_time_cnt + 1;
   end 
  end // else
  end /// always
  /*--------------------------------------------------------------------------------*/
  always@(posedge S_ACLK)
  begin
  if(net_ARVALID && S_ARREADY) begin
    if(S_ARQOS === 0) arqos[aw_cnt[int_cntr_width-2:0]] = ar_qos; 
    else arqos[aw_cnt[int_cntr_width-2:0]] = S_ARQOS; 
  end
  end

  /* Address Read  Channel handshake*/
  always@(negedge S_RESETN or posedge S_ACLK)
  begin
  if(!S_RESETN) begin
    ar_cnt <= 0;
    racount <= 0;
  end else begin
    if(S_ARVALID && !rdfifo_full(S_ARLEN+1)) begin /// if AFI read fifo is not full
      `ifdef USE_AXI_BFM_CORE
        slave.RECEIVE_READ_ADDRESS(0,
                                   id_invalid,
                                   araddr[ar_cnt[int_cntr_width-2:0]],
                                   arlen[ar_cnt[int_cntr_width-2:0]],
                                   arsize[ar_cnt[int_cntr_width-2:0]],
                                   arbrst[ar_cnt[int_cntr_width-2:0]],
                                   arlock[ar_cnt[int_cntr_width-2:0]],
                                   arcache[ar_cnt[int_cntr_width-2:0]],
                                   arprot[ar_cnt[int_cntr_width-2:0]],
                                   arid[ar_cnt[int_cntr_width-2:0]]); /// sampled valid ID.
      `else
        #1;
        if(id_invalid || (0 == S_ARID)) begin
            S_ARREADY        = 1'b1   ;
          @(posedge S_ACLK);
            #1;
            araddr[ar_cnt[int_cntr_width-2:0]]  = S_ARADDR ;
            arlen[ar_cnt[int_cntr_width-2:0]]   = S_ARLEN  ;
            arsize[ar_cnt[int_cntr_width-2:0]]  = S_ARSIZE ;
            arbrst[ar_cnt[int_cntr_width-2:0]]  = S_ARBURST;
            arlock[ar_cnt[int_cntr_width-2:0]]  = S_ARLOCK ;
            arcache[ar_cnt[int_cntr_width-2:0]] = S_ARCACHE;
            arprot[ar_cnt[int_cntr_width-2:0]]  = S_ARPROT ;
            arid[ar_cnt[int_cntr_width-2:0]]    = S_ARID   ;
            S_ARREADY        = 1'b0   ;
        end
      `endif //USE_AXI_BFM_CORE
        ar_flag[ar_cnt[int_cntr_width-2:0]] <= 1'b1;
        ar_cnt    <= ar_cnt+1;
        racount   <= racount + 1;
    end /// if(!ar_fifo_full)
  end /// if else
  end /// always*/
  
  /*--------------------------------------------------------------------------------*/

  /* Align Wrap data for read transaction*/
  task automatic get_wrap_aligned_rd_data;
  output [(data_bus_width*axi_burst_len)-1:0] aligned_data;
  input [addr_width-1:0] addr;
  input [(data_bus_width*axi_burst_len)-1:0] b_data;
  input [max_burst_bytes_width:0] v_bytes;
  reg [addr_width-1:0] start_addr;
  reg [(data_bus_width*axi_burst_len)-1:0] temp_data, wrp_data;
  integer wrp_bytes;
  integer i;
  begin
    start_addr = (addr/v_bytes) * v_bytes;
    wrp_bytes = addr - start_addr;
    wrp_data  = b_data;
    temp_data = 0;
    while(wrp_bytes > 0) begin /// get the data that is wrapped
     temp_data = temp_data >> 8;
     temp_data[(data_bus_width*axi_burst_len)-1 : (data_bus_width*axi_burst_len)-8] = wrp_data[7:0];
     wrp_data = wrp_data >> 8;
     wrp_bytes = wrp_bytes - 1;
    end
    temp_data = temp_data >> ((data_bus_width*axi_burst_len) - (v_bytes*8));
    wrp_bytes = addr - start_addr;
    wrp_data = b_data >> (wrp_bytes*8);
    
    aligned_data = (temp_data | wrp_data);
  end
  endtask
  /*--------------------------------------------------------------------------------*/

  parameter RD_DATA_REQ = 1'b0, WAIT_RD_VALID = 1'b1;
  reg rd_fifo_state; 
  reg [addr_width-1:0] temp_read_address;
  reg [max_burst_bytes_width:0] temp_rd_valid_bytes;
  /* get the data from memory && also calculate the rresp*/
  always@(negedge S_RESETN or posedge SW_CLK)
  begin
  if(!S_RESETN)begin
   wr_rresp_cnt <=0;
   rd_fifo_state <= RD_DATA_REQ;
   temp_rd_valid_bytes = 0;
   temp_read_address <= 0;
   RD_REQ_DDR <= 1'b0;
   RD_REQ_OCM <= 1'b0;
   rd_req        <= 0;
   invalid_rd_req<= 0;
   RD_QOS  <= 0;
  end else begin
   case(rd_fifo_state)
   RD_DATA_REQ : begin
     rd_fifo_state <= RD_DATA_REQ;
     RD_REQ_DDR <= 1'b0;
     RD_REQ_OCM <= 1'b0;
     invalid_rd_req <= 0;
     if(ar_flag[wr_rresp_cnt[int_cntr_width-2:0]] && !rd_intr_fifo_full) begin /// check the rd_fifo_bytes, interconnect fifo full condition
       ar_flag[wr_rresp_cnt[int_cntr_width-2:0]] <= 0;
       rresp = calculate_resp(araddr[wr_rresp_cnt[int_cntr_width-2:0]],arprot[wr_rresp_cnt[int_cntr_width-2:0]]);
       temp_rd_valid_bytes = (arlen[wr_rresp_cnt[int_cntr_width-2:0]]+1)*(2**arsize[wr_rresp_cnt[int_cntr_width-2:0]]);//data_bus_width/8;

       if(arbrst[wr_rresp_cnt[int_cntr_width-2:0]] === AXI_WRAP) /// wrap begin
        temp_read_address = (araddr[wr_rresp_cnt[int_cntr_width-2:0]]/temp_rd_valid_bytes) * temp_rd_valid_bytes;
       else 
        temp_read_address = araddr[wr_rresp_cnt[int_cntr_width-2:0]];
       
       if(rresp === AXI_OK) begin 
         case(decode_address(temp_read_address))//decode_address(araddr[wr_rresp_cnt[int_cntr_width-2:0]]);
          OCM_MEM : RD_REQ_OCM <= 1;
          DDR_MEM : RD_REQ_DDR <= 1;
          default : invalid_rd_req <= 1;
         endcase
       end else
         invalid_rd_req <= 1;
       RD_ADDR    <= temp_read_address; ///araddr[wr_rresp_cnt[int_cntr_width-2:0]];
       RD_BYTES   <= temp_rd_valid_bytes;
       RD_QOS     <= arqos[wr_rresp_cnt[int_cntr_width-2:0]];
       rd_fifo_state <= WAIT_RD_VALID; 
       rd_req     <= 1;
       racount    <= racount - 1;
       read_control_info <= {araddr[wr_rresp_cnt[int_cntr_width-2:0]], arsize[wr_rresp_cnt[int_cntr_width-2:0]], arbrst[wr_rresp_cnt[int_cntr_width-2:0]], arlen[wr_rresp_cnt[int_cntr_width-2:0]], arid[wr_rresp_cnt[int_cntr_width-2:0]], rresp, temp_rd_valid_bytes  };
       wr_rresp_cnt <= wr_rresp_cnt + 1;
     end
   end
   WAIT_RD_VALID : begin    
     rd_fifo_state <= WAIT_RD_VALID;  
     rd_req        <= 0;
     if(RD_DATA_VALID_OCM | RD_DATA_VALID_DDR | invalid_rd_req) begin ///temp_dec == 2'b11) begin
       RD_REQ_DDR <= 1'b0;
       RD_REQ_OCM <= 1'b0;
       invalid_rd_req <= 0;
       rd_fifo_state <= RD_DATA_REQ;
     end
   end
   endcase
  end /// else
  end /// always
  /*--------------------------------------------------------------------------------*/
  
  /* thread to fill in the AFI RD_FIFO */
  reg[rd_afi_fifo_bits-1:0] temp_rd_data;//Read Burst Data, addr, size, burst, len, RID, RRESP, valid bytes
  reg tmp_state; 
  always@(negedge S_RESETN or posedge S_ACLK)
  begin
  if(!S_RESETN)begin
   rd_fifo_wr_ptr <= 0; 
   rcount <= 0;
   tmp_state <= 0;
  end else begin
   case(tmp_state)
   0 : begin 
       tmp_state <= 0;
       if(!temp_rd_intr_fifo_empty) begin
         rd_intr_fifo.read_mem(temp_rd_data);
         tmp_state <= 1;
       end
      end
   1 : begin  
       tmp_state <= 1;
       if(!rdfifo_full(temp_rd_data[rd_afi_ln_msb:rd_afi_ln_lsb]+1)) begin
        read_fifo[rd_fifo_wr_ptr[int_cntr_width-2:0]] = temp_rd_data;
        rd_fifo_wr_ptr = rd_fifo_wr_ptr + 1;
        rcount <= rcount + temp_rd_data[rd_afi_ln_msb:rd_afi_ln_lsb]+1; /// Burst length
        tmp_state <= 0;
       end
      end
    endcase
  end
  end
  /*--------------------------------------------------------------------------------*/
  
  reg[max_burst_bytes_width:0] rd_v_b;
  reg[rd_afi_fifo_bits-1:0] tmp_fifo_rd;  /// Data, addr, size, burst, len, RID, RRESP,valid_bytes
  reg[(data_bus_width*axi_burst_len)-1:0] temp_read_data;
  reg[(axi_rsp_width*axi_burst_len)-1:0] temp_read_rsp;

  /* Read Data Channel handshake */
  always@(negedge S_RESETN or posedge S_ACLK)
  begin
  if(!S_RESETN)begin
   rd_fifo_rd_ptr <= 0;
   rd_latency_count <= get_rd_lat_number(1);
   rd_delayed = 0;
   rresp_time_cnt <= 0;
   rd_v_b = 0;
  end else begin
     if(arvalid_flag[rresp_time_cnt] && ((($time - arvalid_receive_time[rresp_time_cnt])/s_aclk_period) >= rd_latency_count)) begin
       rd_delayed = 1;
     end
     if(!read_fifo_empty && rd_delayed)begin
       rd_delayed = 0;  
       arvalid_flag[rresp_time_cnt] = 1'b0;
       tmp_fifo_rd =  read_fifo[rd_fifo_rd_ptr[int_cntr_width-2:0]];
       rd_v_b      = (tmp_fifo_rd[rd_afi_ln_msb : rd_afi_ln_lsb]+1)*(2**tmp_fifo_rd[rd_afi_siz_msb : rd_afi_siz_lsb]);
       temp_read_data =  tmp_fifo_rd[rd_afi_data_msb : rd_afi_data_lsb];
       if(tmp_fifo_rd[rd_afi_brst_msb : rd_afi_brst_lsb] === AXI_WRAP) begin
          get_wrap_aligned_rd_data(aligned_rd_data, tmp_fifo_rd[rd_afi_addr_msb : rd_afi_addr_lsb], tmp_fifo_rd[rd_afi_data_msb : rd_afi_data_lsb], rd_v_b);
          temp_read_data = aligned_rd_data;
       end
       temp_read_rsp = 0;
       repeat(axi_burst_len) begin
         temp_read_rsp = temp_read_rsp >> axi_rsp_width;
         temp_read_rsp[(axi_rsp_width*axi_burst_len)-1:(axi_rsp_width*axi_burst_len)-axi_rsp_width] = tmp_fifo_rd[rd_afi_rsp_msb : rd_afi_rsp_lsb];
       end 
     `ifdef USE_AXI_BFM_CORE
       slave.SEND_READ_BURST_RESP_CTRL(tmp_fifo_rd[rd_afi_id_msb : rd_afi_id_lsb],
                                       tmp_fifo_rd[rd_afi_addr_msb : rd_afi_addr_lsb], 
                                       tmp_fifo_rd[rd_afi_ln_msb : rd_afi_ln_lsb], 
                                       tmp_fifo_rd[rd_afi_siz_msb : rd_afi_siz_lsb],
                                       tmp_fifo_rd[rd_afi_brst_msb : rd_afi_brst_lsb], 
                                       temp_read_data,
                                       temp_read_rsp);   
     `else
       begin
        #1;
        for(temp_read_burst_i=0; temp_read_burst_i<=tmp_fifo_rd[rd_afi_ln_msb : rd_afi_ln_lsb]; ) begin
            S_RVALID = 1'b1;
            if(temp_read_burst_i == tmp_fifo_rd[rd_afi_ln_msb : rd_afi_ln_lsb]) begin
                S_RLAST = 1'b1;
            end else begin
                S_RLAST = 1'b0;
            end
            S_RID   = tmp_fifo_rd[rd_afi_id_msb : rd_afi_id_lsb];
            S_RRESP = temp_read_rsp [axi_rsp_width *temp_read_burst_i +: axi_rsp_width ];
            S_RDATA = temp_read_data[data_bus_width*temp_read_burst_i +: data_bus_width];
            @(posedge S_ACLK);
            #1;
            if(S_RREADY && S_RVALID) begin
                temp_read_burst_i = temp_read_burst_i+1;
            end
        end
        S_RLAST  = 1'b0;
        S_RVALID = 1'b0;
      end
     `endif //USE_AXI_BFM_CORE
       rcount <= rcount -  (tmp_fifo_rd[rd_afi_ln_msb : rd_afi_ln_lsb]+ 1) ;
       rresp_time_cnt <= rresp_time_cnt+1;
       rd_latency_count <= get_rd_lat_number(1);
       rd_fifo_rd_ptr <= rd_fifo_rd_ptr+1;
     end
  end /// else
  end /// always
endmodule
