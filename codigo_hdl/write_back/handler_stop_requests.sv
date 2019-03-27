module handler_stop_requests(
	//input 	
	input logic request_stop_pipeline_from_decoder,
	
	//output
	output logic stop_fetch
);	

	assign stop_fetch = (request_stop_pipeline_from_decoder) ? (1) : (0);
	
endmodule 