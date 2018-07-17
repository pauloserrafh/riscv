`timescale 1 ps / 1 ps
module tb (

); 
  logic clk_tb, rst_tb;
 /*  initial begin
    $monitor("pc = %d, instr = %h",pc,instr);
    clk = 0;
    rst = 1;
    load_next_pc = 0;
    #5 rst = 0;
    #5 rst = 1;
    #40 load_next_pc = 1;
    next_pc = 32'd120;
    #10 load_next_pc = 0;
  end
  always begin
    #5 clk = !clk;
  end */
  
//Clock de 10ns ou 100MHz
  initial begin
	clk_tb = 1'b0;
	while (1) begin
		#5ns
		clk_tb = ~clk_tb;
	end
end	
//reset inicial e após 2 ciclos de clock, inicia
initial begin
	rst_tb = 1'b1;
	repeat (2) @(posedge clk_tb);
	rst_tb = 1'b0;	
end
  
top_architecture top_architecture_inst(
	.clk (clk_tb)	,
	.rst (rst_tb)
	//---------------------------//
);

	/* initial begin
	
		forever begin
			#10ns;
			$monitor("pc = %d, instr = %h",pc,instr);
		end
	end */
endmodule