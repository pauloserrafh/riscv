// RELEASE HISTORY
// VERSION 	DATE         AUTHOR		DESCRIPTION
// 1.0		2018-05-07   group   	version sv

`timescale 1ns/1ps
module top_cpu (
	input logic clk_top_cpu,
	input logic rst_top_cpu,
	//---------------------------//
	output logic [31:0] pc_out,
	output logic start_read,
	output logic [31:0] instruction_out
);
//--------------INTERNAL-SIGNALS------------------//
//-------------FETCH--------------------//
logic [31:0] next_pc_top_cpu;
logic load_next_pc_top_cpu;

logic [31:0] instr_top_cpu			;
logic [31:0] pc_top_cpu			;
logic [31:0] npc_top_cpu			;

logic next_pc_top			;
//-------------DECODER--------------------//
//                                      ;
logic  	write_reg_from_write_back_top_cpu	;
logic [31:0]	write_data_from_write_back_top_cpu	;
//
logic [4:0] 	rd_from_write_back_top_cpu			;
//
logic 			write_reg_from_decoder_top_cpu		;
logic 			write_reg_select_from_deco_top_cpu	;
//
logic 			read_mem_from_decoder_top_cpu		;
logic 			write_mem_from_decoder_top_cpu		;
logic 			branch_from_decoder_top_cpu			;
logic 			u_branch_from_decoder_top_cpu		;
//
logic 			a_select_from_decoder_top_cpu		;
logic 			b_select_from_decoder_top_cpu		;
logic 			signed_comp_from_decoder_top_cpu	;
logic [1:0] 	result_select_from_decoder_top_cpu	;
logic [2:0] 	alu_op_from_decoder_top_cpu			;
logic 			left_from_decoder_top_cpu			;
logic 			aritm_from_decoder_top_cpu			;
// PIPELINE
logic [31:0]	pc_from_decoder_top_cpu				;
logic [31:0]	rs1_data_from_decoder_top_cpu		;
logic [31:0]	rs2_data_from_decoder_top_cpu		;
logic [31:0]	imm_from_decoder_top_cpu			;
logic [4:0] 	rs1_from_decoder_top_cpu			;
logic [4:0] 	rs2_from_decoder_top_cpu			;
logic [4:0] 	rd_from_decoder_top_cpu				;
logic [2:0]		funct3_from_decoder_top_cpu			;
//
logic 		write_reg_from_memory_top_cpu		       	;
logic 		write_reg_from_wb_top_cpu			       	;
logic [4:0] rd_from_memory_top_cpu				;
logic [4:0] rd_from_wb_top_cpu					;
logic [31:0]result_from_memory_top_cpu			;
logic [31:0]result_from_wb_top_cpu				;
logic [31:0]branch_addr_from_execution_top_cpu 	;
logic [31:0]result_from_execution_top_cpu		;
logic [31:0]rs2_data_from_execution_top_cpu	   ;
logic 		equal_from_execution_top_cpu		       ;
logic 		greater_from_execution_top_cpu		   ;
logic 		lesser_from_execution_top_cpu		       ;
logic [2:0]	funct3_from_execution_top_cpu		;
logic [4:0]	rd_from_execution_top_cpu			;
logic 		write_reg_from_execution_top_cpu	       ;
logic 		select_from_execution_top_cpu	       		;
logic 		read_from_execution_top_cpu		       ;
logic 		write_from_execution_top_cpu		       ;
logic 		branch_from_execution_top_cpu		       ;
logic 		u_branch_from_execution_top_cpu          ;

//-------------EXECUTION--------------------//

//-------------MEMORY--------------------//
logic [2:0] funct3_from_memory_top_cpu;
logic select_from_memory_top_cpu;
logic read_from_memory_top_cpu;
logic write_from_memory_top_cpu;
logic [29:0] memory_addr_top_cpu;
logic [31:0] data_to_write_top_cpu;
logic [3:0] byte_enable_from_memory_top_cpu;

//-------------WRITEBACK--------------------//
logic [31:0] out_from_memory_top_cpu;

logic [31:0] data_write_from_wb_top_cpu;

//--------------INSTANCES-HDL------------------//
fetch fetch_riscv(
	.clk			(  clk_top_cpu	)	,
	.rst			(  rst_top_cpu	)	,
	//memory
	.next_pc		(  next_pc_top_cpu		)	,
	.load_next_pc	(  load_next_pc_top_cpu	)	,
	//
	.instruction	(instr_top_cpu	) 			,
	.pc				(pc_top_cpu		) 		,
	.npc			(npc_top_cpu	)
);

decoder decoder_riscv(
	.clk							(clk_top_cpu	)	,
	.rst_h							(rst_top_cpu	)	,
	//FETCH
	.pc_from_fetch					( pc_top_cpu		),
	.instr_from_icache				( instr_top_cpu	),
	
	.write_reg_from_decoder			(write_reg_from_decoder_top_cpu			)	,
	//
	.pc_from_decoder             	(pc_from_decoder_top_cpu			)	,
	.rs1_data_from_decoder       	(rs1_data_from_decoder_top_cpu		)	,
	.rs2_data_from_decoder       	(rs2_data_from_decoder_top_cpu		)	,
	.imm_from_decoder            	(imm_from_decoder_top_cpu			)	,
	.funct3_from_decoder	        (funct3_from_decoder_top_cpu		)	,
	.rd_from_decoder             	(rd_from_decoder_top_cpu			)	,
	.rs1_from_decoder            	(rs1_from_decoder_top_cpu			)	,
	.rs2_from_decoder            	(rs2_from_decoder_top_cpu			)	,
	.aritm_from_decoder            (aritm_from_decoder_top_cpu				)	,
	.left_from_decoder             (left_from_decoder_top_cpu				)	,
	.a_select_from_decoder			(a_select_from_decoder_top_cpu			)	,
	.b_select_from_decoder			(b_select_from_decoder_top_cpu			)	,
	.signed_comp_from_decoder		(signed_comp_from_decoder_top_cpu		)	,
	.result_select_from_decoder		(result_select_from_decoder_top_cpu		)	,
	.alu_op_from_decoder           (alu_op_from_decoder_top_cpu			)	,
	//// WRITE-BACK
	.write_reg_from_write_back		( write_reg_from_wb_top_cpu		),
	.write_data_from_write_back		( data_write_from_wb_top_cpu	),
	.rd_from_write_back				(  rd_from_wb_top_cpu			),
	//
	.write_reg_select_from_decoder	(write_reg_select_from_deco_top_cpu		)	,
	.read_mem_from_decoder			(read_mem_from_decoder_top_cpu			)	,
	.write_mem_from_decoder			(write_mem_from_decoder_top_cpu			)	,
	.branch_from_decoder			( branch_from_decoder_top_cpu			)	,
	.u_branch_from_decoder			(u_branch_from_decoder_top_cpu			)

);

 execution execution_riscv(
	.clk						(clk_top_cpu	),
	.rst						(rst_top_cpu	),
	//FROM DECODER
	.write_reg_from_decoder		(write_reg_from_decoder_top_cpu	),
	.pc_from_decoder			(pc_from_decoder_top_cpu	),
	.rs1_data_from_decoder		(rs1_data_from_decoder_top_cpu		),
	.rs2_data_from_decoder		(rs2_data_from_decoder_top_cpu		),
	.imm_from_decoder			(imm_from_decoder_top_cpu			),
	.funct3_from_decoder		(funct3_from_decoder_top_cpu		),
	.rd_from_decoder			(rd_from_decoder_top_cpu			),
	.reg_src_1_from_decoder 	(rs1_from_decoder_top_cpu		),
	.reg_src_2_from_decoder 	(rs2_from_decoder_top_cpu		),
	.aritm_from_decoder			(aritm_from_decoder_top_cpu				),   //saida ula
	.left_from_decoder			(left_from_decoder_top_cpu				),
	.a_select_from_decoder		(a_select_from_decoder_top_cpu			),
	.b_select_from_decoder		(b_select_from_decoder_top_cpu			),
	.signed_comp_from_decoder	(signed_comp_from_decoder_top_cpu		),
	.result_select_from_decoder	(result_select_from_decoder_top_cpu		),
	.alu_op_from_decoder		(alu_op_from_decoder_top_cpu			),
	.select_from_decoder		(	write_reg_select_from_deco_top_cpu		),   //saida ula
	.read_from_decoder			(	read_mem_from_decoder_top_cpu			),
	.write_from_decoder			(	write_mem_from_decoder_top_cpu			),
	.branch_from_decoder		(	 branch_from_decoder_top_cpu			),
	.u_branch_from_decoder		(	u_branch_from_decoder_top_cpu			),
	//ADIANTAMENTO
	.write_reg_from_memory			(write_reg_from_memory_top_cpu			)	,
	.write_reg_from_wb				(write_reg_from_wb_top_cpu				)	,
	.rd_from_memory					(rd_from_memory_top_cpu					)	,
	.rd_from_wb						(rd_from_wb_top_cpu						)	,
	.result_from_memory				(result_from_memory_top_cpu				)	,
	.result_from_wb					(result_from_wb_top_cpu					)	,
	.branch_addr_from_execution		(branch_addr_from_execution_top_cpu 	)	,
	.result_from_execution			(result_from_execution_top_cpu			)	,
	.rs2_data_from_execution		(rs2_data_from_execution_top_cpu	   	)	,
	.equal_from_execution			(equal_from_execution_top_cpu			)	,
	.greater_from_execution			(greater_from_execution_top_cpu			)	,
	.lesser_from_execution			(lesser_from_execution_top_cpu		   	)	,
	.funct3_from_execution			(funct3_from_execution_top_cpu			)	,
	.rd_from_execution				(rd_from_execution_top_cpu				)	,
	.write_reg_from_execution		(write_reg_from_execution_top_cpu		)	,
	.select_from_execution			(select_from_execution_top_cpu	   	)	,
	.read_from_execution			(read_from_execution_top_cpu		   	)	,
	.write_from_execution			(write_from_execution_top_cpu			)	,
	.branch_from_execution			(branch_from_execution_top_cpu			)	,
	.u_branch_from_execution        (u_branch_from_execution_top_cpu    	)
);

memory memory_riscv (
	.clk				(clk_top_cpu),
	.rst				(rst_top_cpu)	,
	//---------------------------//
	.branch_addr_from_execution(branch_addr_from_execution_top_cpu),
	.result_from_execution(result_from_execution_top_cpu),
	.rs2_data_from_execution(rs2_data_from_execution_top_cpu),
	.funct3_from_execution(funct3_from_execution_top_cpu),
	.rd_from_execution(rd_from_execution_top_cpu),
	.equal_from_execution(equal_from_execution_top_cpu),
	.lesser_from_execution(lesser_from_execution_top_cpu),
	.greater_from_execution(greater_from_execution_top_cpu),
	.read_from_execution(read_from_execution_top_cpu),
	.write_from_execution(write_from_execution_top_cpu),
	.branch_from_execution(branch_from_execution_top_cpu),
	.u_branch_from_execution(u_branch_from_execution_top_cpu),
	.write_reg_from_execution(write_reg_from_execution_top_cpu),
	.select_from_execution(select_from_execution_top_cpu),
	//----------------------------//
	.result_from_memory(result_from_memory_top_cpu),
	.funct3_from_memory(funct3_from_memory_top_cpu),
	.rd_from_memory(rd_from_memory_top_cpu),
	.load_next_pc(load_next_pc_top_cpu),
	.next_pc(next_pc_top_cpu),
	.write_reg_from_memory(write_reg_from_memory_top_cpu),
	.select_from_memory(select_from_memory_top_cpu),
	.out_from_memory_dcache (out_from_memory_top_cpu)
);

write_back write_back_riscv (
	.clk				(clk_top_cpu),
	.rst				(rst_top_cpu),
	//---------------------------//
	.result_from_memory(result_from_memory_top_cpu),
	.funct3_from_memory(funct3_from_memory_top_cpu),
	.rd_from_memory(rd_from_memory_top_cpu),
	.out_from_memory(out_from_memory_top_cpu),
	.write_reg_from_memory(write_reg_from_memory_top_cpu),
	.select_from_memory(select_from_memory_top_cpu),
	//----------------------------//
	.data_write_from_wb(data_write_from_wb_top_cpu),
	.rd_from_wb(rd_from_wb_top_cpu),
	.result_from_wb(result_from_wb_top_cpu),
	.write_reg_from_wb(write_reg_from_wb_top_cpu)
);

endmodule