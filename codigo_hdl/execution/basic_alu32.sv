module basic_alu32 (	
	input logic [31:0] a,   
	input logic [31:0] b,
	input logic [2:0] op, 	

	output logic [31:0]c
);

	//                         op     operacao     	   		   descricao
	parameter ALU_OP_ADD  = 3'b000; // Soma    	      	       a + b
	parameter ALU_OP_SUB  = 3'b001; // Subtracao               a - b 
	
	parameter ALU_OP_AND  = 3'b010; // Bitwise And             a and b
	parameter ALU_OP_OR   = 3'b011; // Bitwise Or              a  or b		
	parameter ALU_OP_XOR  = 3'b100; // Bitwise Xor             a xor b
	
	parameter ALU_OP_SLT  = 3'b101; // Set Less Than           32'b1 if a <(signed) b 
	parameter ALU_OP_SLTU = 3'b110; // Set Less Than Unsigend  32'b1 if a <(unsigned) b   
	
	always_comb begin
		case (op)
			ALU_OP_ADD: c = a + b;
			ALU_OP_SUB: c = a - b;
			ALU_OP_XOR: c = a ^ b;
			ALU_OP_AND: c = a & b;
			ALU_OP_OR:  c = a | b;
			ALU_OP_SLT: c = ($signed(a) < $signed(b)) ? (32'b1):(32'b0);
			ALU_OP_SLTU: c = (a < b) ? (32'b1):(32'b0); 
			default: c = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
		endcase
	end

endmodule
