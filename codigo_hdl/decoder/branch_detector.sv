module branch_detector(
	input logic clk, // clock
	input logic rst_h, // Asynchronous reset active high
	input logic stop,
	
	//input 	
	input logic [6:0] opcode,
	
	//output
	output logic request_stop_pipeline,
	output logic stall
);	
	parameter JAL_OPCODE     = 7'b1101111;
	parameter JALR_OPCODE    = 7'b1100111;
	parameter BRANCH_OPCODE  = 7'b1100011;

	typedef enum bit {decoding_state=1'b0, stall_state=1'b1} state_branch_detector;
	
	state_branch_detector state;
	logic [1:0] count;
	
	assign stall = (state == stall_state) ? (1) : (0);
	assign request_stop_pipeline = ((state == stall_state && count > 2'b0) || ((opcode == JAL_OPCODE || opcode == JALR_OPCODE || opcode == BRANCH_OPCODE) && state == decoding_state) ) ? (1) : (0);
	
	// Controle da mudança de estado e contador
	always_ff@(posedge clk or posedge rst_h) begin
		if(rst_h) begin
			state <= decoding_state;
			count <= 2'b00;
		end
		else begin
			if(stop == 1'b0) begin
				case (state)
					decoding_state: begin
						if(opcode == JAL_OPCODE || opcode == JALR_OPCODE || opcode == BRANCH_OPCODE) begin
							state <= stall_state;
							count <= 2'b10;
						end
						else begin
							state <= decoding_state;
							count <= 2'b00;
						end
					end
					
					stall_state: begin
						if(count != 2'b0) begin
							state <= stall_state;
							count <= count - 1;
						end
						else begin
							state <= decoding_state;
							count <= 2'b00;
						end
					end
				endcase
			end
			else begin
				state <= state;
				count <= count;
			end
		end
	end

endmodule 