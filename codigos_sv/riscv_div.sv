`timescale 1ns/1ps

module riscv_div(

	input clk,
	input rst,

	input div_en,
	input signed [31:0] a,
	input signed [31:0] b,

	output signed [31:0] q,
	output signed [31:0] r,

	output div_zero,
	output logic freeze_pipe

);

reg unsigned [5:0] div_count;

reg [31:0] div_n;
reg [31:0] div_d;
reg [31:0] div_r;

reg sig_dividend;
reg sig_divisor;
reg q_sign;

reg [32:0] div_sub;

reg div_neg; // é bom utilizar esse registrador para indicar uma operaçao com negativos??
reg div_done;
reg div_by_zero;
reg div_overflow;

enum {
	IDLE_BIT = 0,
	DIV_BIT = 1,
	SIG_DIV_BIT = 2,
	END_DIV_BIT = 3,
	PRE_DIV_BIT = 4
} state_bit; 

enum logic [4:0] {
	idle = 5'b00001<<IDLE_BIT,
	div = 5'b00001<<DIV_BIT,
	sig_div = 5'b00001<<SIG_DIV_BIT,
	end_div = 5'b00001<<END_DIV_BIT,
	pre_div = 5'b00001<<PRE_DIV_BIT
} state;
//
//BEGIN
assign div_sub = {1'b0, div_r[30:0], div_n[31]} - div_d;

assign q = div_n;
assign r = div_r;

assign sig_dividend = a[31];
assign sig_divisor = b[31];

assign q_sign = sig_dividend~^sig_divisor;

assign div_zero = div_by_zero;

always_ff @(posedge clk, posedge rst) begin: div_operation
if (rst) begin
	div_count <= 6'b000000;
	state <= idle;
	div_done <= 1'b0;
	div_by_zero <= 1'b0;
	div_overflow <= 1'b0;
end
else begin
		unique case(1'b1)
			state[IDLE_BIT]: begin
				div_count <= 6'b100000;
				div_done <= 1'b0;
				div_n <= a; //quociente
				div_d <= b; //divisor
				div_r <= 32'h0000_0000; //resto
				if (div_en == 1'b1) begin
					state <= pre_div;
				end 
				else begin
					state <= idle;
				end
				if ((a == 32'h8000_0000) && (b == 32'hFFFF_FFFF)) begin
					div_overflow <= 1'b1;
				end
				else begin
					div_overflow <= 1'b0;
				end
				if (b == 32'h0000_0000) begin
					div_by_zero <= 1'b1;
				end
				else begin
					div_by_zero <= 1'b0;
				end
			end
			
			state[PRE_DIV_BIT]: begin
				if (sig_dividend == 1'b1) begin
					div_n <= ~div_n + 1'b1;
				end
				else begin
					div_n <= div_n;
				end
				if (sig_divisor == 1'b1) begin
					div_d <= ~div_d + 1'b1;
				end
				else begin
					div_d <= div_d;
				end
				state <= div;
			end
			
			state[DIV_BIT]: begin
				if (div_done == 1'b0) begin
					div_count <= div_count - 1'b1;
					state <= div;
					if (div_sub[32] == 1'b0) begin
						div_r <= div_sub[31:0];
						div_n <= {div_n[30:0], 1'b1};
					end
					else begin
						div_r <= {div_r[30:0], div_n[31]};
						div_n <= {div_n[30:0], 1'b0};
					end
					if (div_count == 6'b000001) begin
						div_done <= 1'b1;
					end
					else begin
						div_done <= div_done;
					end
				end
				else begin
				  state <= sig_div;
				  div_done <= 1'b0;
				end
			end //end div
			
			state[SIG_DIV_BIT]: begin
				if (sig_dividend == 1'b1) begin
					div_r <= ~div_r + 1'b1;
				end
				else begin
					div_r <= div_r;
				end
				if (q_sign) begin
					div_n <= div_n;
				end
				else begin
					div_n <= ~div_n + 1'b1;
				end
				state <= end_div;
			end //end sig_div
			
			state[END_DIV_BIT]: begin
				if (div_by_zero == 1'b1) begin
					div_n <= 32'hFFFF_FFFF;
					div_r <= a;
					state <= idle;
					div_done <= div_done;
					div_by_zero <= 1'b0;
				end
				else if (div_overflow == 1'b1) begin
					div_n <= 32'h8000_0000;
					div_r <= 32'h0000_0000;
					state <= idle;
					div_done <= div_done;
					div_overflow <= 1'b0;
				end
				else begin
					state <= idle;
					div_done <= div_done;
				end
			end
			
			default: begin
				state <= idle;
				div_done <= 1'b0;
			end
		endcase
	end
end: div_operation

always_comb begin
    unique case(1'b1)
        state[IDLE_BIT]:
            freeze_pipe = 1'b0;
        state[DIV_BIT]:
            freeze_pipe = 1'b0;
        state[END_DIV_BIT]:
            freeze_pipe = 1'b1;
			default: begin
				freeze_pipe = 1'b0;
			end
    endcase
end

endmodule