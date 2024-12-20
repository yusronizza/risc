module registerFile (
    input wire          clk,                // Clock signal
    input wire          rst,                // Reset signal
    input wire  [4:0]   readAddress1,       // A0
    input wire  [4:0]   readAddress2,       // A1
    input wire  [4:0]   writeAddress,       // A3
    input               writeEnable,        // WE3
    input wire  [31:0]  writeData,          // WD3
    output wire [31:0]  readData1,          // RD1
    output wire [31:0]  readData2           // RD2
);

// Create 32 address of register
reg [31:0] registers [0:31];

/*
 * Combinational Circuit
 * Assign output to related address
*/

assign readData1 = registers[readAddress1];
assign readData2 = registers[readAddress2];

/*
 * Sequential Circuit
 * Write data to registers[writeAddress] when Write Enable on
*/

always @(posedge clk or posedge rst) begin
    if (rst == 1'b1) begin
        registers[0] <= 32'h00000000;
        registers[1] <= 32'h00000000;
        registers[2] <= 32'h00000000;
        registers[3] <= 32'h00000000;
        registers[4] <= 32'h00000000;
        registers[5] <= 32'h00000000;
        registers[6] <= 32'h00000000;
        registers[7] <= 32'h00000000;
        registers[8] <= 32'h00000000;
        registers[9] <= 32'h00000000;
        registers[10] <= 32'h00000000;
        registers[11] <= 32'h00000000;
        registers[12] <= 32'h00000000;
        registers[13] <= 32'h00000000;
        registers[14] <= 32'h00000000;
        registers[15] <= 32'h00000000;
        registers[16] <= 32'h00000000;
        registers[17] <= 32'h00000000;
        registers[18] <= 32'h00000000;
        registers[19] <= 32'h00000000;
        registers[20] <= 32'h00000000;
        registers[21] <= 32'h00000000;
        registers[22] <= 32'h00000000;
        registers[23] <= 32'h00000000;
        registers[24] <= 32'h00000000;
        registers[25] <= 32'h00000000;
        registers[26] <= 32'h00000000;
        registers[27] <= 32'h00000000;
        registers[28] <= 32'h00000000;
        registers[29] <= 32'h00000000;
        registers[30] <= 32'h00000000;
        registers[31] <= 32'h00000000;
    end
    else if (writeEnable == 1'b1) begin
        registers[writeAddress] <= writeData;
    end
    else begin
        registers[0] <= 32'h00000000;
    end
end

endmodule