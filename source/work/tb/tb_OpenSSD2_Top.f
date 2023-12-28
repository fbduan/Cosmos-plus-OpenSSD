
////    +define+ORIGINAL_CDN_AXI3_SLAVE_BFM
////    +define+ORIGINAL_CDN_AXI3_MASTER_BFM
    /////+define+VIP_AXI3_MASTER_BFM

    +define+USER_SIMULATION_SPEEDUP

    -f ${OPENSSD_HOME}/source/work/tb/OpenSSD2_wrapper.f
    -f ${OPENSSD_HOME}/source/work/tb/ddr3_model.f
    -f ${OPENSSD_HOME}/source/work/tb/nand_model.f
    -f ${OPENSSD_HOME}/source/work/tb/tb_bus_bfm.f
    -f ${OPENSSD_HOME}/source/work/tb/proc_sys_reset.f

    +incdir+${OPENSSD_HOME}/source/work/tc
    ${OPENSSD_HOME}/source/work/tb/tb_OpenSSD2_Top.v


