add wave -position insertpoint  \
sim:/datamemory/Cur_StackPointer \
sim:/datamemory/MemoryProtection \
sim:/datamemory/Next_StackPointer \
sim:/datamemory/Push_Pop \
sim:/datamemory/SP_Write \
sim:/datamemory/address \
sim:/datamemory/clk \
sim:/datamemory/data_in \
sim:/datamemory/data_out \
sim:/datamemory/free_sig \
sim:/datamemory/memory \
sim:/datamemory/protect_sig \
sim:/datamemory/read_enable \
sim:/datamemory/rst \
sim:/datamemory/write_enable
force -freeze sim:/datamemory/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/datamemory/rst 1 0
run
force -freeze sim:/datamemory/rst 0 0
force -freeze sim:/datamemory/SP_Write 1 0
force -freeze sim:/datamemory/Push_Pop 1 0
force -freeze sim:/datamemory/data_in 2'd10 0
run
force -freeze sim:/datamemory/rst 0 0
run
force -freeze sim:/datamemory/Push_Pop 0 0
force -freeze sim:/datamemory/Push_Pop 0 0
run
force -freeze sim:/datamemory/SP_Write 0 0
force -freeze sim:/datamemory/address 2'd15 0
force -freeze sim:/datamemory/write_enable 1 0
run
force -freeze sim:/datamemory/write_enable 0 0
force -freeze sim:/datamemory/read_enable 1 0
force -freeze sim:/datamemory/read_enable 0 0
force -freeze sim:/datamemory/write_enable 1 0
force -freeze sim:/datamemory/data_in 2'd15 0
run
run
force -freeze sim:/datamemory/write_enable 0 0
force -freeze sim:/datamemory/read_enable 1 0
run