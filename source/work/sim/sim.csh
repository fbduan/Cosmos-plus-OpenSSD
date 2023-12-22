#!/bin/csh -f

vcs -full64 -sverilog +v2k -notice -timescale=1ns/1ps -CFLAGS -DVCS -kdb -add_seq_delay 1 -debug_access+all +error+1000 -top tb_OpenSSD2_Top -f ../tb/tb_OpenSSD2_Top.f  -l tb_OpenSSD2_Top.log
