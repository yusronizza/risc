module dataMemory #(
    parameter MEM_DEPTH = 1000
)
(
    input wire              clk,
    input wire              rst,
    input wire  [31:0]      readAddress,
    input wire              writeEnable,
    input wire  [31:0]      writeData,
    output wire [31:0]      readData
);
integer i;
reg [31:0] registers [0:MEM_DEPTH];

assign readData = registers[readAddress];

always @(posedge clk or posedge rst) begin
    if (rst == 1'b1) begin
        //On reset make all value to 0
        for (i = 0; i < MEM_DEPTH; i = i + 1) begin
            registers[i] <= 32'h00000000;
        end
    end
    else begin
        if (writeEnable == 1'b1) begin
            registers[readAddress] <= writeData;
        end
        else begin
            registers[readAddress] <= registers[readAddress];
        end
    end
end

endmodule