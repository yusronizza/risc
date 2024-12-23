module mainDecoder(
    input   [6:0]           OPCode,
    input   [2:0]           funct3,
    input                   funct75,
    
    //Input from ALU flag
    input                   negative_flag,
    input                   zero_flag,
    input                   carry_flag,
    input                   overflow_flag,

    // Output control
    output wire             regWrite,
    output wire [2:0]       immSource,
    output reg  [2:0]       loadCtrl,
    output reg  [1:0]       storeCtrl,
    output wire             srcAIn,
    output wire             srcBIn,
    output wire             resultSource,
    output wire             memWrite,
    output wire             PCNextIn,
    output wire             srcPCTarget,
    output wire [2:0]       ALUOp
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
                      (OPCode == OPCode_U_AUI)  ? 2'b00 :
                      (OPCode == OPCode_U_LUI)  ? 2'b10 :
                      (OPCode == OPCode_J_JAL)  ? 2'b11 :
                      (OPCode == OPCode_I_JALR) ? 2'b11 : 2'b00 ;

assign srcAIn = (OPCode == OPCode_U_AUI) ? 1'b0 : 1'b1;

assign srcBIn = (OPCode == OPCode_R_TYPE)   ? 1'b0 :
                (OPCode == OPCode_B_BRANCH) ? 1'b0 : 1'b1;

assign immSource = (OPCode == OPCode_I_LW)    ? 3'b000 :
                   (OPCode == OPCode_S_STORE) ? 3'b001 :
                   (OPCode == OPCode_I_IMM)   ? 3'b000 :
                   (OPCode == OPCode_U_AUI)   ? 3'b100 :
                   (OPCode == OPCode_U_LUI)   ? 3'b100 :
                   (OPCode == OPCode_B_BRANCH)? 3'b010 :
                   (OPCode == OPCode_I_JALR)  ? 3'b011 :
                   (OPCode == OPCode_J_JAL)   ? 3'b011 : 3'b000;

always @(OPCode or funct3) begin
    if(OPCode == OPCode_I_LW) begin
        loadCtrl <= funct3;
    end
end

always @(OPCode or funct3) begin
    if(OPCode == OPCode_S_STORE) begin
        storeCtrl <= funct3[1:0];
    end
end

endmodule