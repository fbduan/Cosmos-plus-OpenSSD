/****************************************************************************************
*
*   Disclaimer   This software code and all associated documentation, comments or other 
*  of Warranty:  information (collectively "Software") is provided "AS IS" without 
*                warranty of any kind. MICRON TECHNOLOGY, INC. ("MTI") EXPRESSLY 
*                DISCLAIMS ALL WARRANTIES EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
*                TO, NONINFRINGEMENT OF THIRD PARTY RIGHTS, AND ANY IMIED WARRANTIES 
*                OF MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. MTI DOES NOT 
*                WARRANT THAT THE SOFTWARE WILL MEET YOUR REQUIREMENTS, OR THAT THE 
*                OPERATION OF THE SOFTWARE WILL BE UNINTERRUPTED OR ERROR-FREE. 
*                FURTHERMORE, MTI DOES NOT MAKE ANY REPRESENTATIONS REGARDING THE USE OR 
*                THE RESULTS OF THE USE OF THE SOFTWARE IN TERMS OF ITS CORRECTNESS, 
*                ACCURACY, RELIABILITY, OR OTHERWISE. THE ENTIRE RISK ARISING OUT OF USE 
*                OR PERFORMANCE OF THE SOFTWARE REMAINS WITH YOU. IN NO EVENT SHALL MTI, 
*                ITS AFFILIATED COMPANIES OR THEIR SUPPLIERS BE LIABLE FOR ANY DIRECT, 
*                INDIRECT, CONSEQUENTIAL, INCIDENTAL, OR SPECIAL DAMAGES (INCLUDING, 
*                WITHOUT LIMITATION, DAMAGES FOR LOSS OF PROFITS, BUSINESS INTERRUPTION, 
*                OR LOSS OF INFORMATION) ARISING OUT OF YOUR USE OF OR INABILITY TO USE 
*                THE SOFTWARE, EVEN IF MTI HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH 
*                DAMAGES. Because some jurisdictions prohibit the exclusion or 
*                limitation of liability for consequential or incidental damages, the 
*                above limitation may not apply to you.
*
*                Copyright 2006 Micron Technology, Inc. All rights reserved.
*
****************************************************************************************/
//**************************************
//Asynchronous I/F timing parameters
//**************************************
// This devices supports 6 different async timing modes (0 through 5)
parameter MAX_ASYNC_TIM_MODE = 5;

//setup and hold times
//Command, Data, and Address Input
real  tADL_min; // ALE to data start
real  tALH_min; // ALE hold time
real  tALS_min; // ALE setup time
real  tCCS_min; // Change column time
real  tCH_min;  // CE# hold time
real  tCLH_min; // CLE hold time
real  tCLS_min; // CLE setup time
real  tCS_min; // CE# setup time
real  tDH_min; // Data hold time
real  tDS_min; // Data setup time
real  tWC_min; // write cycle time
real  tWH_min; // WE# pulse width HIGH
real  tWP_min; // WE# pulse width
real  tWW_min; // WP# setup time
//Normal Operation
real  tAR_min; // ALE to RE# delay
real  tCLR_min; // CLR to RE# delay
real  tOH_min; // CE# HIGH to output hold
real  tCOH_min; // CE# HIGH to output hold
real  tIR_min; // Output High-Z to RE# LOW
real  tRC_min; // read cycle time
real  tREH_min; // RE# HIGH hold time
real  tRHOH_min; // RE# HIGH to output hold
real  tRHW_min; // RE# HIGH to WE# LOW
real  tRLOH_min; // RE# LOW to output hold
real  tRP_min ; // RE# pulse width
real  tRR_min; // Ready to RE# LOW
real  tWHR_min; // WE# HIGH to RE# LOW

// program page cache mode has special timing checks for all configs
real  tALH_cache_min; // ALE hold time
real  tALS_cache_min; // ALE setup time
real  tCH_cache_min;  // CE# hold time
real  tCCS_cache_min; // Change column time
real  tCLH_cache_min; // CLE hold time
real  tCLS_cache_min; // CLE setup time
real  tCS_cache_min;  // CE# setup time
real  tDH_cache_min;  // Data hold time
real  tDS_cache_min;  // Data setup time
real  tIR_cache_min;  // Output High-Z to RE# LOW
real  tRC_cache_min;  // read cycle time
real  tREH_cache_min; // RE# HIGH hold time
real  tRLOH_cache_min;// RE# LOW to output hold
real  tRP_cache_min;  // RE# pulse width
real  tWC_cache_min;  // write cycle time
real  tWHR_cache_min; // WE# HIGH to RE# LOW
real  tWP_cache_min;  // WE# pulse width
real  tWH_cache_min;  // WE# pulse width HIGH
real  tWW_cache_min;  // WP# setup time
//Delays
real  tCEA_max; // CE# access time
real  tCHZ_max; // CE# HIGH to output High-Z
real  tREA_max; // RE# access time
real  tRHZ_max; // RE# HIGH to output High-Z
real  tWB_max; // WE# HIGH to busy
real  tCEA_cache_max; // CE# access time
real  tREA_cache_max; // RE# access time
real  tCHZ_cache_max; // CE# HIGH to output High-Z

real     tR_max;
real     tRCBSY_max;
real     tDCBSYR1_max; 

//PROGRAM/ERASE Characteristics
//parameter  tBERS_min            =    5000000; // BLOCK ERASE operation time
//parameter  tBERS_max            =   10000000; // BLOCK ERASE operation time
parameter  tBERS_min            =    500000 /500; // BLOCK ERASE operation time
parameter  tBERS_max            =   1000000 /1000; // BLOCK ERASE operation time
parameter  tCBSY_min            =   1100000 /1000; // Busy time for PROGRAM CACHE operation

parameter  tCBSY_max            =   2500000 /1000;  // Busy time for PROGRAM CACHE operation
parameter  tDBSY_min            =        500 /5; // Busy time for TWO-PLANE PROGRAM PAGE operation
parameter  tDBSY_max            =       1000 /5; // Busy time for TWO-PLANE PROGRAM PAGE operation
parameter  tFEAT                =       1000 /5; // Busy time for SET FEATURES and GET FEATURES operations
parameter  tITC_max             =       1000 /5; // Busy time for sync interface switch

parameter  tLBSY_min            =       2000 /5; // Busy time for PROGRAM/ERASE on locked block
parameter  tLBSY_max            =       3000 /5; // Busy time for PROGRAM/ERASE on locked block
parameter  tOBSY_max            =      50000 /50; // Busy time for OTP DATA PROGRAM if OTP is protected
//parameter  tPROG_typ            =     1875000; // Busy time for PAGE PROGRAM operation
//parameter  tPROG_vpp_typ        =     1545000; // Busy time for PAGE PROGRAM operation
//parameter  tPROG_max            =     2500000; // Busy time for PAGE PROGRAM operation 
parameter  tPROG_typ            =     187500 /500; // Busy time for PAGE PROGRAM operation
parameter  tPROG_vpp_typ        =     154500 /500; // Busy time for PAGE PROGRAM operation
parameter  tPROG_max            =     250000 /500; // Busy time for PAGE PROGRAM operation 
parameter  tPBSY_min            =      32000 /50;  
parameter  tPBSY_max            =      34000 /50;

parameter  NPP                  =          1; // Number of partial page programs
real       tLPROG_cache_typ                  ; // Prog Page Cache Last Page

real       tR_typ;
real       tR_vpp_typ;

parameter  tRCBSY_max_typ       =      145000/500; // Cache busy in page read cache mode (first 31h)
parameter  tRCBSY_max_retry     =      400000/500; // Cache busy in page read cache mode (first 31h)
parameter  tR_max_typ           =      145000/500; // Data transfer from Flash array to data register
parameter  tR_vpp_max_typ       =      95000 /500; // Data transfer from Flash array to data register
parameter  tR_SP_max_typ       =       85000 /500; // Data transfer from Flash array to data register
parameter  tR_SP_vpp_max_typ   =       75000 /500; // Data transfer from Flash array to data register
parameter  tR_max_retry         =      400000/500; // Data transfer from Flash array to data register

parameter  tR_mp_max            =     145000 /500; // Data transfer from Flash array to data register (multi-plane)
parameter  tRST_read            =      10000 /20; // RESET time issued during READ
parameter  tRST_prog            =      30000 /20; // RESET time issued during PROGRAM
parameter  tRST_erase           =     500000 /500; // RESET time issued during ERASE       
parameter  tRST_ready           =      5000  /20; // RESET time issued during idle

`ifdef SHORT_RESET
parameter  tVCC_delay           =        100 /1; // VCC valid to R/B# low valid
parameter  tRB_PU_max           =       1000 /5; // R/B# Power up delay.  
parameter  tRST_powerup         =    1000000 /1000; // RESET time issued after power-up    
`else  // default
parameter  tVCC_delay           =       1000 /5; // VCC valid to R/B# low valid
parameter  tRB_PU_max           =      10000 /80; // R/B# Power up delay.  
parameter  tRST_powerup         =    3000000 /1000; // RESET time issued after power-up    
`endif

//parameter  tESPD_max            =    1100000; // Erase Suspend operation time       
parameter  tESPD_max            =    110000 /100; // Erase Suspend operation time       
parameter  tESPDN_max           =     18000 /100; // Erase Resume operation dummy time with no erase suspended
//parameter  tEMLBi_R             =       500;  
//parameter  tEMLBi_L             =       500;  

parameter  tPSPD_min            =    150000 /500;
parameter  tPSPD_max            =    500000 /500;
parameter  tPSPDN_max           =    18000  /100;   //according to design datasheet;

parameter  tZQCS                =       300 /5;
parameter  tZQCL                =      1000 /5;

real       tRER;
real       tRER_vpp;

parameter  tRER_typ             =     90000 /100;
parameter  tRER_vpp_typ         =     70000 /100;
parameter  tRER_SP_typ          =     70000 /100;
parameter  tRER_SP_vpp_typ      =     60000 /100;
parameter  tRPP_typ             =     65000 /100;
parameter  tRPP_vpp_typ         =     60000 /100;
parameter  tRPPER_typ           =     61000 /100;
parameter  tRPPER_vpp_typ       =     55000 /100;


//unused timing parameters for this device
//programmable drivestrength timing parameters
parameter  tCLHIO_min           =           0; // Programmable I/O CLE hold time
parameter  tCLSIO_min           =           0; // Programmable I/O CLE setup time
parameter  tDHIO_min            =           0; // Programmable I/O data hold time
parameter  tDSIO_min            =           0; // Programmable I/O data setup time
parameter  tREAIO_max           =           0; // Programmable I/O RE# access time
parameter  tRPIO_min            =           0; // Programmable I/O RE# pulse width
parameter  tWCIO_min            =           0; // Programmable I/O write cycle time
parameter  tWHIO_min            =           0; // Programmable I/O pulse width high
parameter  tWHRIO_min           =           0; // Programmable I/O WE# high to RE# low
parameter  tWPIO_min            =           0; // Programmable I/O WE# pulse width

//EDO cycle time upper bound
parameter  tEDO_RC              =          30;
`define EDO

//**************************************
//Source Synchronous I/F timing parameters
//**************************************
// This devices supports 6 different sync timing modes (0 through 5)
parameter MAX_SYNC_TIM_MODE = 5;

// some timing parameters share the same names as an async param, thus the
//  need to add the sync identifier in the sync timing parameter name


real tAC_sync_max;   //Access window of DQ[7:0] from CLK
real tADL_sync_min;  // ALE to data start
real tCAD_sync_min;  //Cmd, Addr, Data delay
real tCALH_sync_min; //ALE, CLE, W/R# hold
real tCALS_sync_min; //ALE, CLE, W/R# setup
real tCAH_sync_min;  //DQ hold - Cmd, Addr
real tCAS_sync_min;  //DQ setup - Cmd, Addr
real tCCS_sync_min;  //Change column setup
real tCH_sync_min;   //CE# hold
real tCK_sync_min;   //min CLK cycle time
real tCK_sync_max;   //max CLK cycle time
real tCKH_sync_min;  //CLK cycle high
real tCKL_sync_min;  //CLK cycle low
real tCKH_sync_max;  //CLK cycle high
real tCKL_sync_max;  //CLK cycle low
integer tCKWR_sync_min; //Data Output End to W/R# High
real tCS_sync_min;   //CE# setup
real tDH_sync_min;      //Data In hold
real tDQSCK_sync_max;   //Access window of DQS from CLK
real tDQSD_sync_min;    //DQS, DQ[7:0] Driven by NAND
real tDQSHZ_sync_min;   //DQS, DQ[7:0] to tri-state
real tDQSH_sync_min;    //DQS input high pulse width
real tDQSH_sync_max;    //DQS input high pulse width
real tDQSL_sync_min;    //DQS input low pulse width
real tDQSL_sync_max;    //DQS input low pulse width
real tDQSS_sync_min;    //Data input
real tDQSS_sync_max;    //Data input
real tDQSQ_sync_max;    //DQS-DQ skew
real tDS_sync_min;      //Data In Setup
real tDSH_sync_min;     //DQS falling edge from CLK rising - hold
real tDSS_sync_min;     //DQS falling to CLK rising - setup
real tDVW_sync_min;     //DQS falling to CLK rising setup
real tHP_sync_min;      //Half Clock Period
real tQH_sync_min;      //DQ-DQS hold, DQS to first DQ to go non-valid, per access, (aka tOH)
real tQHS_sync_max;     //Data Hold Skew Factor, (aka tOHS)
real tRHW_sync_min;     // Data output to command, address, or data input
real tRPRE_sync_min;    // DQ driven to data output cycle request
real tRR_sync_min;      // Ready to data output
real tWB_sync_max;      // CLK high to R/B# low
real tWHR_sync_min;     // Command cycle to data output
real tWPRE_sync_min;    //DQS Write preamble
real tWPST_sync_min;    //DQS Write postamble
real tWRCK_sync_min;    // W/R# LOW to data output cycle
real tWW_sync_min;      // WP# transition to command cycle

real tACmaxDQSQmaxsync; 
real tACmaxQHminsync;   
real tACmaxDQSQmaxDVWminsync; 

//*************************************************
//Source Synchronous Enhanced I/F timing parameters
//*************************************************
// This devices supports 9 different sync enhanced timing modes (0 through 8)
parameter MAX_SYNC_ENH_TIM_MODE = 8;

real tAC_sync_enh_min;	// Access window of DQ[7:0] from CLK
real tAC_sync_enh_max;	// Access window of DQ[7:0] from CLK
real tADL_sync_enh_min;	// ALE to data start
real tAR_sync_enh_min;	// ALE to RE# low
real tCAH_sync_enh_min;	// DQ hold - Cmd, Addr
real tCALH_sync_enh_min;	// ALE, CLE, W/R# hold
real tCALS_sync_enh_min;	// ALE, CLE, W/R# setup
real tCALS2_sync_enh_min;	// ALE, CLE, W/R# setup2
real tCAS_sync_enh_min;	// DQ setup - Cmd, Addr
real tCH_sync_enh_min;	// CE# hold
real tCHZ_sync_enh_max;	// CE# high to output HiZ
real tCLHZ_sync_enh_max;	//CLE high to output HiZ
real tCLR_sync_enh_min;	// CLE to RE# low
real tCR_sync_enh_min;	// CE# to RE# low
real tCS_sync_enh_min;	// CE# setup
real tCS1_sync_enh_min;	// CE# setup for data output with ODT disabled
real tCS2_sync_enh_min;	// CE# setup for DQS/DQ with ODT enabled
real tRR_sync_enh_min;	// Ready to data output
real tWB_sync_enh_max;	// CLK high to R/B# low
real tWC_sync_enh_min;	// WE# cycle time
real tWH_sync_enh_min;	// WE# pulse width
real tWHR_sync_enh_min;	// Command cycle to data output
real tWP_sync_enh_min;	// WP# transition to command cycle
real tWW_sync_enh_min;	// WP# transition to command cycle
real tCDQSS_sync_enh_min;	// DQS setup time for data input start
real tDH_sync_enh_min;	// Data In hold
real tDS_sync_enh_min;	// Data In Setup
real tDQSH_sync_enh_min;	// DQS input high pulse width
real tDQSL_sync_enh_min;	// DQS input low pulse width
real tDSC_sync_enh_min;	// Average DQS cycle time
real tWPRE_sync_enh_min;	// DQS Write preamble
real tWPRE2_sync_enh_min;	// DQS Write preamble with ODT enabled
real tWPST_sync_enh_min;	// DQS Write postamble
real tWPSTH_sync_enh_min;	// DQS Write postamble hold time
real tDQSQ_sync_enh_max;	// DQS-DQ skew
real tDQSRE_sync_enh_max;	// Access window of DQS from RE#
real tDQSD_sync_enh_min;	// DQS, DQ[7:0] Driven by NAND
real tDQSD_sync_enh_max;	// DQS, DQ[7:0] Driven by NAND
real tDQSRH_sync_enh_min;	// DQS hold time ater RE# low Volume addressing
real tDVW_sync_enh_min;	// Data Valid window
real tQH_sync_enh_min;	// DQ-DQS hold, DQS to first DQ to go non-valid, per access, (aka tOH)
real tQSH_sync_enh_min;	// DQS output high time
real tQSL_sync_enh_min;	// DQS output low time
real tRC_sync_enh_min;	// Absolute RE# cycle time
real tREH_sync_enh_min;	// Average RE# hold time
real tREH_sync_enh_max;	// Average RE# hold time
real tRP_sync_enh_min;	// Average RE# pulse width
real tRP_sync_enh_max;	// Average RE# pulse width
real tRPRE_sync_enh_min;	// DQ driven to data output cycle request
real tRPRE2_sync_enh_min;	// Read preamble with ODT enabled
real tRPST_sync_enh_min;	// Read postamble
real tRPSTH_sync_enh_min;	// Read postamble hold time

real tDBS_sync_enh_min;	// DQS, RE# high setup to ALE, CLE, CE# low during data burst
real tCSD_sync_enh_min;	// ALE, CLE, WE# hold time from CE# high
real tRHW_sync_enh_min;	// Data output to command, address, or data input
real tCCS_sync_enh_min;	// Change column setup
real tVDLY_sync_enh_max;  //delay before next command after a folume is selected
real tCEH_sync_enh_min;  //CE# HIGH hold time prior to volume select

real tVDLY_max;		// delay before next command after a volume is selected
real tCEH_min;		// CE# hold time
real tENi_max;		// ENi low until any command issued is ignored
real tENo_max;		// CE# low until ENo low


//*************************************************
//Source Synchronous Enhanced I/F timing parameters
//*************************************************
// This devices supports 11 different sync enhanced timing modes (0 through 10)
parameter MAX_NV_DDR3_TIM_MODE = 8;

real tAC_nv_ddr3_min;	// Access window of DQ[7:0] from CLK
real tAC_nv_ddr3_max;	// Access window of DQ[7:0] from CLK
real tADL_nv_ddr3_min;	// ALE to data start
real tAR_nv_ddr3_min;	// ALE to RE# low
real tCAH_nv_ddr3_min;	// DQ hold - Cmd, Addr
real tCALH_nv_ddr3_min;	// ALE, CLE, W/R# hold
real tCALS_nv_ddr3_min;	// ALE, CLE, W/R# setup
real tCALS2_nv_ddr3_min;	// ALE, CLE, W/R# setup2
real tCAS_nv_ddr3_min;	// DQ setup - Cmd, Addr
real tCH_nv_ddr3_min;	// CE# hold
real tCHZ_nv_ddr3_max;	// CE# high to output HiZ
real tCLHZ_nv_ddr3_max;	//CLE high to output HiZ
real tCLR_nv_ddr3_min;	// CLE to RE# low
real tCR_nv_ddr3_min;	// CE# to RE# low
real tCS_nv_ddr3_min;	// CE# setup
real tCS1_nv_ddr3_min;	// CE# setup for data output with ODT disabled
real tCS2_nv_ddr3_min;	// CE# setup for DQS/DQ with ODT enabled
real tRR_nv_ddr3_min;	// Ready to data output
real tWB_nv_ddr3_max;	// CLK high to R/B# low
real tWC_nv_ddr3_min;	// WE# cycle time
real tWH_nv_ddr3_min;	// WE# pulse width
real tWHR_nv_ddr3_min;	// Command cycle to data output
real tWP_nv_ddr3_min;	// WP# transition to command cycle
real tWW_nv_ddr3_min;	// WP# transition to command cycle
real tCDQSS_nv_ddr3_min;	// DQS setup time for data input start
real tDH_nv_ddr3_min;	// Data In hold
real tDS_nv_ddr3_min;	// Data In Setup
real tDQSH_nv_ddr3_min;	// DQS input high pulse width
real tDQSL_nv_ddr3_min;	// DQS input low pulse width
real tDSC_nv_ddr3_min;	// Average DQS cycle time
real tWPRE_nv_ddr3_min;	// DQS Write preamble
real tWPRE2_nv_ddr3_min;	// DQS Write preamble with ODT enabled
real tWPST_nv_ddr3_min;	// DQS Write postamble
real tWPSTH_nv_ddr3_min;	// DQS Write postamble hold time
real tDQSQ_nv_ddr3_max;	// DQS-DQ skew
real tDQSRE_nv_ddr3_max;	// Access window of DQS from RE#
real tDQSD_nv_ddr3_min;	// DQS, DQ[7:0] Driven by NAND
real tDQSD_nv_ddr3_max;	// DQS, DQ[7:0] Driven by NAND
real tDQSRH_nv_ddr3_min;	// DQS hold time ater RE# low Volume addressing
real tDVW_nv_ddr3_min;	// Data Valid window
real tQH_nv_ddr3_min;	// DQ-DQS hold, DQS to first DQ to go non-valid, per access, (aka tOH)
real tQSH_nv_ddr3_min;	// DQS output high time
real tQSL_nv_ddr3_min;	// DQS output low time
real tRC_nv_ddr3_min;	// Absolute RE# cycle time
real tREH_nv_ddr3_min;	// Average RE# hold time
real tREH_nv_ddr3_max;	// Average RE# hold time
real tRP_nv_ddr3_min;	// Average RE# pulse width
real tRP_nv_ddr3_max;	// Average RE# pulse width
real tRPRE_nv_ddr3_min;	// DQ driven to data output cycle request
real tRPRE2_nv_ddr3_min;	// Read preamble with ODT enabled
real tRPST_nv_ddr3_min;	// Read postamble
real tRPSTH_nv_ddr3_min;	// Read postamble hold time

real tDBS_nv_ddr3_min;	// DQS, RE# high setup to ALE, CLE, CE# low during data burst
real tCSD_nv_ddr3_min;	// ALE, CLE, WE# hold time from CE# high
real tRHW_nv_ddr3_min;	// Data output to command, address, or data input
real tCCS_nv_ddr3_min;	// Change column setup
real tVDLY_nv_ddr3_max;		// delay before next command after a volume is selected
real tCEH_nv_ddr3_min;		// CE# hold time
//real tENi_max;		// ENi low until any command issued is ignored
//real tENo_max;		// CE# low until ENo low


task switch_timing_mode;
    input [5:0] new_mode;
    begin
        case (new_mode[5:4])
            4'h0 : begin // async
                if (new_mode[3:0] > MAX_ASYNC_TIM_MODE) begin
                    $display("%0t  :  ERROR: Illegal timing mode %d.  Max legal async timing mode = %d", $realtime, new_mode[3:0], MAX_ASYNC_TIM_MODE);
                    disable switch_timing_mode;
                end
            end
            4'h1 : begin // sync
	        if (new_mode[3:0] > MAX_SYNC_TIM_MODE) begin
	            $display("%0t  :  ERROR: Illegal timing mode %d.  Max legal sync timing mode = %d", $realtime, new_mode[3:0], MAX_SYNC_TIM_MODE);
                    disable switch_timing_mode;
                end
            end
            4'h2 : begin // sync_en
	        if (new_mode[3:0] > MAX_SYNC_ENH_TIM_MODE) begin
	            $display("%0t  :  ERROR: Illegal timing mode %d.  Max legal sync enhanced timing mode = %d", $realtime, new_mode[3:0], MAX_SYNC_ENH_TIM_MODE);
                    disable switch_timing_mode;
                end
            end

        endcase


        case (new_mode)
            8'h00 : begin // async mode 0
            	    tADL_min            =    300;
		    tALH_min            =     20;
		    tALS_min            =     50;
		    tAR_min             =     25;
		    tCEA_max            =    100;
		    tCH_min             =     20;
		    tCHZ_max            =    100;
		    tCLH_min            =     20;
		    tCLR_min            =     20;
		    tCLS_min            =     50;
		    tCOH_min            =      0;
		    tCS_min             =     70;
		    tDH_min             =     20;
		    tDS_min             =     40;
		    tIR_min             =     10;
		    tRC_min             =    100;
		    tREA_max            =     40;
		    tREH_min            =     30;
		    tRHOH_min           =      0;
		    tRHW_min            =    200;
		    tRHZ_max            =    200;
		    tRLOH_min           =      0;
		    tRP_min             =     50;
		    tRR_min             =     40;
		    tWB_max             =    200;
		    tWC_min             =    100;
		    tWH_min             =     30;
		    tWHR_min            =    120;
		    tWP_min             =     50;
            end
            8'h01 : begin // async mode 1
         	    tADL_min            =    300;
		    tALH_min            =     10;
		    tALS_min            =     25;
		    tAR_min             =     10;
		    tCEA_max            =     45;
		    tCH_min             =     10;
		    tCHZ_max            =     50;
		    tCLH_min            =     10;
		    tCLR_min            =     10;
		    tCLS_min            =     25;
		    tCOH_min            =     15;
		    tCS_min             =     35;
		    tDH_min             =     10;
		    tDS_min             =     20;
		    tIR_min             =      0;
		    tRC_min             =     50;
		    tREA_max            =     30;
		    tREH_min            =     15;
		    tRHOH_min           =     15;
		    tRHW_min            =    100;
		    tRHZ_max            =    100;
		    tRLOH_min           =      0;
		    tRP_min             =     25;
		    tRR_min             =     20;
		    tWB_max             =    100;
		    tWC_min             =     45;
		    tWH_min             =     15;
		    tWHR_min            =     80;
		    tWP_min             =     25;
            end
            8'h02 : begin // async mode 2
                    tADL_min            =    300;
		    tALH_min            =     10;
		    tALS_min            =     15;
		    tAR_min             =     10;
		    tCEA_max            =     30;
		    tCH_min             =     10;
		    tCHZ_max            =     50;
		    tCLH_min            =     10;
		    tCLR_min            =     10;
		    tCLS_min            =     15;
		    tCOH_min            =     15;
		    tCS_min             =     25;
		    tDH_min             =      5;
		    tDS_min             =     15;
		    tIR_min             =      0;
		    tRC_min             =     35;
		    tREA_max            =     25;
		    tREH_min            =     15;
		    tRHOH_min           =     15;
		    tRHW_min            =    100;
		    tRHZ_max            =    100;
		    tRLOH_min           =      0;
		    tRP_min             =     17;
		    tRR_min             =     20;
		    tWB_max             =    100;
		    tWC_min             =     35;
		    tWH_min             =     15;
		    tWHR_min            =     80;
		    tWP_min             =     17;
            end
            8'h03 : begin // async mode 3
              	    tADL_min            =    300;
		    tALH_min            =      5;
		    tALS_min            =     10;
		    tAR_min             =     10;
		    tCEA_max            =     25;
		    tCH_min             =      5;
		    tCHZ_max            =     50;
		    tCLH_min            =      5;
		    tCLR_min            =     10;
		    tCLS_min            =     10;
		    tCOH_min            =     15;
		    tCS_min             =     25;
		    tDH_min             =      5;
		    tDS_min             =     10;
		    tIR_min             =      0;
		    tRC_min             =     30;
		    tREA_max            =     20;
		    tREH_min            =     10;
		    tRHOH_min           =     15;
		    tRHW_min            =    100;
		    tRHZ_max            =    100;
		    tRLOH_min           =      0;
		    tRP_min             =     15;
		    tRR_min             =     20;
		    tWB_max             =    100;
		    tWC_min             =     30;
		    tWH_min             =     10;
		    tWHR_min            =     60;
		    tWP_min             =     15;
            end
            8'h04 : begin // async mode 4
                    tADL_min            =    300;
		    tALH_min            =      5;
		    tALS_min            =     10;
		    tAR_min             =     10;
		    tCEA_max            =     25;
		    tCH_min             =      5;
		    tCHZ_max            =     30;
		    tCLH_min            =      5;
		    tCLR_min            =     10;
		    tCLS_min            =     10;
		    tCOH_min            =     15;
		    tCS_min             =     20;
		    tDH_min             =      5;
		    tDS_min             =     10;
		    tIR_min             =      0;
		    tRC_min             =     25;
		    tREA_max            =     20;
		    tREH_min            =     10;
		    tRHOH_min           =     15;
		    tRHW_min            =    100;
		    tRHZ_max            =    100;
		    tRLOH_min           =      5;
		    tRP_min             =     12;
		    tRR_min             =     20;
		    tWB_max             =    100;
		    tWC_min             =     25;
		    tWH_min             =     10;
		    tWHR_min            =     60;
		    tWP_min             =     12;
            end
            8'h05 : begin // async mode 5
                tADL_min            =     300;
		    tALH_min            =      5;
		    tALS_min            =     10;
		    tAR_min             =     10;
		    tCEA_max            =     25;
		    tCH_min             =      5;
		    tCHZ_max            =     30;
		    tCLH_min            =      5;
		    tCLR_min            =     10;
		    tCLS_min            =     10;
		    tCOH_min            =     15;
		    tCS_min             =     15;
		    tDH_min             =      5;
		    tDS_min             =      7;
		    tIR_min             =      0;
		    tRC_min             =     20;
		    tREA_max            =     16;
		    tREH_min            =      7;
		    tRHOH_min           =     15;
		    tRHW_min            =    100;
		    tRHZ_max            =    100;
		    tRLOH_min           =      5;
		    tRP_min             =     10;
		    tRR_min             =     20;
		    tWB_max             =    100;
		    tWC_min             =     20;
		    tWH_min             =      7;
		    tWHR_min            =     60;
		    tWP_min             =     10;
            end
            8'h10 : begin // sync mode 0
                tADL_sync_min       =    300;
	            tCALH_sync_min      =     10;
	            tCALS_sync_min      =     10;
	            tCAH_sync_min       =     10;
	            tCAS_sync_min       =     10;
	            tCH_sync_min        =     10;
	            tCK_sync_min        =     50;
	            tCK_sync_max        =    100;
	            tCS_sync_min        =     35;
	            tDH_sync_min        =      5;
	            tDQSQ_sync_max      =      5;
	            tDS_sync_min        =    5.0;
	            tQHS_sync_max       =    6.0;
                tWHR_sync_min       =     80;
		    tRR_sync_min        =     40;
		    tWB_sync_max        =    100;
            end
            8'h11 : begin // sync mode 1
                tADL_sync_min       =    300;
	            tCALH_sync_min      =      5;
	            tCALS_sync_min      =      5;
	            tCAH_sync_min       =      5;
	            tCAS_sync_min       =      5;
	            tCH_sync_min        =      5;
	            tCK_sync_min        =     30;
	            tCK_sync_max        =     50;
	            tCS_sync_min        =     25;
	            tDH_sync_min        =    2.5;
	            tDQSQ_sync_max      =    2.5;
	            tDS_sync_min        =    3.0;
	            tQHS_sync_max       =    3.0;
                tWHR_sync_min       =     80;
		    tRR_sync_min        =     20;
		    tWB_sync_max        =    100;
		
            end
            8'h12 : begin // sync mode 2
                tADL_sync_min       =     300;
	            tCALH_sync_min      =      4;
	            tCALS_sync_min      =      4;
	            tCAH_sync_min       =      4;
	            tCAS_sync_min       =      4;
	            tCH_sync_min        =      4;
	            tCK_sync_min        =     20;
	            tCK_sync_max        =     30;
	            tCS_sync_min        =     15;
	            tDH_sync_min        =    1.7;
	            tDQSQ_sync_max      =    1.7;
	            tDS_sync_min        =    2.0;
	            tQHS_sync_max       =    2.0;
                tWHR_sync_min       =     80;
 		    tRR_sync_min        =     20;
		    tWB_sync_max        =    100;
           end
            8'h13 : begin // sync mode 3
                tADL_sync_min       =     300;
	            tCALH_sync_min      =      3;
	            tCALS_sync_min      =      3;
	            tCAH_sync_min       =      3;
	            tCAS_sync_min       =      3;
	            tCH_sync_min        =      3;
	            tCK_sync_min        =     15;
	            tCK_sync_max        =     20;
	            tCS_sync_min        =     15;
	            tDH_sync_min        =    1.3;
	            tDQSQ_sync_max      =    1.3;
	            tDS_sync_min        =    1.5;
	            tQHS_sync_max       =    1.5;
                tWHR_sync_min       =     80;
   		    tRR_sync_min        =     20;
		    tWB_sync_max        =    100;
          end
            8'h14 : begin // sync mode 4
                tADL_sync_min       =     300;
	            tCALH_sync_min      =    2.5;
	            tCALS_sync_min      =    2.5;
	            tCAH_sync_min       =    2.5;
	            tCAS_sync_min       =    2.5;
	            tCH_sync_min        =    2.5;
	            tCK_sync_min        =     12;
	            tCK_sync_max        =     15;
	            tCS_sync_min        =     15;
	            tDH_sync_min        =    1.1;
	            tDQSQ_sync_max      =    1.0;
	            tDS_sync_min        =    1.1;
	            tQHS_sync_max       =    1.2;
                tWHR_sync_min       =     80;
  		    tRR_sync_min        =     20;
		    tWB_sync_max        =    100;
           end
            8'h15 : begin // sync mode 5
                tADL_sync_min       =     300;
	            tCALH_sync_min      =      2;
	            tCALS_sync_min      =      2;
	            tCAH_sync_min       =      2;
	            tCAS_sync_min       =      2;
	            tCH_sync_min        =      2;
	            tCK_sync_min        =     10;
	            tCK_sync_max        =     12;
	            tCS_sync_min        =     15;
	            tDH_sync_min        =    0.9;
	            tDQSQ_sync_max      =   0.85;
	            tDS_sync_min        =    0.9;
	            tQHS_sync_max       =      1;
                tWHR_sync_min       =     80;
  		    tRR_sync_min        =     20;
		    tWB_sync_max        =    100;
           end
            8'h20 : begin // sync enhanced mode 0
                tADL_sync_enh_min       =    300;
	            tDH_sync_enh_min        =    4.0;
	            tDS_sync_enh_min        =    4.0;
                    tDSC_sync_enh_min       =    30;
	            tDQSQ_sync_enh_max      =    2.5;
                    tRC_sync_enh_min        =    30;
            end
            8'h21 : begin // sync enhanced mode 1
                tADL_sync_enh_min       =    300;
	            tDH_sync_enh_min        =    3.3;
	            tDS_sync_enh_min        =    3.3;
                    tDSC_sync_enh_min       =    25;
	            tDQSQ_sync_enh_max      =    2.0;
                    tRC_sync_enh_min        =    25;
            end
            8'h22 : begin // sync enhanced mode 2
                tADL_sync_enh_min       =    300;
	            tDH_sync_enh_min        =    2.0;
	            tDS_sync_enh_min        =    2.0;
                    tDSC_sync_enh_min       =    15;
	            tDQSQ_sync_enh_max      =    1.4;
                    tRC_sync_enh_min        =    15;
            end
            8'h23 : begin // sync enhanced mode 3
                tADL_sync_enh_min       =    300;
	            tDH_sync_enh_min        =    1.1;
	            tDS_sync_enh_min        =    1.1;
                    tDSC_sync_enh_min       =    12;
	            tDQSQ_sync_enh_max      =    1.0;
                    tRC_sync_enh_min        =    12;
            end
            8'h24 : begin // sync enhanced mode 4
                tADL_sync_enh_min       =    300;
	            tDH_sync_enh_min        =    0.7;
	            tDS_sync_enh_min        =    0.7;
                    tDSC_sync_enh_min       =    10;
	            tDQSQ_sync_enh_max      =    0.8;
                    tRC_sync_enh_min        =    10;
            end
            8'h25 : begin // sync enhanced mode 5
                tADL_sync_enh_min       =    300;
	            tDH_sync_enh_min        =    0.6;
	            tDS_sync_enh_min        =    0.6;
                    tDSC_sync_enh_min       =    7.5;
	            tDQSQ_sync_enh_max      =    0.6;
                    tRC_sync_enh_min        =    7.5;
            end
            8'h26 : begin // sync enhanced mode 6
                tADL_sync_enh_min       =    300;
	            tDH_sync_enh_min        =    0.55;
	            tDS_sync_enh_min        =    0.55;
                    tDSC_sync_enh_min       =    6;
	            tDQSQ_sync_enh_max      =    0.5;
                    tRC_sync_enh_min        =     6;
            end
            8'h27 : begin // sync enhanced mode 7
                tADL_sync_enh_min       =    300;
	            tDH_sync_enh_min        =    0.4;
	            tDS_sync_enh_min        =    0.4;
                    tDSC_sync_enh_min       =    5;
	            tDQSQ_sync_enh_max      =    0.4;
                    tRC_sync_enh_min        =     5;
            end
            8'h28 : begin // sync enhanced mode 8
                tADL_sync_enh_min       =    300;
	            tDH_sync_enh_min        =    0.3;
	            tDS_sync_enh_min        =    0.3;
                    tDSC_sync_enh_min       =    3.75;
	            tDQSQ_sync_enh_max      =    0.35;
                    tRC_sync_enh_min        =    3.75;
            end

            default : begin
	            $display("%0t  :  ERROR: Illegal timing mode %h.", $realtime, new_mode);
            end
        endcase

	tCCS_min            =    400;
        tOH_min             =    tCOH_min;
	tWW_min             =         100;
        tALH_cache_min 	    =    tALH_min;
        tALS_cache_min 	    =    tALS_min;
        tCCS_cache_min      =    tCCS_min;
        tCH_cache_min 	    =     tCH_min;
        tCLH_cache_min 	    =    tCLH_min;
        tCLS_cache_min 	    =    tCLS_min;
        tCS_cache_min	        =     tCS_min;
        tDH_cache_min		=     tDH_min;
        tDS_cache_min		=     tDS_min;
        tIR_cache_min		=     tIR_min;
        tRC_cache_min		=     tRC_min;
        tREH_cache_min	    =    tREH_min;
        tRLOH_cache_min	    =   tRLOH_min;
        tRP_cache_min		=     tRP_min;
        tWC_cache_min		=     tWC_min;
        tWHR_cache_min 	    =    tWHR_min;
        tWP_cache_min		=     tWP_min;
        tWH_cache_min		=     tWH_min;
        tWW_cache_min		=     tWW_min;
        tCEA_cache_max 	    =    tCEA_max;
        tREA_cache_max 	    =    tREA_max;
        tCHZ_cache_max 	    =    tCHZ_max;

	    tAC_sync_max        =     20;
	    tCAD_sync_min       =     25;
            tCCS_sync_min       =    400;
	    tCKH_sync_min       =      0.43 * tCK_sync_min;
	    tCKH_sync_max       =      0.57 * tCK_sync_min;
	    tCKL_sync_min       =      0.43 * tCK_sync_min;
	    tCKL_sync_max       =      0.57 * tCK_sync_min;
	    tDQSCK_sync_max     =     20;
	    tDQSD_sync_min      =     18;  // ??? max, min =0
	    tDQSHZ_sync_min     =     20;  // ??? max
	    tDQSH_sync_min      =      0.4 * tCK_sync_min;
	    tDQSH_sync_max      =      0.6 * tCK_sync_min;
	    tDQSL_sync_min      =      0.4 * tCK_sync_min;
	    tDQSL_sync_max      =      0.6 * tCK_sync_min;
	    tDQSS_sync_min      =      0.75 * tCK_sync_min;
	    tDQSS_sync_max      =      1.25 * tCK_sync_min;
	    tDSH_sync_min       =      0.2 * tCK_sync_min;
	    tDSS_sync_min       =      0.2 * tCK_sync_min;
        tRHW_sync_min       =    100;
        tRPRE_sync_min      =      0;
 
//        tRR_sync_min        =     20;
//        tWB_sync_max        =    100;

	    tWPRE_sync_min      =      1.5 * tCK_sync_min;
	    tWPST_sync_min      =      1.5 * tCK_sync_min;
        tWRCK_sync_min      =     20;
        tWW_sync_min        =    100;
        if(tCKL_sync_min < tCKH_sync_min)
            tHP_sync_min    =   tCKL_sync_min;
        else
            tHP_sync_min    =   tCKH_sync_min;
        tQH_sync_min        = tHP_sync_min - tQHS_sync_max;
        tDVW_sync_min       = tQH_sync_min - tDQSQ_sync_max;
	// by assigning quotient to integer type, quotient is automatically rounded to nearest integer
        tCKWR_sync_min      = ((tDQSCK_sync_max + tCK_sync_min) / tCK_sync_min);
        if (tCKWR_sync_min < ((tDQSCK_sync_max + tCK_sync_min) / tCK_sync_min))
		tCKWR_sync_min = tCKWR_sync_min + 1; // if tCKWR_sync_min was rounded down, then add 1 to it
	tACmaxDQSQmaxsync   = tAC_sync_max + tDQSQ_sync_max;
        tACmaxQHminsync     = tAC_sync_max + tQH_sync_min;
        tACmaxDQSQmaxDVWminsync = tAC_sync_max + tDQSQ_sync_max + tDVW_sync_min;
        tLPROG_cache_typ     = (2*tPROG_typ) -(tCLS_min +tCLH_min) -(tCS_min +(5*tWC_min) +tDH_min) -(tALS_min) -(tADL_min); // Prog Page Cache Last Page

	// For Sync Enhanced Parameters Common to All Modes

        tAC_sync_enh_min = 3;
        tAC_sync_enh_max = 25;
        tAR_sync_enh_min = 10;
        tCAH_sync_enh_min = 5;
        tCALH_sync_enh_min = 5;
        tCALS_sync_enh_min = 15;
        tCALS2_sync_enh_min = 25;
        tCAS_sync_enh_min = 5;
        tCH_sync_enh_min = 5;
        tCHZ_sync_enh_max = 30;
        tCLHZ_sync_enh_max = 30;
        tCLR_sync_enh_min  = 10;
        tCR_sync_enh_min  = 10;
        tCS_sync_enh_min  = 20;
        tCS1_sync_enh_min  = 30;
        tCS2_sync_enh_min  = 40;
        tRR_sync_enh_min   = 20;
        tWB_sync_enh_max   = 100;
        tWC_sync_enh_min   = 25;
        tWH_sync_enh_min   = 11;
        tWHR_sync_enh_min  = 80;
        tWP_sync_enh_min   = 11;
        tWW_sync_enh_min   = 100;
        tCDQSS_sync_enh_min = 30;
        tDQSH_sync_enh_min  = 0.43 * tDSC_sync_enh_min;
        tDQSL_sync_enh_min  = 0.43 * tDSC_sync_enh_min;
        tWPRE_sync_enh_min  = 15;
        tWPRE2_sync_enh_min  = 25;
        tWPST_sync_enh_min  = 6.5;
        tWPSTH_sync_enh_min  = 15;

        tDQSRE_sync_enh_max  = 25;
        tDQSD_sync_enh_min   = 5;
        tDQSD_sync_enh_max   = 18;
        tDQSRH_sync_enh_min  = 5;

        tQH_sync_enh_min     = 0.37 * tRC_sync_enh_min;
        tQSH_sync_enh_min    = 0.37 * tRC_sync_enh_min;
        tQSL_sync_enh_min    = 0.37 * tRC_sync_enh_min;
        tREH_sync_enh_min = 0.45 * tRC_sync_enh_min;
        tREH_sync_enh_max = 0.55 * tRC_sync_enh_min;
        tRP_sync_enh_min = 0.45 * tRC_sync_enh_min;
        tRP_sync_enh_max = 0.55 * tRC_sync_enh_min;

        tRPRE_sync_enh_min   = 15;
        tRPRE2_sync_enh_min   = 25;
        tRPST_sync_enh_min    = tDQSRE_sync_enh_max + 0.5 * tRC_sync_enh_min;
        tRPSTH_sync_enh_min   = 15;
        tDVW_sync_enh_min     = tQH_sync_enh_min - tDQSQ_sync_enh_max;
        
        tDBS_sync_enh_min     = 5;
        tCSD_sync_enh_min     = 10;
        tRHW_sync_enh_min     = 100;
        tCCS_sync_enh_min     = 400;
	tVDLY_sync_enh_max    = 50;
	tCEH_sync_enh_min     = 20;
        tVDLY_max             = 50;
        tCEH_min              = 20;
        tENi_max              = 15;
        tENo_max              = 50;

    end
endtask


task switch_timing_mode_ONFI4;
    input [3:0] new_mode;
    begin
        
        if (new_mode[3:0] > MAX_NV_DDR3_TIM_MODE) begin
          $display("%0t  :  ERROR: Illegal timing mode %d.  Max legal nv ddr3 timing mode = %d", $realtime, new_mode[3:0],MAX_NV_DDR3_TIM_MODE);
          disable switch_timing_mode_ONFI4;
        end


        case (new_mode)

            4'h0 : begin // nv ddr3 mode 0
                tADL_nv_ddr3_min       =    300;
	            tDH_nv_ddr3_min        =    4.0;
	            tDS_nv_ddr3_min        =    4.0;
                    tDSC_nv_ddr3_min       =    30;
	            tDQSQ_nv_ddr3_max      =    2.5;
                    tRC_nv_ddr3_min        =    30;
            end
            4'h1 : begin // nv ddr3 mode 1
                tADL_nv_ddr3_min       =    300;
	            tDH_nv_ddr3_min        =    3.3;
	            tDS_nv_ddr3_min        =    3.3;
                    tDSC_nv_ddr3_min       =    25;
	            tDQSQ_nv_ddr3_max      =    2.0;
                    tRC_nv_ddr3_min        =    25;
            end
            4'h2 : begin // nv ddr3 mode 2
                tADL_nv_ddr3_min       =    300;
	            tDH_nv_ddr3_min        =    2.0;
	            tDS_nv_ddr3_min        =    2.0;
                    tDSC_nv_ddr3_min       =    15;
	            tDQSQ_nv_ddr3_max      =    1.4;
                    tRC_nv_ddr3_min        =    15;
            end
            4'h3 : begin // nv ddr3 mode 3
                tADL_nv_ddr3_min       =    300;
	            tDH_nv_ddr3_min        =    1.1;
	            tDS_nv_ddr3_min        =    1.1;
                    tDSC_nv_ddr3_min       =    12;
	            tDQSQ_nv_ddr3_max      =    1.0;
                    tRC_nv_ddr3_min        =    12;
            end
            4'h4 : begin // nv ddr3 mode 4
                tADL_nv_ddr3_min       =    300;
	            tDH_nv_ddr3_min        =    0.7;
	            tDS_nv_ddr3_min        =    0.7;
                    tDSC_nv_ddr3_min       =    10;
	            tDQSQ_nv_ddr3_max      =    0.8;
                    tRC_nv_ddr3_min        =    10;
            end
            4'h5 : begin // nv ddr3 mode 5
                tADL_nv_ddr3_min       =    300;
	            tDH_nv_ddr3_min        =    0.6;
	            tDS_nv_ddr3_min        =    0.6;
                    tDSC_nv_ddr3_min       =    7.5;
	            tDQSQ_nv_ddr3_max      =    0.6;
                    tRC_nv_ddr3_min        =    7.5;
            end
            4'h6 : begin // nv ddr3 mode 6
                tADL_nv_ddr3_min       =    300;
	            tDH_nv_ddr3_min        =    0.55;
	            tDS_nv_ddr3_min        =    0.55;
                    tDSC_nv_ddr3_min       =    6;
	            tDQSQ_nv_ddr3_max      =    0.5;
                    tRC_nv_ddr3_min        =     6;
            end
            4'h7 : begin // nv ddr3 mode 7
                tADL_nv_ddr3_min       =    300;
	            tDH_nv_ddr3_min        =    0.4;
	            tDS_nv_ddr3_min        =    0.4;
                    tDSC_nv_ddr3_min       =    5;
	            tDQSQ_nv_ddr3_max      =    0.4;
                    tRC_nv_ddr3_min        =     5;
            end	    
            4'h8 : begin // nv ddr3 mode 8
                tADL_nv_ddr3_min       =    300;
	            tDH_nv_ddr3_min        =    0.3;
	            tDS_nv_ddr3_min        =    0.3;
                    tDSC_nv_ddr3_min       =    3.75;
	            tDQSQ_nv_ddr3_max      =    0.35;
                    tRC_nv_ddr3_min        =    3.75;
            end
            4'h9 : begin // nv ddr3 mode 9
                tADL_nv_ddr3_min       =    300;
	            tDH_nv_ddr3_min        =    0.24;
	            tDS_nv_ddr3_min        =    0.24;
                    tDSC_nv_ddr3_min       =    3;
	            tDQSQ_nv_ddr3_max      =    0.3;
                    tRC_nv_ddr3_min        =    3;
            end
            4'hA : begin // nv ddr3 mode 10
                tADL_nv_ddr3_min       =    300;
	            tDH_nv_ddr3_min        =    0.2;
	            tDS_nv_ddr3_min        =    0.2;
                    tDSC_nv_ddr3_min       =    2.5;
	            tDQSQ_nv_ddr3_max      =    0.25;
                    tRC_nv_ddr3_min        =    2.5;
            end
    
            default : begin
	            $display("%0t  :  ERROR: Illegal timing mode %h.", $realtime, new_mode);
            end
        endcase	
	
	// For NV DDR3 Parameters Common to All Modes

        tAC_nv_ddr3_min = 3;
        tAC_nv_ddr3_max = 25;
        tAR_nv_ddr3_min = 10;
        tCAH_nv_ddr3_min = 5;
        tCALH_nv_ddr3_min = 5;
        tCALS_nv_ddr3_min = 15;
        tCALS2_nv_ddr3_min = 25;
        tCAS_nv_ddr3_min = 5;
        tCH_nv_ddr3_min = 5;
        tCHZ_nv_ddr3_max = 30;
        tCLHZ_nv_ddr3_max = 30;
        tCLR_nv_ddr3_min  = 10;
        tCR_nv_ddr3_min  = 10;
        tCS_nv_ddr3_min  = 20;
        tCS1_nv_ddr3_min  = 30;
        tCS2_nv_ddr3_min  = 40;
        tRR_nv_ddr3_min   = 20;
        tWB_nv_ddr3_max   = 100;
        tWC_nv_ddr3_min   = 25;
        tWH_nv_ddr3_min   = 11;
        tWHR_nv_ddr3_min  = 80;
        tWP_nv_ddr3_min   = 11;
        tWW_nv_ddr3_min   = 100;
        tCDQSS_nv_ddr3_min = 30;
        tDQSH_nv_ddr3_min  = 0.43 * tDSC_nv_ddr3_min;
        tDQSL_nv_ddr3_min  = 0.43 * tDSC_nv_ddr3_min;
        tWPRE_nv_ddr3_min  = 15;
        tWPRE2_nv_ddr3_min  = 25;
        tWPST_nv_ddr3_min  = 6.5;
        tWPSTH_nv_ddr3_min  = 15;
	
        tDQSRE_nv_ddr3_max  = 25;
        tDQSD_nv_ddr3_min   = 5;
        tDQSD_nv_ddr3_max   = 18;
        tDQSRH_nv_ddr3_min  = 5;
	
        tQH_nv_ddr3_min     = 0.37 * tRC_nv_ddr3_min;
        tQSH_nv_ddr3_min    = 0.37 * tRC_nv_ddr3_min;
        tQSL_nv_ddr3_min    = 0.37 * tRC_nv_ddr3_min;
        tREH_nv_ddr3_min = 0.45 * tRC_nv_ddr3_min;
        tREH_nv_ddr3_max = 0.55 * tRC_nv_ddr3_min;
        tRP_nv_ddr3_min = 0.45 * tRC_nv_ddr3_min;
        tRP_nv_ddr3_max = 0.55 * tRC_nv_ddr3_min;
	
        tRPRE_nv_ddr3_min   = 15;
        tRPRE2_nv_ddr3_min   = 25;
        tRPST_nv_ddr3_min    = tDQSRE_nv_ddr3_max + 0.5 * tRC_nv_ddr3_min;
        tRPSTH_nv_ddr3_min   = 15;

        tDVW_nv_ddr3_min     = tQH_nv_ddr3_min - tDQSQ_nv_ddr3_max;
	
        tDBS_nv_ddr3_min     = 5;
        tCSD_nv_ddr3_min     = 10;
        tRHW_nv_ddr3_min     = 100;
        tCCS_nv_ddr3_min     = 400;
        tVDLY_nv_ddr3_max    = 50;
        tCEH_nv_ddr3_min     = 20;
        tENi_max              = 15;
        tENo_max              = 50;	
	
end		
endtask



initial begin

    tR_max       = tR_max_typ;
    tRCBSY_max   = tRCBSY_max_typ;
    tDCBSYR1_max = tRCBSY_max;
    
    tCK_sync_min = 100; // initial dummy value to prevent Infinity results from division operation errors during switch_timing_mode(8'h00)
    

    switch_timing_mode(8'h00);
    switch_timing_mode(8'h10);
    switch_timing_mode(8'h20);
    switch_timing_mode_ONFI4(8'h00);

    
end

//tCCS is defined in the parameter page


//--------------------- end timing params ---------------------

//--------------------------------------------------------
//Device memory array configuration parameters


parameter PAGE_BITS       =   10;     // MLC: 1024 pages/block
parameter COL_BITS        =   15;     // 16K + 2208
parameter COL_CNT_BITS    =   15;   
parameter BLCK_BITS	  =   12;     //  The Plane Bit is included. 548 Blks/Plane 

parameter DQ_BITS         =    8;
parameter NUM_OTP_ROW     =   29;  // Number of OTP pages
parameter OTP_ADDR_MAX    =    NUM_OTP_ROW+3;
parameter OTP_NPP         =    2;  // Number of Partial Programs in OTP
parameter NUM_BOOT_BLOCKS =    0;  // unused for this part
parameter BOOT_BLOCK_BITS =    1;  // unused for this part

// --------- valid sizes  ---------------
// flash memory array organization
`ifdef CLASST
    parameter LUN_BITS  =    1;
    parameter ROW_BITS  =   23;
`else `ifdef CLASSK
    parameter LUN_BITS  =    1;
    parameter ROW_BITS  =   23;
`else `ifdef CLASSU
    parameter LUN_BITS  =    1;
    parameter ROW_BITS  =   23;
`else 
    // default CLASSB, E, F, M
    `ifdef DIES2
      parameter LUN_BITS  =    1;
      parameter ROW_BITS  =   23;
	`else
      parameter LUN_BITS  =    0;
      parameter ROW_BITS  =   22;//change to 31 due to feature of 6 address cycle
	`endif
`endif `endif `endif


`ifdef FullMem   // Only do this if you require the full memory size.
//Defining FullMem will make simulation EXTREMELY SLOW!!
parameter NUM_ROW   = 1 << ROW_BITS;  // PagesXBlocks
`else
// smaller values for fast sim load, increase these parameters if you need more model memory during simulation
parameter NUM_ROW   = 1024;  // smaller values for fast sim load
`endif

parameter NUM_COL    = 18592; //16K + 2208 spare bytes
parameter NUM_PAGE   = (1 << PAGE_BITS);  
parameter NUM_PLANES =    4;
//parameter NUM_BLCK   = (1 << BLCK_BITS) -1; 
parameter NUM_BLCK   = 2191; 
parameter BPC_MAX   = 3'b001;
parameter BPC       = 3'b001;
parameter PAGE_SIZE     =       NUM_COL*BPC_MAX*DQ_BITS;

`define PAGEBITSGT8
// read id parameters
parameter NUM_ID_BYTES          =      8;
parameter READ_ID_BYTE0     	=  8'h2c;   // Micron Manufacturer ID
`ifdef CLASSU
    parameter READ_ID_BYTE1 	=  8'hC4;
    parameter READ_ID_BYTE2 	=  8'hE5;
`else `ifdef CLASSK
    parameter READ_ID_BYTE1 	=  8'hC4;
    parameter READ_ID_BYTE2 	=  8'hE5;
`else `ifdef CLASST
    parameter READ_ID_BYTE1 	=  8'hC4;
    parameter READ_ID_BYTE2 	=  8'hE5;
`else // CLASS B, E, F, M
    parameter READ_ID_BYTE1 	=  8'hAA;
    parameter READ_ID_BYTE2 	=  8'hE4;
`endif `endif `endif
parameter READ_ID_BYTE3 	=  8'h34;
parameter READ_ID_BYTE4		=  8'hAA;
parameter READ_ID_BYTE5		=  8'h04;
parameter READ_ID_BYTE6		=  8'h00;
parameter READ_ID_BYTE7		=  8'h00;
`define IDBYTESGT5 // used to tell model that there are more than 5 ID bytes

//-------------------------------------------
//   Supported features of this device
//-------------------------------------------
parameter FEATURE_SET = 16'b1100011001101011;
//     MP Read using Cache--||||||||||||||||--basic NAND commands
//          Multi-Plane cmd--||||||||||||||--new commands (page rd cache commands)
//           boot block lock--||||||||||||--read ID2
//                       used--||||||||||--read unique
//                 page unlock--||||||||--OTP commands
//                     ONFI_OTP--||||||--Legacy 2plane commands
//                      features--||||--ONFI 
//       drive strength(non-ONFI)--||--block lock

parameter FEATURE_SET2 = 16'b0000000110111010;
//                   unused--||||||||||||||||--ECC timing
//                    unused--||||||||||||||--Reset LUN command
//                     unused--||||||||||||--MP Read output
//                      unused--||||||||||--Program Clear
//                       unused--||||||||--JEDEC
//                        unused--||||||--ONFI3
//                         unused--||||--unused
//                One Pass Program--||--ONFI4

parameter DRIVESTR_EN = 3'h3; // supports feature address 80H or 10h
parameter NOONFIRDCACHERANDEN = 3'h0; // non-onfi read page cache random enable (special case)

//-------------------------------------------
//   Multiple Die Setup
//-------------------------------------------
`ifdef CLASSE
    `define NUM_DIE2
    `define DIES2
    parameter NUM_DIE   =   2;
    parameter NUM_CE    =   2;
//    `define D2T2B2C2D2;  // 2 Die, 2 Target, 2 R/B, Separate Cmd (2 cmd buses), Separate Data (2 data buses)
    parameter async_only_n = 1'b1;
`else `ifdef CLASSF
    `define NUM_DIE2
    parameter NUM_DIE   =   2;
    parameter NUM_CE    =   2;
//    `define D2T2B2C1D1;  // 2 Die, 2 Target, 2 R/B, Common Cmd (1 cmd bus), Common Data (1 data bus)
    `ifdef NAND_SYNC
	parameter async_only_n = 1'b1;
    `else
	parameter async_only_n = 1'b0;
    `endif
`else `ifdef CLASSK
    `define NUM_DIE4
    `define DIES4    
    parameter NUM_DIE   =   4;
    parameter NUM_CE    =   2;
//    `define D4T2B2C2D2;  // 4 Die, 2 Target, 2 R/B, Separate Cmd (2 cmd buses), Separate Data (2 data buses)
    parameter async_only_n = 1'b1;

`else `ifdef CLASSM
    `define NUM_DIE4
    `define DIES4    
    parameter NUM_DIE   =   4;
    parameter NUM_CE    =   4;
//    `define D4T4B4C2D2;  // 4 Die, 4 Target, 4 R/B, Separate Cmd (2 cmd buses), Separate Data (2 data buses)
    parameter async_only_n = 1'b1;

`else `ifdef CLASSU

    `define NUM_DIE8
    `define DIES8        
    parameter NUM_DIE   =   8;
    parameter NUM_CE    =   4;
//    `define D8T4B4C2D2;  // 8 Die, 4 Target, 4 R/B, Separate Cmd (2 cmd buses), Separate Data (2 data buses)
    `ifdef NAND_SYNC
	parameter async_only_n = 1'b1;
    `else
	parameter async_only_n = 1'b0;
    `endif
`else `ifdef CLASST
    `define NUM_DIE16
    `define DIES16        
    parameter NUM_DIE   =   16;
    parameter NUM_CE    =   8;
//    `define D16T8B4C2D2;  // 16 Die, 8 Target, 4 R/B, Separate Cmd (2 cmd buses), Separate Data (2 data buses)
    `ifdef NAND_SYNC
	parameter async_only_n = 1'b1;
    `else
	parameter async_only_n = 1'b0;
    `endif
`else  // DEFAULT = CLASSB
    `ifndef DIES2
            parameter NUM_DIE   =   1;
            parameter NUM_CE    =   1;
    `else //Added for MultiDie simulation 
            parameter NUM_DIE   =   2;
            parameter NUM_CE    =   1;
    `endif 
    
    `ifdef NAND_SYNC
         parameter async_only_n = 1'b1;
    `else
         parameter async_only_n = 1'b0;
    `endif


`endif `endif `endif `endif `endif `endif

//-------------------------------------------
//   ONFI Setup
//-------------------------------------------
//need to keep this in params file since ever NAND device will have different values
reg [DQ_BITS -1 : 0]        onfi_params_array [NUM_COL-1 : 0]; // packed array
reg [PAGE_SIZE -1 : 0]      onfi_params_array_unpacked;

reg [DQ_BITS -1 : 0]        onfi_params_array_ext [47 : 0]; // packed array
reg [48*8-1:0]              onfi_params_array_ext_unpacked;

`define JEDEC_ARRAY_DEFINED
reg [DQ_BITS -1 : 0]        jedec_params_array [511 : 0]; // packed array
reg [PAGE_SIZE -1 : 0]      jedec_params_array_unpacked; 



task setup_params_array;
    integer k;
    reg [PAGE_SIZE -1 : 0]      mask;
    begin
    // Here we set the values of the read-only ONFI parameters.
    // These are defined by the ONFI spec
    // and are the default power-on values for the ONFI FEATURES supported by this device.
    //-------------------------------------
    // Parameter page signature
    onfi_params_array[0] = 8'h4F; // 'O'
    onfi_params_array[1] = 8'h4E; // 'N'
    onfi_params_array[2] = 8'h46; // 'F'
    onfi_params_array[3] = 8'h49; // 'I'
    // ONFI revision number
    onfi_params_array[4] = 8'hFE; // ONFI 2.3 compliant
    onfi_params_array[5] = 8'h03;
    
    // Features supported
    `ifdef ONFI4
       `ifdef CLASSU
	    onfi_params_array[6] = 8'hDA;
	    onfi_params_array[7] = 8'hF9;
       `else `ifdef CLASSK
	    onfi_params_array[6] = 8'hDA;
	    onfi_params_array[7] = 8'hF9;
       `else `ifdef CLASST
	    onfi_params_array[6] = 8'hDA;
	    onfi_params_array[7] = 8'hF9;
       `else `ifdef CLASSM
	    onfi_params_array[6] = 8'hD8;
	    onfi_params_array[7] = 8'hF9;	    
       `else `ifdef CLASSE
	    onfi_params_array[6] = 8'hD8;
	    onfi_params_array[7] = 8'hF9;
       `else `ifdef CLASSB // CLASS B
	    onfi_params_array[6] = 8'hD8;
	    onfi_params_array[7] = 8'hF9;	 
        `endif `endif `endif `endif `endif `endif 
    `else	
       `ifdef CLASSB
	    onfi_params_array[6] = 8'hF8;
	    onfi_params_array[7] = 8'hDD;
       `else `ifdef CLASSF
	    onfi_params_array[6] = 8'hF8;
	    onfi_params_array[7] = 8'h5D;
       `else `ifdef CLASSE
	    onfi_params_array[6] = 8'hF8;
	    onfi_params_array[7] = 8'hDD;
       `else `ifdef CLASSM
	    onfi_params_array[6] = 8'hF8;
	    onfi_params_array[7] = 8'hDD;
       `else //CLASSK,U,T
	    onfi_params_array[6] = 8'hFA;
	    onfi_params_array[7] = 8'hDD;
       `endif `endif `endif `endif
    `endif
    // optional command supported
       
    // Reserved
    onfi_params_array[8] = 8'hFF;
    onfi_params_array[9] = 8'h3F;
    onfi_params_array[10] = 8'h0F;
    onfi_params_array[11] = 8'h00;
    // Extended parameter page length
    onfi_params_array[12] = 8'h03;
    onfi_params_array[13] = 8'h00;
    // number of parameter pages
    onfi_params_array[14] = 8'h3D;
    // Reserved
    for (k=15; k<=31 ; k=k+1) begin
        onfi_params_array[k] = 8'h00;
    end
    // Manufacturer ID
    onfi_params_array[32] = 8'h4D; //M
    onfi_params_array[33] = 8'h49; //I
    onfi_params_array[34] = 8'h43; //C
    onfi_params_array[35] = 8'h52; //R
    onfi_params_array[36] = 8'h4F; //O
    onfi_params_array[37] = 8'h4E; //N
    onfi_params_array[38] = 8'h20;
    onfi_params_array[39] = 8'h20;
    onfi_params_array[40] = 8'h20;
    onfi_params_array[41] = 8'h20;
    onfi_params_array[42] = 8'h20;
    onfi_params_array[43] = 8'h20;    
    // Device model
    onfi_params_array[44] = 8'h4D; //M
    onfi_params_array[45] = 8'h54; //T
    onfi_params_array[46] = 8'h32; //2
    onfi_params_array[47] = 8'h39; //9
    onfi_params_array[48] = 8'h46; //F

    `ifdef ONFI4
       `ifdef CLASSU
            onfi_params_array[49] = 8'h32; //2
            onfi_params_array[50] = 8'h54; //T
            onfi_params_array[51] = 8'h30; //0
            onfi_params_array[52] = 8'h38; //8
            onfi_params_array[53] = 8'h43; //C
            onfi_params_array[54] = 8'h55; //U
            onfi_params_array[55] = 8'h46; //F
            onfi_params_array[56] = 8'h42; //B
            onfi_params_array[57] = 8'h45; //E
            onfi_params_array[58] = 8'h4D; //M
            onfi_params_array[59] = 8'h34; //4
            onfi_params_array[60] = 8'h20; //
            onfi_params_array[61] = 8'h20; //
	    onfi_params_array[62] = 8'h20; //
	`else `ifdef CLASSM
            onfi_params_array[49] = 8'h31; //1
            onfi_params_array[50] = 8'h54; //T
            onfi_params_array[51] = 8'h30; //0
            onfi_params_array[52] = 8'h38; //8
            onfi_params_array[53] = 8'h43; //C
            onfi_params_array[54] = 8'h4D; //M
            onfi_params_array[55] = 8'h46; //F
            onfi_params_array[56] = 8'h42; //B
            onfi_params_array[57] = 8'h45; //E
            onfi_params_array[58] = 8'h4A; //J
            onfi_params_array[59] = 8'h34; //4
            onfi_params_array[60] = 8'h20; //
            onfi_params_array[61] = 8'h20; //
	    onfi_params_array[62] = 8'h20; //
	`else `ifdef CLASSK
            onfi_params_array[49] = 8'h31; //1
            onfi_params_array[50] = 8'h54; //T
            onfi_params_array[51] = 8'h30; //0
            onfi_params_array[52] = 8'h38; //8
            onfi_params_array[53] = 8'h43; //C
            onfi_params_array[54] = 8'h4B; //K
            onfi_params_array[55] = 8'h46; //F
            onfi_params_array[56] = 8'h42; //B
            onfi_params_array[57] = 8'h45; //E
            onfi_params_array[58] = 8'h4A; //J
            onfi_params_array[59] = 8'h34; //4
            onfi_params_array[60] = 8'h20; //
            onfi_params_array[61] = 8'h20; //
	    onfi_params_array[62] = 8'h20; //
	`else `ifdef CLASSE
            onfi_params_array[49] = 8'h35; //5
            onfi_params_array[50] = 8'h31; //1
            onfi_params_array[51] = 8'h32; //2
            onfi_params_array[52] = 8'h47; //G
            onfi_params_array[53] = 8'h30; //0
            onfi_params_array[54] = 8'h38; //8
            onfi_params_array[55] = 8'h43; //C
            onfi_params_array[56] = 8'h45; //E
            onfi_params_array[57] = 8'h46; //F
            onfi_params_array[58] = 8'h42; //B
            onfi_params_array[59] = 8'h45; //E
            onfi_params_array[60] = 8'h4A; //J
            onfi_params_array[61] = 8'h34; //4
	    onfi_params_array[62] = 8'h20; 
	`else `ifdef CLASST
            onfi_params_array[49] = 8'h34; //4
            onfi_params_array[50] = 8'h54; //T
            onfi_params_array[51] = 8'h30; //0
            onfi_params_array[52] = 8'h38; //8
            onfi_params_array[53] = 8'h43; //C
            onfi_params_array[54] = 8'h54; //T
            onfi_params_array[55] = 8'h46; //F
            onfi_params_array[56] = 8'h42; //B
            onfi_params_array[57] = 8'h45; //E
            onfi_params_array[58] = 8'h4A; //J
            onfi_params_array[59] = 8'h36; //6
            onfi_params_array[60] = 8'h20; //
            onfi_params_array[61] = 8'h20; //
	    onfi_params_array[62] = 8'h20; //
	`else `ifdef CLASSB
            onfi_params_array[49] = 8'h32; //2
            onfi_params_array[50] = 8'h35; //5
            onfi_params_array[51] = 8'h36; //6
            onfi_params_array[52] = 8'h47; //G
            onfi_params_array[53] = 8'h30; //0
            onfi_params_array[54] = 8'h38; //8
            onfi_params_array[55] = 8'h43; //C
            onfi_params_array[56] = 8'h42; //B
            onfi_params_array[57] = 8'h46; //F
            onfi_params_array[58] = 8'h42; //B
            onfi_params_array[59] = 8'h45; //E
            onfi_params_array[60] = 8'h4A; //J
            onfi_params_array[61] = 8'h34; //4
	    onfi_params_array[62] = 8'h20; //
	`endif `endif `endif `endif `endif `endif
    `else //
        `ifdef CLASST
            onfi_params_array[49] = 8'h34; //4
            onfi_params_array[50] = 8'h54; //T
            onfi_params_array[51] = 8'h30; //0
            onfi_params_array[52] = 8'h38; //8
            onfi_params_array[53] = 8'h43; //C
            onfi_params_array[54] = 8'h54; //T
            onfi_params_array[55] = 8'h43; //C
            onfi_params_array[56] = 8'h42; //B
            onfi_params_array[57] = 8'h42; //B
            onfi_params_array[58] = 8'h4A; //J
            onfi_params_array[59] = 8'h36; //6
            onfi_params_array[60] = 8'h20; //
            onfi_params_array[61] = 8'h20; //
	    onfi_params_array[62] = 8'h20; //
	`else `ifdef CLASSU
            onfi_params_array[49] = 8'h32; //2
            onfi_params_array[50] = 8'h54; //T
            onfi_params_array[51] = 8'h30; //0
            onfi_params_array[52] = 8'h38; //8
            onfi_params_array[53] = 8'h43; //C
            onfi_params_array[54] = 8'h55; //U
            onfi_params_array[55] = 8'h43; //C
            onfi_params_array[56] = 8'h42; //B
            onfi_params_array[57] = 8'h42; //B
            onfi_params_array[58] = 8'h4D; //M
            onfi_params_array[59] = 8'h34; //4
            onfi_params_array[60] = 8'h20; 
            onfi_params_array[61] = 8'h20; 
	    onfi_params_array[62] = 8'h20; 
	`else `ifdef CLASSM
            onfi_params_array[49] = 8'h31; //1
            onfi_params_array[50] = 8'h54; //T
            onfi_params_array[51] = 8'h30; //0
            onfi_params_array[52] = 8'h38; //8
            onfi_params_array[53] = 8'h43; //C
            onfi_params_array[54] = 8'h4D; //M
            onfi_params_array[55] = 8'h43; //C
            onfi_params_array[56] = 8'h42; //B
            onfi_params_array[57] = 8'h42; //B
            onfi_params_array[58] = 8'h4A; //J
            onfi_params_array[59] = 8'h34; //4
            onfi_params_array[60] = 8'h20; 
            onfi_params_array[61] = 8'h20; 
	    onfi_params_array[62] = 8'h20; 
	`else `ifdef CLASSK
            onfi_params_array[49] = 8'h31; //1
            onfi_params_array[50] = 8'h54; //T
            onfi_params_array[51] = 8'h30; //0
            onfi_params_array[52] = 8'h38; //8
            onfi_params_array[53] = 8'h43; //C
            onfi_params_array[54] = 8'h4B; //K
            onfi_params_array[55] = 8'h43; //C
            onfi_params_array[56] = 8'h42; //B
            onfi_params_array[57] = 8'h42; //B
            onfi_params_array[58] = 8'h4A; //J
            onfi_params_array[59] = 8'h34; //4
            onfi_params_array[60] = 8'h20; 
            onfi_params_array[61] = 8'h20; 
	    onfi_params_array[62] = 8'h20; 
	`else `ifdef CLASSF
            onfi_params_array[49] = 8'h35; //5
            onfi_params_array[50] = 8'h31; //1
            onfi_params_array[51] = 8'h32; //2
            onfi_params_array[52] = 8'h47; //G
            onfi_params_array[53] = 8'h30; //0
            onfi_params_array[54] = 8'h38; //8
            onfi_params_array[55] = 8'h43; //C
            onfi_params_array[56] = 8'h46; //F
            onfi_params_array[57] = 8'h43; //C
            onfi_params_array[58] = 8'h42; //B
            onfi_params_array[59] = 8'h42; //B
            onfi_params_array[60] = 8'h57; //W
            onfi_params_array[61] = 8'h50; //P
	    onfi_params_array[62] = 8'h20; 
	`else `ifdef CLASSE
            onfi_params_array[49] = 8'h35; //5
            onfi_params_array[50] = 8'h31; //1
            onfi_params_array[51] = 8'h32; //2
            onfi_params_array[52] = 8'h47; //G
            onfi_params_array[53] = 8'h30; //0
            onfi_params_array[54] = 8'h38; //8
            onfi_params_array[55] = 8'h43; //C
            onfi_params_array[56] = 8'h45; //E
            onfi_params_array[57] = 8'h43; //C
            onfi_params_array[58] = 8'h42; //B
            onfi_params_array[59] = 8'h42; //B
            onfi_params_array[60] = 8'h4A; //J
            onfi_params_array[61] = 8'h34; //4
	    onfi_params_array[62] = 8'h20; 
	`else //CLASSB
	    onfi_params_array[49] = 8'h32; //2
            onfi_params_array[50] = 8'h35; //5
            onfi_params_array[51] = 8'h36; //6
            onfi_params_array[52] = 8'h47; //G
            onfi_params_array[53] = 8'h30; //0
            onfi_params_array[54] = 8'h38; //8
            onfi_params_array[55] = 8'h43; //C
            onfi_params_array[56] = 8'h42; //B
            onfi_params_array[57] = 8'h43; //C
            onfi_params_array[58] = 8'h42; //B
            onfi_params_array[59] = 8'h42; //B
            onfi_params_array[60] = 8'h4A; //J
            onfi_params_array[61] = 8'h34; //4
	    onfi_params_array[62] = 8'h20;
	`endif `endif `endif `endif `endif `endif  
    `endif    	
    onfi_params_array[63] = 8'h20;

    // manufacturer ID
    onfi_params_array[64] = 8'h2C;
    // Date code
    onfi_params_array[65] = 8'h00; 
    onfi_params_array[66] = 8'h00; 
    // reserved
    for (k=67; k<=79 ; k=k+1) begin
        onfi_params_array[k] = 8'h00;
    end
    // Number of data bytes per page
    onfi_params_array[80] = 8'h00;
    onfi_params_array[81] = 8'h40;
    onfi_params_array[82] = 8'h00;
    onfi_params_array[83] = 8'h00;
    // Number of spare bytes per page        
    onfi_params_array[84] = 8'hA0;
    onfi_params_array[85] = 8'h08;

    // Number of data bytes per partial page (obsolete in ONFI 2.2)
    onfi_params_array[86] = 8'h00;    
    onfi_params_array[87] = 8'h00;    
    onfi_params_array[88] = 8'h00;    
    onfi_params_array[89] = 8'h00;    
    // Number of spare bytes per partial page (obsolete in ONFI 2.2)
    onfi_params_array[90] = 8'h00;
    onfi_params_array[91] = 8'h00;

    // Number of pages per block
    onfi_params_array[92] = 8'h00;
    onfi_params_array[93] = 8'h04;
    onfi_params_array[94] = 8'h00;
    onfi_params_array[95] = 8'h00;
    // Number of blocks per unit
    onfi_params_array[96] = 8'h90;
    onfi_params_array[97] = 8'h08;
    onfi_params_array[98] = 8'h00;
    onfi_params_array[99] = 8'h00;
    // Number of units
    `ifdef CLASSU
	onfi_params_array[100] = 8'h02;
    `else `ifdef CLASSK
        onfi_params_array[100] = 8'h02;
    `else `ifdef CLASST
	onfi_params_array[100] = 8'h02;
    `else // CLASS B, E, F,M
	onfi_params_array[100] = 8'h01;
    `endif `endif `endif
    // Number of address cycles
    onfi_params_array[101] = 8'h23;
    // Number of bits per cell
    onfi_params_array[102] = 8'h02;
    // Bad blocks maximum per unit
    onfi_params_array[103] = 8'hC0;
    onfi_params_array[104] = 8'h00;
    // Block endurance
    onfi_params_array[105] = 8'h03;
    onfi_params_array[106] = 8'h03;
    // Guaranteed valid blocks at beginning of target
    onfi_params_array[107] = 8'h01;
    // Block endurance for guaranteed valid blocks
    onfi_params_array[108] = 8'h00;
    onfi_params_array[109] = 8'h00;
    // Number of program per page
    onfi_params_array[110] = 8'h01;
    // Partial programming attributes
    onfi_params_array[111] = 8'h00;
    // Number of ECC bits
    onfi_params_array[112] = 8'hFF;
    // Number of interleaved address bits
    onfi_params_array[113] = 8'h02;
    // Interleaved operation attributes
    onfi_params_array[114] = 8'h1E;
    // reserved
    for (k=115; k<=127 ; k=k+1) begin
        onfi_params_array[k] = 8'h00;
    end

    // IO pin capacitance
    onfi_params_array[128] = 8'h00;
 
   `ifdef ONFI4
 // Timing mode support
    onfi_params_array[129] = 8'h00; 
   `else
    onfi_params_array[129] = 8'h3F; 
   `endif  
    onfi_params_array[130] = 8'h00;

    // Program cache timing mode support (obsolete in ONFI 2.2)
    onfi_params_array[131] = 8'h00;    
    onfi_params_array[132] = 8'h00;

    // tPROG max page program time
    onfi_params_array[133] = 8'hC4;
    onfi_params_array[134] = 8'h09;
    // tBERS max block erase time
    onfi_params_array[135] = 8'h10;
    onfi_params_array[136] = 8'h27;
    // tR max page read time        
    onfi_params_array[137] = 8'h91;
    onfi_params_array[138] = 8'h00;
    // tCCS min change column setup time (same as tWHR)
    onfi_params_array[139] = 8'h90;
    onfi_params_array[140] = 8'h01;

    // Source Synchronous Timing Mode Support
    `ifdef ONFI4
       	    onfi_params_array[141] = 8'h00;
    `else
	    onfi_params_array[141] = 8'h3F;
    `endif

    `ifdef ONFI4
       	  onfi_params_array[142] = 8'h00;
    `else `ifdef CLASSF
	  onfi_params_array[142] = 8'h1F;
    `else  //aync,ddr,ddr2 classe,m,k,u,t
 	  onfi_params_array[142] = 8'hFF;
    `endif `endif 

    // Source Synchronous Features
       onfi_params_array[143] = 8'h02;
	

    // Clk input pin capacitance per chip enable, typical
       onfi_params_array[144] = 8'h00;
       onfi_params_array[145] = 8'h00;

// i/o pin capacitance, typical
       onfi_params_array[146] = 8'h00;
       onfi_params_array[147] = 8'h00;

//input capacitance, typical
       onfi_params_array[148] = 8'h00;
       onfi_params_array[149] = 8'h00;

// input pin capacitance, maximum  
        onfi_params_array[150] = 8'h00;


// Drive Strength Support
`ifdef ONFI4
    onfi_params_array[151] = 8'h01;
`else
    onfi_params_array[151] = 8'h03;
`endif

    // tR max multiplane page read time 
    onfi_params_array[152] = 8'h91;
    onfi_params_array[153] = 8'h00;
    // tADL time 
    onfi_params_array[154] = 8'h46;
    onfi_params_array[155] = 8'h00;

    //reserved
    for (k=156; k<=157; k=k+1) begin
        onfi_params_array[k] = 8'h00;
    end
    
    //NV-DDR2 features
    `ifdef ONFI4
       	    onfi_params_array[158] = 8'h1B;
    `else 
       `ifdef CLASSF
	  onfi_params_array[158] = 8'h03;
       `else
          onfi_params_array[158] = 8'h1B;
       `endif 
    `endif
 
 //NV-DDR2 warmup cycles    
    onfi_params_array[159] = 8'h44;

   `ifdef ONFI4
       	    onfi_params_array[160] = 8'h3F;
   `else  
	    onfi_params_array[160] = 8'h00;
   `endif 
      
       //Reserved
    for (k=161; k<=163; k=k+1) begin
        onfi_params_array[k] = 8'h00;
    end        
    
    // Vendor-specific revision number    
    onfi_params_array[164] = 8'h01;
    onfi_params_array[165] = 8'h00;
    //vendor-specific
    onfi_params_array[166] = 8'h01;
    onfi_params_array[167] = 8'h00;
    onfi_params_array[168] = 8'h00;
    onfi_params_array[169] = 8'h00;

`ifdef ONFI4
    onfi_params_array[170] = 8'h02;
`else
    onfi_params_array[170] = 8'h03;
`endif
    onfi_params_array[171] = 8'h10;
    onfi_params_array[172] = 8'h01;
    onfi_params_array[173] = 8'h81;
    onfi_params_array[174] = 8'h04;
    onfi_params_array[175] = 8'h02;
    onfi_params_array[176] = 8'h03;
    onfi_params_array[177] = 8'h01;
    onfi_params_array[178] = 8'h1D;
    onfi_params_array[179] = 8'h90;
    onfi_params_array[180] = 8'h1F;
    //Read Retry Options available
    onfi_params_array[181] = 8'hFF;
    onfi_params_array[182] = 8'hFF;
    onfi_params_array[183] = 8'h00;
    onfi_params_array[184] = 8'h00; 
    //Reserved
    for (k=185; k<=252; k=k+1) begin
        onfi_params_array[k] = 8'h00;
    end
      
    // Parameter page revision
    onfi_params_array[253] = 8'h01;

    // Integrity CRC
    `ifdef ONFI4
        `ifdef CLASST
	    onfi_params_array[254] = 8'h1B;
	    onfi_params_array[255] = 8'hA2;
        `else `ifdef CLASSU
	    onfi_params_array[254] = 8'h49;
	    onfi_params_array[255] = 8'hB5;
        `else `ifdef CLASSM
	    onfi_params_array[254] = 8'hE9;
	    onfi_params_array[255] = 8'hB5;
        `else `ifdef CLASSK
	    onfi_params_array[254] = 8'hA7;
	    onfi_params_array[255] = 8'h81;
        `else `ifdef CLASSE
	    onfi_params_array[254] = 8'h2D;
	    onfi_params_array[255] = 8'hAE;
        `else `ifdef CLASSB
	    onfi_params_array[254] = 8'h36;
	    onfi_params_array[255] = 8'h7C;
        `endif `endif `endif `endif `endif `endif
        
    `else
 	`ifdef CLASST
	    onfi_params_array[254] = 8'hE7;
	    onfi_params_array[255] = 8'hCE;
        `else `ifdef CLASSU
	    onfi_params_array[254] = 8'hB5;
	    onfi_params_array[255] = 8'hD9;
        `else `ifdef CLASSM
	    onfi_params_array[254] = 8'h15;
	    onfi_params_array[255] = 8'hD9;
        `else `ifdef CLASSK
	    onfi_params_array[254] = 8'h5B;
	    onfi_params_array[255] = 8'hED;
        `else `ifdef CLASSF
	    onfi_params_array[254] = 8'h38;
	    onfi_params_array[255] = 8'h79;
        `else `ifdef CLASSE
	    onfi_params_array[254] = 8'hF7;
	    onfi_params_array[255] = 8'hAA;	
        `else 
 	    onfi_params_array[254] = 8'hEC;
	    onfi_params_array[255] = 8'h78;
	`endif `endif `endif `endif `endif `endif
    `endif

    onfi_params_array_unpacked = 0; 
    for (k=0; k<=255; k=k+1) begin
        mask = ({8{1'b1}} << (k*8)); // shifting left zero-fills
        //mask clears onfi params array unpacked slice so can or in onfi_params_array[k] byte
        onfi_params_array_unpacked = (onfi_params_array_unpacked & ~mask) | (onfi_params_array[k]<<(k*8)); // unpacking array
    end

    //onfi params array repeats for each 256 bytes up to 15616 (61 copies), then it starts outputting the extended parameter page
    for (k=1; k< 8'h3D; k=k+1) begin
        onfi_params_array_unpacked[0256*k*8+:0256*8] = onfi_params_array_unpacked[0256*8-1:0000];
    end
 
    //-------------------------------------
    // Extended Parameter Page    
    // Note: I use [15663-15616] index notation b/c datasheet starts at index 15616, but our array starts at index 0
    //
    //Integrity CRC 
    onfi_params_array_ext[15616-15616] = 8'hFE;
    onfi_params_array_ext[15617-15616] = 8'h34;
    // Extended Parameter Page Signature
    onfi_params_array_ext[15618-15616] = 8'h45; //E
    onfi_params_array_ext[15619-15616] = 8'h50; //P
    onfi_params_array_ext[15620-15616] = 8'h50; //P
    onfi_params_array_ext[15621-15616] = 8'h53; //S
    // Reserved
    for (k=15622; k<=15631; k=k+1) begin
        onfi_params_array_ext[k-15616] = 8'h00;
    end
    // Section 0 Type
    onfi_params_array_ext[15632-15616] = 8'h02;
    // Section 0 Length
    onfi_params_array_ext[15633-15616] = 8'h01;
    // Reserved
    for (k=15634; k<=15647; k=k+1) begin
        onfi_params_array_ext[k-15616] = 8'h00;
    end
    // Number of Bits ECC Correctability
    onfi_params_array_ext[15648-15616] = 8'h48;
    // Codeword Size
    onfi_params_array_ext[15649-15616] = 8'h0A;
    // Bad Blocks Maximum per LUN
    onfi_params_array_ext[15650-15616] = 8'hC0;
    onfi_params_array_ext[15651-15616] = 8'h00;
    // Block Endurance
    onfi_params_array_ext[15652-15616] = 8'h03;
    onfi_params_array_ext[15653-15616] = 8'h03;
    // Reserved
    for (k=15654; k<=15663; k=k+1) begin
        onfi_params_array_ext[k-15616] = 8'h00;
    end

    onfi_params_array_ext_unpacked =0;
    for (k=0; k<=47; k=k+1) begin
        mask = ({8{1'b1}} << (k*8)); // shifting left zero-fills
        //mask clears onfi params array unpacked slice so can or in onfi_params_array[k] byte
        onfi_params_array_ext_unpacked = (onfi_params_array_ext_unpacked & ~mask) | (onfi_params_array_ext[k]<<(k*8)); // unpacking array
    end
  
    // onfi params array extended repeats for each 48 bytes up to 18543 (60 copies), than all FFs to last column
    for (k=0; k<8'h3C; k=k+1) begin    
	onfi_params_array_unpacked[(15664*8+48*k*8)+:48*8] = onfi_params_array_ext_unpacked[48*8-1:00];
    end    
    
    onfi_params_array_unpacked[NUM_COL*8-1:18544*8] = {(NUM_COL-18544){8'hFF}};

 //-------------------------------------
    // JEDEC Parameter Page    

 //-------------------------------------
    // Parameter page signature
    jedec_params_array[0] = 8'h4A; // 'J'
    jedec_params_array[1] = 8'h45; // 'E'
    jedec_params_array[2] = 8'h53; // 'S'
    jedec_params_array[3] = 8'h44; // 'D'
    // JEDEC revision number
    jedec_params_array[4] = 8'h06; // JEDEC 1.0 compliant
    jedec_params_array[5] = 8'h00;
    // Features supported
`ifdef ONFI4
  `ifdef CLASST
    jedec_params_array[6] = 8'h9A;
    jedec_params_array[7] = 8'h01;
  `else `ifdef CLASSU
    jedec_params_array[6] = 8'h9A;
    jedec_params_array[7] = 8'h01;
  `else `ifdef CLASSK
    jedec_params_array[6] = 8'h9A;
    jedec_params_array[7] = 8'h01;
  `else  //CLASS M, E, B
      jedec_params_array[6] = 8'h98;
      jedec_params_array[7] = 8'h01;	
  `endif `endif `endif 
`else
  `ifdef CLASST
    jedec_params_array[6] = 8'hBA;
    jedec_params_array[7] = 8'h01;
  `else `ifdef CLASSU
    jedec_params_array[6] = 8'hBA;
    jedec_params_array[7] = 8'h01;
  `else `ifdef CLASSK
    jedec_params_array[6] = 8'hBA;
    jedec_params_array[7] = 8'h01;
  `else  //CLASS M, F, E, B
      jedec_params_array[6] = 8'hB8;
      jedec_params_array[7] = 8'h01;	
  `endif `endif `endif 
`endif 
  // Features supported           
    jedec_params_array[8] = 8'hFF;
    jedec_params_array[9] = 8'h07;
    jedec_params_array[10] = 8'h00;
    //Secondary commands supported
    jedec_params_array[11] = 8'h58;
    jedec_params_array[12] = 8'h00;
    jedec_params_array[13] = 8'h24;
    for (k=14; k<=31 ; k=k+1) begin
        jedec_params_array[k] = 8'h00;
    end
    // These bytes match ONFI param page index (i.e. onfi_params_array[k] = onfi_params_array[k])
    // Manufacturer ID
    for (k=32; k<=43 ; k=k+1) begin
        jedec_params_array[k] = onfi_params_array[k];
    end
    // These bytes match ONFI param page index (i.e. onfi_params_array[k] = onfi_params_array[k])
    // Device model
    for (k=44; k<=63 ; k=k+1) begin
        jedec_params_array[k] = onfi_params_array[k];
    end

    // manufacturer ID
    jedec_params_array[64] = 8'h2C;
    jedec_params_array[65] = 8'h00; 
    jedec_params_array[66] = 8'h00; 
    jedec_params_array[67] = 8'h00; 
    jedec_params_array[68] = 8'h00; 
    jedec_params_array[69] = 8'h00; 
    // reserved
    for (k=70; k<=79 ; k=k+1) begin
        jedec_params_array[k] = 8'h00;
    end
    
    // These bytes match ONFI param page index (i.e. onfi_params_array[k] = onfi_params_array[k])
    // Number of data bytes per page (80-83)
    // Number of spare bytes per page (84-85)
    // Number of data bytes per partial page (obsolete in ONFI 2.2) (86-89)
    // Number of spare bytes per partial page (obsolete in ONFI 2.2) (90-91)
    // Number of pages per block (92-95)
    // Number of blocks per unit (96-99)
    // Number of units (100)
    // Number of address cycles (101)
    // Number of bits per cell (102)
    for (k=80; k<=85 ; k=k+1) begin
        jedec_params_array[k] = onfi_params_array[k];
    end

    // These are obsolete in ONFI 2.2, but not in JEDEC, so restore its value
    // Number of data bytes per partial page (obsolete in ONFI 2.2) (86-89)
    jedec_params_array[86] = 8'h00;    
    jedec_params_array[87] = 8'h04;    
    jedec_params_array[88] = 8'h00;    
    jedec_params_array[89] = 8'h00;    
    // Number of spare bytes per partial page (obsolete in ONFI 2.2) (90-91)
    jedec_params_array[90] = 8'h8A;
    jedec_params_array[91] = 8'h00;
    
    for (k=92; k<=102 ; k=k+1) begin
        jedec_params_array[k] = onfi_params_array[k];
    end

    // Number of program per page
    jedec_params_array[103] = 8'h01;
    // Number of plane address bits
    jedec_params_array[104] = 8'h02;
    // multi-plane operation attributes
    jedec_params_array[105] = 8'h07;
    // reserved
    for (k=106; k<=143 ; k=k+1) begin
        jedec_params_array[k] = 8'h00;
    end

    // Timing mode support
    jedec_params_array[144] = onfi_params_array[129];    
    jedec_params_array[145] = onfi_params_array[130];

    // reserved
`ifdef ONFI4
    jedec_params_array[146] = 8'h00;
`else // ASYNC,DDR,DDR2
  `ifdef CLASSF
    jedec_params_array[146] = 8'h0F;
  `else    // ASYNC CLASS B,E,M,K,U,T
    jedec_params_array[146] = 8'hFF;
  `endif 
`endif
    jedec_params_array[147] = 8'h00;

    // Source Synchronous Timing Mode Support
 `ifdef ONFI4
    jedec_params_array[148] = 8'h00;
 `else //ASYNC
    jedec_params_array[148] = 8'h3F;
 `endif 
    jedec_params_array[149] = 8'h00;

    // Aynchronous Features
    jedec_params_array[150] = 8'h00;
    // reserved
    jedec_params_array[151] = 8'h00;
    // Synchronous Features
    jedec_params_array[152] = 8'h00;

    // tPROG max page program time
    jedec_params_array[153] = onfi_params_array[133];
    jedec_params_array[154] = onfi_params_array[134];
    // tBERS max block erase time
    jedec_params_array[155] = onfi_params_array[135];
    jedec_params_array[156] = onfi_params_array[136];
    // tR max page read time        
    jedec_params_array[157] = onfi_params_array[137];
    jedec_params_array[158] = onfi_params_array[138];
    // tR max multiplane page read time 
    jedec_params_array[159] = onfi_params_array[152];
    jedec_params_array[160] = onfi_params_array[153];
    // tCCS min change column setup time (same as tWHR)
    jedec_params_array[161] = onfi_params_array[139];
    jedec_params_array[162] = onfi_params_array[140];

    // I/O pin capacitance per chip enable, typical 
    jedec_params_array[163] = 8'h00;
    jedec_params_array[164] = 8'h00;

 
    // input capacitance per chip enable, typical 
    jedec_params_array[165] = 8'h00; //A
    jedec_params_array[166] = 8'h00;

    // Clk input pin capacitance per chip enable, typical 
    jedec_params_array[167] = 8'h00;
    jedec_params_array[168] = 8'h00;
  
    // Drive Strength Support
    jedec_params_array[169] = onfi_params_array[151];

    //tADL program page register clear enhancement value(ns)
    jedec_params_array[170] = onfi_params_array[154];
    jedec_params_array[171] = onfi_params_array[155];
    
    //reserved
    for (k=172; k<=207; k=k+1) begin
        jedec_params_array[k] = 8'h00;
    end

    // Guaranteed valid blocks at beginning of target
    jedec_params_array[208] = onfi_params_array[107];
    // Block endurance for guaranteed valid blocks
    jedec_params_array[209] = onfi_params_array[108];
    jedec_params_array[210] = onfi_params_array[109];
    // Number of Bits ECC Correctability
    jedec_params_array[211] = onfi_params_array_ext[15648-15616];
    // Codeword Size
    jedec_params_array[212] = onfi_params_array_ext[15649-15616];
    // Bad Blocks Maximum per LUN
    jedec_params_array[213] = onfi_params_array_ext[15650-15616];
    jedec_params_array[214] = onfi_params_array_ext[15651-15616];
    // Block Endurance
    jedec_params_array[215] = onfi_params_array_ext[15652-15616];
    jedec_params_array[216] = onfi_params_array_ext[15653-15616];

    //reserved
    for (k=217; k<=419; k=k+1) begin
        jedec_params_array[k] = 8'h00;
    end

    // Vendor-specific revision number    
    jedec_params_array[420] = 8'h01;
    jedec_params_array[421] = 8'h00;
        // Read Retry Options
    jedec_params_array[422] = onfi_params_array[180];
    jedec_params_array[423] = onfi_params_array[181];
    jedec_params_array[424] = onfi_params_array[182];
    jedec_params_array[425] = onfi_params_array[183];
    jedec_params_array[426] = onfi_params_array[184];
    
    
        
    for (k=427; k<=509; k=k+1) begin
        jedec_params_array[k] = 8'h00;
    end

// Integrity CRC
    `ifdef ONFI4
        `ifdef CLASST
	    jedec_params_array[510] = 8'hAF;
	    jedec_params_array[511] = 8'h5A;
        `else `ifdef CLASSU
	    jedec_params_array[510] = 8'hB0;
	    jedec_params_array[511] = 8'hA0;
        `else `ifdef CLASSM
	    jedec_params_array[510] = 8'h30;
	    jedec_params_array[511] = 8'h08;
        `else `ifdef CLASSK
	    jedec_params_array[510] = 8'h59;
	    jedec_params_array[511] = 8'h53;
        `else `ifdef CLASSE
	    jedec_params_array[510] = 8'h3F;
	    jedec_params_array[511] = 8'h9F;
        `else `ifdef CLASSB
	    jedec_params_array[510] = 8'h28;
	    jedec_params_array[511] = 8'h6F;
        `endif `endif `endif `endif `endif `endif
        
    `else
 	`ifdef CLASST
	    jedec_params_array[510] = 8'h22;
	    jedec_params_array[511] = 8'hF8;
        `else `ifdef CLASSU
	    jedec_params_array[510] = 8'h3D;
	    jedec_params_array[511] = 8'h02;
        `else `ifdef CLASSM
	    jedec_params_array[510] = 8'hBD;
	    jedec_params_array[511] = 8'hAA;
        `else `ifdef CLASSK
	    jedec_params_array[510] = 8'hD4;
	    jedec_params_array[511] = 8'hF1;
        `else `ifdef CLASSF
	    jedec_params_array[510] = 8'hC3;
	    jedec_params_array[511] = 8'hE8;
        `else `ifdef CLASSE
	    jedec_params_array[510] = 8'h28;
	    jedec_params_array[511] = 8'h38;	
        `else `ifdef CLASSB
 	    jedec_params_array[510] = 8'h3F;
	    jedec_params_array[511] = 8'hC8;
	`endif `endif `endif `endif `endif `endif `endif
    `endif
      
    jedec_params_array_unpacked =0;
    for (k=0; k<=511; k=k+1) begin
        mask = ({8{1'b1}} << (k*8)); // shifting left zero-fills
        //mask clears onfi params array unpacked slice so can or in jedec_params_array[k] byte
        jedec_params_array_unpacked = (jedec_params_array_unpacked & ~mask) | (jedec_params_array[k]<<(k*8)); // unpacking array
    end

    // jedec params array repeats for each 512 bytes up to 18432 (36 copies)
    for (k=1; k<=35; k=k+1) begin    
	jedec_params_array_unpacked[512*k*8+:512*8] = jedec_params_array_unpacked[0512*8-1:0000];
    end
    //jedec_params_array_unpacked[1024*8-1:0512*8] = jedec_params_array_unpacked[0512*8-1:0000];
    //jedec_params_array_unpacked[1536*8-1:1024*8] = jedec_params_array_unpacked[0512*8-1:0000];
    jedec_params_array_unpacked[NUM_COL*8-1:18432*8] = {(NUM_COL-18432){8'hFF}};

    end
endtask



//-----------------------------------------------------------------
// FUNCTION : check_feat_addr (addr)
// verifies feature address is valid for this part.
//-----------------------------------------------------------------
function check_feat_addr;
input [07:00] id_reg_addr;
input [00:00] nand_mode  ;
begin
    check_feat_addr = 0;
    case (id_reg_addr)
       8'h01, 8'h02, 8'h10, 8'h58, 8'h80, 8'h81, 8'h90, 8'h89, 8'h30, 8'hE7, 8'hF5, 8'hF6 : check_feat_addr = 1;
    endcase
end
endfunction

reg [(4*DQ_BITS)-1 : 0]         onfi_features [0 : 255];

//----------------------------------------------------------------------
// TASK : init_onfi_params
//Assigns the read-only ONFI parameters (for devices with ONFI support)
//----------------------------------------------------------------------
task init_onfi_params;
begin
    //Supported ONFI feature addresses and parameter initialization
    //These are used in the GET FEATURES and SET FEATURES commands
    // Read Features section has read data output assignments. 
    onfi_features[8'h01] = 0;
    onfi_features[8'h02] = 0;
    onfi_features[8'h10] = 2;
    onfi_features[8'h30] = 0;
    onfi_features[8'h58] = 0;
    onfi_features[8'h80] = 2;
    onfi_features[8'h81] = 0;
    onfi_features[8'h85] = 0;
    onfi_features[8'h89] = 0;
    onfi_features[8'h90] = 0;
    onfi_features[8'hE7] = 8'h34;
    onfi_features[8'hF5] = 0;
    onfi_features[8'hF6] = 0;


    setup_params_array;  // ONFI parameter page
end
endtask

`define SYNC2ASYNCRESET
//`define x8


//----------------------------------------------------------------------
// TASK : update_feat_gen
//----------------------------------------------------------------------
task update_feat_gen;
input [2:0] gen_in; 
begin

end
endtask

