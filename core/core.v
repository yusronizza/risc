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

/* Constant 4 For PC Counter Plus 4*/
// wire [31:0] constant4 = 32'b00000000_00000000_00000000_00000100;
wire [31:0] constant4 = 32'b00000000_00000000_00000000_00000001;

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
wire  [3:0] ALUFlags;
wire [31:0] storeAlignOut;
wire [31:0] loadExtendOut;
wire [31:0] readDataMemory;
wire [31:0] PCTarget;
wire [31:0] opPCTarget;
wire [31:0] writeDataRegister;

controlUnit controlUnit (
    .OPCode        (instr[6:0]), 
    .funct3        (instr[14:12]),
    .funct75       (instr[30]),
    .ALUFlags      (ALUFlags),
    .regWrite      (regWrite),
    .immSource     (immSource),
    .loadCtrl      (loadCtrl),
    .storeCtrl     (storeCtrl),
    .srcAIn        (srcAIn),
    .srcBIn        (srcBIn),
    .resultSource  (resultSrc),
    .memWrite      (memWrite),
    .PCNextIn      (PCNextIn),
    .srcPCTarget   (srcPCTarget),
    .ALUControl    (ALUControl)
);

mux2x1 PCNextInMux (
    .sel (PCNextIn),
    .inA (PCPlus4),
    .inB (PCTarget),
    .out (PCNext)
);

programCounter programCounter (
    .clk    (clk),
    .rst    (rst),
    .PCNext (PCNext),
    .PC     (PC)
);

instructionMemory instructionMemory (
    .readAddress (PC),
    .readData    (instr)
);

adder PCPlus4Adder (
    .inA (PC),
    .inB (constant4),
    .out (PCPlus4)
);

registerFile registerFile (
    .clk            (clk),
    .rst            (rst),
    .readAddress1   (instr[19:15]),
    .readAddress2   (instr[24:20]),
    .writeAddress   (instr[11:7]),
    .writeEnable    (regWrite),
    .writeData      (writeDataRegister),
    .readData1      (registerData1),
    .readData2      (registerData2)
);

immExt immExt (
    .immSrc (immSrc),
    .instr  (instr),
    .immOut (immExtended)
);

mux2x1 srcAmux (
    .sel (srcAIn),
    .inA (PC),
    .inB (registerData1),
    .out (ALUDataA)
);

mux2x1 srcBmux (
    .sel (srcBIn),
    .inA (registerData2),
    .inB (immExtended),
    .out (ALUDataB)
);

mux2x1 srcPCmux (
    .sel (srcPCTarget),
    .inA (registerData1),
    .inB (PC),
    .out (opPCTarget)
);

storeExt storeAlign (
    .storeCtrl  (StoreCtrl),
    .dataMem    (registerData2),
    .dataExt    (storeAlignOut)
);

ALU ALU (
    .srcA       (ALUDataA),
    .srcB       (ALUDataB),
    .ALUControl (ALUControl),
    .ALUResult  (ALUResult),
    .flags      (ALUFlags)
);

adder PCTargetAdder (
    .inA (opPCTarget),
    .inB (immExtended),
    .out (PCTarget)
);

dataMemory dataMemory (
    .clk            (clk),
    .rst            (rst),
    .readAddress    (ALUResult),
    .writeEnable    (memWrite),
    .writeData      (storeAlignOut),
    .readData       (readDataMemory)
);

loadExt loadExt (
    .loadCtrl   (loadCtrl),
    .dataMem    (readDataMemory),
    .dataExt    (loadExtendOut)
);

mux4x1 resultSrcmux (
    .sel (resultSrc),
    .inA (ALUResult),
    .inB (loadExtendOut),
    .inC (immExtended),
    .inD (PCPlus4),
    .out (writeDataRegister)
);

endmodule