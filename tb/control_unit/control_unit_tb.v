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

reg [33:0] test_vectors [0:36];  // 34-bit data, 37 rows
integer i;

initial begin
    $readmemb("control_unit_tb.txt", test_vectors);
    for (i = 0 ; i < 37 ; i = i + 1 ) begin
        {OPCode, funct3, funct75, ALUFlags} = {test_vectors[i][33:23], 4'b0000};
        #10;
    end
    
end

endmodule
