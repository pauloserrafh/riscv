vlog -f compile_questa_sv_win.f

vsim -t ps -L cycloneiv_ver  -L altera_ver -L altera_mf_ver -L lpm_ver -L sgate_ver -novopt work.tb
run 10ps

add wave -divider "TOP" \
sim:/tb/top_architecture_inst/top_cpu_riscv/pc_top_cpu \
sim:/tb/top_architecture_inst/top_cpu_riscv/npc_top_cpu \
sim:/tb/top_architecture_inst/top_cpu_riscv/instr_top_cpu

add wave -divider "FETCH" \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/state \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/reset_f \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/clk \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/rst \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/pc \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/next_pc \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/load_next_pc \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/instruction \

add wave -divider "CACHE_ROM" \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/instr_mem/rden \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/instr_mem/q \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/instr_mem/clock \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/instr_mem/address

run 100000ns
