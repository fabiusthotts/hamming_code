module hamming_encoder;

  reg [63:0] data_in = 64'b0101100101100101001111001010101011001111000011110011001100110011;
  wire [110:0] codeword_out;

  reg [7:0] h_parity;  
  reg [7:0] v_parity;  
  reg [14:0] d_parity;
    
  integer i, j;

    initial begin
      
        for (i = 0; i < 8; i = i + 1) begin
            h_parity[i] = ^data_in[i*8 +: 8]; 
        end

        for (j = 0; j < 8; j = j + 1) begin
            v_parity[j] = ^{data_in[j], data_in[j+8], data_in[j+16], data_in[j+24], data_in[j+32], data_in[j+40], data_in[j+48], data_in[j+56]};
        end

        d_parity[0]  = ^{data_in[63]};
        d_parity[1]  = ^{data_in[55], data_in[62]};
        d_parity[2]  = ^{data_in[47], data_in[54], data_in[61]};
        d_parity[3]  = ^{data_in[39], data_in[46], data_in[53], data_in[60]};
        d_parity[4]  = ^{data_in[31], data_in[38], data_in[45], data_in[52], data_in[59]};
        d_parity[5]  = ^{data_in[23], data_in[30], data_in[37], data_in[44], data_in[51], data_in[58]};
        d_parity[6]  = ^{data_in[15], data_in[22], data_in[29], data_in[36], data_in[43], data_in[50], data_in[57]};
        d_parity[7]  = ^{data_in[7], data_in[14], data_in[21], data_in[28], data_in[35], data_in[42], data_in[49], data_in[56]};
        d_parity[8]  = ^{data_in[6], data_in[13], data_in[20], data_in[27], data_in[34], data_in[41], data_in[48]};
        d_parity[9]  = ^{data_in[5], data_in[12], data_in[19], data_in[26], data_in[33], data_in[40]};
        d_parity[10] = ^{data_in[4], data_in[11], data_in[18], data_in[25], data_in[32]};
        d_parity[11] = ^{data_in[3], data_in[10], data_in[17], data_in[24]};
        d_parity[12] = ^{data_in[2], data_in[9], data_in[16]};
        d_parity[13] = ^{data_in[1], data_in[8]};
		d_parity[14] = ^{data_in[0]};
    

    	$display("Data Input  : %b", data_in);
   		$display("H Parity    : %b", h_parity);
    	$display("V Parity    : %b", v_parity);
    	$display("D Parity    : %b", d_parity);
      
    end
  
    wire [11:0] h_enc, v_enc, d_enc1;
    wire [10:0] d_enc2;
  
  	hamming_12_8 hamming_H(.data_in(h_parity), .code_out(h_enc));
  	hamming_12_8 hamming_V(.data_in(v_parity), .code_out(v_enc));
   	hamming_12_8 hamming_D1(.data_in(d_parity[7:0]), .code_out(d_enc1));
    hamming_11_7 hamming_D2(.data_in(d_parity[14:8]), .code_out(d_enc2));
  
    assign codeword_out = {data_in, h_enc, v_enc, d_enc1, d_enc2}; 
  
   	initial begin
      $monitor("Final data: %b", codeword_out); 
      $finish;
    end
endmodule
