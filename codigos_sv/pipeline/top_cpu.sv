// RELEASE HISTORY
// VERSION 	DATE         AUTHOR		DESCRIPTION
// 1.0		2018-05-07   group   	version sv

`timescale 1ns/1ps
module top_cpu (
	input logic clk,
	input logic rst,
	//---------------------------//
	output logic [31:0] pc_out,
	output logic start_read,
	output logic [31:0] instruction_out
);
//--------------internal-signals------------------//
logic [31:0] name_signal //example
//---------------------------------//

fetch fetch_riscv(
	.clk			(		)	,
	.rst			(		)	,
	//		
	.next_pc		(		)	,
	.load_next_pc	(		)	,
	//		
	.instruction	(		)	,
	.pc				(		)	,
	.npc			(		)	

);

 decoder decoder_riscv(
	.clk					(	)	,
	.rst					(	)	,
	//
	.instruction			(	)	,
	.write_reg				(	)	,
	.write_data				(	)	,
	.write_reg_control		(	)	, //RegWrite
	.pc						(	)	,
	//
	.read_data_1			(	)	,
	.read_data_2			(	)	,
	.immed_31_0				(	)	,
	.immed_11_7				(	)	,
	.immed_30_14_12			(	)	
);

 execution execution_riscv(
	.clk				(	),
	.rst				(	),
	//                  
	.read_data_1		(	),
	.read_data_2		(	),
	.immed_31_0			(	),
	.immed_11_7			(	),
	.immed_30_14_12		(	),
	.alu_source			(	),
	.alu_op				(	),
	//                  
	.alu_result			(	),   //saida ula
	.flag_zero			(	),
	.add_pc				(	),
	.read_data_1_out	(	)	
	);

	memory memory_riscv (
	.clk				(		)	,
	.rst				(		)	,
	//	
	.alu_result			(		)	,   //saida ula
	.flag_zero			(		)	,
	.add_sum			(		)	,
	.read_data_2_in		(		)	,
	.mem_read_control	(		)	,
	.mem_write_control	(		)	,
	.branch_control		(		)	,
	//
	.read_data			(		)	,
	.ula_result			(		)	,
	.immed_11_7			(		)
);

write_back write_back_riscv (
	.clk				(		),
	.rst				(		),
	//
	.read_data			(		),
	.ula_result			(		),
	.mem_to_reg_control	(		), //vem do controle
	//
	.data_write_mem		(		)
	
);	

	
endmodule 