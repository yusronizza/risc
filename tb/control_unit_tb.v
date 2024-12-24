module tb;
    
reg  [6:0]   OPCode;
reg  [2:0]   funct3;
reg          funct75;
reg  [3:0]   ALUFlags;
wire         regWrite;
wire [2:0]   immSource;
wire [2:0]   loadCtrl;
wire [1:0]   storeCtrl;
wire         srcAIn;
wire         srcBIn;
wire         resultSource;
wire         memWrite;
wire         PCNextIn;
wire         srcPCTarget;
wire [3:0]   ALUControl;

controlUnit DUT(
    .OPCode         (OPCode),
    .funct3         (funct3),
    .funct75        (funct75),
    .ALUFlags       (ALUFlags),
    .regWrite       (regWrite),
    .immSource      (immSource),
    .loadCtrl       (loadCtrl),
    .storeCtrl      (storeCtrl),
    .srcAIn         (srcAIn),
    .srcBIn         (srcBIn),
    .resultSource   (resultSource),
    .memWrite       (memWrite),
    .PCNextIn       (PCNextIn),
    .srcPCTarget    (srcPCTarget),
    .ALUControl     (ALUControl)
);

initial begin
    OPCode   = 7'b0110011;
    funct3   = 3'b101;
    funct75  = 1'b0;
    ALUFlags = 4'b0000;
    #1;
    OPCode   = 7'b0110011;
    funct3   = 3'b011;
    funct75  = 1'b1;
    ALUFlags = 4'b0000;
    #1;
    OPCode   = 7'b0000011;
    funct3   = 3'b100;
    funct75  = 1'b1;
    ALUFlags = 4'b0000;
    #1;
    OPCode   = 7'b0100011;
    funct3   = 3'b010;
    funct75  = 1'b1;
    ALUFlags = 4'b0000;
    #1;
    OPCode   = 7'b0100011;
    funct3   = 3'b010;
    funct75  = 1'b0;
    ALUFlags = 4'b0000;
end

endmodule
