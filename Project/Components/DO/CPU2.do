force -freeze sim:/cpu/rst 1 0
force -freeze sim:/cpu/clk 1 0, 0 {50 ns} -r 100
force -freeze sim:/cpu/IN_PORT 32'd0 0
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
run


or r2,r2,r3
protect r2
lDD r7,EA (3) 
DEC R7
NOT R7
OUT R7