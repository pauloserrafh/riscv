// RELEASE HISTORY
// VERSION 	DATE         AUTHOR		DESCRIPTION
// 1.0		2018-05-07   group   	version sv

`timescale 1ns/1ps
module execution (
	input logic clk,
	input logic rst,
	//---------------------------//
	input logic [31:0] 	read_data_1,
	input logic [31:0] 	read_data_2,
	input logic [31:0] 	immed_31_0,
	input logic [4:0] 	immed_11_7,
	input logic [3:0] 	immed_30_14_12,
	input logic 		alu_source,
	input logic [4:0] 	alu_op,
	//---------------------------//
	output logic [31:0] alu_result,   //saida ula
	output logic 		flag_zero,
	output logic [31:0] add_pc,
	output logic [31:0] read_data_1_out
);
//---------------------------------//







endmodule 