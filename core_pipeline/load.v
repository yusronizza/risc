module load(
    input       [2:0]   funct3,
    input       [31:0]  dataIn,
    output  reg [31:0]  dataOut
);

localparam LB       =   3'b000; 
localparam LH       =   3'b001; 
localparam LW       =   3'b010; 
localparam LBU      =   3'b100; 
localparam LHU      =   3'b101;

always @* begin
    case (funct3)
        LB : dataOut = {{24{dataIn[7]}}, dataIn[7:0]};
        LH : dataOut = {{16{dataIn[15]}}, dataIn[15:0]};
        LW : dataOut = {dataIn[31:0]};
        LBU : dataOut = {{24{1'b0}}, dataIn[7:0]};
        LHU : dataOut = {{16{1'b0}}, dataIn[15:0]};
    endcase
end
                        
endmodule