module dataMemory (
    input wire              clk,
    input wire              rst,
    input wire  [31:0]      readAddress,
    input wire              writeEnable,
    input wire  [31:0]      writeData,
    input        [1:0]      DQM,
    output wire [31:0]      readData
);

reg [31:0] registers [0:1000];
assign readData = registers[readAddress];

localparam BYTE = 2'b00;
localparam HALF = 2'b01;
localparam WORD = 2'b10;

integer i;

initial begin
    for (i = 0; i < 1000; i = i + 1) begin
        registers[i] <= 32'h00000000;
    end
end

always @(posedge clk or posedge rst) begin
    if (rst == 1'b1) begin
        for (i = 0; i < 1000; i = i + 1) begin
            registers[i] <= 32'h00000000;
        end
    end
    else begin
        if (writeEnable == 1'b1) begin
            case (DQM)
                BYTE: registers[readAddress][7:0]  <= writeData[7:0];
                HALF: registers[readAddress][15:0] <= writeData[15:0];
                WORD: registers[readAddress]       <= writeData;
            endcase
        end
        else begin
            registers[readAddress] <= registers[readAddress];
        end
    end
end

endmodule