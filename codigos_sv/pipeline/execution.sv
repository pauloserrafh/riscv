// RELEASE HISTORY
// VERSION 	DATE         AUTHOR		DESCRIPTION
// 1.0		2018-05-07   group   	version sv

`timescale 1ns/1ps
module execution (
	input logic clk,
	input logic rst,
	//---------------------------//
	input logic [31:0] read_data_1_from_decoder,
	input logic [31:0] read_data_2_from_decoder,
	input logic [31:0] immed_31_0_from_decoder,
	input logic [4:0] immed_11_7_from_decoder,
	input logic alu_source,							//From controler
	//input logic [3:0] alu_op_from_controller,		//immediate 30 14-12
	input logic [2:0] alu_op_2_0_from_decoder,
	input logic alu_op_3_from_decoder,
	input logic [31:0] pc_from_decoder,
	//---------------------------//
	output logic [31:0] alu_result_from_execution,	//saida ula. Vai para proximo estagio.
	//Caso a ALU seja uma unidade externa, a flag sera enviada por ela.
	//Nao deve ficar aqui essa variavel
	//output logic flag_zero_from_execution,		//flag zero da ula. Vai para proximo estagio.
	output logic [31:0] add_sum_from_execution, 	//AddSum, calculo do PC caso haja desvio. Vai para proximo estagio.
	output logic [4:0] 	immed_11_7_from_execution,	//Vem do estagio anterior e passado para o proximo
	output logic [31:0] read_data_2_from_execution,	//Vem do estagio anterior e passado para o proximo

	//Dados que irao para a ALU. Variaveis existem para os testes.
	//Quando tudo estiver integrado, serao removidas.
	output logic [31:0] alu_input_1,
	output logic [31:0] alu_input_2
);
//---------------------------------//

always_ff @(posedge clk or negedge rst) begin
	//TODO
	//Estado reset

	//Variaveis passadas diretamente para o proximo estagio
	assign read_data_2_from_execution = read_data_2_from_decoder;
	assign immed_11_7_from_execution = immed_11_7_from_decoder;

	//Calcula AddSum a partir do PC e immediate
	//TODO
	//Verificar se eh preciso fazer shift como indicado na imagem da documentacao
	assign add_sum_from_execution = pc_from_decoder + immed_31_0_from_decoder;

	//Seleciona input da alu
	assign alu_input_1 = read_data_1_from_decoder;
	assign alu_input_2 = (alu_source) ? immed_31_0_from_decoder : read_data_2_from_decoder;

end
endmodule