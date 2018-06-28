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
	input logic alu_source_control,							//From controler
	input logic [4:0] alu_op_from_control,					//From controler
	input logic [3:0] immediate_30_14_12_from_decoder,		//immediate 30 14-12
	input logic [31:0] pc_from_decoder,
	//---------------------------//
	output logic [31:0] alu_result_from_execution,	//saida ula. Vai para proximo estagio.
	output logic [31:0] alu_result_hi_from_execution,	//saida ula. Vai para proximo estagio. ?
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

riscv_alu execution_alu(
	.clk(clk),
	.rst(rst),
	.div_en(),

	.A(alu_input_1),
	.B(alu_input_2),
	.op(), //immediate_30_14_12_from_decoder alu_op_from_control ?

	.freeze_pipe(), // ?
	.C(alu_result_from_execution),
	.C_hi(alu_result_hi_from_execution)
);

always_ff @(posedge clk or negedge rst) begin
	//TODO
	//Estado reset

	//Variaveis passadas diretamente para o proximo estagio
	read_data_2_from_execution <= read_data_2_from_decoder;
	immed_11_7_from_execution <= immed_11_7_from_decoder;

	//Calcula AddSum a partir do PC e immediate
	//TODO
	//Verificar se eh preciso fazer shift como indicado na imagem da documentacao
	add_sum_from_execution <= pc_from_decoder + immed_31_0_from_decoder;

	//Seleciona input da alu
	alu_input_1 <= read_data_1_from_decoder;
	alu_input_2 <= (alu_source_control) ? immed_31_0_from_decoder : read_data_2_from_decoder;

end
endmodule