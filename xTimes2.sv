module xTimes2(b_i, b_o);
    input logic [7:0] b_i;
    output logic [7:0] b_o;

    logic [7:0] b_shifted;

    // left shift 1 logic 
    assign b_shifted = b_i << 1;

    // MSB check & output logic 
    assign b_o = b_i[7] ? (b_shifted ^ 8'b00011011) : b_shifted;

endmodule 

module xTimes2_tb();
    logic [7:0] b_i, b_o;

    xTimes dut (.b_i, .b_o);

    initial begin 
        $dumpfile("waveform.vcd");
        $dumpvars(0, gf_square_tb);
        
        b_i <= 8'h13; #10;
        // b_i <= 8'b00010001; #10;
        // b_i <= 8'b11110001; #10;
        $stop;
    end
endmodule 