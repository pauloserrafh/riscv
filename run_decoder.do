vlog -f compile_questa_sv_win.f

vsim -t ps -L cycloneiv_ver  -L altera_ver -L altera_mf_ver -L lpm_ver -L sgate_ver -novopt work.tb
run 1ns

add wave -divider "D_CACHE"\
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/instruction \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/pc_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/memory_riscv/branch_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/memory_riscv/d_cache_inst/wren \
sim:/tb/top_architecture_inst/top_cpu_riscv/memory_riscv/d_cache_inst/q \
sim:/tb/top_architecture_inst/top_cpu_riscv/memory_riscv/d_cache_inst/data \
sim:/tb/top_architecture_inst/top_cpu_riscv/memory_riscv/d_cache_inst/clock \
sim:/tb/top_architecture_inst/top_cpu_riscv/memory_riscv/d_cache_inst/address

add wave -divider "BANCO"\
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/registerBank/registers \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/registerBank/rd \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/registerBank/write_data \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/registerBank/write

add wave -divider "EXEC"\
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/rd_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/read_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/rd_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/result_from_execution \

add wave -divider "MEM"\
sim:/tb/top_architecture_inst/top_cpu_riscv/memory_riscv/result_from_memory \
sim:/tb/top_architecture_inst/top_cpu_riscv/memory_riscv/result_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/memory_riscv/data_to_write \
sim:/tb/top_architecture_inst/top_cpu_riscv/memory_riscv/rd_from_memory \
sim:/tb/top_architecture_inst/top_cpu_riscv/memory_riscv/memory_addr \
sim:/tb/top_architecture_inst/top_cpu_riscv/memory_riscv/read_from_memory \
sim:/tb/top_architecture_inst/top_cpu_riscv/memory_riscv/out_from_memory_dcache \
sim:/tb/top_architecture_inst/top_cpu_riscv/memory_riscv/memory_addr

add wave -divider "WRITE_BACK"\
sim:/tb/top_architecture_inst/top_cpu_riscv/write_back_riscv/write_reg_from_wb \
sim:/tb/top_architecture_inst/top_cpu_riscv/write_back_riscv/write_reg_from_memory \
sim:/tb/top_architecture_inst/top_cpu_riscv/write_back_riscv/write_data \
sim:/tb/top_architecture_inst/top_cpu_riscv/write_back_riscv/select_from_memory \
sim:/tb/top_architecture_inst/top_cpu_riscv/write_back_riscv/data_write_from_wb \
sim:/tb/top_architecture_inst/top_cpu_riscv/write_back_riscv/result_from_wb \
sim:/tb/top_architecture_inst/top_cpu_riscv/write_back_riscv/result_from_memory \
sim:/tb/top_architecture_inst/top_cpu_riscv/write_back_riscv/rd_from_wb \
sim:/tb/top_architecture_inst/top_cpu_riscv/write_back_riscv/rd_from_memory

run 20000ns
