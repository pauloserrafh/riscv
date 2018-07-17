module multiplexer_result (
	input logic [31:0] 	a,
	input logic [31:0] 	b,
	input logic [31:0] 	c,
	input logic [31:0] 	d,
	input logic [1:0]		select,
	output logic [31:0]	out);
	
	always_comb begin
		case (select)
			2'b00: out = a;
			2'b01: out = b;
			2'b10: out = c+4;
			2'b11: out = d;
			default: out = a;
		endcase
	end

endmodule