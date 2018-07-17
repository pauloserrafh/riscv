module multiplexer (
	input logic [31:0] 	read_data_1,
	input logic [31:0] 	read_data_2,
	input logic				select,
	output logic [31:0]	out);
	
	always_comb begin
		out = (select) ? read_data_2 : read_data_1;
	end

endmodule