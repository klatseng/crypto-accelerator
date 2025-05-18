/*
5/9/2025
subBytes module 

1. multiplicative inverse x' = x^-1 = x^254  
2. XOR x' with right shift 4, 5, 6, 7, of x' and 0x63 

*/

// calculate inverse then shifting for one byte 
// genvar to generate the whole 2D matrix 
module subBytes(in, out);
	input logic [7:0] in [3:0][3:0];
    output logic [7:0] out [3:0][3:0];

	logic [7:0] inv [3:0][3:0]; // inverse 

	logic [7:0] inv_rs4 [3:0][3:0]; // right shift 4
	logic [7:0] inv_rs5 [3:0][3:0]; // right shift 5
	logic [7:0] inv_rs6 [3:0][3:0]; // right shift 6
	logic [7:0] inv_rs7 [3:0][3:0]; // right shift 7

	// -------- 1. TODO: inverse logic ----------

	// -------- 2. XOR stage --------------------
	assign inv_rs4 = inv >> 4;
	assign inv_rs5 = inv >> 5;
	assign inv_rs6 = inv >> 6;
	assign inv_rs7 = inv >> 7;

	// output logic 
	assign out = inv ^ inv_rs4 ^ inv_rs5 ^ inv_rs6 ^ inv_rs7; 

	always_comb begin 
		for (int i = 0; i < )
	end

endmodule 