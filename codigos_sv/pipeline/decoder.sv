// RELEASE HISTORY
// VERSION 	DATE         AUTHOR		DESCRIPTION
// 1.0		2018-05-07   group   	version sv

`timescale 1ns/1ps
module decoder (
	input logic clk,
	input logic rst,
	//---------------------------//
	input logic [31:0] instruction,
	input logic [4:0] immed_11_7_from_wb,
	input logic [31:0] data_write_from_wb,
	input logic write_reg_control,					//RegWrite
	input logic [31:0] pc_from_fetch,
	//---------------------------//
	output logic [31:0] read_data_1_from_decoder,
	output logic [31:0] read_data_2_from_decoder,
	output logic [31:0] immed_31_0_from_decoder,
	output logic [4:0] immed_11_7_from_decoder,
	output logic [3:0] immediate_30_14_12_from_decoder,		//immediate 30 14-12. Enviado para o ALU controller.
	output logic [31:0] instruction_to_controller,
	output logic [31:0] pc_from_decoder,

	//------------------------------------------//
	//Dados que irao para a memoria. Variaveis existem para os testes.
	//Quando tudo estiver integrado, serao removidas.
	input logic [31:0] read_data_1_from_memory_controller,
	input logic [31:0] read_data_2_from_memory_controller,
	output logic [4:0] read_register_1,
	output logic [4:0] read_register_2,
	output logic [4:0] write_reg_to_memory,
	output logic [31:0] write_data_to_memory
);
//---------------------------------//

always_latch begin
	if (~write_reg_control) begin
		read_data_1_from_decoder <= read_data_1_from_memory_controller;
		read_data_2_from_decoder <= read_data_2_from_memory_controller;
	end
end

always_ff @(posedge clk or negedge rst) begin
	//TODO
	//Estado reset

	//Envia a instrução para o controller para que ele possa definir quais serão as proximas
	//saidas para os outros estagios
	instruction_to_controller <= instruction;

	//Envia pc para o proximo estagio
	pc_from_decoder <= pc_from_fetch;

	//Instrucao passada diretamente para o proximo estagio
	//TODO
	// Verificar se precisa fazer extensao para 64
	immed_31_0_from_decoder <= instruction;

	//Assign dos bits usados para alucontrol
	immediate_30_14_12_from_decoder [2:0] <= instruction[14:12];
	immediate_30_14_12_from_decoder [3] <= instruction[30];

	//Assign do imediato 11-7 passados para o proximo estagio
	immed_11_7_from_decoder <= instruction[11:7];

	//Assign variaveis que irao para a memoria
	if (write_reg_control) begin
		read_register_1 <= instruction[4:0];
		read_register_2 <= instruction[9:5];
		write_reg_to_memory <= immed_11_7_from_wb;
		write_data_to_memory <= data_write_from_wb;
	end else begin
		read_register_1 <= instruction[4:0];
		read_register_2 <= instruction[9:5];
	end

end
endmodule