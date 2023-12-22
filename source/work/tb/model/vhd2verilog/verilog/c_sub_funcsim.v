// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.4.1 (win64) Build 1149489 Thu Feb 19 16:23:09 MST 2015
// Date        : Fri Dec 22 09:26:24 2023
// Host        : E14-hulk running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim C:/OpenSSD/IPRepo/V2NFC100DDR/src/c_sub/c_sub_funcsim.v
// Design      : c_sub
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z045ffg900-3
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_addsub_v12_0,Vivado 2014.4.1" *) (* CHECK_LICENSE_TYPE = "c_sub,c_addsub_v12_0,{}" *) 
(* core_generation_info = "c_sub,c_addsub_v12_0,{x_ipProduct=Vivado 2014.4.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=c_addsub,x_ipVersion=12.0,x_ipCoreRevision=5,x_ipLanguage=VERILOG,x_ipSimLanguage=VERILOG,C_VERBOSITY=0,C_XDEVICEFAMILY=zynq,C_IMPLEMENTATION=0,C_A_WIDTH=15,C_B_WIDTH=15,C_OUT_WIDTH=15,C_CE_OVERRIDES_SCLR=0,C_A_TYPE=0,C_B_TYPE=0,C_LATENCY=0,C_ADD_MODE=1,C_B_CONSTANT=0,C_B_VALUE=000000000000000,C_AINIT_VAL=0,C_SINIT_VAL=0,C_CE_OVERRIDES_BYPASS=1,C_BYPASS_LOW=0,C_SCLR_OVERRIDES_SSET=1,C_HAS_C_IN=0,C_HAS_C_OUT=0,C_BORROW_LOW=1,C_HAS_CE=0,C_HAS_BYPASS=0,C_HAS_SCLR=0,C_HAS_SSET=0,C_HAS_SINIT=0}" *) 
(* NotValidForBitStream *)
module c_sub
   (A,
    B,
    S);
  input [14:0]A;
  input [14:0]B;
  output [14:0]S;

  wire [14:0]A;
  wire [14:0]B;
  wire [14:0]S;
  wire NLW_U0_C_OUT_UNCONNECTED;

(* C_ADD_MODE = "1" *) 
   (* C_AINIT_VAL = "0" *) 
   (* C_A_TYPE = "0" *) 
   (* C_A_WIDTH = "15" *) 
   (* C_BORROW_LOW = "1" *) 
   (* C_BYPASS_LOW = "0" *) 
   (* C_B_CONSTANT = "0" *) 
   (* C_B_TYPE = "0" *) 
   (* C_B_VALUE = "000000000000000" *) 
   (* C_B_WIDTH = "15" *) 
   (* C_CE_OVERRIDES_BYPASS = "1" *) 
   (* C_CE_OVERRIDES_SCLR = "0" *) 
   (* C_HAS_BYPASS = "0" *) 
   (* C_HAS_CE = "0" *) 
   (* C_HAS_C_IN = "0" *) 
   (* C_HAS_C_OUT = "0" *) 
   (* C_HAS_SCLR = "0" *) 
   (* C_HAS_SINIT = "0" *) 
   (* C_HAS_SSET = "0" *) 
   (* C_IMPLEMENTATION = "0" *) 
   (* C_LATENCY = "0" *) 
   (* C_OUT_WIDTH = "15" *) 
   (* C_SCLR_OVERRIDES_SSET = "1" *) 
   (* C_SINIT_VAL = "0" *) 
   (* C_VERBOSITY = "0" *) 
   (* C_XDEVICEFAMILY = "zynq" *) 
   (* DONT_TOUCH *) 
   (* downgradeipidentifiedwarnings = "yes" *) 
   c_sub_c_addsub_v12_0__parameterized0 U0
       (.A(A),
        .ADD(1'b1),
        .B(B),
        .BYPASS(1'b0),
        .CE(1'b1),
        .CLK(1'b0),
        .C_IN(1'b0),
        .C_OUT(NLW_U0_C_OUT_UNCONNECTED),
        .S(S),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* ORIG_REF_NAME = "c_addsub_v12_0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynq" *) 
(* C_IMPLEMENTATION = "0" *) (* C_A_WIDTH = "15" *) (* C_B_WIDTH = "15" *) 
(* C_OUT_WIDTH = "15" *) (* C_CE_OVERRIDES_SCLR = "0" *) (* C_A_TYPE = "0" *) 
(* C_B_TYPE = "0" *) (* C_LATENCY = "0" *) (* C_ADD_MODE = "1" *) 
(* C_B_CONSTANT = "0" *) (* C_B_VALUE = "000000000000000" *) (* C_AINIT_VAL = "0" *) 
(* C_SINIT_VAL = "0" *) (* C_CE_OVERRIDES_BYPASS = "1" *) (* C_BYPASS_LOW = "0" *) 
(* C_SCLR_OVERRIDES_SSET = "1" *) (* C_HAS_C_IN = "0" *) (* C_HAS_C_OUT = "0" *) 
(* C_BORROW_LOW = "1" *) (* C_HAS_CE = "0" *) (* C_HAS_BYPASS = "0" *) 
(* C_HAS_SCLR = "0" *) (* C_HAS_SSET = "0" *) (* C_HAS_SINIT = "0" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module c_sub_c_addsub_v12_0__parameterized0
   (A,
    B,
    CLK,
    ADD,
    C_IN,
    CE,
    BYPASS,
    SCLR,
    SSET,
    SINIT,
    C_OUT,
    S);
  input [14:0]A;
  input [14:0]B;
  input CLK;
  input ADD;
  input C_IN;
  input CE;
  input BYPASS;
  input SCLR;
  input SSET;
  input SINIT;
  output C_OUT;
  output [14:0]S;

  wire [14:0]A;
  wire ADD;
  wire [14:0]B;
  wire BYPASS;
  wire CE;
  wire CLK;
  wire C_IN;
  wire C_OUT;
  wire [14:0]S;
  wire SCLR;
  wire SINIT;
  wire SSET;

(* C_ADD_MODE = "1" *) 
   (* C_AINIT_VAL = "0" *) 
   (* C_A_TYPE = "0" *) 
   (* C_A_WIDTH = "15" *) 
   (* C_BORROW_LOW = "1" *) 
   (* C_BYPASS_LOW = "0" *) 
   (* C_B_CONSTANT = "0" *) 
   (* C_B_TYPE = "0" *) 
   (* C_B_VALUE = "000000000000000" *) 
   (* C_B_WIDTH = "15" *) 
   (* C_CE_OVERRIDES_BYPASS = "1" *) 
   (* C_CE_OVERRIDES_SCLR = "0" *) 
   (* C_HAS_BYPASS = "0" *) 
   (* C_HAS_CE = "0" *) 
   (* C_HAS_C_IN = "0" *) 
   (* C_HAS_C_OUT = "0" *) 
   (* C_HAS_SCLR = "0" *) 
   (* C_HAS_SINIT = "0" *) 
   (* C_HAS_SSET = "0" *) 
   (* C_IMPLEMENTATION = "0" *) 
   (* C_LATENCY = "0" *) 
   (* C_OUT_WIDTH = "15" *) 
   (* C_SCLR_OVERRIDES_SSET = "1" *) 
   (* C_SINIT_VAL = "0" *) 
   (* C_VERBOSITY = "0" *) 
   (* C_XDEVICEFAMILY = "zynq" *) 
   (* downgradeipidentifiedwarnings = "yes" *) 
   c_sub_c_addsub_v12_0_viv__parameterized0 xst_addsub
       (.A(A),
        .ADD(ADD),
        .B(B),
        .BYPASS(BYPASS),
        .CE(CE),
        .CLK(CLK),
        .C_IN(C_IN),
        .C_OUT(C_OUT),
        .S(S),
        .SCLR(SCLR),
        .SINIT(SINIT),
        .SSET(SSET));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2014"
`pragma protect key_keyowner = "Cadence Design Systems.", key_keyname= "cds_rsa_key", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 64)
`pragma protect key_block
h8K6vGIjBVbUQHzfXbUrl5/whf08Gqu+yw4ttmDR3YF8xx+MxaDV7O5td88kM38o6/JEYlFU3uZE
QXNnobMFkg==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-VERIF-SIM-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
o9/LuKVt9o249gjS19hRjev/8Ota2gPLw1eQ5xtFqKvj9Gw2mjPOZ7jUjKlj+orSy2u+vfmb9vF7
zsl7zzyxe6crcY0cEUoe8E/BqGRBH+Imu2ZskZAU6kimi1SPNvV2yJz3S/pAX7U/eNGMX7hFCdBi
q+g4fAiM9rXQZ5jPRV0=


`pragma protect key_keyowner = "Xilinx", key_keyname= "xilinx_2014_03", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
SEa6Fl2ikHhuFBA7bggD/0f212wM/0aQqHN/rjFVcijKjI/GLuGKMXRhhwucswJC20efA+ey7XpL
9TGk1E1u1SITDWI7JWLh2YI/VPoenSmzuyVjxKPpdLzloum5rl7RRf4G396zDmvRUsxEcjj5EgBR
HWfMQPY0ls7Wo/LNCrJbiLypytkzq/Au8JbfnKJDN8OSCS867YNvtCgGz7+z73wG2+0fXmsEyCHr
YMVlXRm4p20zXKDgTBEwswSOgCRzfO1jLKI1fpJ08nkIcJTlMYeFveP/HaDXdt1tMsAgne4HgpIq
jHHOI9MQQcl1OwdkSEou4akJhdOTlUOqb0bGAg==


`pragma protect key_keyowner = "Synopsys", key_keyname= "SNPS-VCS-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
uAvEPhq73XwNI2BQyRQ0PZQQgVV6a7M74r5tl3sMZ8rALYUw0rUNe6wD1AZN3RHLUeCi4juUwjO3
ng2ZBIgCx00fD73efJPEJ7JsPdo/h9eEw4r/yP892yv4A9cZIOKpY2i6GG4Sgyt7vfBguv2otRqf
DY0GyDKQRAqJj7Fb/Js=


`pragma protect key_keyowner = "Aldec", key_keyname= "ALDEC08_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
qgbM4qddr2A6nyKPw6hWN/yOQ5B0Nc5mu6hWhbJvUDNUBt82sudnB4woVubGXzukw9tQJxfo/Alu
BdXtFMghSOhuKLMF69qdIEw++dVSomEbnl6MnqiAtA9Ic8ErYH/RfdU2thSRfMpKg0CULk7IKqvM
OKkM0R7Gx1MB4NTx+lUtbCDahtvTzN4xKRxMVegdWwBzto7xwTUj10QNsYliFbjei+61fGagE1dG
hEFuzE1zBdgIdeIQZR9XTek3i579UQJRCMObkIoq1VPyzt/lR3LiTpio3x1knaWGPwW23ak87sZV
rxUjtAnJ2GYhFryo+nm2pby3bpe8zcd/sbDJWw==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-PREC-RSA", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
gjlL25Pc6CmJDxbSbbs9sTMnlSXGSHvIc9e+gBJ3Yfs6dRyIOupSRm/6hWwxn/bEt7FQiAMtI5vK
Ka9xSG/i5dnDUE2sdDRBS7EDmbmqTMbTEKcdpzWx901pk1+teGNrSat1BJr/LYAIvQ4JB4ODk+t6
MVL2XqxHUQZ9lEgmU8SDlt8pnIoXXrctOfq0AjG8JLiFbvSyRb3/GZfMcdY6IhplSWXAVnfxppp5
AmMwpTI/7k51ksBFERylecrRl1pLErGig0YFJOyK+OVsWAqw+fIQw42+TeXsWQlrg42p06dXcwPC
am20bTPhxKN5PrawIfPHz7OSbg6dwKVQOFGnPA==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
B3MsZiXkmfMmRPc5OQkarxIV8p1u8tnpVZGC/aoRfvXBTfKHHn0mWgugHbcqPNaNRz0CWOkpIHPT
DtvXbdB3xclO61Xqb5t1LVVbguA7rTQXUMpcOsUok+nquL0YrQ+IvXB1ocRYza7uFWNOt+mIKhdu
EaDaZePXl3D+3sCx1qTIW4xgrSnx4qxmt8oUabxMfupz7Z/tUhzxc9hUC4hpGye4nTPIMxL1BNZ9
dyeEAAAi8aezyCU5kDu5BdsHlaJhzncBEI74U7QCzq0gto36pTZZTw+JUSdpveAOFJ/LlJWpu428
5CGDhOzTZ6QcmYz4c7arN+mj0p3i/DMnNOc18Q==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 10336)
`pragma protect data_block
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
byuUBTc0zr5xHtFl2V1iJi3dUg==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
