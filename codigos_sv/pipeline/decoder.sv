// RELEASE HISTORY
// VERSION 	DATE         AUTHOR		DESCRIPTION
// 1.0		2018-05-07   group   	version sv

`timescale 1ns/1ps
module decoder (
	input logic clk,
	input logic rst,
	//---------------------------//
	input logic [31:0] 	instruction,
	input logic [4:0] 	write_reg,
	input logic [31:0] 	write_data,
	input logic 		write_reg_control, //RegWrite
	input logic [31:0] 	pc,
	//---------------------------//
	output logic [31:0] read_data_1_from_decoder,
	output logic [31:0] read_data_2_from_decoder,
	output logic [31:0] immed_31_0_from_decoder,
	output logic [4:0] immed_11_7_from_decoder,
	output logic [3:0] immed_30_14_12_from_decoder
);
//---------------------------------//







endmodule 