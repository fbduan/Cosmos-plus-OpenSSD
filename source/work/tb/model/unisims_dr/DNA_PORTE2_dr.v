`include "B_DNA_PORTE2_defines.vh"

reg trig_attr = 0;
reg [`DNA_PORTE2_DATA_SZ-1:0] ATTR [0:`DNA_PORTE2_ADDR_N-1];

initial begin

   ATTR[`DNA_PORTE2__SIM_DNA_VALUE] = SIM_DNA_VALUE;

end

always @(trig_attr) begin
   SIM_DNA_VALUE_reg = ATTR[`DNA_PORTE2__SIM_DNA_VALUE];
end


task write_attr;
  input  [`DNA_PORTE2_ADDR_SZ-1:0] addr;
  input  [`DNA_PORTE2_DATA_SZ-1:0] data;
begin
    ATTR[addr] = data;
    trig_attr = ~trig_attr;
end
endtask


function [`DNA_PORTE2_DATA_SZ-1:0] read_attr;
   input  [`DNA_PORTE2_ADDR_SZ-1:0] addr;
begin
    read_attr = ATTR[addr];
end
endfunction


task commit_attr;
   begin

end
endtask