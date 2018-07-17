module mux_fowarding_unit (

	input logic [31:0] 	read_data_1,
	input logic [31:0]	alu_result_4stg,
	input logic [31:0]	result_5stg,
	input logic [1:0]		Fowarding,
	
	output logic [31:0] operand);
	
	always_comb 
	begin
		case (Fowarding)
			2'b00:	operand = read_data_1;
			2'b10:	operand = alu_result_4stg;
			2'b01:	operand = result_5stg;
			default: operand = read_data_1;
		endcase
	end

endmodule