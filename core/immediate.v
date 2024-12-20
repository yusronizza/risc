module extend (
    input wire  [31:0]  instr,
    input wire  [1:0]   immSrc,
    output wire [31:0]  immExt
);

localparam I_TYPE = 2'b00; //12-bit signed immediate
localparam S_TYPE = 2'b01; //12-bit signed immediate
localparam B_TYPE = 2'b10; //13-bit signed immediate
localparam J_TYPE = 2'b11; //21-bit signed immediate

assign immExt = (immSrc == I_TYPE) ? {{20{instr[31]}}, instr[31:20]} :
                (immSrc == S_TYPE) ? {{20{instr[31]}}, instr[31:25] , instr[11:7]} :
                (immSrc == B_TYPE) ? {{20{instr[31]}}, instr[7]     , instr[30:25]  , instr[11:8]   , 1'b0} :
                (immSrc == J_TYPE) ? {{12{instr[31]}}, instr[19:12] , instr[20]     , instr[30:21]  , 1'b0} : 
                32'h00000000;

endmodule