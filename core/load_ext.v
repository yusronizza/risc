module LoadExt(
    input       [2:0]   loadCtrl,
    input       [31:0]  dataMem,
    output  reg [31:0]  dataExt
);

localparam LB       =   3'b000; 
localparam LH       =   3'b001; 
localparam LW       =   3'b010; 
localparam LBU      =   3'b100; 
localparam LHU      =   3'b101;

always @(loadCtrl or dataMem or dataExt) begin
    case (loadCtrl)
        LB  : dataExt <= {{24{dataMem[7]}}  , dataMem[7:0]};
        LH  : dataExt <= {{16{dataMem[15]}} , dataMem[15:0]};
        LW  : dataExt <= {dataMem[31:0]};
        LBU : dataExt <= {{24{1'b0}}        , dataMem[7:0]};
        LHU : dataExt <= {{16{1'b0}}        , dataMem[15:0]};
        default: dataExt <= 32'h00000000;
    endcase
end
                        
endmodule