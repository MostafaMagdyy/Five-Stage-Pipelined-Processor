force -freeze sim:/id_ex_reg/MemToReg_D 1 0
force -freeze sim:/id_ex_reg/en 1 0
force -freeze sim:/id_ex_reg/clk 1 25, 0 {75 ns} -r 100
force -freeze sim:/id_ex_reg/rst 1 0
force -freeze sim:/id_ex_reg/ALUsrc_D 1 0
force -freeze sim:/id_ex_reg/AluOP_D 4'd4 0
force -freeze sim:/id_ex_reg/MemRead_D 0 0
force -freeze sim:/id_ex_reg/MemWrite_D 1 0
force -freeze sim:/id_ex_reg/Protect_D 1 0
force -freeze sim:/id_ex_reg/MemToReg_D 0 0
force -freeze sim:/id_ex_reg/RegWrite_D 1 0
force -freeze sim:/id_ex_reg/Branch_D 0 0
force -freeze sim:/id_ex_reg/OUT_D 1 0
force -freeze sim:/id_ex_reg/Rsrc1_D 32'd1 0
force -freeze sim:/id_ex_reg/Rsrc2_D 32'd2 0
force -freeze sim:/id_ex_reg/Rdst_D 3'd3 0
force -freeze sim:/id_ex_reg/instruction 16'd4 0
run
force -freeze sim:/id_ex_reg/rst 0 0
run