module load_unit (
	input logic [31:0] mem_out,
	input logic [1:0] offset,
	input logic [2:0] funct3,

	output logic [31:0] data
);

	parameter LB = 3'b000;
	parameter LH = 3'b001;
	parameter LW = 3'b010;
	parameter LBU = 3'b100;
	parameter LHU = 3'b101;

	always_comb begin
		case (funct3)
			LB:
				case (offset)
					2'b00: data = {{24{mem_out[7]}},mem_out[7:0]};
					2'b01: data = {{24{mem_out[15]}},mem_out[15:8]};
					2'b10: data = {{24{mem_out[23]}},mem_out[23:16]};
					2'b11: data = {{24{mem_out[31]}},mem_out[31:24]};
					default : data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
				endcase
			LH:
				case (offset)
					2'b00: data = {{16{mem_out[15]}},mem_out[15:0]};
					2'b01: data = {{16{mem_out[23]}},mem_out[23:8]}; // desalinhado
					2'b10: data = {{16{mem_out[31]}},mem_out[31:16]};
					//2'b11: data = {16'b0,mem_out[31:24]}; // desalinhado
					default : data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
				endcase
			LBU:
				case (offset)
					2'b00: data = {24'b0,mem_out[7:0]};
					2'b01: data = {24'b0,mem_out[15:8]};
					2'b10: data = {24'b0,mem_out[23:16]};
					2'b11: data = {24'b0,mem_out[31:24]};
					default : data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
				endcase
			LHU:
				case (offset)
					2'b00: data = {16'b0,mem_out[15:0]};
					2'b01: data = {16'b0,mem_out[23:8]}; // desalinhado
					2'b10: data = {16'b0,mem_out[31:16]};
					//2'b11: data = {16'b0,mem_out[31:24]}; // desalinhado
					default : data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
				endcase

			LW: data = mem_out;
			default : data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;

		endcase
	end

endmodule
