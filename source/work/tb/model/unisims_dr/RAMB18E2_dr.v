`include "B_RAMB18E2_defines.vh"

reg [`RAMB18E2_DATA_SZ-1:0] ATTR [0:`RAMB18E2_ADDR_N-1];
reg [48:1] CASCADE_ORDER_A_REG = CASCADE_ORDER_A;
reg [48:1] CASCADE_ORDER_B_REG = CASCADE_ORDER_B;
reg [88:1] CLOCK_DOMAINS_REG = CLOCK_DOMAINS;
reg DOA_REG_REG = DOA_REG;
reg DOB_REG_REG = DOB_REG;
reg [40:1] ENADDRENA_REG = ENADDRENA;
reg [40:1] ENADDRENB_REG = ENADDRENB;
reg [255:0] INITP_00_REG = INITP_00;
reg [255:0] INITP_01_REG = INITP_01;
reg [255:0] INITP_02_REG = INITP_02;
reg [255:0] INITP_03_REG = INITP_03;
reg [255:0] INITP_04_REG = INITP_04;
reg [255:0] INITP_05_REG = INITP_05;
reg [255:0] INITP_06_REG = INITP_06;
reg [255:0] INITP_07_REG = INITP_07;
reg [255:0] INIT_00_REG = INIT_00;
reg [255:0] INIT_01_REG = INIT_01;
reg [255:0] INIT_02_REG = INIT_02;
reg [255:0] INIT_03_REG = INIT_03;
reg [255:0] INIT_04_REG = INIT_04;
reg [255:0] INIT_05_REG = INIT_05;
reg [255:0] INIT_06_REG = INIT_06;
reg [255:0] INIT_07_REG = INIT_07;
reg [255:0] INIT_08_REG = INIT_08;
reg [255:0] INIT_09_REG = INIT_09;
reg [255:0] INIT_0A_REG = INIT_0A;
reg [255:0] INIT_0B_REG = INIT_0B;
reg [255:0] INIT_0C_REG = INIT_0C;
reg [255:0] INIT_0D_REG = INIT_0D;
reg [255:0] INIT_0E_REG = INIT_0E;
reg [255:0] INIT_0F_REG = INIT_0F;
reg [255:0] INIT_10_REG = INIT_10;
reg [255:0] INIT_11_REG = INIT_11;
reg [255:0] INIT_12_REG = INIT_12;
reg [255:0] INIT_13_REG = INIT_13;
reg [255:0] INIT_14_REG = INIT_14;
reg [255:0] INIT_15_REG = INIT_15;
reg [255:0] INIT_16_REG = INIT_16;
reg [255:0] INIT_17_REG = INIT_17;
reg [255:0] INIT_18_REG = INIT_18;
reg [255:0] INIT_19_REG = INIT_19;
reg [255:0] INIT_1A_REG = INIT_1A;
reg [255:0] INIT_1B_REG = INIT_1B;
reg [255:0] INIT_1C_REG = INIT_1C;
reg [255:0] INIT_1D_REG = INIT_1D;
reg [255:0] INIT_1E_REG = INIT_1E;
reg [255:0] INIT_1F_REG = INIT_1F;
reg [255:0] INIT_20_REG = INIT_20;
reg [255:0] INIT_21_REG = INIT_21;
reg [255:0] INIT_22_REG = INIT_22;
reg [255:0] INIT_23_REG = INIT_23;
reg [255:0] INIT_24_REG = INIT_24;
reg [255:0] INIT_25_REG = INIT_25;
reg [255:0] INIT_26_REG = INIT_26;
reg [255:0] INIT_27_REG = INIT_27;
reg [255:0] INIT_28_REG = INIT_28;
reg [255:0] INIT_29_REG = INIT_29;
reg [255:0] INIT_2A_REG = INIT_2A;
reg [255:0] INIT_2B_REG = INIT_2B;
reg [255:0] INIT_2C_REG = INIT_2C;
reg [255:0] INIT_2D_REG = INIT_2D;
reg [255:0] INIT_2E_REG = INIT_2E;
reg [255:0] INIT_2F_REG = INIT_2F;
reg [255:0] INIT_30_REG = INIT_30;
reg [255:0] INIT_31_REG = INIT_31;
reg [255:0] INIT_32_REG = INIT_32;
reg [255:0] INIT_33_REG = INIT_33;
reg [255:0] INIT_34_REG = INIT_34;
reg [255:0] INIT_35_REG = INIT_35;
reg [255:0] INIT_36_REG = INIT_36;
reg [255:0] INIT_37_REG = INIT_37;
reg [255:0] INIT_38_REG = INIT_38;
reg [255:0] INIT_39_REG = INIT_39;
reg [255:0] INIT_3A_REG = INIT_3A;
reg [255:0] INIT_3B_REG = INIT_3B;
reg [255:0] INIT_3C_REG = INIT_3C;
reg [255:0] INIT_3D_REG = INIT_3D;
reg [255:0] INIT_3E_REG = INIT_3E;
reg [255:0] INIT_3F_REG = INIT_3F;
reg [17:0] INIT_A_REG = INIT_A;
reg [17:0] INIT_B_REG = INIT_B;
reg [32:1] INIT_FILE_REG = INIT_FILE;
reg IS_CLKARDCLK_INVERTED_REG = IS_CLKARDCLK_INVERTED;
reg IS_CLKBWRCLK_INVERTED_REG = IS_CLKBWRCLK_INVERTED;
reg IS_ENARDEN_INVERTED_REG = IS_ENARDEN_INVERTED;
reg IS_ENBWREN_INVERTED_REG = IS_ENBWREN_INVERTED;
reg IS_RSTRAMARSTRAM_INVERTED_REG = IS_RSTRAMARSTRAM_INVERTED;
reg IS_RSTRAMB_INVERTED_REG = IS_RSTRAMB_INVERTED;
reg IS_RSTREGARSTREG_INVERTED_REG = IS_RSTREGARSTREG_INVERTED;
reg IS_RSTREGB_INVERTED_REG = IS_RSTREGB_INVERTED;
reg [40:1] RDADDRCHANGEA_REG = RDADDRCHANGEA;
reg [40:1] RDADDRCHANGEB_REG = RDADDRCHANGEB;
reg [5:0] READ_WIDTH_A_REG = READ_WIDTH_A;
reg [4:0] READ_WIDTH_B_REG = READ_WIDTH_B;
reg [48:1] RSTREG_PRIORITY_A_REG = RSTREG_PRIORITY_A;
reg [48:1] RSTREG_PRIORITY_B_REG = RSTREG_PRIORITY_B;
reg [120:1] SIM_COLLISION_CHECK_REG = SIM_COLLISION_CHECK;
reg [40:1] SLEEP_ASYNC_REG = SLEEP_ASYNC;
reg [17:0] SRVAL_A_REG = SRVAL_A;
reg [17:0] SRVAL_B_REG = SRVAL_B;
reg [88:1] WRITE_MODE_A_REG = WRITE_MODE_A;
reg [88:1] WRITE_MODE_B_REG = WRITE_MODE_B;
reg [4:0] WRITE_WIDTH_A_REG = WRITE_WIDTH_A;
reg [5:0] WRITE_WIDTH_B_REG = WRITE_WIDTH_B;

initial begin
  ATTR[`RAMB18E2__CASCADE_ORDER_A] = CASCADE_ORDER_A;
  ATTR[`RAMB18E2__CASCADE_ORDER_B] = CASCADE_ORDER_B;
  ATTR[`RAMB18E2__CLOCK_DOMAINS] = CLOCK_DOMAINS;
  ATTR[`RAMB18E2__DOA_REG] = DOA_REG;
  ATTR[`RAMB18E2__DOB_REG] = DOB_REG;
  ATTR[`RAMB18E2__ENADDRENA] = ENADDRENA;
  ATTR[`RAMB18E2__ENADDRENB] = ENADDRENB;
  ATTR[`RAMB18E2__INITP_00] = INITP_00;
  ATTR[`RAMB18E2__INITP_01] = INITP_01;
  ATTR[`RAMB18E2__INITP_02] = INITP_02;
  ATTR[`RAMB18E2__INITP_03] = INITP_03;
  ATTR[`RAMB18E2__INITP_04] = INITP_04;
  ATTR[`RAMB18E2__INITP_05] = INITP_05;
  ATTR[`RAMB18E2__INITP_06] = INITP_06;
  ATTR[`RAMB18E2__INITP_07] = INITP_07;
  ATTR[`RAMB18E2__INIT_00] = INIT_00;
  ATTR[`RAMB18E2__INIT_01] = INIT_01;
  ATTR[`RAMB18E2__INIT_02] = INIT_02;
  ATTR[`RAMB18E2__INIT_03] = INIT_03;
  ATTR[`RAMB18E2__INIT_04] = INIT_04;
  ATTR[`RAMB18E2__INIT_05] = INIT_05;
  ATTR[`RAMB18E2__INIT_06] = INIT_06;
  ATTR[`RAMB18E2__INIT_07] = INIT_07;
  ATTR[`RAMB18E2__INIT_08] = INIT_08;
  ATTR[`RAMB18E2__INIT_09] = INIT_09;
  ATTR[`RAMB18E2__INIT_0A] = INIT_0A;
  ATTR[`RAMB18E2__INIT_0B] = INIT_0B;
  ATTR[`RAMB18E2__INIT_0C] = INIT_0C;
  ATTR[`RAMB18E2__INIT_0D] = INIT_0D;
  ATTR[`RAMB18E2__INIT_0E] = INIT_0E;
  ATTR[`RAMB18E2__INIT_0F] = INIT_0F;
  ATTR[`RAMB18E2__INIT_10] = INIT_10;
  ATTR[`RAMB18E2__INIT_11] = INIT_11;
  ATTR[`RAMB18E2__INIT_12] = INIT_12;
  ATTR[`RAMB18E2__INIT_13] = INIT_13;
  ATTR[`RAMB18E2__INIT_14] = INIT_14;
  ATTR[`RAMB18E2__INIT_15] = INIT_15;
  ATTR[`RAMB18E2__INIT_16] = INIT_16;
  ATTR[`RAMB18E2__INIT_17] = INIT_17;
  ATTR[`RAMB18E2__INIT_18] = INIT_18;
  ATTR[`RAMB18E2__INIT_19] = INIT_19;
  ATTR[`RAMB18E2__INIT_1A] = INIT_1A;
  ATTR[`RAMB18E2__INIT_1B] = INIT_1B;
  ATTR[`RAMB18E2__INIT_1C] = INIT_1C;
  ATTR[`RAMB18E2__INIT_1D] = INIT_1D;
  ATTR[`RAMB18E2__INIT_1E] = INIT_1E;
  ATTR[`RAMB18E2__INIT_1F] = INIT_1F;
  ATTR[`RAMB18E2__INIT_20] = INIT_20;
  ATTR[`RAMB18E2__INIT_21] = INIT_21;
  ATTR[`RAMB18E2__INIT_22] = INIT_22;
  ATTR[`RAMB18E2__INIT_23] = INIT_23;
  ATTR[`RAMB18E2__INIT_24] = INIT_24;
  ATTR[`RAMB18E2__INIT_25] = INIT_25;
  ATTR[`RAMB18E2__INIT_26] = INIT_26;
  ATTR[`RAMB18E2__INIT_27] = INIT_27;
  ATTR[`RAMB18E2__INIT_28] = INIT_28;
  ATTR[`RAMB18E2__INIT_29] = INIT_29;
  ATTR[`RAMB18E2__INIT_2A] = INIT_2A;
  ATTR[`RAMB18E2__INIT_2B] = INIT_2B;
  ATTR[`RAMB18E2__INIT_2C] = INIT_2C;
  ATTR[`RAMB18E2__INIT_2D] = INIT_2D;
  ATTR[`RAMB18E2__INIT_2E] = INIT_2E;
  ATTR[`RAMB18E2__INIT_2F] = INIT_2F;
  ATTR[`RAMB18E2__INIT_30] = INIT_30;
  ATTR[`RAMB18E2__INIT_31] = INIT_31;
  ATTR[`RAMB18E2__INIT_32] = INIT_32;
  ATTR[`RAMB18E2__INIT_33] = INIT_33;
  ATTR[`RAMB18E2__INIT_34] = INIT_34;
  ATTR[`RAMB18E2__INIT_35] = INIT_35;
  ATTR[`RAMB18E2__INIT_36] = INIT_36;
  ATTR[`RAMB18E2__INIT_37] = INIT_37;
  ATTR[`RAMB18E2__INIT_38] = INIT_38;
  ATTR[`RAMB18E2__INIT_39] = INIT_39;
  ATTR[`RAMB18E2__INIT_3A] = INIT_3A;
  ATTR[`RAMB18E2__INIT_3B] = INIT_3B;
  ATTR[`RAMB18E2__INIT_3C] = INIT_3C;
  ATTR[`RAMB18E2__INIT_3D] = INIT_3D;
  ATTR[`RAMB18E2__INIT_3E] = INIT_3E;
  ATTR[`RAMB18E2__INIT_3F] = INIT_3F;
  ATTR[`RAMB18E2__INIT_A] = INIT_A;
  ATTR[`RAMB18E2__INIT_B] = INIT_B;
  ATTR[`RAMB18E2__INIT_FILE] = INIT_FILE;
  ATTR[`RAMB18E2__IS_CLKARDCLK_INVERTED] = IS_CLKARDCLK_INVERTED;
  ATTR[`RAMB18E2__IS_CLKBWRCLK_INVERTED] = IS_CLKBWRCLK_INVERTED;
  ATTR[`RAMB18E2__IS_ENARDEN_INVERTED] = IS_ENARDEN_INVERTED;
  ATTR[`RAMB18E2__IS_ENBWREN_INVERTED] = IS_ENBWREN_INVERTED;
  ATTR[`RAMB18E2__IS_RSTRAMARSTRAM_INVERTED] = IS_RSTRAMARSTRAM_INVERTED;
  ATTR[`RAMB18E2__IS_RSTRAMB_INVERTED] = IS_RSTRAMB_INVERTED;
  ATTR[`RAMB18E2__IS_RSTREGARSTREG_INVERTED] = IS_RSTREGARSTREG_INVERTED;
  ATTR[`RAMB18E2__IS_RSTREGB_INVERTED] = IS_RSTREGB_INVERTED;
  ATTR[`RAMB18E2__RDADDRCHANGEA] = RDADDRCHANGEA;
  ATTR[`RAMB18E2__RDADDRCHANGEB] = RDADDRCHANGEB;
  ATTR[`RAMB18E2__READ_WIDTH_A] = READ_WIDTH_A;
  ATTR[`RAMB18E2__READ_WIDTH_B] = READ_WIDTH_B;
  ATTR[`RAMB18E2__RSTREG_PRIORITY_A] = RSTREG_PRIORITY_A;
  ATTR[`RAMB18E2__RSTREG_PRIORITY_B] = RSTREG_PRIORITY_B;
  ATTR[`RAMB18E2__SIM_COLLISION_CHECK] = SIM_COLLISION_CHECK;
  ATTR[`RAMB18E2__SLEEP_ASYNC] = SLEEP_ASYNC;
  ATTR[`RAMB18E2__SRVAL_A] = SRVAL_A;
  ATTR[`RAMB18E2__SRVAL_B] = SRVAL_B;
  ATTR[`RAMB18E2__WRITE_MODE_A] = WRITE_MODE_A;
  ATTR[`RAMB18E2__WRITE_MODE_B] = WRITE_MODE_B;
  ATTR[`RAMB18E2__WRITE_WIDTH_A] = WRITE_WIDTH_A;
  ATTR[`RAMB18E2__WRITE_WIDTH_B] = WRITE_WIDTH_B;
end

always @(posedge trig_attr) begin
  CASCADE_ORDER_A_REG = ATTR[`RAMB18E2__CASCADE_ORDER_A];
  CASCADE_ORDER_B_REG = ATTR[`RAMB18E2__CASCADE_ORDER_B];
  CLOCK_DOMAINS_REG = ATTR[`RAMB18E2__CLOCK_DOMAINS];
  DOA_REG_REG = ATTR[`RAMB18E2__DOA_REG];
  DOB_REG_REG = ATTR[`RAMB18E2__DOB_REG];
  ENADDRENA_REG = ATTR[`RAMB18E2__ENADDRENA];
  ENADDRENB_REG = ATTR[`RAMB18E2__ENADDRENB];
  INITP_00_REG = ATTR[`RAMB18E2__INITP_00];
  INITP_01_REG = ATTR[`RAMB18E2__INITP_01];
  INITP_02_REG = ATTR[`RAMB18E2__INITP_02];
  INITP_03_REG = ATTR[`RAMB18E2__INITP_03];
  INITP_04_REG = ATTR[`RAMB18E2__INITP_04];
  INITP_05_REG = ATTR[`RAMB18E2__INITP_05];
  INITP_06_REG = ATTR[`RAMB18E2__INITP_06];
  INITP_07_REG = ATTR[`RAMB18E2__INITP_07];
  INIT_00_REG = ATTR[`RAMB18E2__INIT_00];
  INIT_01_REG = ATTR[`RAMB18E2__INIT_01];
  INIT_02_REG = ATTR[`RAMB18E2__INIT_02];
  INIT_03_REG = ATTR[`RAMB18E2__INIT_03];
  INIT_04_REG = ATTR[`RAMB18E2__INIT_04];
  INIT_05_REG = ATTR[`RAMB18E2__INIT_05];
  INIT_06_REG = ATTR[`RAMB18E2__INIT_06];
  INIT_07_REG = ATTR[`RAMB18E2__INIT_07];
  INIT_08_REG = ATTR[`RAMB18E2__INIT_08];
  INIT_09_REG = ATTR[`RAMB18E2__INIT_09];
  INIT_0A_REG = ATTR[`RAMB18E2__INIT_0A];
  INIT_0B_REG = ATTR[`RAMB18E2__INIT_0B];
  INIT_0C_REG = ATTR[`RAMB18E2__INIT_0C];
  INIT_0D_REG = ATTR[`RAMB18E2__INIT_0D];
  INIT_0E_REG = ATTR[`RAMB18E2__INIT_0E];
  INIT_0F_REG = ATTR[`RAMB18E2__INIT_0F];
  INIT_10_REG = ATTR[`RAMB18E2__INIT_10];
  INIT_11_REG = ATTR[`RAMB18E2__INIT_11];
  INIT_12_REG = ATTR[`RAMB18E2__INIT_12];
  INIT_13_REG = ATTR[`RAMB18E2__INIT_13];
  INIT_14_REG = ATTR[`RAMB18E2__INIT_14];
  INIT_15_REG = ATTR[`RAMB18E2__INIT_15];
  INIT_16_REG = ATTR[`RAMB18E2__INIT_16];
  INIT_17_REG = ATTR[`RAMB18E2__INIT_17];
  INIT_18_REG = ATTR[`RAMB18E2__INIT_18];
  INIT_19_REG = ATTR[`RAMB18E2__INIT_19];
  INIT_1A_REG = ATTR[`RAMB18E2__INIT_1A];
  INIT_1B_REG = ATTR[`RAMB18E2__INIT_1B];
  INIT_1C_REG = ATTR[`RAMB18E2__INIT_1C];
  INIT_1D_REG = ATTR[`RAMB18E2__INIT_1D];
  INIT_1E_REG = ATTR[`RAMB18E2__INIT_1E];
  INIT_1F_REG = ATTR[`RAMB18E2__INIT_1F];
  INIT_20_REG = ATTR[`RAMB18E2__INIT_20];
  INIT_21_REG = ATTR[`RAMB18E2__INIT_21];
  INIT_22_REG = ATTR[`RAMB18E2__INIT_22];
  INIT_23_REG = ATTR[`RAMB18E2__INIT_23];
  INIT_24_REG = ATTR[`RAMB18E2__INIT_24];
  INIT_25_REG = ATTR[`RAMB18E2__INIT_25];
  INIT_26_REG = ATTR[`RAMB18E2__INIT_26];
  INIT_27_REG = ATTR[`RAMB18E2__INIT_27];
  INIT_28_REG = ATTR[`RAMB18E2__INIT_28];
  INIT_29_REG = ATTR[`RAMB18E2__INIT_29];
  INIT_2A_REG = ATTR[`RAMB18E2__INIT_2A];
  INIT_2B_REG = ATTR[`RAMB18E2__INIT_2B];
  INIT_2C_REG = ATTR[`RAMB18E2__INIT_2C];
  INIT_2D_REG = ATTR[`RAMB18E2__INIT_2D];
  INIT_2E_REG = ATTR[`RAMB18E2__INIT_2E];
  INIT_2F_REG = ATTR[`RAMB18E2__INIT_2F];
  INIT_30_REG = ATTR[`RAMB18E2__INIT_30];
  INIT_31_REG = ATTR[`RAMB18E2__INIT_31];
  INIT_32_REG = ATTR[`RAMB18E2__INIT_32];
  INIT_33_REG = ATTR[`RAMB18E2__INIT_33];
  INIT_34_REG = ATTR[`RAMB18E2__INIT_34];
  INIT_35_REG = ATTR[`RAMB18E2__INIT_35];
  INIT_36_REG = ATTR[`RAMB18E2__INIT_36];
  INIT_37_REG = ATTR[`RAMB18E2__INIT_37];
  INIT_38_REG = ATTR[`RAMB18E2__INIT_38];
  INIT_39_REG = ATTR[`RAMB18E2__INIT_39];
  INIT_3A_REG = ATTR[`RAMB18E2__INIT_3A];
  INIT_3B_REG = ATTR[`RAMB18E2__INIT_3B];
  INIT_3C_REG = ATTR[`RAMB18E2__INIT_3C];
  INIT_3D_REG = ATTR[`RAMB18E2__INIT_3D];
  INIT_3E_REG = ATTR[`RAMB18E2__INIT_3E];
  INIT_3F_REG = ATTR[`RAMB18E2__INIT_3F];
  INIT_A_REG = ATTR[`RAMB18E2__INIT_A];
  INIT_B_REG = ATTR[`RAMB18E2__INIT_B];
  INIT_FILE_REG = ATTR[`RAMB18E2__INIT_FILE];
  IS_CLKARDCLK_INVERTED_REG = ATTR[`RAMB18E2__IS_CLKARDCLK_INVERTED];
  IS_CLKBWRCLK_INVERTED_REG = ATTR[`RAMB18E2__IS_CLKBWRCLK_INVERTED];
  IS_ENARDEN_INVERTED_REG = ATTR[`RAMB18E2__IS_ENARDEN_INVERTED];
  IS_ENBWREN_INVERTED_REG = ATTR[`RAMB18E2__IS_ENBWREN_INVERTED];
  IS_RSTRAMARSTRAM_INVERTED_REG = ATTR[`RAMB18E2__IS_RSTRAMARSTRAM_INVERTED];
  IS_RSTRAMB_INVERTED_REG = ATTR[`RAMB18E2__IS_RSTRAMB_INVERTED];
  IS_RSTREGARSTREG_INVERTED_REG = ATTR[`RAMB18E2__IS_RSTREGARSTREG_INVERTED];
  IS_RSTREGB_INVERTED_REG = ATTR[`RAMB18E2__IS_RSTREGB_INVERTED];
  RDADDRCHANGEA_REG = ATTR[`RAMB18E2__RDADDRCHANGEA];
  RDADDRCHANGEB_REG = ATTR[`RAMB18E2__RDADDRCHANGEB];
  READ_WIDTH_A_REG = ATTR[`RAMB18E2__READ_WIDTH_A];
  READ_WIDTH_B_REG = ATTR[`RAMB18E2__READ_WIDTH_B];
  RSTREG_PRIORITY_A_REG = ATTR[`RAMB18E2__RSTREG_PRIORITY_A];
  RSTREG_PRIORITY_B_REG = ATTR[`RAMB18E2__RSTREG_PRIORITY_B];
  SIM_COLLISION_CHECK_REG = ATTR[`RAMB18E2__SIM_COLLISION_CHECK];
  SLEEP_ASYNC_REG = ATTR[`RAMB18E2__SLEEP_ASYNC];
  SRVAL_A_REG = ATTR[`RAMB18E2__SRVAL_A];
  SRVAL_B_REG = ATTR[`RAMB18E2__SRVAL_B];
  WRITE_MODE_A_REG = ATTR[`RAMB18E2__WRITE_MODE_A];
  WRITE_MODE_B_REG = ATTR[`RAMB18E2__WRITE_MODE_B];
  WRITE_WIDTH_A_REG = ATTR[`RAMB18E2__WRITE_WIDTH_A];
  WRITE_WIDTH_B_REG = ATTR[`RAMB18E2__WRITE_WIDTH_B];
end

// procedures to override, read attribute values

task write_attr;
  input  [`RAMB18E2_ADDR_SZ-1:0] addr;
  input  [`RAMB18E2_DATA_SZ-1:0] data;
  begin
    ATTR[addr] = data;
  end
endtask

function [`RAMB18E2_DATA_SZ-1:0] read_attr;
  input  [`RAMB18E2_ADDR_SZ-1:0] addr;
  begin
    read_attr = ATTR[addr];
  end
endfunction

task commit_attr;
  begin
    trig_attr = 1'b1;
    #100;
    trig_attr = 1'b0;
  end
endtask