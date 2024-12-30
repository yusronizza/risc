module store(
    input   [2:0]   funct3,
    input   [31:0]  dataIn,
    output  [31:0]  dataOut
);

localparam SB   = 3'b000; 
localparam SH   = 3'b001;
localparam SW   = 3'b010;

assign dataOut  = (funct3 == SB) ? {{24{1'b0}}, dataIn[7:0]}    :
                  (funct3 == SH) ? {{16{1'b0}}, dataIn[15:0]}   : 
                  (funct3 == SW) ? dataIn[31:0]                 : 32'h00000000;
                        
endmodule