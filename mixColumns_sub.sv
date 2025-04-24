module mixColumns_col(col_i, col_o);
    input logic [7:0] col_i [3:0];
    output logic [7:0] col_o [3:0];

    logic [7:0] in_times2 [3:0];
    logic [7:0] in_times3 [3:0];

    // intermediate times2 and times3 values 
    genvar i;
    generate 
        for (i = 0; i < 4; i++) begin 
            xTimes2 times2_instance (.b_i(col_i[i]), .b_o(in_times2[i]));
            xTimes3 times3_instance (.b_i(col_i[i]), .b_o(in_times3[i]));
        end 
    endgenerate

    // assign output 
    assign col_o[3] = in_times2[3] ^ in_times3[2] ^ col_i[1] ^ col_i[0];
    assign col_o[2] = col_i[3] ^ in_times2[2] ^ in_times3[1] ^ col_i[0];
    assign col_o[1] = col_i[3] ^ col_i[2] ^ in_times2[1] ^ in_times3[0];
    assign col_o[0] = in_times3[3] ^ col_i[2] ^ col_i[1] ^ in_times2[0];
endmodule 


module xTimes2(b_i, b_o);
    input logic [7:0] b_i;
    output logic [7:0] b_o;

    logic [7:0] b_shifted;

    // left shift 1 logic 
    assign b_shifted = b_i << 1;

    // MSB check & output logic 
    assign b_o = b_i[7] ? (b_shifted ^ 8'b00011011) : b_shifted;

endmodule 

module xTimes3(b_i, b_o);
    input logic [7:0] b_i;
    output logic [7:0] b_o;
    
    logic [7:0] b_times2;

    xTimes2 times2 (.b_i(b_i), .b_o(b_times2));

    assign b_o = b_times2 ^ b_i;
endmodule 

// module xTimes2_tb();
//     logic [7:0] b_i, b_o;

//     xTimes dut (.b_i, .b_o);

//     initial begin 
//         b_i <= 8'b10001000; #10;
//         b_i <= 8'b00010001; #10;
//         b_i <= 8'b11110001; #10;
//         $stop;
//     end
// endmodule 

module mixColumns_col_tb();
    logic [7:0] col_i [3:0];
    logic [7:0] col_o [3:0];

    mixColumns_col dut (.col_i, .col_o);

    initial begin 
        col_i[3] = 8'b00000011;
        col_i[2] = 8'b00000010;
        col_i[1] = 8'b00000001;
        col_i[0] = 8'b00001100;
        #10;
        col_i[3] = 8'b11111111;
        col_i[2] = 8'b11111100;
        col_i[1] = 8'b11110011;
        col_i[0] = 8'b11001100;
        #10;
        $stop;
    end
endmodule 