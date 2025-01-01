module adder (
    input wire  [31:0] inA,
    input wire  [31:0] inB,
    output wire [31:0] out
    // output wire        overflow
);

wire [32:0] result;
assign result = inA + inB;
// assign overflow = result[32];
assign out    = result[31:0];

endmodule