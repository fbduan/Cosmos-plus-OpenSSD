`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/02 22:39:41
// Design Name: 
// Module Name: tb_phy
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`ifdef ORIGINAL_CDN_AXI3_MASTER_BFM
`elsif VIP_AXI3_MASTER_BFM
    import axi_vip_pkg::*;
    import vip_axi3_slave_bfm_pkg::*;
    import vip_axi3_master_bfm_pkg::*;
`else  //undef ORIGINAL_CDN_AXI3_MASTER_BFM
`endif //endif ORIGINAL_CDN_AXI3_MASTER_BFM

module tb_OpenSSD2_Top(/*autoarg*/);


glbl glbl();

`ifdef ORIGINAL_CDN_AXI3_MASTER_BFM
`elsif VIP_AXI3_MASTER_BFM
    vip_axi3_slave_bfm_slv_t s_axi_gp0_agent;
    vip_axi3_slave_bfm_slv_t s_axi_gp1_agent;
    vip_axi3_slave_bfm_slv_t s_axi_acp_agent;
    vip_axi3_slave_bfm_slv_t s_axi_hp0_agent;
    vip_axi3_slave_bfm_slv_t s_axi_hp1_agent;
    vip_axi3_slave_bfm_slv_t s_axi_hp2_agent;
    vip_axi3_slave_bfm_slv_t s_axi_hp3_agent;
    
    vip_axi3_master_bfm_mst_t m_axi_gp0_agent;
    vip_axi3_master_bfm_mst_t m_axi_gp1_agent;
    
    initial begin
        s_axi_gp0_agent = new("S_AXI_GP0_slave_vip", tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_GP0.slave.inst.IF);
        s_axi_gp1_agent = new("S_AXI_GP1_slave_vip", tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_GP1.slave.inst.IF);
        s_axi_acp_agent = new("S_AXI_ACP_slave_vip", tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_ACP.slave.inst.IF);
        s_axi_hp0_agent = new("S_AXI_HP0_slave_vip", tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.slave.inst.IF);
        s_axi_hp1_agent = new("S_AXI_HP1_slave_vip", tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP1.slave.inst.IF);
        s_axi_hp2_agent = new("S_AXI_HP2_slave_vip", tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP2.slave.inst.IF);
        s_axi_hp3_agent = new("S_AXI_HP3_slave_vip", tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP3.slave.inst.IF);
        
        m_axi_gp0_agent = new("M_AXI_GP0_master_vip",tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.M_AXI_GP0.slave.inst.IF);
        m_axi_gp1_agent = new("M_AXI_GP1_master_vip",tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.M_AXI_GP1.slave.inst.IF);
    
        s_axi_gp0_agent.set_agent_tag("S_AXI_GP0_slave_vip" );
        s_axi_gp1_agent.set_agent_tag("S_AXI_GP1_slave_vip" );
        s_axi_acp_agent.set_agent_tag("S_AXI_ACP_slave_vip" );
        s_axi_hp0_agent.set_agent_tag("S_AXI_HP0_slave_vip" );
        s_axi_hp1_agent.set_agent_tag("S_AXI_HP1_slave_vip" );
        s_axi_hp2_agent.set_agent_tag("S_AXI_HP2_slave_vip" );
        s_axi_hp3_agent.set_agent_tag("S_AXI_HP3_slave_vip" );
        m_axi_gp0_agent.set_agent_tag("M_AXI_GP0_master_vip");
        m_axi_gp1_agent.set_agent_tag("M_AXI_GP1_master_vip");
    
        s_axi_gp0_agent.set_verbosity( 0 );
        s_axi_gp1_agent.set_verbosity( 0 );
        s_axi_acp_agent.set_verbosity( 0 );
        s_axi_hp0_agent.set_verbosity( 0 );
        s_axi_hp1_agent.set_verbosity( 0 );
        s_axi_hp2_agent.set_verbosity( 0 );
        s_axi_hp3_agent.set_verbosity( 0 );
        m_axi_gp0_agent.set_verbosity( 0 );
        m_axi_gp1_agent.set_verbosity( 0 );
    
        s_axi_gp0_agent.start_slave();
        s_axi_gp1_agent.start_slave();
        s_axi_acp_agent.start_slave();
        s_axi_hp0_agent.start_slave();
        s_axi_hp1_agent.start_slave();
        s_axi_hp2_agent.start_slave();
        s_axi_hp3_agent.start_slave();
        m_axi_gp0_agent.start_master();
        m_axi_gp1_agent.start_master();
    end
`else  //undef ORIGINAL_CDN_AXI3_MASTER_BFM
`endif //endif ORIGINAL_CDN_AXI3_MASTER_BFM


initial begin
    string fsdb_name = "tb_openssd2_top.fsdb";
    $fsdbDumpfile(fsdb_name);
    $fsdbDumpvars(0, tb_OpenSSD2_Top);
    $fsdbDumpSVA();
    $fsdbDumpMDA(0, tb_OpenSSD2_Top);
end

/*autodefine*/
//auto wires{{{
wire [14:0]   DDR_addr;
wire [2:0]    DDR_ba;
wire          DDR_cas_n;
wire          DDR_ck_n;
wire          DDR_ck_p;
wire          DDR_cke;
wire          DDR_cs_n;
wire [3:0]    DDR_dm;
wire [31:0]   DDR_dq;
wire [3:0]    DDR_dqs_n;
wire [3:0]    DDR_dqs_p;
wire          DDR_odt;
wire          DDR_ras_n;
wire          DDR_reset_n;
wire          DDR_we_n;
wire          FIXED_IO_ddr_vrn;
wire          FIXED_IO_ddr_vrp;
wire [53:0]   FIXED_IO_mio;
wire          FIXED_IO_ps_clk;
wire          FIXED_IO_ps_porb;
wire          FIXED_IO_ps_srstb;
wire [7:0]    IO_NAND_CH0_DQ;
wire          IO_NAND_CH0_DQS_N;
wire          IO_NAND_CH0_DQS_P;
wire [7:0]    IO_NAND_CH1_DQ;
wire          IO_NAND_CH1_DQS_N;
wire          IO_NAND_CH1_DQS_P;
wire [7:0]    I_NAND_CH0_RB;
wire [7:0]    I_NAND_CH1_RB;
wire [31:0]   O_DEBUG;
wire          O_NAND_CH0_ALE;
wire [7:0]    O_NAND_CH0_CE;
wire          O_NAND_CH0_CLE;
wire          O_NAND_CH0_RE_N;
wire          O_NAND_CH0_RE_P;
wire          O_NAND_CH0_WE;
wire          O_NAND_CH0_WP;
wire          O_NAND_CH1_ALE;
wire [7:0]    O_NAND_CH1_CE;
wire          O_NAND_CH1_CLE;
wire          O_NAND_CH1_RE_N;
wire          O_NAND_CH1_RE_P;
wire          O_NAND_CH1_WE;
wire          O_NAND_CH1_WP;
wire          pcie_perst_n;
wire          pcie_ref_clk_n;
wire          pcie_ref_clk_p;
wire [7:0]    pcie_rx_n;
wire [7:0]    pcie_rx_p;
wire          ps_m_axi_gp0_aclk;
wire [31:0]   ps_m_axi_gp0_araddr;
wire [1:0]    ps_m_axi_gp0_arburst;
wire [3:0]    ps_m_axi_gp0_arcache;
wire          ps_m_axi_gp0_aresetn;
wire [11:0]   ps_m_axi_gp0_arid;
wire [3:0]    ps_m_axi_gp0_arlen;
wire [1:0]    ps_m_axi_gp0_arlock;
wire [2:0]    ps_m_axi_gp0_arprot;
wire [3:0]    ps_m_axi_gp0_arqos;
wire          ps_m_axi_gp0_arready;
wire [2:0]    ps_m_axi_gp0_arsize;
wire          ps_m_axi_gp0_arvalid;
wire [31:0]   ps_m_axi_gp0_awaddr;
wire [1:0]    ps_m_axi_gp0_awburst;
wire [3:0]    ps_m_axi_gp0_awcache;
wire [11:0]   ps_m_axi_gp0_awid;
wire [3:0]    ps_m_axi_gp0_awlen;
wire [1:0]    ps_m_axi_gp0_awlock;
wire [2:0]    ps_m_axi_gp0_awprot;
wire [3:0]    ps_m_axi_gp0_awqos;
wire          ps_m_axi_gp0_awready;
wire [2:0]    ps_m_axi_gp0_awsize;
wire          ps_m_axi_gp0_awvalid;
wire [11:0]   ps_m_axi_gp0_bid;
wire          ps_m_axi_gp0_bready;
wire [1:0]    ps_m_axi_gp0_bresp;
wire          ps_m_axi_gp0_bvalid;
wire [31:0]   ps_m_axi_gp0_rdata;
wire [11:0]   ps_m_axi_gp0_rid;
wire          ps_m_axi_gp0_rlast;
wire          ps_m_axi_gp0_rready;
wire [1:0]    ps_m_axi_gp0_rresp;
wire          ps_m_axi_gp0_rvalid;
wire [31:0]   ps_m_axi_gp0_wdata;
wire [11:0]   ps_m_axi_gp0_wid;
wire          ps_m_axi_gp0_wlast;
wire          ps_m_axi_gp0_wready;
wire [3:0]    ps_m_axi_gp0_wstrb;
wire          ps_m_axi_gp0_wvalid;
wire          ps_s_axi_hp0_aclk;
wire [31:0]   ps_s_axi_hp0_araddr;
wire [1:0]    ps_s_axi_hp0_arburst;
wire [3:0]    ps_s_axi_hp0_arcache;
wire          ps_s_axi_hp0_aresetn;
wire [11:0]   ps_s_axi_hp0_arid;
wire [3:0]    ps_s_axi_hp0_arlen;
wire [1:0]    ps_s_axi_hp0_arlock;
wire [2:0]    ps_s_axi_hp0_arprot;
wire [3:0]    ps_s_axi_hp0_arqos;
wire          ps_s_axi_hp0_arready;
wire [2:0]    ps_s_axi_hp0_arsize;
wire          ps_s_axi_hp0_arvalid;
wire [31:0]   ps_s_axi_hp0_awaddr;
wire [1:0]    ps_s_axi_hp0_awburst;
wire [3:0]    ps_s_axi_hp0_awcache;
wire [11:0]   ps_s_axi_hp0_awid;
wire [3:0]    ps_s_axi_hp0_awlen;
wire [1:0]    ps_s_axi_hp0_awlock;
wire [2:0]    ps_s_axi_hp0_awprot;
wire [3:0]    ps_s_axi_hp0_awqos;
wire          ps_s_axi_hp0_awready;
wire [2:0]    ps_s_axi_hp0_awsize;
wire          ps_s_axi_hp0_awvalid;
wire [11:0]   ps_s_axi_hp0_bid;
wire          ps_s_axi_hp0_bready;
wire [1:0]    ps_s_axi_hp0_bresp;
wire          ps_s_axi_hp0_bvalid;
wire [31:0]   ps_s_axi_hp0_rdata;
wire [11:0]   ps_s_axi_hp0_rid;
wire          ps_s_axi_hp0_rlast;
wire          ps_s_axi_hp0_rready;
wire [1:0]    ps_s_axi_hp0_rresp;
wire          ps_s_axi_hp0_rvalid;
wire [31:0]   ps_s_axi_hp0_wdata;
wire [11:0]   ps_s_axi_hp0_wid;
wire          ps_s_axi_hp0_wlast;
wire          ps_s_axi_hp0_wready;
wire [3:0]    ps_s_axi_hp0_wstrb;
wire          ps_s_axi_hp0_wvalid;
//}}}
//auto regs{{{
reg           fsdb_name;
reg           m_axi_gp0_agent;
reg           m_axi_gp1_agent;
reg           s_axi_acp_agent;
reg           s_axi_gp0_agent;
reg           s_axi_gp1_agent;
reg           s_axi_hp0_agent;
reg           s_axi_hp1_agent;
reg           s_axi_hp2_agent;
reg           s_axi_hp3_agent;
reg           tb_ps_clk;
reg           tb_ps_porb;
reg           tb_ps_srstb;
//}}}
// End of automatic define

// 100 MHz
initial begin
    tb_ps_clk   = 1'b0;
    forever begin
        #20;
        tb_ps_clk = ~tb_ps_clk;
    end
end
////always@* #10 tb_ps_clk = ~tb_ps_clk;

initial begin
    tb_ps_porb  = 1'b1;
    tb_ps_srstb = 1'b1;

    @(tb_ps_clk);
    #13;

    tb_ps_porb  = 1'b0;
    tb_ps_srstb = 1'b0;
    repeat(1000) @(tb_ps_clk);
    #12;
    tb_ps_porb  = 1'b1;
    tb_ps_srstb = 1'b1;
end

assign FIXED_IO_ps_clk   = tb_ps_clk  ;
assign FIXED_IO_ps_porb  = tb_ps_porb ;
assign FIXED_IO_ps_srstb = tb_ps_srstb;

assign pcie_perst_n   = 1'b0;
assign pcie_ref_clk_n = 1'b1;
assign pcie_ref_clk_p = 1'b0;
assign pcie_rx_n[7:0] = 8'hFF;
assign pcie_rx_p[7:0] = 8'h00;

OpenSSD2_wrapper u_OpenSSD2_wrapper_0( /*AUTOINST*/
        .DDR_addr          ( DDR_addr[14:0]      ),    //IO [14:0] u_OpenSSD2_wrapper_0
        .DDR_ba            ( DDR_ba[2:0]         ),    //IO [2:0]  u_OpenSSD2_wrapper_0
        .DDR_cas_n         ( DDR_cas_n           ),    //IO        u_OpenSSD2_wrapper_0
        .DDR_ck_n          ( DDR_ck_n            ),    //IO        u_OpenSSD2_wrapper_0
        .DDR_ck_p          ( DDR_ck_p            ),    //IO        u_OpenSSD2_wrapper_0
        .DDR_cke           ( DDR_cke             ),    //IO        u_OpenSSD2_wrapper_0
        .DDR_cs_n          ( DDR_cs_n            ),    //IO        u_OpenSSD2_wrapper_0
        .DDR_dm            ( DDR_dm[3:0]         ),    //IO [3:0]  u_OpenSSD2_wrapper_0
        .DDR_dq            ( DDR_dq[31:0]        ),    //IO [31:0] u_OpenSSD2_wrapper_0
        .DDR_dqs_n         ( DDR_dqs_n[3:0]      ),    //IO [3:0]  u_OpenSSD2_wrapper_0
        .DDR_dqs_p         ( DDR_dqs_p[3:0]      ),    //IO [3:0]  u_OpenSSD2_wrapper_0
        .DDR_odt           ( DDR_odt             ),    //IO        u_OpenSSD2_wrapper_0
        .DDR_ras_n         ( DDR_ras_n           ),    //IO        u_OpenSSD2_wrapper_0
        .DDR_reset_n       ( DDR_reset_n         ),    //IO        u_OpenSSD2_wrapper_0
        .DDR_we_n          ( DDR_we_n            ),    //IO        u_OpenSSD2_wrapper_0
        .FIXED_IO_ddr_vrn  ( FIXED_IO_ddr_vrn    ),    //IO        u_OpenSSD2_wrapper_0   nouse
        .FIXED_IO_ddr_vrp  ( FIXED_IO_ddr_vrp    ),    //IO        u_OpenSSD2_wrapper_0   nouse
        .FIXED_IO_mio      ( FIXED_IO_mio[53:0]  ),    //IO [53:0] u_OpenSSD2_wrapper_0   nouse
        .FIXED_IO_ps_clk   ( FIXED_IO_ps_clk     ),    //IO        u_OpenSSD2_wrapper_0   TODO:
        .FIXED_IO_ps_porb  ( FIXED_IO_ps_porb    ),    //IO        u_OpenSSD2_wrapper_0   TODO:
        .FIXED_IO_ps_srstb ( FIXED_IO_ps_srstb   ),    //IO        u_OpenSSD2_wrapper_0   TODO:
        .IO_NAND_CH0_DQ    ( IO_NAND_CH0_DQ[7:0] ),    //IO [7:0]  u_OpenSSD2_wrapper_0
        .IO_NAND_CH0_DQS_N ( IO_NAND_CH0_DQS_N   ),    //IO        u_OpenSSD2_wrapper_0
        .IO_NAND_CH0_DQS_P ( IO_NAND_CH0_DQS_P   ),    //IO        u_OpenSSD2_wrapper_0
        .IO_NAND_CH1_DQ    ( IO_NAND_CH1_DQ[7:0] ),    //IO [7:0]  u_OpenSSD2_wrapper_0
        .IO_NAND_CH1_DQS_N ( IO_NAND_CH1_DQS_N   ),    //IO        u_OpenSSD2_wrapper_0
        .IO_NAND_CH1_DQS_P ( IO_NAND_CH1_DQS_P   ),    //IO        u_OpenSSD2_wrapper_0
        .I_NAND_CH0_RB     ( I_NAND_CH0_RB[7:0]  ),    //I  [7:0]  u_OpenSSD2_wrapper_0
        .I_NAND_CH1_RB     ( I_NAND_CH1_RB[7:0]  ),    //I  [7:0]  u_OpenSSD2_wrapper_0
        .O_DEBUG           ( O_DEBUG[31:0]       ),    //O  [31:0] u_OpenSSD2_wrapper_0   nouse
        .O_NAND_CH0_ALE    ( O_NAND_CH0_ALE      ),    //O         u_OpenSSD2_wrapper_0
        .O_NAND_CH0_CE     ( O_NAND_CH0_CE[7:0]  ),    //O  [7:0]  u_OpenSSD2_wrapper_0
        .O_NAND_CH0_CLE    ( O_NAND_CH0_CLE      ),    //O         u_OpenSSD2_wrapper_0
        .O_NAND_CH0_RE_N   ( O_NAND_CH0_RE_N     ),    //O         u_OpenSSD2_wrapper_0
        .O_NAND_CH0_RE_P   ( O_NAND_CH0_RE_P     ),    //O         u_OpenSSD2_wrapper_0   nouse
        .O_NAND_CH0_WE     ( O_NAND_CH0_WE       ),    //O         u_OpenSSD2_wrapper_0
        .O_NAND_CH0_WP     ( O_NAND_CH0_WP       ),    //O         u_OpenSSD2_wrapper_0
        .O_NAND_CH1_ALE    ( O_NAND_CH1_ALE      ),    //O         u_OpenSSD2_wrapper_0
        .O_NAND_CH1_CE     ( O_NAND_CH1_CE[7:0]  ),    //O  [7:0]  u_OpenSSD2_wrapper_0
        .O_NAND_CH1_CLE    ( O_NAND_CH1_CLE      ),    //O         u_OpenSSD2_wrapper_0
        .O_NAND_CH1_RE_N   ( O_NAND_CH1_RE_N     ),    //O         u_OpenSSD2_wrapper_0
        .O_NAND_CH1_RE_P   ( O_NAND_CH1_RE_P     ),    //O         u_OpenSSD2_wrapper_0   nouse
        .O_NAND_CH1_WE     ( O_NAND_CH1_WE       ),    //O         u_OpenSSD2_wrapper_0
        .O_NAND_CH1_WP     ( O_NAND_CH1_WP       ),    //O         u_OpenSSD2_wrapper_0
        .pcie_perst_n      ( pcie_perst_n        ),    //I         u_OpenSSD2_wrapper_0   tie constant
        .pcie_ref_clk_n    ( pcie_ref_clk_n      ),    //I         u_OpenSSD2_wrapper_0   tie constant
        .pcie_ref_clk_p    ( pcie_ref_clk_p      ),    //I         u_OpenSSD2_wrapper_0   tie constant
        .pcie_rx_n         ( pcie_rx_n[7:0]      ),    //I  [7:0]  u_OpenSSD2_wrapper_0   tie constant
        .pcie_rx_p         ( pcie_rx_p[7:0]      ),    //I  [7:0]  u_OpenSSD2_wrapper_0   tie constant
        .pcie_tx_n         (                     ),    //O  [7:0]  u_OpenSSD2_wrapper_0   floating
        .pcie_tx_p         (                     )     //O  [7:0]  u_OpenSSD2_wrapper_0   floating
);

genvar gvar_i;
generate
    for(gvar_i=0; gvar_i<8; gvar_i=gvar_i+1) begin:NAND_CH0_WAY
        nand_model u_nand_ch0_way(
                .Dq_Io     ( IO_NAND_CH0_DQ[7:0]   ),    //IO [DQ_BITS-1:0] u_nand_ch0_way0
                .Dqs       ( IO_NAND_CH0_DQS_P     ),    //IO               u_nand_ch0_way0
                .Cle       ( O_NAND_CH0_CLE        ),    //I                u_nand_ch0_way0
                .Ale       ( O_NAND_CH0_ALE        ),    //I                u_nand_ch0_way0
                .Ce_n      ( O_NAND_CH0_CE[gvar_i] ),    //I                u_nand_ch0_way0
                .Clk_We_n  ( O_NAND_CH0_WE         ),    //I                u_nand_ch0_way0
                .Wr_Re_n   ( O_NAND_CH0_RE_N       ),    //I                u_nand_ch0_way0
                .Wp_n      ( O_NAND_CH0_WP         ),    //I                u_nand_ch0_way0
                .Rb_n      ( I_NAND_CH0_RB[gvar_i] )     //I                u_nand_ch0_way0
        );
    end
    for(gvar_i=0; gvar_i<8; gvar_i=gvar_i+1) begin:NAND_CH1_WAY
        nand_model u_nand_ch1_way(
                .Dq_Io     ( IO_NAND_CH1_DQ[7:0]   ),    //IO [DQ_BITS-1:0] u_nand_ch0_way0
                .Dqs       ( IO_NAND_CH1_DQS_P     ),    //IO               u_nand_ch0_way0
                .Cle       ( O_NAND_CH1_CLE        ),    //I                u_nand_ch0_way0
                .Ale       ( O_NAND_CH1_ALE        ),    //I                u_nand_ch0_way0
                .Ce_n      ( O_NAND_CH1_CE[gvar_i] ),    //I                u_nand_ch0_way0
                .Clk_We_n  ( O_NAND_CH1_WE         ),    //I                u_nand_ch0_way0
                .Wr_Re_n   ( O_NAND_CH1_RE_N       ),    //I                u_nand_ch0_way0
                .Wp_n      ( O_NAND_CH1_WP         ),    //I                u_nand_ch0_way0
                .Rb_n      ( I_NAND_CH1_RB[gvar_i] )     //I                u_nand_ch0_way0
        );
    end
endgenerate
assign IO_NAND_CH0_DQS_N = (IO_NAND_CH0_DQS_P === 1'b0) ? 1'b1 :
                           (IO_NAND_CH0_DQS_P === 1'b1) ? 1'b0 : IO_NAND_CH0_DQS_P;
assign IO_NAND_CH1_DQS_N = (IO_NAND_CH1_DQS_P === 1'b0) ? 1'b1 :
                           (IO_NAND_CH1_DQS_P === 1'b1) ? 1'b0 : IO_NAND_CH1_DQS_P;


ddr3 u_ddr3_upper( 
        .rst_n   ( DDR_reset_n              ),    //I                  u_ddr3    
        .ck      ( DDR_ck_p                 ),    //I                  u_ddr3    
        .ck_n    ( DDR_ck_n                 ),    //I                  u_ddr3    
        .cke     ( DDR_cke                  ),    //I                  u_ddr3    
        .cs_n    ( DDR_cs_n                 ),    //I                  u_ddr3    
        .ras_n   ( DDR_ras_n                ),    //I                  u_ddr3    
        .cas_n   ( DDR_cas_n                ),    //I                  u_ddr3    
        .we_n    ( DDR_we_n                 ),    //I                  u_ddr3    
        .dm_tdqs ( DDR_dm[3:2]              ),    //IO [DM_BITS-1:0]   u_ddr3    
        .ba      ( DDR_ba[2:0]              ),    //I  [BA_BITS-1:0]   u_ddr3    
        .addr    ( DDR_addr[14:0]           ),    //I  [ADDR_BITS-1:0] u_ddr3    
        .dq      ( DDR_dq[31:16]            ),    //IO [DQ_BITS-1:0]   u_ddr3    
        .dqs     ( DDR_dqs_p[3:2]           ),    //IO [DQS_BITS-1:0]  u_ddr3    
        .dqs_n   ( DDR_dqs_n[3:2]           ),    //IO [DQS_BITS-1:0]  u_ddr3    
        .tdqs_n  (                          ),    //O  [DQS_BITS-1:0]  u_ddr3    
        .odt     ( DDR_odt                  )     //I                  u_ddr3    
);

ddr3 u_ddr3_lower( 
        .rst_n   ( DDR_reset_n              ),    //I                  u_ddr3    
        .ck      ( DDR_ck_p                 ),    //I                  u_ddr3    
        .ck_n    ( DDR_ck_n                 ),    //I                  u_ddr3    
        .cke     ( DDR_cke                  ),    //I                  u_ddr3    
        .cs_n    ( DDR_cs_n                 ),    //I                  u_ddr3    
        .ras_n   ( DDR_ras_n                ),    //I                  u_ddr3    
        .cas_n   ( DDR_cas_n                ),    //I                  u_ddr3    
        .we_n    ( DDR_we_n                 ),    //I                  u_ddr3    
        .dm_tdqs ( DDR_dm[1:0]              ),    //IO [DM_BITS-1:0]   u_ddr3    
        .ba      ( DDR_ba[2:0]              ),    //I  [BA_BITS-1:0]   u_ddr3    
        .addr    ( DDR_addr[14:0]           ),    //I  [ADDR_BITS-1:0] u_ddr3    
        .dq      ( DDR_dq[15:0]             ),    //IO [DQ_BITS-1:0]   u_ddr3    
        .dqs     ( DDR_dqs_p[1:0]           ),    //IO [DQS_BITS-1:0]  u_ddr3    
        .dqs_n   ( DDR_dqs_n[1:0]           ),    //IO [DQS_BITS-1:0]  u_ddr3    
        .tdqs_n  (                          ),    //O  [DQS_BITS-1:0]  u_ddr3    
        .odt     ( DDR_odt                  )     //I                  u_ddr3    
);

assign ps_m_axi_gp0_aclk        = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_ACLK;
assign ps_m_axi_gp0_aresetn     = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_ARESETN[0:0];
assign ps_m_axi_gp0_awready     = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_awready   ;
assign ps_m_axi_gp0_wready      = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_wready    ;
assign ps_m_axi_gp0_bvalid      = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_bvalid    ;
assign ps_m_axi_gp0_bid[11:0]   = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_bid[11:0] ;
assign ps_m_axi_gp0_bresp[1:0]  = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_bresp[1:0];
assign ps_m_axi_gp0_arready     = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_arready   ;
assign ps_m_axi_gp0_rvalid      = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_rvalid    ;
assign ps_m_axi_gp0_rid[11:0]   = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_rid[11:0] ;
assign ps_m_axi_gp0_rdata[31:0] = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_rdata[31:0];
assign ps_m_axi_gp0_rlast       = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_rlast     ;
assign ps_m_axi_gp0_rresp[1:0]  = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_rresp[1:0];

initial begin
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_araddr[31:0]  = ps_m_axi_gp0_araddr[31:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_arburst[1:0]  = ps_m_axi_gp0_arburst[1:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_arcache[3:0]  = ps_m_axi_gp0_arcache[3:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_arid[11:0]    = ps_m_axi_gp0_arid[11:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_arlen[3:0]    = ps_m_axi_gp0_arlen[3:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_arlock[1:0]   = ps_m_axi_gp0_arlock[1:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_arprot[2:0]   = ps_m_axi_gp0_arprot[2:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_arqos[3:0]    = ps_m_axi_gp0_arqos[3:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_arsize[2:0]   = ps_m_axi_gp0_arsize[2:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_arvalid       = ps_m_axi_gp0_arvalid;
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_awaddr[31:0]  = ps_m_axi_gp0_awaddr[31:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_awburst[1:0]  = ps_m_axi_gp0_awburst[1:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_awcache[3:0]  = ps_m_axi_gp0_awcache[3:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_awid[11:0]    = ps_m_axi_gp0_awid[11:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_awlen[3:0]    = ps_m_axi_gp0_awlen[3:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_awlock[1:0]   = ps_m_axi_gp0_awlock[1:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_awprot[2:0]   = ps_m_axi_gp0_awprot[2:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_awqos[3:0]    = ps_m_axi_gp0_awqos[3:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_awsize[2:0]   = ps_m_axi_gp0_awsize[2:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_awvalid       = ps_m_axi_gp0_awvalid;
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_bready        = ps_m_axi_gp0_bready;
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_rready        = ps_m_axi_gp0_rready;
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_wdata[31:0]   = ps_m_axi_gp0_wdata[31:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_wid[11:0]     = ps_m_axi_gp0_wid[11:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_wlast         = ps_m_axi_gp0_wlast;
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_wstrb[3:0]    = ps_m_axi_gp0_wstrb[3:0];
    force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.GPIC0.S00_AXI_wvalid        = ps_m_axi_gp0_wvalid;
end

axi_master_bfm_core #(
        .VERBOSE            ( 1             ),
        .ERROR_RESP_FINISH  ( 1             ),

        .ADDR_WIDTH         ( 32            ),
        .DATA_WIDTH         ( 32            ),
        .ID_WIDTH           ( 5             ),
        .SIZE_WIDTH         ( 3             ),
        .QOS_WIDTH          ( 4             ),
        .MAX_CMDNUM         ( 16            ),
        .MAX_ID             ( 0             ),
        .MAX_BURSTLEN       ( 16            ),   // when change this you must change
        .WLOG_NAME          ( "axi_master_write.log"),
        .RLOG_NAME          ( "axi_master_read.log" ),
        .CFG_W_MAX_LATENCY  ( 200           ),  //ns
        .CFG_R_MAX_LATENCY  ( 200           ),  //ns
        .AXI_VERSION        ( 3             ) 
        ) u_psnf( /*AUTOINST*/
         .aclk    ( ps_m_axi_gp0_aclk                     )    //I                    u_psnf    
        ,.aresetn ( ps_m_axi_gp0_aresetn                  )    //I                    u_psnf    
        ,.awaddr  ( ps_m_axi_gp0_awaddr[31:0]             )    //O  [ADDR_WIDTH-1:0]  u_psnf    
        ,.awburst ( ps_m_axi_gp0_awburst[1:0]             )    //O  [BURST_WIDTH-1:0] u_psnf    
        ,.awid    ( ps_m_axi_gp0_awid[11:0]               )    //O  [ID_WIDTH-1:0]    u_psnf    
        ,.awlen   ( ps_m_axi_gp0_awlen[3:0]               )    //O  [LEN_WIDTH-1:0]   u_psnf    
        ,.awsize  ( ps_m_axi_gp0_awsize[2:0]              )    //O  [SIZE_WIDTH-1:0]  u_psnf    
        ,.awprot  ( ps_m_axi_gp0_awprot[2:0]              )    //O  [PROT_WIDTH-1:0]  u_psnf    
        ,.awcache ( ps_m_axi_gp0_awcache[3:0]             )    //O  [CACHE_WIDTH-1:0] u_psnf    
        ,.awlock  ( ps_m_axi_gp0_awlock[1:0]              )    //O  [LOCK_WIDTH-1:0]  u_psnf    
        ,.awqos   ( ps_m_axi_gp0_awqos[3:0]               )    //O  [QOS_WIDTH-1:0]   u_psnf    
        ,.awvalid ( ps_m_axi_gp0_awvalid                  )    //O                    u_psnf    
        ,.awready ( ps_m_axi_gp0_awready                  )    //I                    u_psnf    
        ,.wvalid  ( ps_m_axi_gp0_wvalid                   )    //O                    u_psnf    
        ,.wready  ( ps_m_axi_gp0_wready                   )    //I                    u_psnf    
        ,.wid     ( ps_m_axi_gp0_wid[11:0]                )    //O  [ID_WIDTH-1:0]    u_psnf    
        ,.wdata   ( ps_m_axi_gp0_wdata[31:0]              )    //O  [DATA_WIDTH-1:0]  u_psnf    
        ,.wstrb   ( ps_m_axi_gp0_wstrb[3:0]               )    //O  [STRB_WIDTH-1:0]  u_psnf    
        ,.wlast   ( ps_m_axi_gp0_wlast                    )    //O                    u_psnf    
        ,.bvalid  ( ps_m_axi_gp0_bvalid                   )    //I                    u_psnf    
        ,.bready  ( ps_m_axi_gp0_bready                   )    //O                    u_psnf    
        ,.bid     ( ps_m_axi_gp0_bid[11:0]                )    //I  [ID_WIDTH-1:0]    u_psnf    
        ,.bresp   ( ps_m_axi_gp0_bresp[1:0]               )    //I  [RESP_WIDTH-1:0]  u_psnf    
        ,.arvalid ( ps_m_axi_gp0_arvalid                  )    //O                    u_psnf    
        ,.arready ( ps_m_axi_gp0_arready                  )    //I                    u_psnf    
        ,.arid    ( ps_m_axi_gp0_arid[11:0]               )    //O  [ID_WIDTH-1:0]    u_psnf    
        ,.araddr  ( ps_m_axi_gp0_araddr[31:0]             )    //O  [ADDR_WIDTH-1:0]  u_psnf    
        ,.arburst ( ps_m_axi_gp0_arburst[1:0]             )    //O  [BURST_WIDTH-1:0] u_psnf    
        ,.arlen   ( ps_m_axi_gp0_arlen[3:0]               )    //O  [LEN_WIDTH-1:0]   u_psnf    
        ,.arsize  ( ps_m_axi_gp0_arsize[2:0]              )    //O  [SIZE_WIDTH-1:0]  u_psnf    
        ,.arprot  ( ps_m_axi_gp0_arprot[2:0]              )    //O  [PROT_WIDTH-1:0]  u_psnf    
        ,.arcache ( ps_m_axi_gp0_arcache[3:0]             )    //O  [CACHE_WIDTH-1:0] u_psnf    
        ,.arlock  ( ps_m_axi_gp0_arlock[1:0]              )    //O  [LOCK_WIDTH-1:0]  u_psnf    
        ,.arqos   ( ps_m_axi_gp0_arqos[3:0]               )    //O  [QOS_WIDTH-1:0]   u_psnf    
        ,.rvalid  ( ps_m_axi_gp0_rvalid                   )    //I                    u_psnf    
        ,.rready  ( ps_m_axi_gp0_rready                   )    //O                    u_psnf    
        ,.rid     ( ps_m_axi_gp0_rid[11:0]                )    //I  [ID_WIDTH-1:0]    u_psnf    
        ,.rdata   ( ps_m_axi_gp0_rdata[31:0]              )    //I  [DATA_WIDTH-1:0]  u_psnf    
        ,.rlast   ( ps_m_axi_gp0_rlast                    )    //I                    u_psnf    
        ,.rresp   ( ps_m_axi_gp0_rresp[1:0]               )    //I  [RESP_WIDTH-1:0]  u_psnf    
);


event event_nfps_bfm_force;
event event_nfps_bfm_release;

assign ps_s_axi_hp0_aclk        = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ACLK;
assign ps_s_axi_hp0_aresetn     = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_RESETN;
assign ps_s_axi_hp0_awready     = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWREADY   ;
assign ps_s_axi_hp0_wready      = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_WREADY    ;
assign ps_s_axi_hp0_bvalid      = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_BVALID    ;
assign ps_s_axi_hp0_bid[11:0]   = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_BID[11:0] ;
assign ps_s_axi_hp0_bresp[1:0]  = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_BRESP[1:0];
assign ps_s_axi_hp0_arready     = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARREADY   ;
assign ps_s_axi_hp0_rvalid      = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_RVALID    ;
assign ps_s_axi_hp0_rid[11:0]   = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_RID[11:0] ;
assign ps_s_axi_hp0_rdata[31:0] = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_RDATA[31:0];
assign ps_s_axi_hp0_rlast       = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_RLAST     ;
assign ps_s_axi_hp0_rresp[1:0]  = tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_RRESP[1:0];
initial begin
    forever begin

        @(event_nfps_bfm_force);

        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.axi_interconnect_0.M00_AXI_awready= 1'b0;
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.axi_interconnect_0.M00_AXI_wready = 1'b0;
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.axi_interconnect_0.M00_AXI_bvalid = 1'b0;
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.axi_interconnect_0.M00_AXI_arready= 1'b0;
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.axi_interconnect_0.M00_AXI_rvalid = 1'b0;

        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARADDR[31:0]  = ps_s_axi_hp0_araddr[31:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARBURST[1:0]  = ps_s_axi_hp0_arburst[1:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARCACHE[3:0]  = ps_s_axi_hp0_arcache[3:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARID[11:0]    = ps_s_axi_hp0_arid[11:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARLEN[3:0]    = ps_s_axi_hp0_arlen[3:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARLOCK[1:0]   = ps_s_axi_hp0_arlock[1:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARPROT[2:0]   = ps_s_axi_hp0_arprot[2:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARQOS[3:0]    = ps_s_axi_hp0_arqos[3:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARSIZE[2:0]   = ps_s_axi_hp0_arsize[2:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARVALID       = ps_s_axi_hp0_arvalid;
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWADDR[31:0]  = ps_s_axi_hp0_awaddr[31:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWBURST[1:0]  = ps_s_axi_hp0_awburst[1:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWCACHE[3:0]  = ps_s_axi_hp0_awcache[3:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWID[11:0]    = ps_s_axi_hp0_awid[11:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWLEN[3:0]    = ps_s_axi_hp0_awlen[3:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWLOCK[1:0]   = ps_s_axi_hp0_awlock[1:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWPROT[2:0]   = ps_s_axi_hp0_awprot[2:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWQOS[3:0]    = ps_s_axi_hp0_awqos[3:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWSIZE[2:0]   = ps_s_axi_hp0_awsize[2:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWVALID       = ps_s_axi_hp0_awvalid;
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_BREADY        = ps_s_axi_hp0_bready;
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_RREADY        = ps_s_axi_hp0_rready;
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_WDATA[31:0]   = ps_s_axi_hp0_wdata[31:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_WID[11:0]     = ps_s_axi_hp0_wid[11:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_WLAST         = ps_s_axi_hp0_wlast;
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_WSTRB[3:0]    = ps_s_axi_hp0_wstrb[3:0];
        force tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_WVALID        = ps_s_axi_hp0_wvalid;

        @(event_nfps_bfm_release);

        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.axi_interconnect_0.M00_AXI_awready   ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.axi_interconnect_0.M00_AXI_wready    ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.axi_interconnect_0.M00_AXI_bvalid    ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.axi_interconnect_0.M00_AXI_arready   ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.axi_interconnect_0.M00_AXI_rvalid    ;

        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARADDR[31:0];
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARBURST[1:0];
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARCACHE[3:0];
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARID[11:0]  ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARLEN[3:0]  ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARLOCK[1:0] ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARPROT[2:0] ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARQOS[3:0]  ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARSIZE[2:0] ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_ARVALID     ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWADDR[31:0];
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWBURST[1:0];
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWCACHE[3:0];
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWID[11:0]  ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWLEN[3:0]  ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWLOCK[1:0] ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWPROT[2:0] ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWQOS[3:0]  ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWSIZE[2:0] ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_AWVALID     ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_BREADY      ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_RREADY      ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_WDATA[31:0] ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_WID[11:0]   ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_WLAST       ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_WSTRB[3:0]  ;
        release tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.S_AXI_HP0.S_WVALID      ;
    end
end

task trigger_nfps_bfm_force;
    $display("[%0d], Force   PS.inst.S_AXI_HP0.S-AXI (    connected to u_nfps BFM model)...", $time);
    ->event_nfps_bfm_force;
endtask
task trigger_nfps_bfm_release;
    ->event_nfps_bfm_release;
    $display("[%0d], Release PS.inst.S_AXI_HP0.S-AXI (dis-connected to u_nfps BFM model)...", $time);
endtask

axi_master_bfm_core #(
        .VERBOSE            ( 1             ),
        .ERROR_RESP_FINISH  ( 1             ),

        .ADDR_WIDTH         ( 32            ),
        .DATA_WIDTH         ( 32            ),
        .ID_WIDTH           ( 6             ),
        .SIZE_WIDTH         ( 3             ),
        .QOS_WIDTH          ( 4             ),
        .MAX_CMDNUM         ( 16            ),
        .MAX_ID             ( 0             ),
        .MAX_BURSTLEN       ( 16            ),   // when change this you must change
        .WLOG_NAME          ( "axi_master_write.log"),
        .RLOG_NAME          ( "axi_master_read.log" ),
        .CFG_W_MAX_LATENCY  ( 200           ),  //ns
        .CFG_R_MAX_LATENCY  ( 200           ),  //ns
        .AXI_VERSION        ( 3             ) 
        ) u_nfps( /*AUTOINST*/
         .aclk    ( ps_s_axi_hp0_aclk                     )    //I                    u_nfps    
        ,.aresetn ( ps_s_axi_hp0_aresetn                  )    //I                    u_nfps    
        ,.awaddr  ( ps_s_axi_hp0_awaddr[31:0]             )    //O  [ADDR_WIDTH-1:0]  u_nfps    
        ,.awburst ( ps_s_axi_hp0_awburst[1:0]             )    //O  [BURST_WIDTH-1:0] u_nfps    
        ,.awid    ( ps_s_axi_hp0_awid[11:0]               )    //O  [ID_WIDTH-1:0]    u_nfps    
        ,.awlen   ( ps_s_axi_hp0_awlen[3:0]               )    //O  [LEN_WIDTH-1:0]   u_nfps    
        ,.awsize  ( ps_s_axi_hp0_awsize[2:0]              )    //O  [SIZE_WIDTH-1:0]  u_nfps    
        ,.awprot  ( ps_s_axi_hp0_awprot[2:0]              )    //O  [PROT_WIDTH-1:0]  u_nfps    
        ,.awcache ( ps_s_axi_hp0_awcache[3:0]             )    //O  [CACHE_WIDTH-1:0] u_nfps    
        ,.awlock  ( ps_s_axi_hp0_awlock[1:0]              )    //O  [LOCK_WIDTH-1:0]  u_nfps    
        ,.awqos   ( ps_s_axi_hp0_awqos[3:0]               )    //O  [QOS_WIDTH-1:0]   u_nfps    
        ,.awvalid ( ps_s_axi_hp0_awvalid                  )    //O                    u_nfps    
        ,.awready ( ps_s_axi_hp0_awready                  )    //I                    u_nfps    
        ,.wvalid  ( ps_s_axi_hp0_wvalid                   )    //O                    u_nfps    
        ,.wready  ( ps_s_axi_hp0_wready                   )    //I                    u_nfps    
        ,.wid     ( ps_s_axi_hp0_wid[11:0]                )    //O  [ID_WIDTH-1:0]    u_nfps    
        ,.wdata   ( ps_s_axi_hp0_wdata[31:0]              )    //O  [DATA_WIDTH-1:0]  u_nfps    
        ,.wstrb   ( ps_s_axi_hp0_wstrb[3:0]               )    //O  [STRB_WIDTH-1:0]  u_nfps    
        ,.wlast   ( ps_s_axi_hp0_wlast                    )    //O                    u_nfps    
        ,.bvalid  ( ps_s_axi_hp0_bvalid                   )    //I                    u_nfps    
        ,.bready  ( ps_s_axi_hp0_bready                   )    //O                    u_nfps    
        ,.bid     ( ps_s_axi_hp0_bid[11:0]                )    //I  [ID_WIDTH-1:0]    u_nfps    
        ,.bresp   ( ps_s_axi_hp0_bresp[1:0]               )    //I  [RESP_WIDTH-1:0]  u_nfps    
        ,.arvalid ( ps_s_axi_hp0_arvalid                  )    //O                    u_nfps    
        ,.arready ( ps_s_axi_hp0_arready                  )    //I                    u_nfps    
        ,.arid    ( ps_s_axi_hp0_arid[11:0]               )    //O  [ID_WIDTH-1:0]    u_nfps    
        ,.araddr  ( ps_s_axi_hp0_araddr[31:0]             )    //O  [ADDR_WIDTH-1:0]  u_nfps    
        ,.arburst ( ps_s_axi_hp0_arburst[1:0]             )    //O  [BURST_WIDTH-1:0] u_nfps    
        ,.arlen   ( ps_s_axi_hp0_arlen[3:0]               )    //O  [LEN_WIDTH-1:0]   u_nfps    
        ,.arsize  ( ps_s_axi_hp0_arsize[2:0]              )    //O  [SIZE_WIDTH-1:0]  u_nfps    
        ,.arprot  ( ps_s_axi_hp0_arprot[2:0]              )    //O  [PROT_WIDTH-1:0]  u_nfps    
        ,.arcache ( ps_s_axi_hp0_arcache[3:0]             )    //O  [CACHE_WIDTH-1:0] u_nfps    
        ,.arlock  ( ps_s_axi_hp0_arlock[1:0]              )    //O  [LOCK_WIDTH-1:0]  u_nfps    
        ,.arqos   ( ps_s_axi_hp0_arqos[3:0]               )    //O  [QOS_WIDTH-1:0]   u_nfps    
        ,.rvalid  ( ps_s_axi_hp0_rvalid                   )    //I                    u_nfps    
        ,.rready  ( ps_s_axi_hp0_rready                   )    //O                    u_nfps    
        ,.rid     ( ps_s_axi_hp0_rid[11:0]                )    //I  [ID_WIDTH-1:0]    u_nfps    
        ,.rdata   ( ps_s_axi_hp0_rdata[31:0]              )    //I  [DATA_WIDTH-1:0]  u_nfps    
        ,.rlast   ( ps_s_axi_hp0_rlast                    )    //I                    u_nfps    
        ,.rresp   ( ps_s_axi_hp0_rresp[1:0]               )    //I  [RESP_WIDTH-1:0]  u_nfps    
);


reg [31:0] tmp_rdata;
initial begin
    @(posedge tb_ps_porb);
    #100;
    tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.fpga_soft_reset(32'hFFFF_FFFF);
    #100;
    tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.PS.inst.fpga_soft_reset(32'h0000_0000);
    #100;
    @(posedge ps_m_axi_gp0_aresetn);
    wait(tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.CH0MMCMC1H200.inst.locked_int == 1);
    repeat(100) @(posedge tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.CH0MMCMC1H200.clk_out1);
    repeat(100) @(posedge ps_m_axi_gp0_aclk);

    `include "tc_nfc_csr_rw.vh"

    $display("************************************************************");
    $display("* [%0d], test completed", $time);
    $display("************************************************************");
    #10000;
    $finish();
end

initial begin
    #1000000;
    $display("************************************************************");
    $display("* [%0d], test Aborted", $time);
    $display("************************************************************");
    $finish();
end

endmodule

//verilog-library-files: ()
//verilog-library-directories: (".")
//verilog-library-directories: ("$OPENSSD_HOME/source/work/rtl")
//verilog-library-directories: ("../rtl/OpenSSD")
//verilog-library-directories: ("../tb/model/sim")


