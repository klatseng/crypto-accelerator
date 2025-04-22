/*
4/22/2025
shiftRows()
33 - 32 - 31 - 30
23 - 22 - 21 - 20
13 - 12 - 11 - 10
03 - 02 - 01 - 00
------------------
33 - 32 - 31 - 30  (unchanged)
22 - 21 - 20 - 23  (LS1)
11 - 10 - 13 - 12  (LS2)
00 - 03 - 02 - 01  (LS3)
*/

module shiftRows(in, out);
	input logic [7:0] in [3:0][3:0];
	output logic [7:0] out [3:0][3:0];
	 
	// row3: unchanged 
	assign out[3][3] = in[3][3];
	assign out[3][2] = in[3][2];
	assign out[3][1] = in[3][1];
	assign out[3][0] = in[3][0];

	// row2: shift left by 1
	assign out[2][3] = in[2][2];
	assign out[2][2] = in[2][1];
	assign out[2][1] = in[2][0];
	assign out[2][0] = in[2][3];

	// row2: shift left by 2 
	assign out[1][3] = in[1][1];
	assign out[1][2] = in[1][0];
	assign out[1][1] = in[1][3];
	assign out[1][0] = in[1][2];

	// row3: shift left by 3 
	assign out[0][3] = in[0][0];
	assign out[0][2] = in[0][3];
	assign out[0][1] = in[0][2];
	assign out[0][0] = in[0][1];
endmodule 

module shiftRows_tb();
	logic [7:0] in [3:0][3:0];
	logic [7:0] out [3:0][3:0];

	shiftRows dut (.in, .out);

	initial begin 
		for (integer i = 0; i < 4; i++) begin 
			for (integer j = 0; j < 4; j++) begin 
				in[i][j] = i+j;
			end
		end
		#10;
		$stop;
	end
endmodule 