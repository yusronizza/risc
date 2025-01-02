module regMemory (
    input                clk,
    input                regWrite_MEM,
    input        [1:0]   resultSrc_MEM,
    input       [31:0]   ALUResult_MEM,
    input       [31:0]   loadOut_MEM,
    input       [31:0]   immOut_MEM,
    input       [31:0]   PCPlus4_MEM,
    input        [4:0]   writeAddress_MEM,
    output wire          regWrite_WB,
    output wire  [1:0]   resultSrc_WB,
    output wire [31:0]   ALUResult_WB,
    output wire [31:0]   loadOut_WB,
    output wire [31:0]   immOut_WB,
    output wire [31:0]   PCPlus4_WB,
    output wire  [4:0]   writeAddress_WB
);

reg        regWrite;
reg  [1:0] resultSrc;
reg [31:0] ALUResult;
reg [31:0] loadOut;
reg [31:0] immOut;
reg [31:0] PCPlus4;
reg  [4:0] writeAddress;

always @(posedge clk) begin
    regWrite        <= regWrite_MEM;
    resultSrc       <= resultSrc_MEM;
    ALUResult       <= ALUResult_MEM;
    loadOut         <= loadOut_MEM;
    immOut          <= immOut_MEM;
    PCPlus4         <= PCPlus4_MEM;
    writeAddress    <= writeAddress_MEM;
    
end

assign regWrite_WB      = regWrite;
assign resultSrc_WB     = resultSrc;
assign ALUResult_WB     = ALUResult;
assign loadOut_WB       = loadOut;
assign immOut_WB        = immOut;
assign PCPlus4_WB       = PCPlus4;
assign writeAddress_WB  = writeAddress;

endmodule