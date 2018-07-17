module fowarding_unit (
	input logic [4:0] reg_src_1,
	input logic [4:0] reg_src_2,
	input logic [4:0] reg_dst_4stg,
	input logic [4:0] reg_dst_5stg,
	input logic wb_4stg,
	input logic wb_5stg,
	
	output logic [1:0] FowardingA,
	output logic [1:0] FowardingB);
	
	always_comb
	begin
		// EX Hazard
		if (wb_4stg && (reg_dst_4stg != 0) && (reg_dst_4stg == reg_src_1))
			FowardingA = 2'b10;
		// MEM Hazard
		else if (wb_5stg && (reg_dst_5stg != 0) && (reg_dst_5stg == reg_src_1))
			FowardingA = 2'b01;
		else
			FowardingA = 2'b00;
		
		if (wb_4stg && (reg_dst_4stg != 0) && (reg_dst_4stg == reg_src_2))
			FowardingB = 2'b10;
		else if (wb_5stg && (reg_dst_5stg != 0) && (reg_dst_5stg == reg_src_2))
			FowardingB = 2'b01;
		else 
			FowardingB = 2'b00;
			
	end

endmodule