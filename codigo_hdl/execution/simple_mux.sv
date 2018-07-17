module simple_mux (
	input logic 	a,
	input logic 	b,
	input logic		select,
	output logic 	out);
	
	always_comb begin
		out = (select) ? b : a;
	end

endmodule