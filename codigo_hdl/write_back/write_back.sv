// RELEASE HISTORY
// VERSION 	DATE         AUTHOR		DESCRIPTION
// 1.0		2018-05-07   group   	version sv

`timescale 1ns/1ps
module write_back (
	input logic clk,
	input logic rst,
	//---------------------------//
	input logic [31:0] result_from_memory,
	input logic [2:0] funct3_from_memory,
	input logic [4:0] rd_from_memory,
	input logic [31:0] out_from_memory,
	input logic write_reg_from_memory,	//Dados do controle
	input logic select_from_memory,		//Dados do controle
	//----------------------------//
	output logic [31:0] data_write_from_wb,
	output logic [4:0] rd_from_wb,
	output logic [31:0] result_from_wb,
	output logic write_reg_from_wb
);
//---------------------------------//

	logic [31:0] write_data;

load_unit l_unit(
	.mem_out(out_from_memory),
	.offset(result_from_memory[1:0]),
	.funct3(funct3_from_memory),
	.data(write_data)
);

always_comb begin
	if(rst) begin
		data_write_from_wb = 32'b0;
		rd_from_wb 			= 5'b0;
		result_from_wb 		= 32'b0;
		write_reg_from_wb 	= 1'b0;
	end else begin
		//Envia valor do bit write_reg para o estagio decoder
		write_reg_from_wb = write_reg_from_memory;

		//Assign dado que sera escrito na memoria
		data_write_from_wb 	= (select_from_memory) ? write_data : result_from_memory;

		//Assign registrador que sera escrito.
		rd_from_wb 	= rd_from_memory;

		//Envia result para a unidade de forwarding
		result_from_wb 	= result_from_memory;
	end
end
endmodule