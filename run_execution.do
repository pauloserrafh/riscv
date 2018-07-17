vlog -f compile_questa_sv_win.f

vsim -t ps -L cycloneiv_ver  -L altera_ver -L altera_mf_ver -L lpm_ver -L sgate_ver -novopt work.tb
run 1ns

add wave -divider "EXECUTION" \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/rst \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/write_reg_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/write_reg_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/write_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/write_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/u_branch_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/u_branch_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/signed_comp_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/select_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/select_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/rs2_data_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/rs2_data_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/rs1_data_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/result_select_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/result_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/reg_src_2_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/reg_src_1_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/read_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/read_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/rd_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/rd_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/pc_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/lesser_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/left_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/imm_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/greater_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/funct3_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/funct3_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/equal_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/branch_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/branch_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/branch_addr_from_execution \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/b_select_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/aritm_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/alu_op_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/a_select_from_decoder \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/FowardingB \
sim:/tb/top_architecture_inst/top_cpu_riscv/execution_riscv/FowardingA

run 50000ns
