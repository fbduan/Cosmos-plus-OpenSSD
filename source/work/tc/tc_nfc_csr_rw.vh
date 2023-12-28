
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

    $display("[%0d], V2NFC100DDR-0 reset (Way-0) start...", $time);
    // set WaySelection to 3'h0
    u_psnf.single_write(4, 32'h43C0_001C, 32'h0000_0000);
    // set UProgramSelect to 8'h01 and HPQ
    u_psnf.single_write(4, 32'h43C0_0000, 32'h8000_0001);
    $display("[%0d], V2NFC100DDR-0 reset (Way-0) end.....", $time);

    $display("[%0d], V2NFC100DDR-0 reset (Way-3) start...", $time);
    // set WaySelection to 3'h0
    u_psnf.single_write(4, 32'h43C0_001C, 32'h0000_0003);
    // set UProgramSelect to 8'h01 and HPQ
    u_psnf.single_write(4, 32'h43C0_0000, 32'h8000_0001);
    $display("[%0d], V2NFC100DDR-0 reset (Way-3) end.....", $time);

    //Erase: Way-8'h03, Row-24'hA5_A5A5
    $display("[%0d], Erase: Way-3'h3, Row-24'hA5_A5A5 start...", $time);
    // set WaySelection to 8'h03
    u_psnf.single_write(4, 32'h43C0_001C, 32'h0000_0003);
    // set RowAddress   to 24'hA5_A5A5
    u_psnf.single_write(4, 32'h43C0_0004, 32'h00A5_A5A5);
    // set UProgramSelect to 8'h25 and HPQ
    u_psnf.single_write(4, 32'h43C0_0000, 32'h8000_0025);

    $display("[%0d], Tiger4NSC_0 Erase preparation...", $time);
    // Wait Channel busy:
    forever begin:wait_Tiger4NSC_0_busy
        // get ChStatus, check if the status is 1'b0
        u_psnf.single_read(4, 32'h43C0_0020, tmp_rdata[31:0]);
        if(tmp_rdata[0] == 1) begin
            disable wait_Tiger4NSC_0_busy;
        end
        repeat(600) @(posedge ps_m_axi_gp0_aclk);
    end

    $display("[%0d], Tiger4NSC_0 Erase start...", $time);
    // Wait Channel idle:
    forever begin:wait_Tiger4NSC_0_idle
        // get ChStatus, check if the status is 1'b0
        u_psnf.single_read(4, 32'h43C0_0020, tmp_rdata[31:0]);
        if(tmp_rdata[0] == 0) begin
            disable wait_Tiger4NSC_0_idle;
        end
        repeat(600) @(posedge ps_m_axi_gp0_aclk);
    end

    $display("[%0d], Tiger4NSC_0 Erase finished...", $time);


