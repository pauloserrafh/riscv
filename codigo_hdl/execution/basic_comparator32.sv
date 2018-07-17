module basic_comparator32 (
	input logic [31:0] a,   
	input logic [31:0] b, 
	input logic signed_comparison, // comparacao com sinal

	output logic equal, // a = b
	output logic greater, // a > b
	output logic lesser // a < b	
);

	assign equal = (a == b);

	always_comb begin
		if(signed_comparison) begin			
			greater = $signed(a) > $signed(b);
			lesser = $signed(a) < $signed(b);
		end 
		else begin
			greater = a > b;
			lesser = a < b;
		end
	end

endmodule
