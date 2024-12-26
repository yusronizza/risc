module storeExt(
    input   [2:0]   funt3,
    input   [31:0]  dataMem,
    output  [31:0]  dataExt
);

localparam SB   = 3'b000; 
localparam SH   = 3'b001;
localparam SW   = 3'b010;

assign dataExt  = (funt3 == SB) ? {{24{1'b0}}, dataMem[7:0]}    :
                  (funt3 == SH) ? {{16{1'b0}}, dataMem[15:0]}   : 
                  (funt3 == SW) ? dataMem[31:0]                 : 32'h00000000;
                        
endmodule