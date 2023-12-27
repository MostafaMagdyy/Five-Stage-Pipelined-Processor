force -freeze sim:/mem_wb_reg/clk 1 25, 0 {75 ns} -r 100
force -freeze sim:/mem_wb_reg/en 1 0

force -freeze sim:/mem_wb_reg/rst 1 0
force -freeze sim:/mem_wb_reg/Rdst_M 3'd1 0
force -freeze sim:/mem_wb_reg/AluOut_M 32'd1 0
force -freeze sim:/mem_wb_reg/MemOut_M 32'd1 0
force -freeze sim:/mem_wb_reg/MemToReg_M 1 0
force -freeze sim:/mem_wb_reg/RegWrite_M 1 0
force -freeze sim:/mem_wb_reg/in_M 1 0
run
force -freeze sim:/mem_wb_reg/rst 0 0
run


force -freeze sim:/mem_wb_reg/rst 0 0
force -freeze sim:/mem_wb_reg/Rdst_M 3'd0 0
force -freeze sim:/mem_wb_reg/AluOut_M 32'd0 0
force -freeze sim:/mem_wb_reg/MemOut_M 32'd0 0
force -freeze sim:/mem_wb_reg/MemToReg_M 0 0
force -freeze sim:/mem_wb_reg/RegWrite_M 0 0
force -freeze sim:/mem_wb_reg/in_M 0 0
run
run
