// RELEASE HISTORY
// VERSION 	DATE         AUTHOR		DESCRIPTION
// 1.0		2018-05-07   group   	version sv

`timescale 1ns/1ps
module write_back (
	input logic clk,
	input logic rst,
	//---------------------------//
	input logic [31:0] read_data,
	input logic [31:0] ula_result,
	input logic mem_to_reg_control, //vem do controle
	//----------------------------//
	output logic [31:0] data_write_mem
	
);
//---------------------------------//







endmodule 