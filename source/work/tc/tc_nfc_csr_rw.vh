
    $display("[%0d], Tiger4NSC CSR read/write test start...", $time);
    u_psnf.single_read(4, 32'h43C0_0000, tmp_rdata[31:0]);
    u_psnf.single_read(4, 32'h43C0_0004, tmp_rdata[31:0]);
    u_psnf.single_read(4, 32'h43C0_0008, tmp_rdata[31:0]);
    u_psnf.single_read(4, 32'h43C0_000C, tmp_rdata[31:0]);

    u_psnf.single_read(4, 32'h43C1_0010, tmp_rdata[31:0]);
    u_psnf.single_read(4, 32'h43C1_0014, tmp_rdata[31:0]);
    u_psnf.single_read(4, 32'h43C1_0018, tmp_rdata[31:0]);
    u_psnf.single_read(4, 32'h43C1_001C, tmp_rdata[31:0]);
    $display("[%0d], Tiger4NSC CSR read/write test end...", $time);


    $display("[%0d], PS OCM read/write test start...", $time);
    trigger_nfps_bfm_force();
    // set Feature-02h (0x0000_0000) to OCM(0x0001_0000)
    // set Feature-10h (0x0000_0003) to OCM(0x0001_0004)
    u_nfps64.single_write(8, 32'h0001_0000, 64'h0000_0003_0000_0000);
    ////u_nfps64.single_write(4, 32'h0001_0004, 32'h0000_0003);
    // set Feature-01h (0x0000_0000) to OCM(0x0001_0008)
    u_nfps64.single_write(8, 32'h0001_0008, 64'h0000_0000_0000_0000);

    u_nfps64.single_read(8, 32'h0001_0000, tmp_rdata[63:0]);
    ////u_nfps64.single_read(4, 32'h0001_0004, tmp_rdata[31:0]);
    u_nfps64.single_read(8, 32'h0001_0008, tmp_rdata[63:0]);

    u_nfps64.single_read(4, 32'h0001_0000, tmp_rdata[63:0]);
    u_nfps64.single_read(4, 32'h0001_0004, tmp_rdata[63:0]);
    u_nfps64.single_read(4, 32'h0001_0008, tmp_rdata[63:0]);
    trigger_nfps_bfm_release();
    $display("[%0d], PS OCM read/write test end...", $time);


    //:: $display("[%0d], V2NFC100DDR-0 reset (Way-0) start...", $time);
    //:: // set WaySelection to 3'h0
    //:: u_psnf.single_write(4, 32'h43C0_001C, 32'h0000_0000);
    //:: // set UProgramSelect to 8'h01 and HPQ
    //:: u_psnf.single_write(4, 32'h43C0_0000, 32'h8000_0001);
    //:: wait(tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.I_NAND_CH0_RB[7:0] != 8'hFF);
    //:: wait(tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.I_NAND_CH0_RB[7:0] == 8'hFF);
    //:: $display("[%0d], V2NFC100DDR-0 reset (Way-0) end.....", $time);

    $display("[%0d], V2NFC100DDR-0 reset (Way-3) start...", $time);
    // set WaySelection to 3'h0
    u_psnf.single_write(4, 32'h43C0_001C, 32'h0000_0003);
    // set UProgramSelect to 8'h01 and HPQ
    u_psnf.single_write(4, 32'h43C0_0000, 32'h8000_0001);
    wait(tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.I_NAND_CH0_RB[7:0] != 8'hFF);
    wait(tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.I_NAND_CH0_RB[7:0] == 8'hFF);
    $display("[%0d], V2NFC100DDR-0 reset (Way-3) end.....", $time);

if(0) begin: erase_way3_rowA5A5A5
    //Erase: Way-8'h03, Row-24'hA5_A5A5
    $display("[%0d], Erase: Way-3'h3, Row-24'hA5_A5A5 start...", $time);
    // set WaySelection to 8'h03
    u_psnf.single_write(4, 32'h43C0_001C, 32'h0000_0003);
    // set RowAddress   to 24'hA5_A5A5
    u_psnf.single_write(4, 32'h43C0_0004, 32'h00A5_A5A5);
    // set UProgramSelect to 8'h25 and HPQ
    u_psnf.single_write(4, 32'h43C0_0000, 32'h8000_0025);

    // Wait Channel busy:
    $display("[%0d], Tiger4NSC_0 Erase preparation...", $time);
    wait(tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.I_NAND_CH0_RB[7:0] != 8'hFF);

    // Wait Channel idle:
    $display("[%0d], Tiger4NSC_0 Erase start...", $time);
    wait(tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.I_NAND_CH0_RB[7:0] == 8'hFF);
    $display("[%0d], Tiger4NSC_0 Erase finished...", $time);
end

    //setFT: Way-8'h03
    $display("[%0d], setFT: Way-3'h3 start...", $time);
    // set WaySelection to 8'h03
    u_psnf.single_write(4, 32'h43C0_001C, 32'h0000_0003);
    // set UserData to 32'hFFFC_0000
    u_psnf.single_write(4, 32'h43C0_0008, 32'h0001_0000);
    // set UProgramSelect to 8'h06 and HPQ
    u_psnf.single_write(4, 32'h43C0_0000, 32'h8000_0006);

    // Wait Channel busy:
    //>: $display("[%0d], Tiger4NSC_0 SetFeature preparation...", $time);
    //>: wait(tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.I_NAND_CH0_RB[7:0] != 8'hFF);
    // Wait Channel idle:
    $display("[%0d], Tiger4NSC_0 SetFeature start...", $time);
    //>: wait(tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.I_NAND_CH0_RB[7:0] == 8'hFF);
    wait_V2NFC100DDR_to_idle(0);
    $display("[%0d], Tiger4NSC_0 SetFeature finished...", $time);


    //getFT: Way-8'h03
    $display("[%0d], getFT: Way-3'h3 start...", $time);
    // set UserData to 32'hFFFC_0000
    u_psnf.single_write(4, 32'h43C0_0008, 32'h0000_FAEE);
    // set CmpltAddress to 32'hFFFC_0000
    u_psnf.single_write(4, 32'h43C0_0018, 32'h0002_0000);
    // set WaySelection to 8'h03
    u_psnf.single_write(4, 32'h43C0_001C, 32'h0000_0003);
    // set UProgramSelect to 8'h25 and HPQ
    u_psnf.single_write(4, 32'h43C0_0000, 32'h8000_002E);

    // Wait Channel busy:
    //>: $display("[%0d], Tiger4NSC_0 getFT preparation...", $time);
    //>: wait(tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.I_NAND_CH0_RB[7:0] != 8'hFF);
    //->: repeat(600) @(posedge ps_m_axi_gp0_aclk);

    // Wait Channel idle:
    $display("[%0d], Tiger4NSC_0 getFT start...", $time);
    //>: wait(tb_OpenSSD2_Top.u_OpenSSD2_wrapper_0.OpenSSD2_i.I_NAND_CH0_RB[7:0] == 8'hFF);
    wait_V2NFC100DDR_to_idle(0);
    $display("[%0d], Tiger4NSC_0 getFT finished...", $time);



