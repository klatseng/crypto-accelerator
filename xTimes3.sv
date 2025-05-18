module xTimes3(b_i, b_o);
    input logic [7:0] b_i;
    output logic [7:0] b_o;
    
    logic [7:0] b_times2;

    xTimes2 times2 (.b_i(b_i), .b_o(b_times2));

    assign b_o = b_times2 ^ b_i;
endmodule 