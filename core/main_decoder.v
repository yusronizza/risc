module mainDecoder(
    input   [6:0]           OPCode,
    
    //Input from ALU flag
    input                   negative_flag,
    input                   zero_flag,
    input                   carry_flag,
    input                   overflow_flag,

    // Output control
    output                  regWrite,
    output      [2:0]       immSource,
    output      [2:0]       loadCtrl,
    output      [1:0]       storeCtrl,
    output                  srcAIn,
    output                  srcBIn,
    output                  resultSource,
    output wire             memWrite,
    output wire             PCNextIn,
    output                  srcPCTarget,
    output      [3:0]       ALUControl
);

/* 
 * Instruction OPCodes
 * RISC-V has 6 type of Instruction : I, U, S, R, B, J
*/
localparam OPCode_I_LW         = 7'b0000011; // 3
localparam OPCode_I_IMM        = 7'b0010011; // 19
localparam OPCode_U_AUI        = 7'b0010111; // 23 : CS
localparam OPCode_S_STORE      = 7'b0100011; // 35
localparam OPCode_R_TYPE       = 7'b0110011; // 51
localparam OPCode_U_LUI        = 7'b0110111; // 55
localparam OPCode_B_BRANCH     = 7'b1100011; // 99
localparam OPCode_I_JALR       = 7'b1100111; // 103 : CS
localparam OPCode_J_JAL        = 7'b1101111; // 111

/* 
 * ALU Control List
 * RISCV32I has 10 type of ALU Instruction
*/
localparam ALU_ADD  = 4'b0000;
localparam ALU_SUB  = 4'b0001;
localparam ALU_AND  = 4'b0010;
localparam ALU_OR   = 4'b0011;
localparam ALU_SLT  = 4'b0100;
localparam ALU_SLL  = 4'b0101;
localparam ALU_SLTU = 4'b0110;
localparam ALU_XOR  = 4'b0111;
localparam ALU_SRL  = 4'b1000;
localparam ALU_SRA  = 4'b1001;


/* Branch and Jump signal */ 

wire branch = (OPCode == OPCode_B_BRANCH)   ? 1'b1 : 1'b0;
wire jump   = (OPCode == OPCode_I_JALR)     ? 1'b1 : 
              (OPCode == OPCode_J_JAL)      ? 1'b1 : 1'b0;

/* Internal signal*/
wire beq    = zero_flag & branch;
wire bne    = ((zero_flag == 1'b0) ? 1'b1 : 1'b0) & branch;
wire blt    = (negative_flag ^ overflow_flag) & branch;
wire bge    = (~(negative_flag ^ overflow_flag)) & branch;
wire bltu   = (~carry_flag) & branch;
wire bgeu   = (carry_flag) & branch;
wire jalr   = jump;
wire jal    = jump;

assign PCNextIn = beq | bne | blt | bge | bltu | bgeu | jalr | jal ;

assign memWrite = (OPCode == OPCode_S_STORE) ? 1'b1 : 1'b0;

assign PCNextIn = (OPCode == OPCode_B_BRANCH)       ? 1'b1 :
                  (OPCode == OPCode_I_JALR)         ? 1'b1 :
                  (OPCode == OPCode_J_JAL)          ? 1'b1 : 1'b0;

assign srcPCTarget = (OPCode == OPCode_B_BRANCH)    ? 1'b1 : 
                     (OPCode == OPCode_J_JAL)       ? 1'b1 : 1'b0;

assign regWrite = (OPCode == OPCode_S_STORE)  ? 1'b0 :
                  (OPCode == OPCode_B_BRANCH) ? 1'b0 : 1'b1;

assign resultSource = (OPCode == OPCode_I_LW)   ? 2'b01 :
                      (OPCode == OPCode_R_TYPE) ? 2'b00 :
                      (OPCode == OPCode_I_IMM)  ? 2'b00 :
                      (OPCode == OPCode_U_AUI)  ? 2'b10 :
                      (OPCode == OPCode_J_JAL)  ? 2'b11 :
                      (OPCode == OPCode_I_JALR) ? 2'b11 : 2'b00 ;

assign srcAIn = (OPCode == OPCode_U_AUI) ? 1'b0 : 1'b1;

assign srcBIn = (OPCode == OPCode_R_TYPE)   ? 1'b0 :
                (OPCode == OPCode_B_BRANCH) ? 1'b0 : 1'b1;
endmodule