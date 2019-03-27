module decoder(
	input logic clk, // clock
	input logic rst_h, // Asynchronous reset active high
	
	//input 	
	input logic [31:0] pc_from_fetch,
	input logic [31:0] instr_from_icache,
	
	input logic  write_reg_from_write_back,
	input logic [31:0] write_data_from_write_back,
	input logic [4:0] rd_from_write_back,
	
	//requisição para parar o pipeline
	output logic request_stop_pipeline_from_decoder,
	
	//output bits de controle reg pipeline	
	output logic write_reg_from_decoder,
	output logic write_reg_select_from_decoder,

	output logic read_mem_from_decoder,
	output logic write_mem_from_decoder,
	output logic branch_from_decoder,
	output logic u_branch_from_decoder,

	output logic a_select_from_decoder,
	output logic b_select_from_decoder,
	output logic signed_comp_from_decoder,
	output logic [1:0] result_select_from_decoder,
	output logic [2:0] alu_op_from_decoder,
	output logic left_from_decoder,
	output logic aritm_from_decoder,
	
	//output reg pipeline
	output logic [31:0] pc_from_decoder,
	output logic [31:0] rs1_data_from_decoder,
	output logic [31:0] rs2_data_from_decoder,
	output logic [31:0] imm_from_decoder,
	output logic [4:0] rs1_from_decoder,
	output logic [4:0] rs2_from_decoder,
	output logic [4:0] rd_from_decoder,
	output logic [2:0] funct3_from_decoder	
);	

	// fios
	logic stall_from_branchDetector;
	
	logic [6:0] instr_from_icache_opcode;
	logic [2:0] instr_from_icache_funct3;
	logic [4:0] instr_from_icache_rd;
	logic [4:0] instr_from_icache_rs1;
	logic [4:0] instr_from_icache_rs2;

	logic write_reg;
	logic write_reg_select;

	logic read_mem;
	logic write_mem;
	logic branch;
	logic u_branch;

	logic a_select;
	logic b_select;
	logic signed_comp;
	logic [1:0] result_select;
	logic [2:0] alu_op;
	logic left;
	logic aritm;

	logic [31:0] immediate;

	logic [31:0] rs1_data;
	logic [31:0] rs2_data;
	
	assign instr_from_icache_opcode = instr_from_icache[6:0];
	assign instr_from_icache_funct3 = instr_from_icache[14:12];
	assign instr_from_icache_rd 	= instr_from_icache[11:7];
	assign instr_from_icache_rs1 	= instr_from_icache[19:15];
	assign instr_from_icache_rs2 	= instr_from_icache[24:20];
	
	branch_detector branchDetector(
		.clk(clk),
		.rst_h(rst_h), 
		.stop(1'b0),
		.opcode(instr_from_icache_opcode),
		.request_stop_pipeline(request_stop_pipeline_from_decoder),
		.stall(stall_from_branchDetector)	
	);
	
	register_bank registerBank(
		//input
		.clk(clk),
		.rst_h(rst_h),
		.rd(rd_from_write_back),
		.rs1(instr_from_icache_rs1),
		.rs2(instr_from_icache_rs2),	
		.write(write_reg_from_write_back),
		.write_data(write_data_from_write_back),	
		
		//output
		.rs1_data(rs1_data),
		.rs2_data(rs2_data)
	);
	
	control_unit controlUnit(
		//input
		.instr(instr_from_icache), //instr_from_icache

		//output
		.write_reg(write_reg),
		.write_reg_select(write_reg_select),

		.read_mem(read_mem),
		.write_mem(write_mem),
		.branch(branch),
		.u_branch(u_branch),

		.a_select(a_select),
		.b_select(b_select),
		.signed_comp(signed_comp),
		.result_select(result_select),
		.alu_op(alu_op),
		.left(left),
		.aritm(aritm)
	);
	
	imm_generator immGenerator(
		//input
		.instruction(instr_from_icache),	 //instr_from_icache

		//output
		.immediate(immediate)
	);

	always_ff@(posedge clk) begin //posedge
		if (rst_h || stall_from_branchDetector) begin
//			//output bits de controle reg pipeline	
			write_reg_from_decoder <= 0;
			write_reg_select_from_decoder <= 0;

			read_mem_from_decoder <= 0;
			write_mem_from_decoder <= 0;
			branch_from_decoder <= 0;
			u_branch_from_decoder <= 0;

			a_select_from_decoder <= 0;
			b_select_from_decoder <= 0;
			signed_comp_from_decoder <= 0;
			result_select_from_decoder <= 2'b0;
			alu_op_from_decoder <= 3'b0;
			left_from_decoder <= 0;
			aritm_from_decoder <= 0;
			
			//output reg pipeline
			pc_from_decoder <= 32'b0;
			rs1_data_from_decoder <= 32'b0;
			rs2_data_from_decoder <= 32'b0;
			imm_from_decoder <= 32'b0;
			rs1_from_decoder <= 5'b0;
			rs2_from_decoder <= 5'b0;
			rd_from_decoder <= 5'b0;
			funct3_from_decoder <= 3'b0;
		end
		else begin
			//output bits de controle reg pipeline	
			write_reg_from_decoder <= write_reg;
			write_reg_select_from_decoder <= write_reg_select;

			read_mem_from_decoder <= read_mem;
			write_mem_from_decoder <= write_mem;
			branch_from_decoder <= branch;
			u_branch_from_decoder <= u_branch;

			a_select_from_decoder <= a_select;
			b_select_from_decoder <= b_select;
			signed_comp_from_decoder <= signed_comp;
			result_select_from_decoder <= result_select;
			alu_op_from_decoder <= alu_op;
			left_from_decoder <= left;
			aritm_from_decoder <= aritm;
			
			//output reg pipeline
			pc_from_decoder <= pc_from_fetch;
			rs1_data_from_decoder <= rs1_data;
			rs2_data_from_decoder <= rs2_data;
			imm_from_decoder <= immediate;
			rs1_from_decoder <= instr_from_icache_rs1;
			rs2_from_decoder <= instr_from_icache_rs2;
			rd_from_decoder <= instr_from_icache_rd;
			funct3_from_decoder <= instr_from_icache_funct3;
		end
	end

endmodule 