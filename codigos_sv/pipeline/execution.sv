// RELEASE HISTORY
// VERSION 	DATE         AUTHOR		DESCRIPTION
// 1.0		2018-05-07   group   	version sv

`timescale 1ns/1ps
module execution (
	input logic clk,
	input logic rst,
	//---------------------------//
	input logic [31:0] 	read_data_1_from_decoder,
	input logic [31:0] 	read_data_2_from_decoder,
	input logic [31:0] 	immed_31_0_from_decoder,
	input logic [4:0] 	immed_11_7_from_decoder,
	input logic [3:0] 	immed_30_14_12_from_decoder,,
	input logic 		alu_source,					//From controler
	input logic [4:0] 	alu_op,						//From controler
	//---------------------------//
	output logic [31:0] alu_result_from_execution,	//saida ula. Vai para proximo estagio.
	output logic 		flag_zero_from_execution,					//flag zero da ula. Vai para proximo estagio.
	output logic [31:0] add_sum_from_execution, 	//AddSum, calculo do PC caso haja desvio. Vai para proximo estagio.
	output logic [31:0] read_data_1_from_execution,
	output logic [4:0] 	immed_11_7_from_execution, //Vem do estagio anterior e passado para o proximo
	output logic [31:0] read_data_2_from_execution //Vem do estagio anterior e passado para o proximo
);
//---------------------------------//

endmodule