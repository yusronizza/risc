module StoreExt(
    input   [1:0]   StoreCtrl,
    input   [31:0]  dataMem,
    output  [31:0]  dataExt
);

localparam SB   = 2'b00; 
localparam SH   = 2'b01;
localparam SW   = 2'b10;

assign dataExt  = (StoreCtrl == SW) ? dataMem[31:0] : 32'h00000000;
                        
endmodule