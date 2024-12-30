`timescale 1ns/1ps

module top_tb ();

reg  [5:0]      branch;
reg             jump;
reg  [31:0]     srcA;
reg  [31:0]     srcB;
reg  [3:0]      ALUControl;

wire [3:0]      ALUFlags;
wire            PCNextSrc;
wire [31:0]     ALUResult;

localparam ADD  = 4'b0000;
localparam SUB  = 4'b0001;
localparam AND  = 4'b0010;
localparam OR   = 4'b0011;
localparam SLT  = 4'b0100;
localparam SLL  = 4'b0101;
localparam SLTU = 4'b0110;
localparam XOR  = 4'b0111;
localparam SRL  = 4'b1000;
localparam SRA  = 4'b1001;

ALU ALU (
    .srcA       (srcA),
    .srcB       (srcB),
    .ALUControl (ALUControl),
    .ALUResult  (ALUResult),
    .flags       (ALUFlags)
);

branchJump branchJump(
    .branch     (branch),
    .jump       (jump),
    .ALUFlags   (ALUFlags),
    .PCNextSrc  (PCNextSrc)
);

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0);
    branch     = 6'b000000;
    jump       = 1'b0;
    srcA       = 32'd35;
    srcB       = 32'd35;
    ALUControl = ADD;
    #1;
    $finish;
end

endmodule