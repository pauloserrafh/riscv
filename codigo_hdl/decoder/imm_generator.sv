module imm_generator (
	input logic [31:0] instruction,
	
	output logic [31:0] immediate	
);
	
	parameter LUI_OPCODE     = 7'b0110111;
	parameter AUIPC_OPCODE   = 7'b0010111;
	parameter JAL_OPCODE     = 7'b1101111;
	parameter JALR_OPCODE    = 7'b1100111;
	parameter BRANCH_OPCODE  = 7'b1100011;
	parameter LOAD_OPCODE    = 7'b0000011;
	parameter STORE_OPCODE   = 7'b0100011;
	parameter ALU_IMM_OPCODE = 7'b0010011;

	logic [31:0] i_type;
	logic [31:0] s_type;
	logic [31:0] b_type;
	logic [31:0] u_type;
	logic [31:0] j_type;

	logic [6:0] opcode;
	logic [4:0] shamt;
	logic [2:0] funct3;

	assign opcode = instruction[6:0];
	assign shamt = instruction[24:20];
	assign funct3 = instruction[14:12];

	assign i_type = {{21{instruction[31]}},instruction[30:25],instruction[24:21],instruction[20]};
	assign s_type = {{21{instruction[31]}},instruction[30:25],instruction[11:8],instruction[7]};
	assign b_type = {{20{instruction[31]}},instruction[7],instruction[30:25],instruction[11:8],1'b0};
	assign u_type = {instruction[31:12],12'b0};
	assign j_type = {{12{instruction[31]}},instruction[19:12],instruction[20],instruction[30:25],instruction[24:21],1'b0};

	always_comb begin
		case (opcode)
			LUI_OPCODE, AUIPC_OPCODE  : immediate = u_type;
			JAL_OPCODE    			  : immediate = j_type;
			JALR_OPCODE, LOAD_OPCODE  : immediate = i_type;
			BRANCH_OPCODE             : immediate = b_type;
			STORE_OPCODE              : immediate = s_type;
			ALU_IMM_OPCODE            : 
				if(funct3 == 3'b001 || funct3 == 3'b101 || funct3 == 3'b101) // funct3 de shifts
					immediate = {27'b0,shamt};
				else 
					immediate = i_type;
			
			default       : immediate = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
		endcase
	end

endmodule