module regFetch (
    input              clk,
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

always @(posedge clk) begin
    instr   <= instr_IF;
    PC      <= PC_IF;
    PCPlus4 <= PCPlus4_IF;
end

assign instr_ID     = instr;
assign PC_ID        = PC;
assign PCPlus4_ID   = PCPlus4;

endmodule