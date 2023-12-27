force -freeze sim:/cpu/rst 1 0
force -freeze sim:/cpu/clk 1 25, 0 {75 ps} -r 100
force -freeze sim:/cpu/rst 0 0
run
run 
run
run
force -freeze sim:/cpu/IN_PORT 32'h0CDAFE19 0
run
force -freeze sim:/cpu/IN_PORT 32'hFFFF 0
run
force -freeze sim:/cpu/IN_PORT 32'hF320 0
run 
run
run
run
run
run
run
run
run
run