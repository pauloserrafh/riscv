`timescale 1ns/1ps
module sim_mem_wb();
	reg clk;
	reg rst;
	//---------------------------//
	reg [31:0] branch_addr_from_execution;
	reg [31:0] result_from_execution;
	reg [31:0] rs2_data_from_execution;
	reg [2:0] funct3_from_execution;
	reg [4:0] rd_from_execution;
	reg equal_from_execution;
	reg less_from_execution;
	reg greater_from_execution;
	reg read_from_execution;		//Dados do controle
	reg write_from_execution;		//Dados do controle
	reg branch_from_execution;	//Dados do controle
	reg u_branch_from_execution;	//Dados do controle
	reg write_reg_from_execution;	//Dados do controle
	reg select_from_execution;	//Dados do controle

	//----------------------------//
	wire load_next_pc;
	wire [31:0] next_pc;
	wire [31:0] data_write_from_wb;
	wire [4:0] rd_from_wb;
	wire [31:0] result_from_wb;
	wire write_reg_from_wb;
	//Dados enviados para o modulo de memoria
	wire read_from_memory;
	wire write_from_memory;
	wire [29:0] memory_addr;
	wire [31:0] data_to_write;
	wire [3:0] byte_enable_from_memory;

	//----------------------------//
	// Dado simulado que vem da memoria.
	reg [31:0] out_from_memory;

	//Dados passados de um estagio para o outro diretamente
	wire [2:0] funct3_from_memory_wire;
	wire [31:0] result_from_memory_wire;
	wire [4:0] rd_from_memory_wire;
	wire write_reg_from_memory_wire;
	wire select_from_memory_wire;

	memory testmem(
		clk,
		rst,
		//---------------------------//
		branch_addr_from_execution,
		result_from_execution,
		rs2_data_from_execution,
		funct3_from_execution,
		rd_from_execution,
		equal_from_execution,
		less_from_execution,
		greater_from_execution,
		read_from_execution,		//Dados do controle
		write_from_execution,		//Dados do controle
		branch_from_execution,	//Dados do controle
		u_branch_from_execution,	//Dados do controle
		write_reg_from_execution,	//Dados do controle
		select_from_execution,	//Dados do controle
		//----------------------------//
		result_from_memory_wire,	//De memory para wb direto
		funct3_from_memory_wire,	//De memory para wb direto
		rd_from_memory_wire,	//De memory para wb direto
		load_next_pc,
		next_pc,
		write_reg_from_memory_wire,	//Dados do controle	//De memory para wb direto
		select_from_memory_wire,	//Dados do controle	//De memory para wb direto
		//Dado enviado ao controler para ler/escrever da memoria
		read_from_memory,
		write_from_memory,
		memory_addr,
		data_to_write,
		byte_enable_from_memory
	);

	write_back testwb(
		clk,
		rst,
		//---------------------------//
		result_from_memory_wire,	//De memory para wb direto
		funct3_from_memory_wire,	//De memory para wb direto
		rd_from_memory_wire,		//De memory para wb direto
		out_from_memory,		//Valor dos dados lidos da memoria.
		write_reg_from_memory_wire,		//Dados do controle	//De memory para wb direto
		select_from_memory_wire,			//Dados do controle	//De memory para wb direto
		//----------------------------//
		data_write_from_wb,
		rd_from_wb,
		result_from_wb,
		write_reg_from_wb
	);
	initial begin
		#0
		clk=0;
		rst=1;
		//Caso minimalista
		//Leitura da memoria e escrita no banco de registradores.
		#5
		clk=1;
		branch_addr_from_execution = {32'b00000000000000000000000000000001};
		result_from_execution = {32'b00000000000000000000000000000000};
		rs2_data_from_execution = {32'b00000000000000000000000000000000};
		funct3_from_execution = {3'b010};
		rd_from_execution = {4'b1111};
		equal_from_execution = {1'b0};
		less_from_execution = {1'b0};
		greater_from_execution = {1'b0};
		read_from_execution = {1'b1};		//Dados do controle
		write_from_execution = {1'b0};		//Dados do controle
		branch_from_execution = {1'b0};		//Dados do controle
		u_branch_from_execution = {1'b0};	//Dados do controle
		write_reg_from_execution = {1'b1};	//Dados do controle
		select_from_execution = {1'b1};		//Dados do controle
		#5
		clk = 0;
		#5
		clk = 1;
		out_from_memory = {32'b00000000000000000000000000001111};
		#5
		clk = 0;
		//Verifica se quando u_branch for 1, ira fazer o desvio
		#5
		clk=1;
		branch_addr_from_execution = {32'b00000000000000000000000000000011};
		result_from_execution = {32'b00000000000000000000000000000000};
		rs2_data_from_execution = {32'b00000000000000000000000000000000};
		funct3_from_execution = {3'b010};
		rd_from_execution = {4'b1111};
		equal_from_execution = {1'b0};
		less_from_execution = {1'b0};
		greater_from_execution = {1'b0};
		read_from_execution = {1'b1};		//Dados do controle
		write_from_execution = {1'b0};		//Dados do controle
		branch_from_execution = {1'b0};		//Dados do controle
		u_branch_from_execution = {1'b1};	//Dados do controle
		write_reg_from_execution = {1'b1};	//Dados do controle
		select_from_execution = {1'b1};		//Dados do controle
		#5
		clk = 0;
	end
endmodule

