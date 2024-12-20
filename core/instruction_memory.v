module instructionMemory(
    input wire  [31:0]  readAddress,
    output wire [31:0]  readData
);

reg [31:0] registers [0:(2**32)-1];
assign readData = registers[readAddress];

endmodule