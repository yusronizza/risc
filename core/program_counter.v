module program_counter (
    input wire          clk,
    input wire          rst,
    input wire [31:0]   PCNext,
    output reg [31:0]   PC
);

always @(posedge clk or posedge rst) begin
    if (rst == 1'b1) begin
        PC <= 32'h00000000;
    end else begin
        PC <= PCNext;
    end
end

endmodule