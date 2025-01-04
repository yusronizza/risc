module hazardUnit (
    //Decode stage signal
    input [4:0]         readAddress1_ID,
    input [4:0]         readAddress2_ID,
    //Execute stage signal
    input [1:0]         PCNextSrc_EX,
    input [4:0]         readAddress1_EX,
    input [4:0]         readAddress2_EX,
    input [4:0]         writeAddress_EX,
    input [1:0]         resultSrc_EX,
    //Memory stage signal
    input [4:0]         writeAddress_MEM,
    input               regWrite_MEM,
    //Writeback stage signal
    input [4:0]         writeAddress_WB,
    input               regWrite_WB,
    //Fetch stage register control
    output wire         stall_IF,
    //Decode stage register control
    output wire         flush_ID,
    output wire         stall_ID,
    //Execute stage register control
    output wire         flush_EX,
    output reg [1:0]    AFwdSrc_EX,
    output reg [1:0]    BFwdSrc_EX
);

/*Data Forwarding*/

always @* begin
    if (((readAddress1_EX == writeAddress_MEM) & regWrite_MEM) & (readAddress1_EX != 0)) begin
        AFwdSrc_EX = 2'b01;
    end
    else if (((readAddress1_EX == writeAddress_WB) & regWrite_WB) & (readAddress1_EX != 0)) begin
        AFwdSrc_EX = 2'b10;
    end
    else begin 
        AFwdSrc_EX = 2'b00;
    end
end

always @* begin
    if (((readAddress2_EX == writeAddress_MEM) & regWrite_MEM) & (readAddress2_EX != 0)) begin
        BFwdSrc_EX = 2'b01;
    end
    else if (((readAddress2_EX == writeAddress_WB) & regWrite_WB) & (readAddress2_EX != 0)) begin
        BFwdSrc_EX = 2'b10;
    end
    else begin 
        BFwdSrc_EX = 2'b00;
    end
end

/*Stall instruction*/
reg lwStall;

always @(*) begin
    if ((resultSrc_EX == 2'b01) & ((readAddress1_ID == writeAddress_EX)|(readAddress2_ID == writeAddress_EX))) begin
        lwStall = 1'b1;
    end
    else begin
        lwStall = 1'b0;
    end
end

assign stall_IF = lwStall;
assign stall_ID = lwStall;
// assign flush_EX = lwStall;

//Control Hazard
assign flush_ID = PCNextSrc_EX;
assign flush_EX = lwStall | PCNextSrc_EX;

endmodule