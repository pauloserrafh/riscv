module basic_shifter32 (
	input logic inserted_bit, // bit a ser inserido no shift, se eh pra completar com 0s ou com 1s
	input logic left, // se eh para direita
	input logic [4:0] amount, // quantidade de shift feito
	input logic [31:0] in, // entrada

	output logic [31:0] out // saida
);

	always_comb begin 
		if(left) begin
			case (amount)
				5'b00000: out = in[31:0];
				5'b00001: out = {in[30:0],{1{inserted_bit}}};
				5'b00010: out = {in[29:0],{2{inserted_bit}}};
				5'b00011: out = {in[28:0],{3{inserted_bit}}};
				5'b00100: out = {in[27:0],{4{inserted_bit}}};
				5'b00101: out = {in[26:0],{5{inserted_bit}}};
				5'b00110: out = {in[25:0],{6{inserted_bit}}};
				5'b00111: out = {in[24:0],{7{inserted_bit}}};
				5'b01000: out = {in[23:0],{8{inserted_bit}}};
				5'b01001: out = {in[22:0],{9{inserted_bit}}};
				5'b01010: out = {in[21:0],{10{inserted_bit}}};
				5'b01011: out = {in[20:0],{11{inserted_bit}}};
				5'b01100: out = {in[19:0],{12{inserted_bit}}};
				5'b01101: out = {in[18:0],{13{inserted_bit}}};
				5'b01110: out = {in[17:0],{14{inserted_bit}}};
				5'b01111: out = {in[16:0],{15{inserted_bit}}};
				5'b10000: out = {in[15:0],{16{inserted_bit}}};
				5'b10001: out = {in[14:0],{17{inserted_bit}}};
				5'b10010: out = {in[13:0],{18{inserted_bit}}};
				5'b10011: out = {in[12:0],{19{inserted_bit}}};
				5'b10100: out = {in[11:0],{20{inserted_bit}}};
				5'b10101: out = {in[10:0],{21{inserted_bit}}};
				5'b10110: out = {in[9:0],{22{inserted_bit}}};
				5'b10111: out = {in[8:0],{23{inserted_bit}}};
				5'b11000: out = {in[7:0],{24{inserted_bit}}};
				5'b11001: out = {in[6:0],{25{inserted_bit}}};
				5'b11010: out = {in[5:0],{26{inserted_bit}}};
				5'b11011: out = {in[4:0],{27{inserted_bit}}};
				5'b11100: out = {in[3:0],{28{inserted_bit}}};
				5'b11101: out = {in[2:0],{29{inserted_bit}}};
				5'b11110: out = {in[1:0],{30{inserted_bit}}};
				5'b11111: out = {in[0],{31{inserted_bit}}};
			endcase
		end
		else begin
			casex (amount)
				5'b00000: out = in[31:0];
				5'b00001: out = {{1{inserted_bit}},in[31:1]};
				5'b00010: out = {{2{inserted_bit}},in[31:2]};
				5'b00011: out = {{3{inserted_bit}},in[31:3]};
				5'b00100: out = {{4{inserted_bit}},in[31:4]};
				5'b00101: out = {{5{inserted_bit}},in[31:5]};
				5'b00110: out = {{6{inserted_bit}},in[31:6]};
				5'b00111: out = {{7{inserted_bit}},in[31:7]};
				5'b01000: out = {{8{inserted_bit}},in[31:8]};
				5'b01001: out = {{9{inserted_bit}},in[31:9]};
				5'b01010: out = {{10{inserted_bit}},in[31:10]};
				5'b01011: out = {{11{inserted_bit}},in[31:11]};
				5'b01100: out = {{12{inserted_bit}},in[31:12]};
				5'b01101: out = {{13{inserted_bit}},in[31:13]};
				5'b01110: out = {{14{inserted_bit}},in[31:14]};
				5'b01111: out = {{15{inserted_bit}},in[31:15]};
				5'b10000: out = {{16{inserted_bit}},in[31:16]};
				5'b10001: out = {{17{inserted_bit}},in[31:17]};
				5'b10010: out = {{18{inserted_bit}},in[31:18]};
				5'b10011: out = {{19{inserted_bit}},in[31:19]};
				5'b10100: out = {{20{inserted_bit}},in[31:20]};
				5'b10101: out = {{21{inserted_bit}},in[31:21]};
				5'b10110: out = {{22{inserted_bit}},in[31:22]};
				5'b10111: out = {{23{inserted_bit}},in[31:23]};
				5'b11000: out = {{24{inserted_bit}},in[31:24]};
				5'b11001: out = {{25{inserted_bit}},in[31:25]};
				5'b11010: out = {{26{inserted_bit}},in[31:26]};
				5'b11011: out = {{27{inserted_bit}},in[31:27]};
				5'b11100: out = {{28{inserted_bit}},in[31:28]};
				5'b11101: out = {{29{inserted_bit}},in[31:29]};
				5'b11110: out = {{30{inserted_bit}},in[31:30]};
				5'b11111: out = {{31{inserted_bit}},in[31]};
			endcase
		end
	end

endmodule
