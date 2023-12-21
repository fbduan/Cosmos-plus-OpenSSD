`timescale 1ps / 1ps
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


module tb_OpenSSD2_Top(/*autoarg*/);

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
wire [7:0]    pcie_tx_n;
wire [7:0]    pcie_tx_p;
//}}}
// End of automatic define



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
        .FIXED_IO_ddr_vrn  ( FIXED_IO_ddr_vrn    ),    //IO        u_OpenSSD2_wrapper_0    
        .FIXED_IO_ddr_vrp  ( FIXED_IO_ddr_vrp    ),    //IO        u_OpenSSD2_wrapper_0    
        .FIXED_IO_mio      ( FIXED_IO_mio[53:0]  ),    //IO [53:0] u_OpenSSD2_wrapper_0    
        .FIXED_IO_ps_clk   ( FIXED_IO_ps_clk     ),    //IO        u_OpenSSD2_wrapper_0    
        .FIXED_IO_ps_porb  ( FIXED_IO_ps_porb    ),    //IO        u_OpenSSD2_wrapper_0    
        .FIXED_IO_ps_srstb ( FIXED_IO_ps_srstb   ),    //IO        u_OpenSSD2_wrapper_0    
        .IO_NAND_CH0_DQ    ( IO_NAND_CH0_DQ[7:0] ),    //IO [7:0]  u_OpenSSD2_wrapper_0    
        .IO_NAND_CH0_DQS_N ( IO_NAND_CH0_DQS_N   ),    //IO        u_OpenSSD2_wrapper_0    
        .IO_NAND_CH0_DQS_P ( IO_NAND_CH0_DQS_P   ),    //IO        u_OpenSSD2_wrapper_0    
        .IO_NAND_CH1_DQ    ( IO_NAND_CH1_DQ[7:0] ),    //IO [7:0]  u_OpenSSD2_wrapper_0    
        .IO_NAND_CH1_DQS_N ( IO_NAND_CH1_DQS_N   ),    //IO        u_OpenSSD2_wrapper_0    
        .IO_NAND_CH1_DQS_P ( IO_NAND_CH1_DQS_P   ),    //IO        u_OpenSSD2_wrapper_0    
        .I_NAND_CH0_RB     ( I_NAND_CH0_RB[7:0]  ),    //I  [7:0]  u_OpenSSD2_wrapper_0    
        .I_NAND_CH1_RB     ( I_NAND_CH1_RB[7:0]  ),    //I  [7:0]  u_OpenSSD2_wrapper_0    
        .O_DEBUG           ( O_DEBUG[31:0]       ),    //O  [31:0] u_OpenSSD2_wrapper_0    
        .O_NAND_CH0_ALE    ( O_NAND_CH0_ALE      ),    //O         u_OpenSSD2_wrapper_0    
        .O_NAND_CH0_CE     ( O_NAND_CH0_CE[7:0]  ),    //O  [7:0]  u_OpenSSD2_wrapper_0    
        .O_NAND_CH0_CLE    ( O_NAND_CH0_CLE      ),    //O         u_OpenSSD2_wrapper_0    
        .O_NAND_CH0_RE_N   ( O_NAND_CH0_RE_N     ),    //O         u_OpenSSD2_wrapper_0    
        .O_NAND_CH0_RE_P   ( O_NAND_CH0_RE_P     ),    //O         u_OpenSSD2_wrapper_0    
        .O_NAND_CH0_WE     ( O_NAND_CH0_WE       ),    //O         u_OpenSSD2_wrapper_0    
        .O_NAND_CH0_WP     ( O_NAND_CH0_WP       ),    //O         u_OpenSSD2_wrapper_0    
        .O_NAND_CH1_ALE    ( O_NAND_CH1_ALE      ),    //O         u_OpenSSD2_wrapper_0    
        .O_NAND_CH1_CE     ( O_NAND_CH1_CE[7:0]  ),    //O  [7:0]  u_OpenSSD2_wrapper_0    
        .O_NAND_CH1_CLE    ( O_NAND_CH1_CLE      ),    //O         u_OpenSSD2_wrapper_0    
        .O_NAND_CH1_RE_N   ( O_NAND_CH1_RE_N     ),    //O         u_OpenSSD2_wrapper_0    
        .O_NAND_CH1_RE_P   ( O_NAND_CH1_RE_P     ),    //O         u_OpenSSD2_wrapper_0    
        .O_NAND_CH1_WE     ( O_NAND_CH1_WE       ),    //O         u_OpenSSD2_wrapper_0    
        .O_NAND_CH1_WP     ( O_NAND_CH1_WP       ),    //O         u_OpenSSD2_wrapper_0    
        .pcie_perst_n      ( pcie_perst_n        ),    //I         u_OpenSSD2_wrapper_0    
        .pcie_ref_clk_n    ( pcie_ref_clk_n      ),    //I         u_OpenSSD2_wrapper_0    
        .pcie_ref_clk_p    ( pcie_ref_clk_p      ),    //I         u_OpenSSD2_wrapper_0    
        .pcie_rx_n         ( pcie_rx_n[7:0]      ),    //I  [7:0]  u_OpenSSD2_wrapper_0    
        .pcie_rx_p         ( pcie_rx_p[7:0]      ),    //I  [7:0]  u_OpenSSD2_wrapper_0    
        .pcie_tx_n         ( pcie_tx_n[7:0]      ),    //O  [7:0]  u_OpenSSD2_wrapper_0    
        .pcie_tx_p         ( pcie_tx_p[7:0]      )     //O  [7:0]  u_OpenSSD2_wrapper_0    
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
        nand_model u_nand_ch0_way(
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


ddr3 u_ddr3_upper( /*AUTOINST*/
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

ddr3 u_ddr3_lower( /*AUTOINST*/
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

endmodule

//verilog-library-files: ("./DDR3/ddr3.v")
//verilog-library-files: ("./m73a_nand_model/nand_model.v")
//verilog-library-directories: (".")
//verilog-library-directories: ("$OPENSSD_HOME/source/work/rtl")
//verilog-library-directories: ("../rtl/OpenSSD")


