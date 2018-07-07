`timescale 1 ps / 1 ps
module fetch (

	input clk,   //clock
	input rst,   //reset


	input logic [31:0] next_pc,  //pr�ximo pc de 32 bits
	input logic load_next_pc,    //controlador para decidir se vai ser um PC+4 ou o PC vindo do branch


	output logic [31:0] instr,   //instru��o de sa�da
	output logic [31:0] pc,      //PC atual
	output logic [31:0] npc      //Novo PC

);

	logic read_inst;             //Bit sinalizando a leitura de uma instru��o
	logic read_cache;            //Bit sinalizando a leitura na cache
	logic [31:0] addr_cache;     //Endere�o de busca na cache
//	logic [31:0] instr_cache;    //Instru��o de busca na cache

//Importando o m�dulo i_cache
i_cache  instr_mem(
	.address(pc[12:2]),  //Associando o endere�o address da cache de 32 Bits � vari�vel addr_cache
	.clock(clk),           //Associando o clock do i_cache � vari�vel clk
	.rden(1'b1),     //Associando o read enable da i_cache � vari�vel read_cache
	.q(instr)        //Associando a vari�vel q da i_cache de 32 Bits � vari�vel instr_cache
);


always_ff @(posedge clk or negedge rst) begin
	if(~rst) begin
		pc <= 0;
		npc <= 0;
		read_inst <= 0;
	end else begin
		read_inst <= 1;
		npc <= pc;
		pc <= load_next_pc ? next_pc : pc +4;

	end
end
endmodule