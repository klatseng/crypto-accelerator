// multiplier module 
// bigger - multiplicand 
// smaller - multiplier 
module gf_mult(a_i, b_i, product_o);
    input logic [7:0] a_i, b_i;
    output logic [7:0] product_o;

    logic [7:0] mcand, mlier; 
    logic [7:0] xTime [7:0]; // intermediate xTime values 
    logic [7:0] temp_product;

    // determine multiplier 
    // if a >= b, b is the multiplier 
    // if a < b, a is the multiplier 
    always_comb begin 
        if (a_i >= b_i) begin 
            mcand = a_i;
            mlier = b_i;
        end else begin 
            mcand = b_i;
            mlier = a_i;
        end
    end

    // precompute all possible xTime values for the multiplicand
    // 7  6  5  4  3  2  1  0
    // 80 40 20 10 08 04 02 01
    assign xTime[0] = mcand;
    xTimes2 Bytex02 (.b_i(mcand), .b_o(xTime[1]));
    xTimes2 Bytex04 (.b_i(xTime[1]), .b_o(xTime[2]));
    xTimes2 Bytex08 (.b_i(xTime[2]), .b_o(xTime[3]));
    xTimes2 Bytex10 (.b_i(xTime[3]), .b_o(xTime[4]));
    xTimes2 Bytex20 (.b_i(xTime[4]), .b_o(xTime[5]));
    xTimes2 Bytex40 (.b_i(xTime[5]), .b_o(xTime[6]));
    xTimes2 Bytex80 (.b_i(xTime[6]), .b_o(xTime[7]));

    // xor non-zero bits 
    always_comb begin 
        temp_product = '0;
        for (int i = 0; i < 8; i++) begin 
            if (mlier[i] == 1) begin 
                temp_product ^= xTime[i];
            end
        end
    end

    // assign final output 
    assign product_o = temp_product;

endmodule 

module gf_mult_tb();
    logic [7:0] a_i, b_i, product_o;

    gf_mult dut (.a_i, .b_i, .product_o);

    initial begin 
        $dumpfile("waveform.vcd");
        $dumpvars(0, gf_mult_tb);

        a_i = 8'h13; b_i = 8'h13; #10;
        a_i = 8'h57; b_i = 8'h13; #10;
        a_i = 8'h13; b_i = 8'h57; #10;
        $stop;
    end
endmodule 