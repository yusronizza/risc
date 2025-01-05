module regExecuteMemory (
    input                clk,
    input                regWrite_EX,
    input                memWrite_EX,
    input        [1:0]   resultSrc_EX,
    input        [2:0]   funct3_EX,
    input       [31:0]   ALUResult_EX,
    input       [31:0]   storeOut_EX,
    input       [31:0]   immOut_EX,
    input        [4:0]   writeAddress_EX,
    input       [31:0]   PCPlus4_EX,
    output wire          regWrite_MEM,
    output wire          memWrite_MEM,
    output wire  [1:0]   resultSrc_MEM,
    output wire  [2:0]   funct3_MEM,
    output wire [31:0]   ALUResult_MEM,
    output wire [31:0]   storeOut_MEM,
    output wire [31:0]   immOut_MEM,
    output wire  [4:0]   writeAddress_MEM,
    output wire [31:0]   PCPlus4_MEM
);

reg         regWrite;
reg         memWrite;
reg  [1:0]  resultSrc;
reg  [2:0]  funct3;
reg [31:0]  ALUResult;
reg [31:0]  storeOut;
reg [31:0]  immOut;
reg  [4:0]  writeAddress;
reg [31:0]  PCPlus4;

initial begin
    regWrite        <= 1'b0;
    memWrite        <= 1'b0;
    resultSrc       <= 2'b00;
    funct3          <= 3'b000;
    ALUResult       <= 32'h00000000;
    storeOut        <= 32'h00000000;
    immOut          <= 32'h00000000;
    writeAddress    <= 5'b00000;
    PCPlus4         <= 32'h00000000;
end

always @(posedge clk) begin
    regWrite        <= regWrite_EX;
    memWrite        <= memWrite_EX;
    resultSrc       <= resultSrc_EX;
    funct3          <= funct3_EX;
    ALUResult       <= ALUResult_EX;
    storeOut        <= storeOut_EX;
    immOut          <= immOut_EX;
    writeAddress    <= writeAddress_EX;
    PCPlus4         <= PCPlus4_EX;
end

assign regWrite_MEM        = regWrite;
assign memWrite_MEM        = memWrite;
assign resultSrc_MEM       = resultSrc;
assign funct3_MEM          = funct3;
assign ALUResult_MEM       = ALUResult;
assign storeOut_MEM        = storeOut;
assign immOut_MEM          = immOut;
assign writeAddress_MEM    = writeAddress;
assign PCPlus4_MEM         = PCPlus4;

endmodule