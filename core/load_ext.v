module LoadExt(
    input   [2:0]   loadCtrl,
    input   [31:0]  dataMem,
    output  [31:0]  dataExt
);

localparam LB       =   3'b000; 
localparam LH       =   3'b001; 
localparam LW       =   3'b010; 
localparam LBU      =   3'b011; 
localparam LHU      =   3'b100;

assign dataExt      =   (loadCtrl == LB) ? {{24{dataMem[7]}} , dataMem[7:0]} :
                        (loadCtrl == LH) ? {{16{dataMem[15]}}, dataMem[15:0]} :
                        (loadCtrl == LW) ? dataMem[31:0] :
                        (loadCtrl == LBU)? {{24{1'b0}} , dataMem[7:0]} :
                        (loadCtrl == LHU)? {{16{1'b0}}, dataMem[15:0]} : 
                        32'h00000000;
                        
endmodule