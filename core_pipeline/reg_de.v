module regDecodeExecute (
    input              clk,
    input              clr,
    input        [5:0] branch_ID,
    input              jump_ID,
    input              regWrite_ID,
    input              ASrc_ID,
    input              BSrc_ID,
    input              PCTargetSrc_ID,
    input        [3:0] ALUControl_ID,
    input              memWrite_ID,
    input        [1:0] resultSrc_ID,
    input        [1:0] DQM_ID,
    input        [2:0] funct3_ID,
    input       [31:0] readData1_ID,
    input       [31:0] readData2_ID,
    input       [31:0] immOut_ID,
    input        [4:0] readAddress1_ID,
    input        [4:0] readAddress2_ID,
    input        [4:0] writeAddress_ID,
    input       [31:0] PC_ID,
    input       [31:0] PCPlus4_ID,
    output wire  [5:0] branch_EX,
    output wire        jump_EX,
    output wire        regWrite_EX,
    output wire        ASrc_EX,
    output wire        BSrc_EX,
    output wire        PCTargetSrc_EX,
    output wire  [3:0] ALUControl_EX,
    output wire        memWrite_EX,
    output wire  [1:0] resultSrc_EX,
    output wire  [1:0] DQM_EX,
    output wire  [2:0] funct3_EX,
    output wire [31:0] readData1_EX,
    output wire [31:0] readData2_EX,
    output wire [31:0] immOut_EX,
    output wire  [4:0] readAddress1_EX,
    output wire  [4:0] readAddress2_EX,
    output wire  [4:0] writeAddress_EX,
    output wire [31:0] PC_EX,
    output wire [31:0] PCPlus4_EX
);

reg  [5:0] branch;
reg        jump;
reg        regWrite;
reg        ASrc;
reg        BSrc;
reg        PCTargetSrc;
reg  [3:0] ALUControl;
reg        memWrite;
reg  [1:0] resultSrc;
reg  [1:0] DQM;
reg  [2:0] funct3;
reg [31:0] readData1;
reg [31:0] readData2;
reg [31:0] immOut;
reg  [4:0] readAddress1;
reg  [4:0] readAddress2;
reg  [4:0] writeAddress;
reg [31:0] PC;
reg [31:0] PCPlus4;

always @(posedge clk) begin
    if (clr == 1'b1) begin
        branch          <= 6'b00000;
        jump            <= 1'b0;
        regWrite        <= 1'b0;
        ASrc            <= 1'b0;
        BSrc            <= 1'b0;
        PCTargetSrc     <= 1'b0;
        ALUControl      <= 4'b0000;
        memWrite        <= 1'b0;
        resultSrc       <= 2'b00;
        DQM             <= 2'b00;
        funct3          <= 3'b000;
        readData1       <= 32'h00000000;
        readData2       <= 32'h00000000;
        immOut          <= 32'h00000000;
        readAddress1    <= 5'b00000;
        readAddress2    <= 5'b00000;
        writeAddress    <= 5'b00000;
        PC              <= 32'h00000000;
        PCPlus4         <= 32'h00000000;
    end else begin
        branch          <= branch_ID;
        jump            <= jump_ID;
        regWrite        <= regWrite_ID;
        ASrc            <= ASrc_ID;
        BSrc            <= BSrc_ID;
        PCTargetSrc     <= PCTargetSrc_ID;
        ALUControl      <= ALUControl_ID;
        memWrite        <= memWrite_ID;
        resultSrc       <= resultSrc_ID;
        DQM             <= DQM_ID;
        funct3          <= funct3_ID;
        readData1       <= readData1_ID;
        readData2       <= readData2_ID;
        immOut          <= immOut_ID;
        readAddress1    <= readAddress1_ID;
        readAddress2    <= readAddress2_ID;
        writeAddress    <= writeAddress_ID;
        PC              <= PC_ID;
        PCPlus4         <= PCPlus4_ID;
    end
end

assign branch_EX        = branch;
assign jump_EX          = jump;
assign regWrite_EX      = regWrite;
assign ASrc_EX          = ASrc;
assign BSrc_EX          = BSrc;
assign PCTargetSrc_EX   = PCTargetSrc;
assign ALUControl_EX    = ALUControl;
assign memWrite_EX      = memWrite;
assign resultSrc_EX     = resultSrc;
assign DQM_EX           = DQM;
assign funct3_EX        = funct3;
assign readData1_EX     = readData1;
assign readData2_EX     = readData2;
assign immOut_EX        = immOut;
assign readAddress1_EX  = readAddress1;
assign readAddress2_EX  = readAddress2;
assign writeAddress_EX  = writeAddress;
assign PC_EX            = PC;
assign PCPlus4_EX       = PCPlus4;

endmodule