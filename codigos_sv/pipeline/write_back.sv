// RELEASE HISTORY
// VERSION 	DATE         AUTHOR		DESCRIPTION
// 1.0		2018-05-07   group   	version sv

`timescale 1ns/1ps
module write_back (
	input logic clk,
	input logic rst,
	//---------------------------//
	input logic [31:0] read_data_from_memory,
	input logic [31:0] alu_result_from_memory,
	input logic mem_to_reg_control, //vem do controle
	input logic [4:0] immed_11_7_from_memory,
	//----------------------------//
	output logic [31:0] data_write_from_wb,
	output logic [4:0] immed_11_7_from_wb
);
//---------------------------------//


always_ff @(posedge clk or negedge rst) begin
	//TODO
	//Estado reset
	
	//Assign dado que sera escrito na memoria
	assign data_write_from_wb = (mem_to_reg_control) ? alu_result_from_memory : read_data_from_memory;

	//Assign registrador que sera escrito. immediate 11-7.
	assign immed_11_7_from_wb = immed_11_7_from_memory;
end
endmodule