// RELEASE HISTORY
// VERSION 	DATE         AUTHOR		DESCRIPTION
// 1.0		2018-05-07   group   	version sv

`timescale 1ns/1ps
module memory (
	input logic clk,
	input logic rst,
	//---------------------------//
	input logic [31:0] branch_addr_from_execution,
	input logic [31:0] result_from_execution,
	input logic [31:0] rs2_data_from_execution,
	input logic [2:0] funct3_from_execution,
	input logic [4:0] rd_from_execution,
	input logic equal_from_execution,
	input logic lesser_from_execution,
	input logic greater_from_execution,
	input logic read_from_execution,		//Dados do controle
	input logic write_from_execution,		//Dados do controle
	input logic branch_from_execution,	//Dados do controle
	input logic u_branch_from_execution,	//Dados do controle
	input logic write_reg_from_execution,	//Dados do controle
	input logic select_from_execution,	//Dados do controle
	//----------------------------//
	output logic [31:0] result_from_memory,
	output logic [2:0] funct3_from_memory,
	output logic [4:0] rd_from_memory,
	output logic load_next_pc,
	output logic [31:0] next_pc,
	output logic write_reg_from_memory,	//Dados do controle
	output logic select_from_memory,	//Dados do controle
	//Dado enviado ao controler para ler/escrever da memoria
	output logic [31:0] out_from_memory_dcache
);
//---------------------------------//

	logic resolve;
	logic [3:0] byte_enable;
	logic [31:0] write_data;	
	logic [31:0] out_d_cache;
	

	branch_unit b_unit(
		.equal(equal_from_execution),
		.lesser(lesser_from_execution),
		.greater(greater_from_execution),
		.branch_type(funct3_from_execution),
		.resolve(resolve)
	);

	store_unit s_unit(
		.mem_in(rs2_data_from_execution),
		.funct3(funct3_from_execution),
		.offset(result_from_execution[1:0]),
		.write_data(write_data),
		.byte_enable(byte_enable)
	);

	d_cache_up d_cache_inst (
		.address		(	result_from_execution[13:2]	),
		.clock			(	clk	),
		.data			(	write_data	),
		.wren			(	write_from_execution	),
		.q				(	out_d_cache	),
		.byteena        (   byte_enable )
	);

	assign out_from_memory_dcache = out_d_cache;

	assign load_next_pc = ((resolve && branch_from_execution) || u_branch_from_execution); // Verifica se deve fazer o desvio ou não. Envia o endereço de desvio para o estagio de fetch.
	assign next_pc = branch_addr_from_execution;

	always_ff @(posedge clk or posedge rst) begin
		if(rst==1'b1) begin
			result_from_memory <= 32'b0;
			funct3_from_memory <= 3'b0;
			rd_from_memory <= 4'b0;
			write_reg_from_memory <= 1'b0;
			select_from_memory <= 1'b0;

		end else begin
			result_from_memory <= result_from_execution;
			funct3_from_memory <= funct3_from_execution;
			rd_from_memory <= rd_from_execution;
			write_reg_from_memory <= write_reg_from_execution;
			select_from_memory <= select_from_execution;		

		end
	end
endmodule