// RELEASE HISTORY
// VERSION 	DATE         AUTHOR		DESCRIPTION
// 1.0		2018-05-07   group   	version sv

`timescale 1ns/1ps
module memory (
	input logic clk,
	input logic rst,
	//---------------------------//
	input logic [31:0] alu_result,   //saida ula
	input logic 		flag_zero,
	input logic [31:0] add_sum,
	input logic [31:0] read_data_2_in,
	input logic mem_read_control,
	input logic mem_write_control,
	input logic branch_control,
	//----------------------------//
	output logic [31:0] read_data,
	output logic [31:0] ula_result,
	output logic [4:0] immed_11_7
	
);
//---------------------------------//







endmodule 