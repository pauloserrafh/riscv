// RELEASE HISTORY
// VERSION 	DATE         AUTHOR		DESCRIPTION
// 1.0		2018-05-07   group   	version sv

`timescale 1ns/1ps
module memory (
	input logic clk,
	input logic rst,
	//---------------------------//
	input logic [31:0] alu_result_from_execution,	//saida ula. Vem do estagio anterior ou da ULA.
	input logic flag_zero_from_execution,			//flag zero da ula. Vem do estagio anterior ou da ULA.
	input logic [31:0] add_sum_from_execution,		//AddSum, calculo do PC caso haja desvio. Vem do estagio anterior.
	input logic [31:0] read_data_2_from_execution,	//Vem do estagio anterior e passado para o proximo
	input logic [4:0] immed_11_7_from_execution,	//Vem do estagio anterior e passado para o proximo
	input logic mem_read_control,
	input logic mem_write_control,
	input logic branch_control,
	input logic [31:0] read_data_from_memory_controller, //Dado lido pela memoria (bloco externo)
	//----------------------------//
	output logic [31:0] read_data_from_memory,
	output logic [31:0] alu_result_from_memory,
	output logic [4:0] immed_11_7_from_memory,
	output logic [31:0] add_sum_from_memory,
	output logic PCSrc_from_memory,
	//Dado enviado ao controler para ler/escrever da memoria
	output logic read,
	output logic write,
	output logic [31:0] memory_addr,
	output logic [31:0] data_to_write
);
//---------------------------------//

always_latch begin
	if (mem_read_control) begin
		assign read_data_from_memory = read_data_from_memory_controller;
	end
end

always_ff @(posedge clk or negedge rst) begin
	//TODO
	//Estado reset

	// Assign valores passados diretamente do estagio anterior
	// para o proximo.
	assign alu_result_from_memory = alu_result_from_execution;
	assign add_sum_from_memory = add_sum_from_execution;
	assign immed_11_7_from_memory = immed_11_7_from_execution;

	//IF flag_zero and branch_control
	//PCSrc = 1 (branch ocorreu)
	//ELSE PCSrc = 0 (branch não ocorreu)
	assign PCSrc_from_memory = (flag_zero_from_execution && branch_control);

	//IF mem_read_control
	//Enviar "alu_result_in" para o controler.
	//Verificar se precisa alinhar o dado
	//read_data = Controler_Data
	if (mem_read_control) begin
		assign memory_addr = alu_result_from_execution;
		//TODO verificar se essas variaveis sao necessarias ou o controle sabera se deve ler ou escrever
		assign read = 1;
		assign write = 0;
	end
	//IF mem_write_control
	//Enviar "(alu_result_in, read_data_2_in)" para o controler salvar na memória
	if (mem_write_control) begin
		assign memory_addr = alu_result_from_execution;
		assign data_to_write = read_data_2_from_execution;
		//TODO verificar se essas variaveis sao necessarias ou o controle sabera se deve ler ou escrever
		assign read = 0;
		assign write = 1;
	end
end
endmodule