module programCounter (
    input wire          clk,
    input wire          rst,
    input wire          en,
    input wire [31:0]   PCNext,
    output reg [31:0]   PC
);

/* Set initial condition for program counter to 0*/
initial begin
    PC <= 32'h00000000;
end

always @(posedge clk or posedge rst) begin
    if (rst == 1'b1) begin
        PC <= 32'h00000000;
    end else if (en == 1'b1) begin
        PC <= PC;
    end else begin
        PC <= PCNext;
    end
end

endmodule