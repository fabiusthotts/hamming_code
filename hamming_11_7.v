module hamming_11_7 (
  input  [6:0] data_in,   
  output [10:0] code_out   
);

    wire p1, p2, p3, p4;  
    assign p1 = data_in[0] ^ data_in[1] ^ data_in[3] ^ data_in[4] ^ data_in[6]; 
    assign p2 = data_in[0] ^ data_in[2] ^ data_in[3] ^ data_in[5] ^ data_in[6];
    assign p3 = data_in[1] ^ data_in[2] ^ data_in[3]; 
    assign p4 = data_in[4] ^ data_in[5] ^ data_in[6];
    assign code_out = {data_in[6], data_in[5], data_in[4], p4, data_in[3], data_in[2], data_in[1], p3, data_in[0], p2, p1};

endmodule

