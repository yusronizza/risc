module core (
    input wire clk,
    input wire rst
);

/*Control signal*/
wire        regWrite;	
wire [2:0]  immSrc;
wire [2:0]  loadCtrl;
wire [1:0]  storeCtrl;
wire        srcAIn;
wire        srcBIn;
wire [1:0]  resultSrc;
wire        memWrite;
wire        PCNextIn;
wire        srcPCTarget;
wire [3:0]  ALUControl;


/*Operation signal*/
wire [31:0] PCNext;
wire [31:0] PC;
wire [31:0] PCPlus4;
wire [31:0] instr;
wire [31:0] registerData1;
wire [31:0] registerData2;
wire [31:0] ALUDataA;
wire [31:0] ALUDataB;
wire [31:0] immExtended;
wire [31:0] ALUResult;
wire [3:0]  ALUFlags;
wire [31:0] storeAlignOut;
wire [31:0] loadExtendOut;
wire [31:0] readDataMemory;
wire [31:0] PCTarget;
wire [31:0] opPCTarget;
wire [31:0] writeDataRegister;

endmodule