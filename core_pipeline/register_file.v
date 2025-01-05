module registerFile (
    input               clk,
    input               rst,
    input               writeEnable,
    input wire  [4:0]   readAddress1,
    input wire  [4:0]   readAddress2,
    input wire  [4:0]   writeAddress,
    input wire  [31:0]  writeData,
    output wire [31:0]  readData1,
    output wire [31:0]  readData2
);

/*  Create 32 address of register
 *  zero    = x0     -> Constant value 0
 *  ra      = x1     -> Return address
 *  sp      = x2     -> Stack pointer
 *  gp      = x3     -> Global pointer
 *  tp      = x4     -> Thread pointer
 *  t0–2    = x5–7   -> Temporary registers
 *  s0/fp   = x8     -> Saved register / Frame pointer
 *  s1      = x9     -> Saved register
 *  a0–1    = x10–11 -> Function arguments / Return values
 *  a2–7    = x12–17 -> Function arguments
 *  s2–11   = x18–27 -> Saved registers
 *  t3-6    = x28–31 -> Temporary registers
*/

reg [31:0] registers [0:31];
integer m;
initial begin
    $readmemh("register.mem", registers);
    for (m = 0; m < 32; m = m + 1) begin
        $monitor ("Register %0h = 0x%0h time=%0t", m, registers[m], $time);
    end
end

// /* Assign initial value just for simulation */
// initial begin
//     registers[0] <= 32'h00000000;
//     registers[1] <= 32'h00000000;
//     registers[2] <= 32'h00000000;
//     registers[3] <= 32'h00000000;
//     registers[4] <= 32'h00000000;
//     registers[5] <= 32'h00000000;
//     registers[6] <= 32'h00000000;
//     registers[7] <= 32'h00000000;
//     registers[8] <= 32'h00000000;
//     registers[9] <= 32'h00000000;
//     registers[10] <= 32'h00000000;
//     registers[11] <= 32'h00000000;
//     registers[12] <= 32'h00000000;
//     registers[13] <= 32'h00000000;
//     registers[14] <= 32'h00000000;
//     registers[15] <= 32'h00000000;
//     registers[16] <= 32'h00000000;
//     registers[17] <= 32'h00000000;
//     registers[18] <= 32'h00000000;
//     registers[19] <= 32'h00000000;
//     registers[20] <= 32'h00000000;
//     registers[21] <= 32'h00000000;
//     registers[22] <= 32'h00000000;
//     registers[23] <= 32'h00000000;
//     registers[24] <= 32'h00000000;
//     registers[25] <= 32'h00000000;
//     registers[26] <= 32'h00000000;
//     registers[27] <= 32'h00000000;
//     registers[28] <= 32'h00000000;
//     registers[29] <= 32'h00000000;
//     registers[30] <= 32'h00000000;
//     registers[31] <= 32'h00000000;
// end

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
integer i;

always @(negedge clk or posedge rst) begin
    if (rst == 1'b1) begin
        for (i = 0 ; i < 32 ; i = i + 1 ) begin
            registers[i] <= 32'h00000000;
        end
    end
    else if (writeEnable == 1'b1) begin
        registers[writeAddress] <= writeData;
    end
    else begin
        registers[0] <= 32'h00000000;
    end
end

endmodule