module mux3x1(
    input        [1:0]  sel,
    input       [31:0]  inA,
    input       [31:0]  inB,
    input       [31:0]  inC,
    output  reg [31:0]  out
);

always @* begin
    case (sel)
        2'b00: out = inA;
        2'b01: out = inB;
        2'b10: out = inC;
    endcase
end

endmodule