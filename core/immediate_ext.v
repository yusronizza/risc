/* This module is all combinational circuit
 * Module can perform immediate extend
 * Consist of control signal, input, and output
*/

module immExt (
    input       [2:0]   immSrc,
    input       [31:0]  instr,
    output  reg [31:0]  immOut
);

localparam I_TYPE   =   3'b000; //12-bit signed immediate
localparam S_TYPE   =   3'b001; //12-bit signed immediate
localparam B_TYPE   =   3'b010; //13-bit signed immediate
localparam J_TYPE   =   3'b011; //21-bit signed immediate
localparam U_TYPE   =   3'b100; //21-bit signed immediate


always @(immSrc or instr) begin
    case (immSrc)
        I_TYPE : 
            immOut <= {{20{instr[31]}}, instr[31:20]};
        S_TYPE : 
            immOut <= {{20{instr[31]}}, instr[31:25] , instr[11:7]};
        B_TYPE : 
            immOut <= {{20{instr[31]}}, instr[7]     , instr[30:25]  , instr[11:8]   , 1'b0};
        J_TYPE : 
            immOut <= {{12{instr[31]}}, instr[19:12] , instr[20]     , instr[30:21]  , 1'b0};
        U_TYPE : 
            immOut <= {instr[31:12], {12{1'b0}}};
        default: 
            immOut <= 32'h00000000;
    endcase
end

endmodule