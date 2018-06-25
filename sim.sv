`timescale 1ns/1ps
module sim();
	reg clk;
	reg rst;
	//---------------------------//
	reg [31:0] alu_result_from_execution;
	reg flag_zero_from_execution;
	reg [31:0] add_sum_from_execution;
	reg [31:0] read_data_2_from_execution;
	reg [4:0] immed_11_7_from_execution;
	reg mem_read_control;
	reg mem_write_control;
	reg branch_control;
	reg [31:0] read_data_from_memory_controller;
	//----------------------------//
	wire [31:0] read_data_from_memory;
	wire [31:0] alu_result_from_memory;
	wire [4:0] immed_11_7_from_memory;
	wire [31:0] add_sum_from_memory;
	wire PCSrc;
	//Dado enviado ao controler para ler/escrever da memoria
	wire read;
	wire write;
	wire [31:0] memory_addr;
	wire [31:0] data_to_write;

	memfull testmembehavior(
		clk,
		rst,
		alu_result_from_execution,
		flag_zero_from_execution,
		add_sum_from_execution,
		read_data_2_from_execution,
		immed_11_7_from_execution,
		mem_read_control,
		mem_write_control,
		branch_control,
		read_data_from_memory_controller,
		read_data_from_memory,
		alu_result_from_memory,
		immed_11_7_from_memory,
		add_sum_from_memory,
		PCSrc,
		read,
		write,
		memory_addr,
		data_to_write
	);
	initial begin
		clk=0;
		rst=0;
		#10
		clk=1;
		alu_result_from_execution = {32{4'bzx01}};
		flag_zero_from_execution = 0;
		add_sum_from_execution = {32{4'bzx01}};
		read_data_2_from_execution = {32{4'bzx01}};
		immed_11_7_from_execution = {32{4'bzx01}};
		mem_read_control = 1;
		mem_write_control = 0;
		branch_control = 0;
		read_data_from_memory_controller = {32{4'bzx01}};
		#15
		clk = 0;
		read_data_from_memory_controller = {32{4'b1111}};
		#20
		clk = 1;
		alu_result_from_execution = {32{4'bzx01}};
		flag_zero_from_execution = 0;
		add_sum_from_execution = {32{4'bzx01}};
		read_data_2_from_execution = {32{4'bzx01}};
		immed_11_7_from_execution = {32{4'bzx01}};
		mem_read_control = 0;
		mem_write_control = 0;
		branch_control = 0;
		read_data_from_memory_controller = {32{4'bzx01}};
	end
endmodule
