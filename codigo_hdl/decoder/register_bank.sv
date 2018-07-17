module register_bank(
	input logic clk, // clock
	input logic rst_h, // Asynchronous reset active high
	input logic [4:0] rd, // registrador de destino
	input logic [4:0] rs1, // registrador que eh operando 1
	input logic [4:0] rs2,	// registrador que eh operando 2
	input logic write, // habilita escrita em rd
	input logic [31:0] write_data, // dado a ser escrito em rd

	output logic [31:0] rs1_data, // dado lido do operando 1
	output logic [31:0] rs2_data // dado lido do operando 2
);
	logic [31:0] registers [31:0];
	
	always_ff@(negedge clk or posedge rst_h) begin
		if(rst_h) begin
			for(int i = 0; i<32 ; i++) begin
				registers[i][31:0] <= 32'b0 + i;
				
			end
		end
		else begin // a escrita nos registradores ocorre da borda de descida		
			if(write == 1 && rd != 5'b0) registers[rd][31:0] <= write_data; 
			else registers[rd][31:0] <= registers[rd][31:0];
		end

	end

	always_comb begin
		rs1_data = registers[rs1][31:0];
		rs2_data = registers[rs2][31:0];
	end

	
endmodule 
