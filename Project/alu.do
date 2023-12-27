force -freeze sim:/alu_32bit/rst 0 0
force -freeze sim:/alu_32bit/alu_en 1 0
force -freeze sim:/alu_32bit/A 32'd15 0
force -freeze sim:/alu_32bit/ALUOp 4'd12 0
run
force -freeze sim:/alu_32bit/carry_in 0 0
force -freeze sim:/alu_32bit/Shift 5'd3 0
run
