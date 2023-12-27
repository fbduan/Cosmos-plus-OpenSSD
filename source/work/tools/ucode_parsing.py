#!/bin/env python3

import os
import sys
import math

import prettytable

from collections import OrderedDict as odict

uPFunc_bits          = 4
uPLength_bits        = 16
uPTargetID_bits      = 5
uPSourceID_bits      = 5
uPOpcode_bits        = 6
uPAddrSrcRegSel_bits = 4
uPChSelect_bits      = 1

uPFunc = {}
uPFunc[1] = 'WritecmdToModule'
uPFunc[2] = 'ReadcmdToModule '
uPFunc[4] = 'UpTrans         '
uPFunc[8] = 'DownTrans       '
for i in range(2**uPFunc_bits):
    if i not in uPFunc:
        uPFunc[i] = "*"

uPChSelect = {}
uPChSelect[0] = "Datapath   "
uPChSelect[1] = "V2NFC100DDR"

uPAddrSrcRegSel = {}
uPAddrSrcRegSel[0] = "32'h0000_0000"
uPAddrSrcRegSel[1] = 'RowAddress   '
uPAddrSrcRegSel[2] = 'UserData     '
uPAddrSrcRegSel[3] = 'DataAddress  '
uPAddrSrcRegSel[4] = 'SpareAddress '
uPAddrSrcRegSel[5] = 'ErrCntAddress'
uPAddrSrcRegSel[6] = 'CmpltAddress '
uPAddrSrcRegSel[7] = 'WaySelection '
uPAddrSrcRegSel[8] = 'ColAddress   '
for i in range(2**uPAddrSrcRegSel_bits):
    if i not in uPAddrSrcRegSel:
        uPAddrSrcRegSel[i] = "*"


mif_file = sys.argv[1]
print(f"{mif_file=}")

mif = []
mif_tab = prettytable.PrettyTable()
mif_tab.field_names = ['Index', 'uPChSelect', 'uPAddrSrcRegSel', 'uPOpcode', 'uPSourceID', 'uPTargetID', 'uPLength', 'uPFunc', 'Comments']
with open(mif_file, "r") as fp:
    for l in fp:
        l = l.strip()
        mif.append( \
                { \
                 'func'  : int(l[-1*(uPFunc_bits                                                                                                 ):                                                                                                 ], 2),
                 'len'   : int(l[-1*(uPFunc_bits+uPLength_bits                                                                                   ):-1*(uPFunc_bits                                                                                 )], 2),
                 'tgtid' : int(l[-1*(uPFunc_bits+uPLength_bits+uPTargetID_bits                                                                   ):-1*(uPFunc_bits+uPLength_bits                                                                   )], 2),
                 'srcid' : int(l[-1*(uPFunc_bits+uPLength_bits+uPTargetID_bits+uPSourceID_bits                                                   ):-1*(uPFunc_bits+uPLength_bits+uPTargetID_bits                                                   )], 2),
                 'opcode': int(l[-1*(uPFunc_bits+uPLength_bits+uPTargetID_bits+uPSourceID_bits+uPOpcode_bits                                     ):-1*(uPFunc_bits+uPLength_bits+uPTargetID_bits+uPSourceID_bits                                   )], 2),
                 'regsel': int(l[-1*(uPFunc_bits+uPLength_bits+uPTargetID_bits+uPSourceID_bits+uPOpcode_bits+uPAddrSrcRegSel_bits                ):-1*(uPFunc_bits+uPLength_bits+uPTargetID_bits+uPSourceID_bits+uPOpcode_bits                     )], 2),
                 'chsel' : int(l[-1*(uPFunc_bits+uPLength_bits+uPTargetID_bits+uPSourceID_bits+uPOpcode_bits+uPAddrSrcRegSel_bits+uPChSelect_bits):-1*(uPFunc_bits+uPLength_bits+uPTargetID_bits+uPSourceID_bits+uPOpcode_bits+uPAddrSrcRegSel_bits)], 2),
                }
        )

        desc_msg = ""
        if     uPFunc[mif[-1]['func']] == "*":
            desc_msg = ""
        elif   mif[-1]['chsel'] == 1:
            if   mif[-1]['tgtid'] == 0x04 and mif[-1]['opcode'] == 0x00:
                desc_msg = "Set TargetWay1B = uPAddrSrcRegSel[ 7:0]"
            elif mif[-1]['tgtid'] == 0x04 and mif[-1]['opcode'] == 0x02:
                desc_msg = "Set   ColAddr2B = uPAddrSrcRegSel[15:0]"
            elif mif[-1]['tgtid'] == 0x04 and mif[-1]['opcode'] == 0x04:
                desc_msg = "Set   RowAddr3B = uPAddrSrcRegSel[23:0]"
            elif mif[-1]['tgtid'] == 0x05 and mif[-1]['opcode'] == 0x00:
                desc_msg = "ModuleTrigger: BNC_P_read_AW30h (w/ Way, Col and Row)"
            elif mif[-1]['tgtid'] == 0x05 and mif[-1]['opcode'] == 0x03:
                desc_msg = "ModuleTrigger: BNC_P_read_DT00h (w/ Way, Col, Row and Len)"
            elif mif[-1]['tgtid'] == 0x05 and mif[-1]['opcode'] == 0x04:
                desc_msg = "ModuleTrigger: BNC_P_program (w/ Way, Col, Row and Len)"
            elif mif[-1]['tgtid'] == 0x05 and mif[-1]['opcode'] == 0x08:
                desc_msg = "ModuleTrigger: BNC_B_erase (w/ Way, Col and Row)"
            elif mif[-1]['tgtid'] == 0x05 and mif[-1]['opcode'] == 0x20:
                desc_msg = "ModuleTrigger: MNC_N_setFT (SetFeature, SDR)"
            elif mif[-1]['tgtid'] == 0x05 and mif[-1]['opcode'] == 0x21:
                desc_msg = "ModuleTrigger: MNC_N_setFT (SetFeature, DDR)"
            elif mif[-1]['tgtid'] == 0x05 and mif[-1]['opcode'] == 0x25:
                desc_msg = "ModuleTrigger: MNC_N_getFT (GetFeature)"
            elif mif[-1]['tgtid'] == 0x05 and mif[-1]['opcode'] == 0x29:
                desc_msg = "ModuleTrigger: MNC_N_readST (ReadStatus)"
            elif mif[-1]['tgtid'] == 0x05 and mif[-1]['opcode'] == 0x2C:
                desc_msg = "ModuleTrigger: MNC_N_init (initial??)"
            elif mif[-1]['tgtid'] == 0x05 and mif[-1]['opcode'] == 0x30:
                desc_msg = "ModuleTrigger: MNC_PO_reset (NFC PHY output module reset)"
            elif mif[-1]['tgtid'] == 0x05 and mif[-1]['opcode'] == 0x32:
                desc_msg = "ModuleTrigger: MNC_PI_reset (NFC PHY  input module reset)"
            elif mif[-1]['tgtid'] == 0x05 and mif[-1]['opcode'] == 0x3E:
                desc_msg = "ModuleTrigger: MNC_PI_poe   (NFC Power On Reset)"
            else:
                desc_msg = "Unknown Opcode + TargetID"
        else: #mif[-1]['chsel'] == 0
            if   mif[-1]['tgtid'] == 0x00 and mif[-1]['opcode'] == 0x01:
                desc_msg = "DispatchCmd_PageReadFromRAM : Scramble/BCH encode/decode traffic"
            elif mif[-1]['tgtid'] == 0x00 and mif[-1]['opcode'] == 0x02:
                desc_msg = "DispatchCmd_SpareReadFromRAM: Scramble/BCH encode/decode traffic"
            elif mif[-1]['tgtid'] == 0x03:
                desc_msg = "uPTargetID == ThisID(3), Nothing TODO"
            else:
                desc_msg = "Scramble/BCH bypass traffic"
                    

        mif_tab.add_row( [
                "%03x"%(len(mif)),
                "-" if uPFunc[mif[-1]['func']] == "*" else "%01x-%s"%(mif[-1]['chsel'],  uPChSelect[mif[-1]['chsel']]),
                "-" if uPFunc[mif[-1]['func']] == "*" else "%01x-%s"%(mif[-1]['regsel'], uPAddrSrcRegSel[mif[-1]['regsel']]),
                "-" if uPFunc[mif[-1]['func']] == "*" else "%02x"%mif[-1]['opcode'],
                "-" if uPFunc[mif[-1]['func']] == "*" else "%02x"%mif[-1]['srcid'],
                "-" if uPFunc[mif[-1]['func']] == "*" else "%02x"%mif[-1]['tgtid'],
                "-" if uPFunc[mif[-1]['func']] == "*" else "%04x"%mif[-1]['len'],
                "%01x"%(mif[-1]['func']) if uPFunc[mif[-1]['func']] == "*" else "%01x-%s"%(mif[-1]['func'], uPFunc[mif[-1]['func']]),
                desc_msg
        ])

print( "Info of %s:\n%s"%(mif_file, mif_tab.get_string()) )
    
