module store_unit (
	input logic [31:0] mem_in,
	input logic [2:0] funct3,
	input logic [1:0] offset,
	output logic [31:0] write_data,
	output logic [3:0] byte_enable
);

	parameter SB = 3'b000;
	parameter SH = 3'b001;
	parameter SW = 3'b010;

	always_comb begin

		case (funct3)
			SB:
				case (offset)
					2'b00: begin
						write_data = {24'b0,mem_in[7:0]};
						byte_enable = 4'b0001;
					end
					2'b01: begin
						write_data = {16'b0,mem_in[7:0],8'b0};
						byte_enable = 4'b0010;
					end
					2'b10: begin
						write_data = {8'b0,mem_in[7:0],16'b0};
						byte_enable = 4'b0100;
					end
					2'b11: begin
						write_data = {mem_in[7:0],24'b0};
						byte_enable = 4'b1000;
					end
					default : begin
						write_data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
						byte_enable = 4'bxxxx;
					end
				endcase
			SH:
				case (offset)
					2'b00: begin
						write_data = {16'b0,mem_in[15:0]};
						byte_enable = 4'b0011;
					end
					// 2'b01: begin // desalinhado
					// 	write_data = {mem_out[31:16],mem_in[7:0],8'b0};
					// 	byte_enable = 4'b0110;
					// end
					2'b10: begin
						write_data = {mem_in[15:0],16'b0};
						byte_enable = 4'b1100;
					end
					// 2'b11: begin // desalinhado
					// end
					default : begin
						write_data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
						byte_enable = 4'bxxxx;
					end
				endcase
			SW: begin
				write_data = mem_in;
				byte_enable = 4'b1111;
			end
			default : begin
				write_data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
				byte_enable = 4'b1111;
			end
		endcase

	end

endmodule