force -freeze sim:/cpu/rst 1 0
force -freeze sim:/cpu/clk 1 25, 0 {75 ns} -r 100
run
force -freeze sim:/cpu/rst 0 0
run
run
run
run
run
run
run
run
run
