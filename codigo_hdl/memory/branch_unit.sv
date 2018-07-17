module branch_unit (
	input logic equal,
	input logic greater,
	input logic lesser,
	input logic [2:0] branch_type,

	output logic resolve
);

	parameter BEQ = 3'b000;
	parameter BNE = 3'b001;
	parameter BLT = 3'b100;
	parameter BGE = 3'b101;
	parameter BLTU = 3'b110;
	parameter BGEU = 3'b111;

	always_comb begin
		case (branch_type)
			BEQ:  resolve = (equal == 1) ? (1):(0);
			BNE:  resolve = (equal == 0) ? (1):(0);
			BLTU,BLT: resolve = (lesser == 1) ? (1):(0);
			BGEU,BGE: resolve = (equal == 1 || greater == 1) ? (1):(0);
			default: resolve = 1'bx;
		endcase
	end

endmodule