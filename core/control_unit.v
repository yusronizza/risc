module control_unit(
    input   [6:0]       OPCode,
    input   [3:0]       funct3,
    input               funct7,
    input               zero,
    output              PCSource,
    output              ResultSource,
    output              MemWrite,
    output  [3:0]       ALUControl,
    output              ALUSource,
    output  [1:0]       ImmSource,
    output              RegWrite
);

/* 
 * Instruction Opcodes
 * RISC-V has 6 type of Instruction : I, U, S, R, B, J
*/
localparam OPCode_I_LW         = 7'b0000011; // 3
localparam OPCode_I_IMM        = 7'b0010011; // 19
localparam OPCode_U_ADDUI_PC   = 7'b0010111; // 23 : CS
localparam OPCode_S_STORE      = 7'b0100011; // 35
localparam OPCode_R_TYPE       = 7'b0110011; // 51
localparam OPCode_U_LUI        = 7'b0110111; // 55
localparam OPCode_B_BRANCH     = 7'b1100011; // 99
localparam OPCode_I_JALR       = 7'b1100111; // 103 : CS
localparam OPCode_J_JAL        = 7'b1101111; // 111

endmodule