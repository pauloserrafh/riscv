module control_unit (
	input logic [31:0] instr,

	output logic write_reg,
	output logic write_reg_select,

	output logic read_mem,
	output logic write_mem,
	output logic branch,
	output logic u_branch,

	output logic a_select,
	output logic b_select,
	output logic signed_comp,
	output logic [1:0] result_select,
	output logic [2:0] alu_op,
	output logic left,
	output logic aritm
);

	parameter LUI_OPCODE     = 7'b0110111;
	parameter AUIPC_OPCODE   = 7'b0010111;
	parameter JAL_OPCODE     = 7'b1101111;
	parameter JALR_OPCODE    = 7'b1100111;
	parameter BRANCH_OPCODE  = 7'b1100011;
	parameter LOAD_OPCODE    = 7'b0000011;
	parameter STORE_OPCODE   = 7'b0100011;
	parameter ALU_IMM_OPCODE = 7'b0010011;
	parameter ALU_REG_OPCODE = 7'b0110011;

	parameter ADD_SUB_FUNCT3 = 3'b000;
	parameter SLT_FUNCT3     = 3'b010;
	parameter SLTU_FUNCT3    = 3'b011;
	parameter XOR_FUNCT3     = 3'b100;
	parameter OR_FUNCT3      = 3'b110;
	parameter AND_FUNCT3     = 3'b111;
	
	parameter SHIFT_LEFT_FUNCT3   = 3'b001;
	parameter SHIFT_RIGHT_FUNCT3  = 3'b101;

	parameter EX_MUX_A_SELECT_RS1_DATA         = 1'b0;
	parameter EX_MUX_A_SELECT_PC               = 1'b1;
	
	parameter EX_MUX_B_SELECT_RS2_DATA         = 1'b0;
	parameter EX_MUX_B_SELECT_IMM              = 1'b1;

	parameter EX_MUX_RESULT_SELECT_ALU         = 2'b00;
	parameter EX_MUX_RESULT_SELECT_SHIFT       = 2'b01;
	parameter EX_MUX_RESULT_SELECT_PC4         = 2'b10;
	parameter EX_MUX_RESULT_SELECT_LUI_IMM     = 2'b11;

	parameter WB_MUX_WRITE_REG_SELECT_RESULT   = 1'b0;
	parameter WB_MUX_WRITE_REG_SELECT_MEM_READ = 1'b1;

	parameter ALU_OP_ADD  = 3'b000; // Soma    	      	       a + b
	parameter ALU_OP_SUB  = 3'b001; // Subtracao               a - b 
	
	parameter ALU_OP_AND  = 3'b010; // Bitwise And             a and b
	parameter ALU_OP_OR   = 3'b011; // Bitwise Or              a  or b		
	parameter ALU_OP_XOR  = 3'b100; // Bitwise Xor             a xor b
	
	parameter ALU_OP_SLT  = 3'b101; // Set Less Than           32'b1 if a <(signed) b 
	parameter ALU_OP_SLTU = 3'b110; // Set Less Than Unsigend  32'b1 if a <(unsigned) b

	parameter SB = 3'b000;
	parameter SH = 3'b001;
	parameter SW = 3'b010;

	logic [6:0] opcode;
	logic [2:0] funct3;
	logic [6:0] funct7;
	
	// logic [5:0] rd;
	// logic [5:0] rs1;
	// logic [5:0] rs2;

	// assign rd = instr[11:7];
	// assign rs1 = instr[19:15];
	// assign rs2 = instr[24:20];
		
	assign opcode = instr[6:0];
	assign funct3 = instr[14:12];
	assign funct7 = instr[31:25];


	always_comb begin

		case (opcode)
			LUI_OPCODE     : begin
				write_reg = 1'b1;
				write_reg_select = WB_MUX_WRITE_REG_SELECT_RESULT;

				read_mem = 1'b0;
				write_mem = 1'b0;
				branch = 1'b0;
				u_branch = 1'b0;				

				a_select = 1'bx;
				b_select = 1'bx;
				signed_comp = 1'bx;
				result_select = EX_MUX_RESULT_SELECT_LUI_IMM;
				alu_op = 3'bxxx;
				left = 1'bx; 			
				aritm = 1'bx;
			end

			AUIPC_OPCODE   : begin
				write_reg = 1'b1;
				write_reg_select = WB_MUX_WRITE_REG_SELECT_RESULT;

				read_mem = 1'b0;
				write_mem = 1'b0;
				branch = 1'b0;
				u_branch = 1'b0;				

				a_select = EX_MUX_A_SELECT_PC;
				b_select = EX_MUX_B_SELECT_IMM;
				signed_comp = 1'bx;
				result_select = EX_MUX_RESULT_SELECT_ALU;
				alu_op = ALU_OP_ADD;
				left = 1'bx; 
				aritm = 1'bx;
			end

			JAL_OPCODE     : begin
				write_reg = 1'b1;
				write_reg_select = WB_MUX_WRITE_REG_SELECT_RESULT;

				read_mem = 1'b0;
				write_mem = 1'b0;
				branch = 1'b0;
				u_branch = 1'b1;				

				a_select = EX_MUX_A_SELECT_PC;
				b_select = EX_MUX_B_SELECT_IMM;
				signed_comp = 1'bx;
				result_select = EX_MUX_RESULT_SELECT_PC4;
				alu_op = ALU_OP_ADD;
				left = 1'bx; 
				aritm = 1'bx;
			end

			JALR_OPCODE    : begin
				write_reg = 1'b1;
				write_reg_select = WB_MUX_WRITE_REG_SELECT_RESULT;

				read_mem = 1'b0;
				write_mem = 1'b0;
				branch = 1'b0;
				u_branch = 1'b1;				

				a_select = EX_MUX_A_SELECT_RS1_DATA;
				b_select = EX_MUX_B_SELECT_IMM;
				signed_comp = 1'bx;
				result_select = EX_MUX_RESULT_SELECT_PC4;
				alu_op = ALU_OP_ADD;
				left = 1'bx; 
				aritm = 1'bx;
			end

			BRANCH_OPCODE  : begin
				write_reg = 1'b0;
				write_reg_select = 1'bx;

				read_mem = 1'b0;
				write_mem = 1'b0;
				branch = 1'b1;
				u_branch = 1'b0;
							
				a_select = EX_MUX_A_SELECT_PC;
				b_select = EX_MUX_B_SELECT_IMM;
				
				if (funct3 == 3'b110 || funct3 == 3'b111) signed_comp = 1'b0;
				else                                      signed_comp = 1'b1;

				result_select = 2'bxx;
				alu_op = ALU_OP_ADD;
				left = 1'bx; 
				aritm = 1'bx;
			end

			LOAD_OPCODE    : begin
				write_reg = 1'b1;
				write_reg_select = WB_MUX_WRITE_REG_SELECT_MEM_READ;

				read_mem = 1'b1;
				write_mem = 1'b0;
				branch = 1'b0;
				u_branch = 1'b0;				

				a_select = EX_MUX_A_SELECT_RS1_DATA;
				b_select = EX_MUX_B_SELECT_IMM;
				signed_comp = 1'bx;
				result_select = EX_MUX_RESULT_SELECT_ALU;
				alu_op = ALU_OP_ADD;
				left = 1'bx; 
				aritm = 1'bx;
			end

			STORE_OPCODE   : begin
				write_reg = 1'b0;
				write_reg_select = 2'bxx;

				read_mem = 1'b0;
				write_mem = 1'b1; //write_mem = (funct3 == SW) ? (1'b1):(1'b0); 
				branch = 1'b0;
				u_branch = 1'b0;				

				a_select = EX_MUX_A_SELECT_RS1_DATA;
				b_select = EX_MUX_B_SELECT_IMM;
				signed_comp = 1'bx;
				result_select = EX_MUX_RESULT_SELECT_ALU;
				alu_op = ALU_OP_ADD;
				left = 1'bx; 
				aritm = 1'bx;
			end

			ALU_IMM_OPCODE : begin
				write_reg = 1'b1;
				write_reg_select = WB_MUX_WRITE_REG_SELECT_RESULT;

				read_mem = 1'b0;
				write_mem = 1'b0;
				branch = 1'b0;
				u_branch = 1'b0;				

				a_select = EX_MUX_A_SELECT_RS1_DATA;
				b_select = EX_MUX_B_SELECT_IMM;
				signed_comp = 1'bx;
				

				case (funct3)
					ADD_SUB_FUNCT3  : begin
						result_select = EX_MUX_RESULT_SELECT_ALU;
						alu_op = ALU_OP_ADD;
						left = 1'bx; 
						aritm = 1'bx;
					end
					SLT_FUNCT3  : begin
						result_select = EX_MUX_RESULT_SELECT_ALU;
						alu_op = ALU_OP_SLT;
						left = 1'bx; 
						aritm = 1'bx;
					end
					SLTU_FUNCT3 : begin
						result_select = EX_MUX_RESULT_SELECT_ALU;
						alu_op = ALU_OP_SLTU;
						left = 1'bx; 
						aritm = 1'bx;
					end
					XOR_FUNCT3  : begin
						result_select = EX_MUX_RESULT_SELECT_ALU;
						alu_op = ALU_OP_XOR;
						left = 1'bx; 
						aritm = 1'bx;
					end
					OR_FUNCT3   : begin
						result_select = EX_MUX_RESULT_SELECT_ALU;
						alu_op = ALU_OP_OR;
						left = 1'bx; 
						aritm = 1'bx;
					end
					AND_FUNCT3  : begin
						result_select = EX_MUX_RESULT_SELECT_ALU;
						alu_op = ALU_OP_AND;
						left = 1'bx; 
						aritm = 1'bx;
					end
					
					//SHIFTS
					SHIFT_LEFT_FUNCT3  : begin
						result_select = EX_MUX_RESULT_SELECT_SHIFT;
						alu_op = 3'bxxx;
						left = 1'b1; 
						aritm = 1'b0;
					end
					SHIFT_RIGHT_FUNCT3  : begin
						result_select = EX_MUX_RESULT_SELECT_SHIFT;
						alu_op = 3'bxxx;
						left = 1'b0; 
						aritm = funct7[5]; // se funct7[5] for 1 entao eh aritmetico senao eh logico
					end
				endcase
			end
			
			ALU_REG_OPCODE : begin
				write_reg = 1'b1;
				write_reg_select = WB_MUX_WRITE_REG_SELECT_RESULT;

				read_mem = 1'b0;
				write_mem = 1'b0;
				branch = 1'b0;
				u_branch = 1'b0;				

				a_select = EX_MUX_A_SELECT_RS1_DATA;
				b_select = EX_MUX_B_SELECT_RS2_DATA;
				signed_comp = 1'bx;				

				case (funct3)
					ADD_SUB_FUNCT3  : begin
						result_select = EX_MUX_RESULT_SELECT_ALU;
						alu_op = (funct7[5] == 1) ? (ALU_OP_SUB):(ALU_OP_ADD); // se funct7[5] for 1 entao eh SUB senao eh ADD
						left = 1'bx; 
						aritm = 1'bx;
					end
					SLT_FUNCT3  : begin
						result_select = EX_MUX_RESULT_SELECT_ALU;
						alu_op = ALU_OP_SLT;
						left = 1'bx; 
						aritm = 1'bx;
					end
					SLTU_FUNCT3 : begin
						result_select = EX_MUX_RESULT_SELECT_ALU;
						alu_op = ALU_OP_SLTU;
						left = 1'bx; 
						aritm = 1'bx;
					end
					XOR_FUNCT3  : begin
						result_select = EX_MUX_RESULT_SELECT_ALU;
						alu_op = ALU_OP_XOR;
						left = 1'bx; 
						aritm = 1'bx;
					end
					OR_FUNCT3   : begin
						result_select = EX_MUX_RESULT_SELECT_ALU;
						alu_op = ALU_OP_OR;
						left = 1'bx; 
						aritm = 1'bx;
					end
					AND_FUNCT3  : begin
						result_select = EX_MUX_RESULT_SELECT_ALU;
						alu_op = ALU_OP_AND;
						left = 1'bx; 
						aritm = 1'bx;
					end
					
					//SHIFTS
					SHIFT_LEFT_FUNCT3  : begin
						result_select = EX_MUX_RESULT_SELECT_SHIFT;
						alu_op = 3'bxxx;
						left = 1'b1; 
						aritm = 1'b0;
					end
					SHIFT_RIGHT_FUNCT3  : begin
						result_select = EX_MUX_RESULT_SELECT_SHIFT;
						alu_op = 3'bxxx;
						left = 1'b0; 
						aritm = funct7[5]; // se funct7[5] for 1 entao eh aritmetico senao eh logico
					end
				
				endcase
			end

			default: begin // INVALID OPCODE
				write_reg = 1'b0;
				write_reg_select = 1'bx;

				read_mem = 1'b0;
				write_mem = 1'b0;
				branch = 1'b0;
				u_branch = 1'b0;				

				a_select = 1'bx;
				b_select = 1'bx;
				signed_comp = 1'bx;
				result_select = 2'bxx;
				alu_op = 3'bxxx;
				left = 1'bx; 
				aritm = 1'bx;
			end
			
		endcase

	end

endmodule
