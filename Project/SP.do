force -freeze sim:/stackpointer/rst 1 0
force -freeze sim:/stackpointer/clk 1 0, 0 {50 ns} -r 100
force -freeze sim:/stackpointer/SP_Write 1 0
force -freeze sim:/stackpointer/Push_Pop 1 0
run
force -freeze sim:/stackpointer/rst 0 0
run


