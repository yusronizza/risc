/* This module is all combinational circuit
 * Module can perform immediate extend, load and store extend
 * Consist of two control signal, two input, and two output
*/

module immExt (
    input   [2:0]   immSrc,
    input   [31:0]  instr,
    output  [31:0]  immOut
);

localparam I_TYPE   =   3'b000; //12-bit signed immediate
localparam S_TYPE   =   3'b001; //12-bit signed immediate
localparam B_TYPE   =   3'b010; //13-bit signed immediate
localparam J_TYPE   =   3'b011; //21-bit signed immediate
localparam U_TYPE   =   3'b100; //21-bit signed immediate

assign immOut       =   (immSrc == I_TYPE) ? {{20{instr[31]}}, instr[31:20]} :
                        (immSrc == S_TYPE) ? {{20{instr[31]}}, instr[31:25] , instr[11:7]} :
                        (immSrc == B_TYPE) ? {{20{instr[31]}}, instr[7]     , instr[30:25]  , instr[11:8]   , 1'b0} :
                        (immSrc == J_TYPE) ? {{12{instr[31]}}, instr[19:12] , instr[20]     , instr[30:21]  , 1'b0} : 
                        (immSrc == U_TYPE) ? {instr[31:12], {12{1'b0}}} :
                        32'h00000000;

endmodule