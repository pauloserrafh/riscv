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
	//----------------------------//
	output logic [31:0] data_write_mem

);
//---------------------------------//







endmodule