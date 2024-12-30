module mux2x1(
    input               sel,
    input       [31:0]  inA,
    input       [31:0]  inB,
    output  reg [31:0]  out
);

always @* begin
    case (sel)
        1'b0: out = inA;
        1'b1: out = inB;
    endcase
end

endmodule