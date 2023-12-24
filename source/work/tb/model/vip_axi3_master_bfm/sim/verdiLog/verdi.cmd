verdiWindowResize -win $_Verdi_1 "1460" "655" "1020" "762"
debImport \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim/vip_axi3_master_bfm.sv" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim/vip_axi3_master_bfm_pkg.sv" \
          "-sv" -path \
          {/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim}
verdiWindowResize -win $_Verdi_1 "1460" "655" "1427" "1015"
nsMsgSelect -range {0 1-1}
nsMsgAction -tab cmpl -index {0 1}
nsMsgSelect -range {0 1-1}
srcHBSelect "vip_axi3_master_bfm" -win $_nTrace1
srcSetScope -win $_nTrace1 "vip_axi3_master_bfm" -delim "."
srcHBSelect "vip_axi3_master_bfm" -win $_nTrace1
srcHBSelect "vip_axi3_master_bfm.inst" -win $_nTrace1
nsMsgSwitchTab -tab general
debImport \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim/vip_axi3_master_bfm.sv" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim/vip_axi3_master_bfm_pkg.sv" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/hdl/axi_vip_v1_1_vl_rfs.sv" \
          "-sv" -path \
          {/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim}
srcHBSelect "vip_axi3_master_bfm.inst.IF" -win $_nTrace1
nsMsgSwitchTab -tab general
debImport \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim/vip_axi3_master_bfm.sv" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim/vip_axi3_master_bfm_pkg.sv" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/hdl/axi_vip_v1_1_vl_rfs.sv" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/xilinx_vip/hdl/axi_vip_if.sv" \
          "-sv" -path \
          {/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim}
nsMsgSelect -range {0 0-0}
nsMsgSwitchTab -tab general
debImport \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim/vip_axi3_master_bfm.sv" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/hdl/axi_vip_v1_1_vl_rfs.sv" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/xilinx_vip/hdl/axi_vip_if.sv" \
          "-sv" -path \
          {/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim}
nsMsgSelect -range {0 1-1}
nsMsgAction -tab cmpl -index {0 1}
nsMsgSelect -range {0 1-1}
nsMsgSelect -range {0 0-0}
nsMsgAction -tab cmpl -index {0 0}
nsMsgSelect -range {0 0-0}
srcDeselectAll -win $_nTrace1
nsMsgSwitchTab -tab general
debImport \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim/vip_axi3_master_bfm.sv" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/hdl/axi_vip_v1_1_vl_rfs.sv" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/xilinx_vip/hdl/axi_vip_if.sv" \
          "-sv" \
          "+incdir+/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/xilinx_vip/hdl" \
          -path \
          {/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim}
nsMsgSelect -range {0 0-0}
nsMsgAction -tab cmpl -index {0 0}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
nsMsgAction -tab cmpl -index {0 0}
nsMsgSwitchTab -tab general
debImport \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim/vip_axi3_master_bfm.sv" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/hdl/axi_vip_v1_1_vl_rfs.sv" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/xilinx_vip/hdl/axi_vip_pkg.sv" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/xilinx_vip/hdl/axi_vip_if.sv" \
          "-sv" \
          "+incdir+/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/xilinx_vip/hdl" \
          -path \
          {/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim}
nsMsgSelect -range {0 1-1}
nsMsgSelect -range {0 0-0}
nsMsgAction -tab cmpl -index {0 0}
nsMsgSwitchTab -tab general
debImport \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim/vip_axi3_master_bfm.sv" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/hdl/axi_vip_v1_1_vl_rfs.sv" \
          "-f" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/xilinx_vip/xilinx_vip_pkg.list.f" \
          "-sv" \
          "+incdir+/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/xilinx_vip/hdl" \
          -path \
          {/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/xilinx_vip}
nsMsgSelect -range {0 0-0}
nsMsgAction -tab cmpl -index {0 0}
nsMsgSelect -range {0 10-10}
nsMsgSelect -range {0 9-9}
nsMsgAction -tab cmpl -index {0 9}
nsMsgSelect -range {0 1-1}
nsMsgSelect -range {0 0-0}
debReload
nsMsgSelect -range {0 0-0}
nsMsgAction -tab cmpl -index {0 0}
nsMsgSwitchTab -tab general
debImport \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim/vip_axi3_master_bfm.sv" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/hdl/axi_vip_v1_1_vl_rfs.sv" \
          "-f" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/xilinx_vip/xilinx_vip_pkg.list.f" \
          "-sv" "+incdir+\$\{XILINX_VIVADO\}/data/xilinx_vip/include" -path \
          {/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/xilinx_vip}
nsMsgSelect -range {0 0-0}
srcDeselectAll -win $_nTrace1
debReload
nsMsgSelect -range {0 0-0}
srcDeselectAll -win $_nTrace1
debReload
debImport \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim/vip_axi3_master_bfm.sv" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/hdl/axi_vip_v1_1_vl_rfs.sv" \
          "-sv" "+incdir+\$\{XILINX_VIVADO\}/data/xilinx_vip/include" -path \
          {/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/xilinx_vip}
srcHBSelect "vip_axi3_master_bfm.inst.IF" -win $_nTrace1
nsMsgSwitchTab -tab general
debImport \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim/vip_axi3_master_bfm.sv" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/hdl/axi_vip_v1_1_vl_rfs.sv" \
          "-f" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/xilinx_vip/xilinx_vip_pkg.list.f" \
          "-sv" "+incdir+\$\{XILINX_VIVADO\}/data/xilinx_vip/include" -path \
          {/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/xilinx_vip}
debImport \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/sim/vip_axi3_master_bfm.sv" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_master_bfm/hdl/axi_vip_v1_1_vl_rfs.sv" \
          "-f" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/xilinx_vip/xilinx_vip_pkg.list.f" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/vip_axi3_slave_bfm/sim/vip_axi3_slave_bfm.sv" \
          "-sv" "+incdir+\$\{XILINX_VIVADO\}/data/xilinx_vip/include" -path \
          {/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/model/xilinx_vip}
srcHBSelect "vip_axi3_slave_bfm" -win $_nTrace1
nsMsgSwitchTab -tab cmpl
nsMsgSwitchTab -tab trace
nsMsgSwitchTab -tab general
debImport "-f" \
          "/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb/vip_axi3_bfm.f" \
          "-sv" "+incdir+\$\{XILINX_VIVADO\}/data/xilinx_vip/include" -path \
          {/home/orysduan/proj/Cosmos-plus-OpenSSD/source/work/tb}
nsMsgSelect -range {0 0-0}
nsMsgAction -tab cmpl -index {0 0}
nsMsgSelect -range {0 0-0}
nsMsgSelect -range {0 0-0}
srcDeselectAll -win $_nTrace1
debReload
srcHBSelect "vip_axi3_master_bfm" -win $_nTrace1
srcSetScope -win $_nTrace1 "vip_axi3_master_bfm" -delim "."
srcHBSelect "vip_axi3_master_bfm" -win $_nTrace1
srcDeselectAll -win $_nTrace1
debExit
