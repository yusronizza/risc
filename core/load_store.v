module LoadStore(
    input   [2:0]   LSCtrl,
    input   [31:0]  dataMem,
    output  [31:0]  dataExt
);

localparam LB       =   3'b000; 
localparam LH       =   3'b001; 
localparam LW       =   3'b010; 
localparam LBU      =   3'b011; 
localparam LHU      =   3'b100;
localparam SB       =   3'b101; 
localparam SH       =   3'b110;
localparam SW       =   3'b111;

assign dataExt      =   (LSCtrl == LB) ? {{24{dataMem[7]}} , dataMem[7:0]} :
                        (LSCtrl == LH) ? {{16{dataMem[15]}}, dataMem[15:0]} :
                        (LSCtrl == LW) ? dataMem[31:0] :
                        (LSCtrl == LBU)? {{24{1'b0}} , dataMem[7:0]} :
                        (LSCtrl == LHU)? {{16{1'b0}}, dataMem[15:0]} : 
                        (LSCtrl == SW) ? dataMem[31:0] :
                        32'h00000000;
                        
endmodule