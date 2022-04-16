restart
add_force clk {1 0ns} {0 5ns} -repeat_every 10ns
add_force a00 {00010000 0ns}
add_force a01 {10010000 0ns}
add_force a02 {00100000 0ns}
add_force a10 {10100000 0ns}
add_force a11 {00110000 0ns}
add_force a12 {00110000 0ns}
add_force a20 {10111000 0ns}
add_force a21 {00111000 0ns}
add_force a22 {00100111 0ns}
add_force b00 {10100111 0ns}
add_force b01 {00100000 0ns}
add_force b02 {00110000 0ns}
add_force b10 {00110000 0ns}
add_force b11 {00010000 0ns}
add_force b12 {10010000 0ns}
add_force b20 {10100000 0ns}
add_force b21 {00110000 0ns}
add_force b22 {00100000 0ns}
run 100ns