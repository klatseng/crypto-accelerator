module mixColumns(in, out);
    input logic [7:0] in [3:0][3:0];
    output logic [7:0] out [3:0][3:0];

    // mixColumns_col(col_i, col_o);
    // input logic [7:0] col_i [3:0];
    // output logic [7:0] col_o [3:0];

    genvar i;
    generate 
        for (i = 0; i < 4; i++) begin : gen_mix_columns
            logic [7:0] col_i [3:0];
            logic [7:0] col_o [3:0];

            // Assign the i-th column of input to col_i
            assign col_i[0] = in[0][i];
            assign col_i[1] = in[1][i];
            assign col_i[2] = in[2][i];
            assign col_i[3] = in[3][i];

            mixColumns_col mix_col_inst(
                .col_i(col_i),
                .col_o(col_o)
            );

            // Assign the output column to the corresponding out column
            assign out[0][i] = col_o[0];
            assign out[1][i] = col_o[1];
            assign out[2][i] = col_o[2];
            assign out[3][i] = col_o[3];
        end
    endgenerate
endmodule 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ;

endmodule 