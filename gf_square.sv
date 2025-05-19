module gf_square(byte_i, square_o);
    input logic [7:0] byte_i;
    output logic [7:0] square_o;

    logic [7:0] bytex02, bytex04, bytex08, bytex10, bytex20, bytex40, bytex80;

    // precompute all possible xTime values for 1 byte
    xTimes2 Bytex02 (.b_i(byte_i), .b_o(bytex02));
    xTimes2 Bytex04 (.b_i(bytex02), .b_o(bytex04));
    xTimes2 Bytex08 (.b_i(bytex04), .b_o(bytex08));
    xTimes2 Bytex10 (.b_i(bytex08), .b_o(bytex10));
    xTimes2 Bytex20 (.b_i(bytex10), .b_o(bytex20));
    xTimes2 Bytex40 (.b_i(bytex20), .b_o(bytex40));
    xTimes2 Bytex80 (.b_i(bytex40), .b_o(bytex80));

    // xor non-zero bits together to get square output 
    always_comb begin 
        square_o = 8'h00;

        if (byte_i[0]) square_o ^= byte_i;
        if (byte_i[1]) square_o ^= bytex02;
        if (byte_i[2]) square_o ^= bytex04;
        if (byte_i[3]) square_o ^= bytex08;
        if (byte_i[4]) square_o ^= bytex10;
        if (byte_i[5]) square_o ^= bytex20;
        if (byte_i[6]) square_o ^= bytex40;
        if (byte_i[7]) square_o ^= bytex80;
    end

endmodule 

module gf_square_tb();
    logic [7:0] byte_i, square_o;

    gf_square dut (.byte_i, .square_o);

    // parameter CLOCK_PERIOD = 100;
    // initial clk_i = 0;
    // always #(CLOCK_PERIOD/2) clk_i = ~clk_i;

    // initial begin 
    //   	$dumpfile("waveform.vcd");
    //     $dumpvars(0, gf_square_tb);
      
    //     rst_i <= 1; @(posedge clk_i);
    //     rst_i <= 1; @(posedge clk_i);
    //     rst_i <= 0; @(posedge clk_i);
    //     byte_i <= 8'h13; @(posedge clk_i);
    //     byte_i <= 8'h20; @(posedge clk_i);
    //     byte_i <= 8'b1000_1000; @(posedge clk_i);
    //     byte_i <= 8'b0011_0010; @(posedge clk_i);
    //     $stop;
    // end

    initial begin 
        $dumpfile("waveform.vcd");
        $dumpvars(0, gf_square_tb);
      
        byte_i = 8'h13; #10;
        byte_i = 8'h20; #10;
        byte_i = 8'b1000_1000; #10;
        byte_i = 8'b0011_0010; #10;
        $stop;
    end
endmodule 