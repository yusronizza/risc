/* This module is all combinational circuit
 * Module can perform immediate extend, load and store extend
 * Consist of two control signal, two input, and two output
*/

module extend (
    input   [1:0]   immSrc,
    input   [2:0]   LSCtrl,
    input   [31:0]  instr,
    input   [31:0]  dataMem,
    output  [31:0]  immExt,
    output  [31:0]  dataExt
);

localparam I_TYPE   =   2'b00; //12-bit signed immediate
localparam S_TYPE   =   2'b01; //12-bit signed immediate
localparam B_TYPE   =   2'b10; //13-bit signed immediate
localparam J_TYPE   =   2'b11; //21-bit signed immediate

localparam LB       =   3'b000; 
localparam LH       =   3'b001; 
localparam LW       =   3'b010; 
localparam LBU      =   3'b011; 
localparam LHU      =   3'b100;
localparam SB       =   3'b101; 
localparam SH       =   3'b110;
localparam SW       =   3'b111;

assign immExt       =   (immSrc == I_TYPE) ? {{20{instr[31]}}, instr[31:20]} :
                        (immSrc == S_TYPE) ? {{20{instr[31]}}, instr[31:25] , instr[11:7]} :
                        (immSrc == B_TYPE) ? {{20{instr[31]}}, instr[7]     , instr[30:25]  , instr[11:8]   , 1'b0} :
                        (immSrc == J_TYPE) ? {{12{instr[31]}}, instr[19:12] , instr[20]     , instr[30:21]  , 1'b0} : 
                        32'h00000000;


assign dataExt      =   (LSCtrl == LB) ? {{24{dataMem[7]}} , dataMem[7:0]} :
                        (LSCtrl == LH) ? {{16{dataMem[15]}}, dataMem[15:0]} :
                        (LSCtrl == LW) ? dataMem[31:0] :
                        (LSCtrl == LBU)? {{24{1'b0}} , dataMem[7:0]} :
                        (LSCtrl == LHU)? {{16{1'b0}}, dataMem[15:0]} : 
                        (LSCtrl == SW) ? dataMem[31:0] :
                        32'h00000000;

endmodule