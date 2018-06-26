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
	//output logic [3:0] alu_op_from_decoder,			//immediate 30 14-12. Enviado para o ALU controller.
	//immediate 30 14-12. Enviado para o ALU controller.
	output logic [2:0] alu_op_2_0_from_decoder,
	output logic alu_op_3_from_decoder,
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
		assign read_data_1_from_decoder = read_data_1_from_memory_controller;
		assign read_data_2_from_decoder = read_data_2_from_memory_controller;
	end
end

always_ff @(posedge clk or negedge rst) begin
	//TODO
	//Estado reset

	//Envia a instrução para o controller para que ele possa definir quais serão as proximas
	//saidas para os outros estagios
	assign instruction_to_controller = instruction;

	//Envia pc para o proximo estagio
	assign pc_from_decoder = pc_from_fetch;

	//Instrucao passada diretamente para o proximo estagio
	//TODO
	// Verificar se precisa fazer extensao para 64
	assign immed_31_0_from_decoder = instruction;

	//Assign dos bits usados para alucontrol
	//TODO
	//Descobrir como fazer esse assign!!!
	//assign alu_op_from_decoder [2:0] = instruction[14:12];
	//assign alu_op_from_decoder [3] = instruction[30];
	assign alu_op_2_0_from_decoder = instruction[14:12];
	assign alu_op_3_from_decoder = instruction[30];

	//Assign do imediato 11-7 passados para o proximo estagio
	assign immed_11_7_from_decoder = instruction[11:7];

	//Assign variaveis que irao para a memoria
	if (write_reg_control) begin
		assign read_register_1 = instruction[4:0];
		assign read_register_2 = instruction[9:5];
		assign write_reg_to_memory = immed_11_7_from_wb;
		assign write_data_to_memory = data_write_from_wb;
	end else begin
		assign read_register_1 = instruction[4:0];
		assign read_register_2 = instruction[9:5];
	end

end
endmodule