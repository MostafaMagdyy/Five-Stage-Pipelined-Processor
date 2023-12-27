force -freeze sim:/ex_mem_reg/clk 1 25, 0 {75 ns} -r 100

force -freeze sim:/ex_mem_reg/en 1 0
force -freeze sim:/ex_mem_reg/rst 1 0
force -freeze sim:/ex_mem_reg/Rdst_E 3'd1 0
force -freeze sim:/ex_mem_reg/AluOut_E 32'd15 0
force -freeze sim:/ex_mem_reg/EA_E 20'd1 0
force -freeze sim:/ex_mem_reg/MemRead_E 2 0
force -freeze sim:/ex_mem_reg/MemRead_E 1 0
force -freeze sim:/ex_mem_reg/MemWrite_E 1 0
force -freeze sim:/ex_mem_reg/MemToReg_E 1 0
force -freeze sim:/ex_mem_reg/RegWrite_E 1 0
force -freeze sim:/ex_mem_reg/Branch_E 1 0
force -freeze sim:/ex_mem_reg/Protect_E 1 0
force -freeze sim:/ex_mem_reg/Free_E 1 0
force -freeze sim:/ex_mem_reg/SP_E 1 0
force -freeze sim:/ex_mem_reg/PUSH_POP_E 1 0
force -freeze sim:/ex_mem_reg/in_E 1 0
force -freeze sim:/ex_mem_reg/RET_CALL_E 1 0
force -freeze sim:/ex_mem_reg/JMP_E 1 0
force -freeze sim:/ex_mem_reg/zero_flag_E 1 0
force -freeze sim:/ex_mem_reg/Reg_dst_E 32'd5 0

run
force -freeze sim:/ex_mem_reg/rst 0 0
run



force -freeze sim:/ex_mem_reg/rst 0 0
force -freeze sim:/ex_mem_reg/Rdst_E 3'd0 0
force -freeze sim:/ex_mem_reg/AluOut_E 32'd05 0
force -freeze sim:/ex_mem_reg/EA_E 20'd0 0
force -freeze sim:/ex_mem_reg/MemRead_E 2 0
force -freeze sim:/ex_mem_reg/MemRead_E 0 0
force -freeze sim:/ex_mem_reg/MemWrite_E 0 0
force -freeze sim:/ex_mem_reg/MemToReg_E 0 0
force -freeze sim:/ex_mem_reg/RegWrite_E 0 0
force -freeze sim:/ex_mem_reg/Branch_E 0 0
force -freeze sim:/ex_mem_reg/Protect_E 0 0
force -freeze sim:/ex_mem_reg/Free_E 0 0
force -freeze sim:/ex_mem_reg/SP_E 0 0
force -freeze sim:/ex_mem_reg/PUSH_POP_E 0 0
force -freeze sim:/ex_mem_reg/in_E 0 0
force -freeze sim:/ex_mem_reg/RET_CALL_E 0 0
force -freeze sim:/ex_mem_reg/JMP_E 0 0
force -freeze sim:/ex_mem_reg/zero_flag_E 0 0
force -freeze sim:/ex_mem_reg/Reg_dst_E 32'd10 0
run
run
