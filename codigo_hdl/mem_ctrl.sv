// -----------------------------------------------------------------------------
// FILE NAME      : mem_ctrl
// AUTHOR         : voo
// AUTHOR'S EMAIL : voo@cin.ufpe.br
// -----------------------------------------------------------------------------
// RELEASE HISTORY
// VERSION 	DATE         AUTHOR		DESCRIPTION
// 2.0		2017-01-30   voo   		version sv
// -----------------------------------------------------------------------------
`timescale 1ns/1ps

module mem_ctrl (
	input logic	clk,
	input logic	rst,
	//CPU:
	input 	logic 			read_from_memory,      
	input 	logic 			write_from_memory,      
	input  	logic [31:0]	memory_addr,
	input  	logic [31:0]	data_to_write,
	input 	logic [3:0]		byte_enable_from_memory,
	output 	logic [31:0] 	data_to_read, //out_from_memory

	//WISHBONE:
	/*output logic wshbn_rd,     
	output logic wshbn_wr,     
	output logic [29:0] wshbn_addr_o,
	output logic [31:0] wshbn_data_o,
	input  logic [31:0] wshbn_data_i,
	input  logic wshbn_busy,
	input  logic wshbn_data_av,
	*/
  //

);

 d_cache d_cache_inst (
	.address		(	memory_addr[11:0]	),
	.clock			(	clk	),
	.data			(	data_to_write	),
	.wren			(	write_from_memory	),
	.q				(	data_to_read	)
);	

endmodule

