module subBytes(
    input  logic        clk_i,
    input  logic        rst_i,
    input  logic [7:0]  in  [3:0][3:0],
    output logic [7:0]  out [3:0][3:0]
);

    genvar i, j;
    generate
        for (i = 0; i < 4; i++) begin : row_loop
            for (j = 0; j < 4; j++) begin : col_loop
                subBytes_byte SubBytes_byte (
                    .clk_i(clk_i),
                    .rst_i(rst_i),
                    .byte_i(in[i][j]),
                    .byte_o(out[i][j])
                );
            end
        end
    endgenerate

endmodule