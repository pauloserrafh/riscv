vlog -f compile_questa_sv_win.f

vsim -t ps -L cycloneiv_ver  -L altera_ver -L altera_mf_ver -L lpm_ver -L sgate_ver -novopt work.tb
run 1ns

add wave -divider "FETCH" \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/rst \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/read_inst \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/read_cache \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/pc \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/npc \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/next_pc \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/load_next_pc \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/instruction \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/clk \
sim:/tb/top_architecture_inst/top_cpu_riscv/fetch_riscv/addr_cache

add wave -divider "DECODER" \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/write_reg_select_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/write_reg_select \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/write_reg_from_write_back \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/write_reg_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/write_reg \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/write_mem_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/write_mem \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/write_data_from_write_back \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/u_branch_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/u_branch \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/signed_comp_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/signed_comp \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/rst_n \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/rs2_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/rs2_data_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/rs2_data \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/rs1_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/rs1_data_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/rs1_data \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/result_select_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/result_select \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/read_mem_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/read_mem \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/rd_from_write_back \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/rd_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/pc_from_fetch \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/pc_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/left_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/left \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/instr_from_icache_rs2 \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/instr_from_icache_rs1 \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/instr_from_icache_rd \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/instr_from_icache_funct3 \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/instr_from_icache \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/immediate \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/imm_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/funct3_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/clk \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/branch_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/branch \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/b_select_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/b_select \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/aritm_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/aritm \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/alu_op_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/alu_op \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/a_select_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/decoder_riscv/a_select

add wave -divider "EXECUTION" \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/write_reg_from_wb \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/write_reg_from_memory \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/write_reg_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/write_reg_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/write_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/write_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/u_branch_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/u_branch_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/signed_comp_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/sig_2 \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/sig_1 \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/select_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/select_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/rst \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/rs2_data_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/rs2_data_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/rs1_data_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/result_select_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/result_from_wb \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/result_from_memory \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/result_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/reg_src_2_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/reg_src_1_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/read_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/read_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/rd_from_wb \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/rd_from_memory \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/rd_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/rd_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/pc_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/out_mux_3 \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/out_mux_2 \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/out_mux_1 \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/less_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/left_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/imm_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/greater_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/gnd \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/funct3_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/funct3_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/equal_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/clk \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/branch_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/branch_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/branch_addr_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/b_select_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/aritm_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/alu_op_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/a_select_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/M4_out \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/FowardingB \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/FowardingA \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/BS_out \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/BC_less \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/BC_greater \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/BC_equal \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/BA_out

add wave -divider "MEMORY" \
run 50000ns
