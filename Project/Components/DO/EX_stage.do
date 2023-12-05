radix -decimal
# decimal
force -freeze sim:/ex_stage/MemtoReg 0 0
force -freeze sim:/ex_stage/ALU_out 5 0
force -freeze sim:/ex_stage/MEM_out 50 0
run
force -freeze sim:/ex_stage/ALU_out -50 0
run
force -freeze sim:/ex_stage/MemtoReg 1 0
run
force -freeze sim:/ex_stage/MEM_out 300 0
run
run