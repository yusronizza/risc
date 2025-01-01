module controlUnit (
    input wire  [6:0]   OPCode,
    input wire  [2:0]   funct3,
    input wire          funct75,
    output wire [5:0]   branch,
    output wire         jump,
    output wire         regWrite,
    output wire [2:0]   immSrc,
    output wire         ASrc,
    output wire         BSrc,
    output wire         PCTargetSrc,
    output wire [3:0]   ALUControl,
    output wire         memWrite,
    output wire [1:0]   resultSrc,
    output wire [1:0]   DQM
);
    
wire [1:0] ALUOp;
wire OPCode5 = OPCode[5];

mainDecoder mainDecoder (
    .OPCode         (OPCode),
    .funct3         (funct3),
    .branch         (branch),
    .jump           (jump),
    .regWrite       (regWrite),
    .immSrc         (immSrc),
    .ASrc           (ASrc),
    .BSrc           (BSrc),
    .resultSrc      (resultSrc),
    .memWrite       (memWrite),
    .PCTargetSrc    (PCTargetSrc),
    .ALUOp          (ALUOp),
    .DQM            (DQM)
);

ALUDecoder ALUDecoder (
    .ALUOp          (ALUOp),
    .funct3         (funct3),
    .funct75        (funct75),
    .OPCode5        (OPCode5),
    .ALUControl     (ALUControl)
);

endmodule