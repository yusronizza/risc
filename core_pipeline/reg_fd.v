module regFetchDecode (
    input              clk,
    input              rst,
    input              en,
    input              clr,
    input       [31:0] instr_IF,
    input       [31:0] PC_IF,
    input       [31:0] PCPlus4_IF,
    output wire [31:0] instr_ID,
    output wire [31:0] PC_ID,
    output wire [31:0] PCPlus4_ID
);

reg [31:0] instr;
reg [31:0] PC;
reg [31:0] PCPlus4;

initial begin
    instr       <= 32'h00000000;
    PC          <= 32'h00000000;
    PCPlus4     <= 32'h00000000;
end

always @(posedge clk or posedge rst) begin
    if ((clr == 1'b1) | (rst == 1'b1)) begin
        instr   <= 32'h00000000;
        PC      <= 32'h00000000;
        PCPlus4 <= 32'h00000000;
    end
    else begin
        if (en == 1'b1) begin
            instr   <= instr;
            PC      <= PC;
            PCPlus4 <= PCPlus4;
        end
        else begin
            instr   <= instr_IF;
            PC      <= PC_IF;
            PCPlus4 <= PCPlus4_IF;
        end
    end
end

assign instr_ID     = instr;
assign PC_ID        = PC;
assign PCPlus4_ID   = PCPlus4;

endmodule