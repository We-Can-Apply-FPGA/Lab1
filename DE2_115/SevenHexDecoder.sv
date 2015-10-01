module SevenHexDecoder(
	input [6:0] i_hex,
	output logic [6:0] o_seven_ten,
	output logic [6:0] o_seven_one
);
	/* The layout of seven segment display, 1: dark
	 *    00
	 *   5  1
	 *    66
	 *   4  2
	 *    33
	 */
	parameter D0 = 7'b1000000;
	parameter D1 = 7'b1111001;
	parameter D2 = 7'b0100100;
	parameter D3 = 7'b0110000;
	parameter D4 = 7'b0011001;
	parameter D5 = 7'b0010010;
	parameter D6 = 7'b0000010;
	parameter D7 = 7'b1011000;
	parameter D8 = 7'b0000000;
	parameter D9 = 7'b0010000;
	
	always_comb begin
	
		case(i_hex / 10)
			0: o_seven_ten = D0;
			1: o_seven_ten = D1;
			2: o_seven_ten = D2;
			3: o_seven_ten = D3;
			4: o_seven_ten = D4;
			5: o_seven_ten = D5;
			6: o_seven_ten = D6;
			7: o_seven_ten = D7;
			8: o_seven_ten = D8;
			9: o_seven_ten = D9;
			10: o_seven_ten = D0;
			11: o_seven_ten = D1;
			12: o_seven_ten = D2;
			default: o_seven_ten = D0;
		endcase
		
		case(i_hex % 10)
			0: o_seven_one = D0;
			1: o_seven_one = D1;
			2: o_seven_one = D2;
			3: o_seven_one = D3;
			4: o_seven_one = D4;
			5: o_seven_one = D5;
			6: o_seven_one = D6;
			7: o_seven_one = D7;
			8: o_seven_one = D8;
			9: o_seven_one = D9;
			default: o_seven_one = D0;
		endcase
	end
endmodule
