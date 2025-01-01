module hazardUnit (
    //Decode stage signal
    input [4:0]     readAddress1_ID,
    input [4:0]     readAddress2_ID,
    //Execute stage signal
    input [1:0]     PCNextSrc_EX,
    input [4:0]     readAddress1_EX,
    input [4:0]     readAddress2_EX,
    input [4:0]     writeAddress_EX,
    input [1:0]     resultSrc_EX,
    //Memory stage signal
    input [4:0]     writeAddress_MEM,
    input           regWrite_MEM,
    //Writeback stage signal
    input [4:0]     writeAddress_WB,
    input           regWrite_WB,
    //Fetch stage register control
    output          stall_IF,
    //Decode stage register control
    output          flush_ID,
    output          stall_ID,
    //Execute stage register control
    output          flush_EX,
    output [1:0]    AFwdSrc_EX,
    output [1:0]    BFwdSrc_EX
);

endmodule