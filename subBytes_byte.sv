module subBytes_byte(clk_i, rst_i, byte_i, byte_o);
    input logic clk_i, rst_i;
    input logic [7:0] byte_i;
    output logic [7:0] byte_o;

    logic [7:0] byte_2pow [7:0]; // byte to the (2 to the power of) ...
    logic [7:0] b64xb32, b16xb8, b4xb2;
    logic [7:0] b128xb64xb32, b16xb8xb4xb2;

    logic [7:0] inv_p, inv_n;
    logic [7:0] inv_rs4;
    logic [7:0] inv_rs5;
    logic [7:0] inv_rs6;
    logic [7:0] inv_rs7;
    logic [7:0] c;

    // ---------- 1. multiplicative inverse ---------- 
    // b^-1 = b^254 = b^128 * b^64 * b^32 * b^16 * b^8 * b^4 * b^2
	 assign byte_2pow[0] = byte_i; // never used
    gf_square byte2 (.byte_i(byte_i), .square_o(byte_2pow[1]));
    gf_square byte4 (.byte_i(byte_2pow[1]), .square_o(byte_2pow[2]));
    gf_square byte8 (.byte_i(byte_2pow[2]), .square_o(byte_2pow[3]));
    gf_square byte16 (.byte_i(byte_2pow[3]), .square_o(byte_2pow[4]));
    gf_square byte32 (.byte_i(byte_2pow[4]), .square_o(byte_2pow[5]));
    gf_square byte64 (.byte_i(byte_2pow[5]), .square_o(byte_2pow[6]));
    gf_square byte128 (.byte_i(byte_2pow[6]), .square_o(byte_2pow[7]));

    // multiplication tree (super naive, can pipeline it later)
    gf_mult mult1 (.a_i(byte_2pow[6]), .b_i(byte_2pow[5]), .product_o(b64xb32));
    gf_mult mult2 (.a_i(byte_2pow[4]), .b_i(byte_2pow[3]), .product_o(b16xb8));
    gf_mult mult3 (.a_i(byte_2pow[2]), .b_i(byte_2pow[1]), .product_o(b4xb2));

    gf_mult mult4 (.a_i(byte_2pow[7]), .b_i(b64xb32), .product_o(b128xb64xb32));
    gf_mult mult5 (.a_i(b16xb8), .b_i(b4xb2), .product_o(b16xb8xb4xb2));
    gf_mult mult6 (.a_i(b128xb64xb32), .b_i(b16xb8xb4xb2), .product_o(inv_n));

    // ---------- 2. xor right shift ----------
    assign inv_rs4 = inv_n >> 4;
	assign inv_rs5 = inv_n >> 5;
	assign inv_rs6 = inv_n >> 6;
	assign inv_rs7 = inv_n >> 7;
    assign c = 8'h63;
    
    assign byte_o = inv_n ^ inv_rs4 ^ inv_rs5 ^ inv_rs6 ^ inv_rs7 ^ c;
    
    // reset register 
//    always_ff @(posedge clk_i) begin 
//        if (rst_i) begin 
//            inv_n <= 8'h00;
//        end else begin 
//            inv_n <= inv_p;
//        end
//    end

endmodule 

module subBytes_byte_tb();
    logic clk_i, rst_i;
	 logic [7:0] byte_i, byte_o;

    subBytes_byte dut (.clk_i, .rst_i, .byte_i, .byte_o);

    parameter CLOCK_PERIOD = 100;
    initial clk_i = 0;
    always #(CLOCK_PERIOD/2) clk_i = ~clk_i;

    initial begin 
        $dumpfile("waveform.vcd");
        $dumpvars(0, subBytes_byte_tb);

        rst_i <= 1; @(posedge clk_i);
        rst_i <= 0; @(posedge clk_i);
        byte_i <= 8'h57; @(posedge clk_i);
        byte_i <= 8'h13; @(posedge clk_i);
        @(posedge clk_i);
        @(posedge clk_i);
        @(posedge clk_i);
        @(posedge clk_i);
		  $stop;
    end
endmodule 