`timescale 1ns/1ps
module execution (
	input logic clk,
	input logic rst,
	//---------Entradas: Decodificação-------------//
	input logic [31:0] 	pc_from_decoder,
	input logic [31:0] 	rs1_data_from_decoder,
	input logic [31:0] 	rs2_data_from_decoder,
	input logic [31:0] 	imm_from_decoder,
	input logic [2:0] 	funct3_from_decoder,
	input logic [4:0] 	rd_from_decoder,
	input logic [4:0]		reg_src_1_from_decoder,
	input logic [4:0]		reg_src_2_from_decoder,
	//---------Entradas: Blocos de Controle--------------//	
	input logic 			aritm_from_decoder,
	input logic 			left_from_decoder,
	input logic         	a_select_from_decoder,
	input logic         	b_select_from_decoder,
	input logic         	signed_comp_from_decoder,
	input logic [1:0]   	result_select_from_decoder,
	input logic [2:0]   	alu_op_from_decoder,
	input logic         	write_reg_from_decoder,
   input logic         	select_from_decoder,
   input logic         	read_from_decoder,
   input logic         	write_from_decoder,
   input logic         	branch_from_decoder,
   input logic         	u_branch_from_decoder,
	//---------Entradas: Blocos para o Adiantamento--------------//	
	 input logic         write_reg_from_memory,
	 input logic         write_reg_from_wb,
	 input logic [4:0]   rd_from_memory,
	 input logic [4:0]   rd_from_wb,
	 input logic [31:0]	result_from_memory,
	 input logic [31:0]	result_from_wb,
	//----------Saídas--------------//
	output logic [31:0] 	branch_addr_from_execution,
	output logic [31:0] 	result_from_execution,	
	output logic [31:0] 	rs2_data_from_execution,
	output logic			equal_from_execution,
	output logic        	greater_from_execution,
	output logic        	lesser_from_execution,
   output logic [2:0] 	funct3_from_execution,
   output logic [4:0]   rd_from_execution,
	output logic         write_reg_from_execution,
	output logic 			select_from_execution,
   output logic         read_from_execution,
   output logic         write_from_execution,
   output logic         branch_from_execution,
   output logic         u_branch_from_execution

);

// Conexões Intermediárias

// Saídas do muxes do adiantamento
logic [31:0]	sig_1;
logic [31:0]	sig_2;
// Saídas do bloco de adiantamento
logic [1:0]		FowardingA;
logic [1:0]		FowardingB;
// multiplexer_1 > basic_alu32
logic [31:0]	out_mux_1;
// multiplexer_2 > basic_alu32
logic [31:0]	out_mux_2;
// Basic_alu32
logic [31:0]	BA_out;
// multiplexer_3 > basic_shifter32
logic 			out_mux_3;
logic				gnd;
// basic_shifter32 > multiplexer_4
logic [31:0]	BS_out;
// Multiplexer 4
logic [31:0]	M4_out;
// Bloco Comparador
logic 			BC_equal;
logic 			BC_greater;
logic 			BC_lesser;

//------ Atribuições --------------------//
assign gnd = 0;

// Comparador
basic_comparator32	BC(sig_1,
								sig_2,
								signed_comp_from_decoder,
								BC_equal,
								BC_greater,
								BC_lesser);
							
mux_fowarding_unit	MF1(rs1_data_from_decoder,
								result_from_execution,
								result_from_memory,
								FowardingA,
								sig_1);

mux_fowarding_unit	MF2(rs2_data_from_decoder,
								result_from_execution,
								result_from_memory,
								FowardingB,
								sig_2);

fowarding_unit			FU(reg_src_1_from_decoder,
								reg_src_2_from_decoder,
								rd_from_execution,
								rd_from_memory,
								write_reg_from_execution,
								write_reg_from_memory,
								FowardingA,
								FowardingB);

multiplexer				M1(sig_1,
								pc_from_decoder,
								a_select_from_decoder,
								out_mux_1);	
								
multiplexer				M2(sig_2,
								imm_from_decoder,
								b_select_from_decoder,
								out_mux_2);

simple_mux				M3(gnd,
								sig_1[31],
								aritm_from_decoder,
								out_mux_3);
								
basic_shifter32		BS(out_mux_3,
								left_from_decoder,
								out_mux_2[4:0],
								sig_1,
								BS_out);

multiplexer_result 	M4(BA_out,
								BS_out,
								pc_from_decoder,
								imm_from_decoder,
								result_select_from_decoder,
								M4_out);
								
basic_alu32				BA(out_mux_1,
								out_mux_2,
								alu_op_from_decoder,
								BA_out);
								
always_ff @(posedge clk or posedge rst) begin
	if(rst==1'b1) begin
		branch_addr_from_execution <= 32'b0;
		result_from_execution 		<= 32'b0;
		rs2_data_from_execution 	<= 32'b0;
		equal_from_execution			<= 1'b0;
		greater_from_execution		<= 1'b0;
		lesser_from_execution		<= 1'b0;	
		funct3_from_execution		<= 3'b0;
		rd_from_execution				<=	5'b0;
		write_reg_from_execution	<= 1'b0;
		select_from_execution		<= 1'b0;
		read_from_execution			<= 1'b0;
		write_from_execution			<= 1'b0;
		branch_from_execution		<= 1'b0;
		u_branch_from_execution		<= 1'b0;
		end
	else begin
		branch_addr_from_execution <= BA_out;
		result_from_execution 		<= M4_out;
		rs2_data_from_execution 	<= sig_2;
		equal_from_execution			<= BC_equal;
		greater_from_execution		<= BC_greater;
		lesser_from_execution		<= BC_lesser;	
		funct3_from_execution		<= funct3_from_decoder;
		rd_from_execution				<=	rd_from_decoder;
		write_reg_from_execution	<= write_reg_from_decoder;
		select_from_execution		<= select_from_decoder;
		read_from_execution			<= read_from_decoder;
		write_from_execution			<= write_from_decoder;
		branch_from_execution		<= branch_from_decoder;
		u_branch_from_execution		<= u_branch_from_decoder;
	end
end

endmodule
