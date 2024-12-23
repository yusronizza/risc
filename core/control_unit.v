module controlUnit (
    //Input from instruction
    input wire  [6:0]   OPCode,
    input wire  [2:0]   funct3,
    input wire          funct75,
    input wire  [3:0]   ALUFlags,

    // Output control
    output wire         regWrite,
    output wire [2:0]   immSource,
    output wire [2:0]   loadCtrl,
    output wire [1:0]   storeCtrl,
    output wire         srcAIn,
    output wire         srcBIn,
    output wire         resultSource,
    output wire         memWrite,
    output wire         PCNextIn,
    output wire         srcPCTarget,
    output wire [3:0]   ALUControl
);
    
wire [1:0] ALUOp;
wire OPCode5 = OPCode[5];

ALUDecoder ALUDecoder (
    .ALUOp      (ALUOp),
    .funct3     (funct3),
    .funct75    (funct75),
    .OPCode5    (OPCode5),
    .ALUControl (ALUControl)
);

mainDecoder mainDecoder (
    .OPCode             (OPCode),
    .funct3             (funct3),
    .funct75            (funct75),
    .negative_flag      (ALUFlags[0]),
    .zero_flag          (ALUFlags[1]),
    .carry_flag         (ALUFlags[2]),
    .overflow_flag      (ALUFlags[3]),
    .regWrite           (regWrite),
    .immSource          (immSource),
    .loadCtrl           (loadCtrl),
    .storeCtrl          (storeCtrl),
    .srcAIn             (srcAIn),
    .srcBIn             (srcBIn),
    .resultSource       (resultSource),
    .memWrite           (memWrite),
    .PCNextIn           (PCNextIn),
    .srcPCTarget        (srcPCTarget),
    .ALUOp              (ALUOp)
);

endmodule