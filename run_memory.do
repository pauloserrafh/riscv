vlog -f compile_questa_sv_win.f

vsim -t ps -L cycloneiv_ver  -L altera_ver -L altera_mf_ver -L lpm_ver -L sgate_ver -novopt work.tb
run 1ns

add wave -divider "MEMORY" \
run 50000ns
