`timescale 1 ps / 1 ps
module fetch (

	input clk,   //clock 
	input rst,   //reset

	input logic [31:0] next_pc,  //pr�ximo pc de 32 bits
	input logic load_next_pc,    //controlador para decidir se vai ser um PC+4 ou o PC vindo do branch

	output logic [31:0] instruction,   //instru��o de sa�da
	output logic [31:0] pc,      //PC atual
	output logic [31:0] npc      //Novo PC

);
	logic read_inst;             //Bit sinalizando a leitura de uma instru��o 
	logic read_cache;            //Bit sinalizando a leitura na cache
	//logic [31:0] addr_cache;     //Endere�o de busca na cache 
//	logic [31:0] instr_cache;    //Instru��o de busca na cache

//Importando o m�dulo i_cache 
i_cache  instr_mem(
	.address(pc[12:2]),  //Associando o endere�o address da cache de 32 Bits � vari�vel addr_cache
	.clock(clk),           //Associando o clock do i_cache � vari�vel clk 
	.rden(read_inst),     //Associando o read enable da i_cache � vari�vel read_cache 
	.q(instruction)        //Associando a vari�vel q da i_cache de 32 Bits � vari�vel instr_cache
);
typedef enum bit [1:0] { reset, init, ready } state_fetch;
state_fetch state;
logic reset_f;

always_ff @(posedge clk) begin
	if(rst) begin
		state <= reset;
	end
	else begin
		case (state)
			reset 	:  begin 
				if (rst) begin
					state <= reset;
				end
				else begin
					state <= init;
				end	
			end
			init	: state <= ready;
			ready	: state <= ready;
		default: state <=	reset;
		endcase;
	end
end

always_comb begin
	case(state)
		reset 	: reset_f = 1'b1;
		init	: reset_f = 1'b0;
		ready	: reset_f = 1'b0;
	endcase;
end

always_ff @(posedge clk) begin
		case (state)
			reset 	:  begin 
				pc <= 32'd0;
				npc <= 32'd0;
				read_inst <= 1'b0;
			end
			init	: begin
				read_inst <= 1'b1;
				pc <= 32'd0; 
				npc <= pc;
			end
			ready	: begin
				read_inst <= 1'b1;
				pc <= load_next_pc ? next_pc : pc + 4; 
				npc <= pc;
			end
		//default: state <=	reset;
		endcase;
end
endmodule