`include "B_CMAC_defines.vh"

reg [`CMAC_DATA_SZ-1:0] ATTR [0:`CMAC_ADDR_N-1];
reg [40:1] CTL_PTP_TRANSPCLK_MODE_REG = CTL_PTP_TRANSPCLK_MODE;
reg [40:1] CTL_RX_CHECK_ACK_REG = CTL_RX_CHECK_ACK;
reg [40:1] CTL_RX_CHECK_PREAMBLE_REG = CTL_RX_CHECK_PREAMBLE;
reg [40:1] CTL_RX_CHECK_SFD_REG = CTL_RX_CHECK_SFD;
reg [40:1] CTL_RX_DELETE_FCS_REG = CTL_RX_DELETE_FCS;
reg [15:0] CTL_RX_ETYPE_GCP_REG = CTL_RX_ETYPE_GCP;
reg [15:0] CTL_RX_ETYPE_GPP_REG = CTL_RX_ETYPE_GPP;
reg [15:0] CTL_RX_ETYPE_PCP_REG = CTL_RX_ETYPE_PCP;
reg [15:0] CTL_RX_ETYPE_PPP_REG = CTL_RX_ETYPE_PPP;
reg [40:1] CTL_RX_FORWARD_CONTROL_REG = CTL_RX_FORWARD_CONTROL;
reg [40:1] CTL_RX_IGNORE_FCS_REG = CTL_RX_IGNORE_FCS;
reg [14:0] CTL_RX_MAX_PACKET_LEN_REG = CTL_RX_MAX_PACKET_LEN;
reg [7:0] CTL_RX_MIN_PACKET_LEN_REG = CTL_RX_MIN_PACKET_LEN;
reg [15:0] CTL_RX_OPCODE_GPP_REG = CTL_RX_OPCODE_GPP;
reg [15:0] CTL_RX_OPCODE_MAX_GCP_REG = CTL_RX_OPCODE_MAX_GCP;
reg [15:0] CTL_RX_OPCODE_MAX_PCP_REG = CTL_RX_OPCODE_MAX_PCP;
reg [15:0] CTL_RX_OPCODE_MIN_GCP_REG = CTL_RX_OPCODE_MIN_GCP;
reg [15:0] CTL_RX_OPCODE_MIN_PCP_REG = CTL_RX_OPCODE_MIN_PCP;
reg [15:0] CTL_RX_OPCODE_PPP_REG = CTL_RX_OPCODE_PPP;
reg [47:0] CTL_RX_PAUSE_DA_MCAST_REG = CTL_RX_PAUSE_DA_MCAST;
reg [47:0] CTL_RX_PAUSE_DA_UCAST_REG = CTL_RX_PAUSE_DA_UCAST;
reg [47:0] CTL_RX_PAUSE_SA_REG = CTL_RX_PAUSE_SA;
reg [40:1] CTL_RX_PROCESS_LFI_REG = CTL_RX_PROCESS_LFI;
reg [15:0] CTL_RX_VL_LENGTH_MINUS1_REG = CTL_RX_VL_LENGTH_MINUS1;
reg [63:0] CTL_RX_VL_MARKER_ID0_REG = CTL_RX_VL_MARKER_ID0;
reg [63:0] CTL_RX_VL_MARKER_ID1_REG = CTL_RX_VL_MARKER_ID1;
reg [63:0] CTL_RX_VL_MARKER_ID10_REG = CTL_RX_VL_MARKER_ID10;
reg [63:0] CTL_RX_VL_MARKER_ID11_REG = CTL_RX_VL_MARKER_ID11;
reg [63:0] CTL_RX_VL_MARKER_ID12_REG = CTL_RX_VL_MARKER_ID12;
reg [63:0] CTL_RX_VL_MARKER_ID13_REG = CTL_RX_VL_MARKER_ID13;
reg [63:0] CTL_RX_VL_MARKER_ID14_REG = CTL_RX_VL_MARKER_ID14;
reg [63:0] CTL_RX_VL_MARKER_ID15_REG = CTL_RX_VL_MARKER_ID15;
reg [63:0] CTL_RX_VL_MARKER_ID16_REG = CTL_RX_VL_MARKER_ID16;
reg [63:0] CTL_RX_VL_MARKER_ID17_REG = CTL_RX_VL_MARKER_ID17;
reg [63:0] CTL_RX_VL_MARKER_ID18_REG = CTL_RX_VL_MARKER_ID18;
reg [63:0] CTL_RX_VL_MARKER_ID19_REG = CTL_RX_VL_MARKER_ID19;
reg [63:0] CTL_RX_VL_MARKER_ID2_REG = CTL_RX_VL_MARKER_ID2;
reg [63:0] CTL_RX_VL_MARKER_ID3_REG = CTL_RX_VL_MARKER_ID3;
reg [63:0] CTL_RX_VL_MARKER_ID4_REG = CTL_RX_VL_MARKER_ID4;
reg [63:0] CTL_RX_VL_MARKER_ID5_REG = CTL_RX_VL_MARKER_ID5;
reg [63:0] CTL_RX_VL_MARKER_ID6_REG = CTL_RX_VL_MARKER_ID6;
reg [63:0] CTL_RX_VL_MARKER_ID7_REG = CTL_RX_VL_MARKER_ID7;
reg [63:0] CTL_RX_VL_MARKER_ID8_REG = CTL_RX_VL_MARKER_ID8;
reg [63:0] CTL_RX_VL_MARKER_ID9_REG = CTL_RX_VL_MARKER_ID9;
reg [40:1] CTL_TEST_MODE_PIN_CHAR_REG = CTL_TEST_MODE_PIN_CHAR;
reg [47:0] CTL_TX_DA_GPP_REG = CTL_TX_DA_GPP;
reg [47:0] CTL_TX_DA_PPP_REG = CTL_TX_DA_PPP;
reg [15:0] CTL_TX_ETHERTYPE_GPP_REG = CTL_TX_ETHERTYPE_GPP;
reg [15:0] CTL_TX_ETHERTYPE_PPP_REG = CTL_TX_ETHERTYPE_PPP;
reg [40:1] CTL_TX_FCS_INS_ENABLE_REG = CTL_TX_FCS_INS_ENABLE;
reg [40:1] CTL_TX_IGNORE_FCS_REG = CTL_TX_IGNORE_FCS;
reg [15:0] CTL_TX_OPCODE_GPP_REG = CTL_TX_OPCODE_GPP;
reg [15:0] CTL_TX_OPCODE_PPP_REG = CTL_TX_OPCODE_PPP;
reg [40:1] CTL_TX_PTP_1STEP_ENABLE_REG = CTL_TX_PTP_1STEP_ENABLE;
reg [10:0] CTL_TX_PTP_LATENCY_ADJUST_REG = CTL_TX_PTP_LATENCY_ADJUST;
reg [47:0] CTL_TX_SA_GPP_REG = CTL_TX_SA_GPP;
reg [47:0] CTL_TX_SA_PPP_REG = CTL_TX_SA_PPP;
reg [15:0] CTL_TX_VL_LENGTH_MINUS1_REG = CTL_TX_VL_LENGTH_MINUS1;
reg [63:0] CTL_TX_VL_MARKER_ID0_REG = CTL_TX_VL_MARKER_ID0;
reg [63:0] CTL_TX_VL_MARKER_ID1_REG = CTL_TX_VL_MARKER_ID1;
reg [63:0] CTL_TX_VL_MARKER_ID10_REG = CTL_TX_VL_MARKER_ID10;
reg [63:0] CTL_TX_VL_MARKER_ID11_REG = CTL_TX_VL_MARKER_ID11;
reg [63:0] CTL_TX_VL_MARKER_ID12_REG = CTL_TX_VL_MARKER_ID12;
reg [63:0] CTL_TX_VL_MARKER_ID13_REG = CTL_TX_VL_MARKER_ID13;
reg [63:0] CTL_TX_VL_MARKER_ID14_REG = CTL_TX_VL_MARKER_ID14;
reg [63:0] CTL_TX_VL_MARKER_ID15_REG = CTL_TX_VL_MARKER_ID15;
reg [63:0] CTL_TX_VL_MARKER_ID16_REG = CTL_TX_VL_MARKER_ID16;
reg [63:0] CTL_TX_VL_MARKER_ID17_REG = CTL_TX_VL_MARKER_ID17;
reg [63:0] CTL_TX_VL_MARKER_ID18_REG = CTL_TX_VL_MARKER_ID18;
reg [63:0] CTL_TX_VL_MARKER_ID19_REG = CTL_TX_VL_MARKER_ID19;
reg [63:0] CTL_TX_VL_MARKER_ID2_REG = CTL_TX_VL_MARKER_ID2;
reg [63:0] CTL_TX_VL_MARKER_ID3_REG = CTL_TX_VL_MARKER_ID3;
reg [63:0] CTL_TX_VL_MARKER_ID4_REG = CTL_TX_VL_MARKER_ID4;
reg [63:0] CTL_TX_VL_MARKER_ID5_REG = CTL_TX_VL_MARKER_ID5;
reg [63:0] CTL_TX_VL_MARKER_ID6_REG = CTL_TX_VL_MARKER_ID6;
reg [63:0] CTL_TX_VL_MARKER_ID7_REG = CTL_TX_VL_MARKER_ID7;
reg [63:0] CTL_TX_VL_MARKER_ID8_REG = CTL_TX_VL_MARKER_ID8;
reg [63:0] CTL_TX_VL_MARKER_ID9_REG = CTL_TX_VL_MARKER_ID9;
reg [40:1] TEST_MODE_PIN_CHAR_REG = TEST_MODE_PIN_CHAR;

initial begin
  ATTR[`CMAC__CTL_PTP_TRANSPCLK_MODE] = CTL_PTP_TRANSPCLK_MODE;
  ATTR[`CMAC__CTL_RX_CHECK_ACK] = CTL_RX_CHECK_ACK;
  ATTR[`CMAC__CTL_RX_CHECK_PREAMBLE] = CTL_RX_CHECK_PREAMBLE;
  ATTR[`CMAC__CTL_RX_CHECK_SFD] = CTL_RX_CHECK_SFD;
  ATTR[`CMAC__CTL_RX_DELETE_FCS] = CTL_RX_DELETE_FCS;
  ATTR[`CMAC__CTL_RX_ETYPE_GCP] = CTL_RX_ETYPE_GCP;
  ATTR[`CMAC__CTL_RX_ETYPE_GPP] = CTL_RX_ETYPE_GPP;
  ATTR[`CMAC__CTL_RX_ETYPE_PCP] = CTL_RX_ETYPE_PCP;
  ATTR[`CMAC__CTL_RX_ETYPE_PPP] = CTL_RX_ETYPE_PPP;
  ATTR[`CMAC__CTL_RX_FORWARD_CONTROL] = CTL_RX_FORWARD_CONTROL;
  ATTR[`CMAC__CTL_RX_IGNORE_FCS] = CTL_RX_IGNORE_FCS;
  ATTR[`CMAC__CTL_RX_MAX_PACKET_LEN] = CTL_RX_MAX_PACKET_LEN;
  ATTR[`CMAC__CTL_RX_MIN_PACKET_LEN] = CTL_RX_MIN_PACKET_LEN;
  ATTR[`CMAC__CTL_RX_OPCODE_GPP] = CTL_RX_OPCODE_GPP;
  ATTR[`CMAC__CTL_RX_OPCODE_MAX_GCP] = CTL_RX_OPCODE_MAX_GCP;
  ATTR[`CMAC__CTL_RX_OPCODE_MAX_PCP] = CTL_RX_OPCODE_MAX_PCP;
  ATTR[`CMAC__CTL_RX_OPCODE_MIN_GCP] = CTL_RX_OPCODE_MIN_GCP;
  ATTR[`CMAC__CTL_RX_OPCODE_MIN_PCP] = CTL_RX_OPCODE_MIN_PCP;
  ATTR[`CMAC__CTL_RX_OPCODE_PPP] = CTL_RX_OPCODE_PPP;
  ATTR[`CMAC__CTL_RX_PAUSE_DA_MCAST] = CTL_RX_PAUSE_DA_MCAST;
  ATTR[`CMAC__CTL_RX_PAUSE_DA_UCAST] = CTL_RX_PAUSE_DA_UCAST;
  ATTR[`CMAC__CTL_RX_PAUSE_SA] = CTL_RX_PAUSE_SA;
  ATTR[`CMAC__CTL_RX_PROCESS_LFI] = CTL_RX_PROCESS_LFI;
  ATTR[`CMAC__CTL_RX_VL_LENGTH_MINUS1] = CTL_RX_VL_LENGTH_MINUS1;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID0] = CTL_RX_VL_MARKER_ID0;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID10] = CTL_RX_VL_MARKER_ID10;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID11] = CTL_RX_VL_MARKER_ID11;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID12] = CTL_RX_VL_MARKER_ID12;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID13] = CTL_RX_VL_MARKER_ID13;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID14] = CTL_RX_VL_MARKER_ID14;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID15] = CTL_RX_VL_MARKER_ID15;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID16] = CTL_RX_VL_MARKER_ID16;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID17] = CTL_RX_VL_MARKER_ID17;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID18] = CTL_RX_VL_MARKER_ID18;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID19] = CTL_RX_VL_MARKER_ID19;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID1] = CTL_RX_VL_MARKER_ID1;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID2] = CTL_RX_VL_MARKER_ID2;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID3] = CTL_RX_VL_MARKER_ID3;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID4] = CTL_RX_VL_MARKER_ID4;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID5] = CTL_RX_VL_MARKER_ID5;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID6] = CTL_RX_VL_MARKER_ID6;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID7] = CTL_RX_VL_MARKER_ID7;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID8] = CTL_RX_VL_MARKER_ID8;
  ATTR[`CMAC__CTL_RX_VL_MARKER_ID9] = CTL_RX_VL_MARKER_ID9;
  ATTR[`CMAC__CTL_TEST_MODE_PIN_CHAR] = CTL_TEST_MODE_PIN_CHAR;
  ATTR[`CMAC__CTL_TX_DA_GPP] = CTL_TX_DA_GPP;
  ATTR[`CMAC__CTL_TX_DA_PPP] = CTL_TX_DA_PPP;
  ATTR[`CMAC__CTL_TX_ETHERTYPE_GPP] = CTL_TX_ETHERTYPE_GPP;
  ATTR[`CMAC__CTL_TX_ETHERTYPE_PPP] = CTL_TX_ETHERTYPE_PPP;
  ATTR[`CMAC__CTL_TX_FCS_INS_ENABLE] = CTL_TX_FCS_INS_ENABLE;
  ATTR[`CMAC__CTL_TX_IGNORE_FCS] = CTL_TX_IGNORE_FCS;
  ATTR[`CMAC__CTL_TX_OPCODE_GPP] = CTL_TX_OPCODE_GPP;
  ATTR[`CMAC__CTL_TX_OPCODE_PPP] = CTL_TX_OPCODE_PPP;
  ATTR[`CMAC__CTL_TX_PTP_1STEP_ENABLE] = CTL_TX_PTP_1STEP_ENABLE;
  ATTR[`CMAC__CTL_TX_PTP_LATENCY_ADJUST] = CTL_TX_PTP_LATENCY_ADJUST;
  ATTR[`CMAC__CTL_TX_SA_GPP] = CTL_TX_SA_GPP;
  ATTR[`CMAC__CTL_TX_SA_PPP] = CTL_TX_SA_PPP;
  ATTR[`CMAC__CTL_TX_VL_LENGTH_MINUS1] = CTL_TX_VL_LENGTH_MINUS1;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID0] = CTL_TX_VL_MARKER_ID0;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID10] = CTL_TX_VL_MARKER_ID10;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID11] = CTL_TX_VL_MARKER_ID11;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID12] = CTL_TX_VL_MARKER_ID12;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID13] = CTL_TX_VL_MARKER_ID13;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID14] = CTL_TX_VL_MARKER_ID14;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID15] = CTL_TX_VL_MARKER_ID15;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID16] = CTL_TX_VL_MARKER_ID16;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID17] = CTL_TX_VL_MARKER_ID17;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID18] = CTL_TX_VL_MARKER_ID18;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID19] = CTL_TX_VL_MARKER_ID19;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID1] = CTL_TX_VL_MARKER_ID1;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID2] = CTL_TX_VL_MARKER_ID2;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID3] = CTL_TX_VL_MARKER_ID3;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID4] = CTL_TX_VL_MARKER_ID4;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID5] = CTL_TX_VL_MARKER_ID5;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID6] = CTL_TX_VL_MARKER_ID6;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID7] = CTL_TX_VL_MARKER_ID7;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID8] = CTL_TX_VL_MARKER_ID8;
  ATTR[`CMAC__CTL_TX_VL_MARKER_ID9] = CTL_TX_VL_MARKER_ID9;
  ATTR[`CMAC__TEST_MODE_PIN_CHAR] = TEST_MODE_PIN_CHAR;
end

always @(trig_attr) begin
  CTL_PTP_TRANSPCLK_MODE_REG = ATTR[`CMAC__CTL_PTP_TRANSPCLK_MODE];
  CTL_RX_CHECK_ACK_REG = ATTR[`CMAC__CTL_RX_CHECK_ACK];
  CTL_RX_CHECK_PREAMBLE_REG = ATTR[`CMAC__CTL_RX_CHECK_PREAMBLE];
  CTL_RX_CHECK_SFD_REG = ATTR[`CMAC__CTL_RX_CHECK_SFD];
  CTL_RX_DELETE_FCS_REG = ATTR[`CMAC__CTL_RX_DELETE_FCS];
  CTL_RX_ETYPE_GCP_REG = ATTR[`CMAC__CTL_RX_ETYPE_GCP];
  CTL_RX_ETYPE_GPP_REG = ATTR[`CMAC__CTL_RX_ETYPE_GPP];
  CTL_RX_ETYPE_PCP_REG = ATTR[`CMAC__CTL_RX_ETYPE_PCP];
  CTL_RX_ETYPE_PPP_REG = ATTR[`CMAC__CTL_RX_ETYPE_PPP];
  CTL_RX_FORWARD_CONTROL_REG = ATTR[`CMAC__CTL_RX_FORWARD_CONTROL];
  CTL_RX_IGNORE_FCS_REG = ATTR[`CMAC__CTL_RX_IGNORE_FCS];
  CTL_RX_MAX_PACKET_LEN_REG = ATTR[`CMAC__CTL_RX_MAX_PACKET_LEN];
  CTL_RX_MIN_PACKET_LEN_REG = ATTR[`CMAC__CTL_RX_MIN_PACKET_LEN];
  CTL_RX_OPCODE_GPP_REG = ATTR[`CMAC__CTL_RX_OPCODE_GPP];
  CTL_RX_OPCODE_MAX_GCP_REG = ATTR[`CMAC__CTL_RX_OPCODE_MAX_GCP];
  CTL_RX_OPCODE_MAX_PCP_REG = ATTR[`CMAC__CTL_RX_OPCODE_MAX_PCP];
  CTL_RX_OPCODE_MIN_GCP_REG = ATTR[`CMAC__CTL_RX_OPCODE_MIN_GCP];
  CTL_RX_OPCODE_MIN_PCP_REG = ATTR[`CMAC__CTL_RX_OPCODE_MIN_PCP];
  CTL_RX_OPCODE_PPP_REG = ATTR[`CMAC__CTL_RX_OPCODE_PPP];
  CTL_RX_PAUSE_DA_MCAST_REG = ATTR[`CMAC__CTL_RX_PAUSE_DA_MCAST];
  CTL_RX_PAUSE_DA_UCAST_REG = ATTR[`CMAC__CTL_RX_PAUSE_DA_UCAST];
  CTL_RX_PAUSE_SA_REG = ATTR[`CMAC__CTL_RX_PAUSE_SA];
  CTL_RX_PROCESS_LFI_REG = ATTR[`CMAC__CTL_RX_PROCESS_LFI];
  CTL_RX_VL_LENGTH_MINUS1_REG = ATTR[`CMAC__CTL_RX_VL_LENGTH_MINUS1];
  CTL_RX_VL_MARKER_ID0_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID0];
  CTL_RX_VL_MARKER_ID10_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID10];
  CTL_RX_VL_MARKER_ID11_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID11];
  CTL_RX_VL_MARKER_ID12_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID12];
  CTL_RX_VL_MARKER_ID13_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID13];
  CTL_RX_VL_MARKER_ID14_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID14];
  CTL_RX_VL_MARKER_ID15_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID15];
  CTL_RX_VL_MARKER_ID16_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID16];
  CTL_RX_VL_MARKER_ID17_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID17];
  CTL_RX_VL_MARKER_ID18_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID18];
  CTL_RX_VL_MARKER_ID19_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID19];
  CTL_RX_VL_MARKER_ID1_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID1];
  CTL_RX_VL_MARKER_ID2_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID2];
  CTL_RX_VL_MARKER_ID3_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID3];
  CTL_RX_VL_MARKER_ID4_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID4];
  CTL_RX_VL_MARKER_ID5_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID5];
  CTL_RX_VL_MARKER_ID6_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID6];
  CTL_RX_VL_MARKER_ID7_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID7];
  CTL_RX_VL_MARKER_ID8_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID8];
  CTL_RX_VL_MARKER_ID9_REG = ATTR[`CMAC__CTL_RX_VL_MARKER_ID9];
  CTL_TEST_MODE_PIN_CHAR_REG = ATTR[`CMAC__CTL_TEST_MODE_PIN_CHAR];
  CTL_TX_DA_GPP_REG = ATTR[`CMAC__CTL_TX_DA_GPP];
  CTL_TX_DA_PPP_REG = ATTR[`CMAC__CTL_TX_DA_PPP];
  CTL_TX_ETHERTYPE_GPP_REG = ATTR[`CMAC__CTL_TX_ETHERTYPE_GPP];
  CTL_TX_ETHERTYPE_PPP_REG = ATTR[`CMAC__CTL_TX_ETHERTYPE_PPP];
  CTL_TX_FCS_INS_ENABLE_REG = ATTR[`CMAC__CTL_TX_FCS_INS_ENABLE];
  CTL_TX_IGNORE_FCS_REG = ATTR[`CMAC__CTL_TX_IGNORE_FCS];
  CTL_TX_OPCODE_GPP_REG = ATTR[`CMAC__CTL_TX_OPCODE_GPP];
  CTL_TX_OPCODE_PPP_REG = ATTR[`CMAC__CTL_TX_OPCODE_PPP];
  CTL_TX_PTP_1STEP_ENABLE_REG = ATTR[`CMAC__CTL_TX_PTP_1STEP_ENABLE];
  CTL_TX_PTP_LATENCY_ADJUST_REG = ATTR[`CMAC__CTL_TX_PTP_LATENCY_ADJUST];
  CTL_TX_SA_GPP_REG = ATTR[`CMAC__CTL_TX_SA_GPP];
  CTL_TX_SA_PPP_REG = ATTR[`CMAC__CTL_TX_SA_PPP];
  CTL_TX_VL_LENGTH_MINUS1_REG = ATTR[`CMAC__CTL_TX_VL_LENGTH_MINUS1];
  CTL_TX_VL_MARKER_ID0_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID0];
  CTL_TX_VL_MARKER_ID10_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID10];
  CTL_TX_VL_MARKER_ID11_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID11];
  CTL_TX_VL_MARKER_ID12_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID12];
  CTL_TX_VL_MARKER_ID13_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID13];
  CTL_TX_VL_MARKER_ID14_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID14];
  CTL_TX_VL_MARKER_ID15_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID15];
  CTL_TX_VL_MARKER_ID16_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID16];
  CTL_TX_VL_MARKER_ID17_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID17];
  CTL_TX_VL_MARKER_ID18_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID18];
  CTL_TX_VL_MARKER_ID19_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID19];
  CTL_TX_VL_MARKER_ID1_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID1];
  CTL_TX_VL_MARKER_ID2_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID2];
  CTL_TX_VL_MARKER_ID3_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID3];
  CTL_TX_VL_MARKER_ID4_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID4];
  CTL_TX_VL_MARKER_ID5_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID5];
  CTL_TX_VL_MARKER_ID6_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID6];
  CTL_TX_VL_MARKER_ID7_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID7];
  CTL_TX_VL_MARKER_ID8_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID8];
  CTL_TX_VL_MARKER_ID9_REG = ATTR[`CMAC__CTL_TX_VL_MARKER_ID9];
  TEST_MODE_PIN_CHAR_REG = ATTR[`CMAC__TEST_MODE_PIN_CHAR];
end

// procedures to override, read attribute values

task write_attr;
  input  [`CMAC_ADDR_SZ-1:0] addr;
  input  [`CMAC_DATA_SZ-1:0] data;
  begin
    ATTR[addr] = data;
    trig_attr = ~trig_attr; // to be removed
  end
endtask

function [`CMAC_DATA_SZ-1:0] read_attr;
  input  [`CMAC_ADDR_SZ-1:0] addr;
  begin
    read_attr = ATTR[addr];
  end
endfunction

task commit_attr;
  begin
    trig_attr = ~trig_attr;
  end
endtask