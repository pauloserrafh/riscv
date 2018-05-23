module fetch (

	input clk,
	input rst,


	input logic [31:0] next_pc,
	input logic load_next_pc,


	output logic [31:0] instr,
	output logic [31:0] pc,
	output logic [31:0] npc

);

	logic read_inst;
	logic read_cache;
	logic [31:0] addr_cache;
	logic [31:0] instr_cache;


i_cache  instr_mem(
	.address(addr_cache),
	.clock(clk),
	.rden(read_cache),
	.q(instr_cache)
);

 inst_mem_ctrl mem_controller (
	 .clk(clk),
	 .rst(rst),
	 
	//CPU:
	 .rd(read_inst),
	 .addr_i(pc),
	 .instr_o(instr),
	 //.cmp(),
	 
	//MEM0:
	 .mem0_rd(read_cache),
	 .mem0_addr_o(addr_cache),
	 .mem0_data_i(instr_cache)
	 
	//MEM1:
	//output logic mem1_rd,
	//output logic [31:0] mem1_addr_o,
	//input logic [31:0] mem1_data_i 
 );

always_ff @(posedge clk or negedge rst) begin
	if(~rst) begin
		pc <= 0;
		npc <= 0;
		instr <= 0;
		read_inst <= 0;
	end else begin
		read_inst <= 1;
		npc <= pc;
		pc <= load_next_pc ? next_pc : pc + 4; 

	end
end
