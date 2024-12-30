`timescale 1ns / 1ps

module core (
    // input wire clk,
    // input wire rst
);

reg clk;
reg rst;

initial begin
    clk <= 1'b0;
    rst <= 1'b0;
    #1;
    forever begin
        #1;
        clk <= ~clk;
    end
end


wire [2:0]  funct3;
wire [6:0]  OPCode;
wire        funct75;
wire [4:0]  readAddress1;
wire [4:0]  readAddress2;
wire [4:0]  writeAddress;

/*Control signal*/
wire [5:0]  branch;
wire        jump;
wire        regWrite;	
wire [2:0]  immSrc;
wire        ASrc;
wire        BSrc;
wire        PCTargetSrc;
wire [3:0]  ALUControl;
wire        memWrite;
wire [1:0]  resultSrc;
wire [1:0]  DQM;
wire        PCNextSrc;

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
wire [31:0] immExtOut;
wire [31:0] ALUResult;
wire  [3:0] ALUFlags;
wire [31:0] storeOut;
wire [31:0] loadOut;
wire [31:0] memoryData;
wire [31:0] PCTarget;
wire [31:0] PCTargetOP;
wire [31:0] writeDataRegister;

/*Instruction Parser*/
assign funct3       = instr[14:12];
assign OPCode       = instr[6:0];
assign funct75      = instr[30];
assign readAddress1 = instr[19:15];
assign readAddress2 = instr[24:20];
assign writeAddress = instr[11:7];

controlUnit controlUnit (
    .OPCode         (OPCode), 
    .funct3         (funct3),
    .funct75        (funct75),
    .branch         (branch),
    .jump           (jump),
    .regWrite       (regWrite),
    .immSrc         (immSrc),
    .ASrc           (ASrc),
    .BSrc           (BSrc),
    .PCTargetSrc    (PCTargetSrc),
    .ALUControl     (ALUControl),
    .memWrite       (memWrite),
    .resultSrc      (resultSrc),
    .DQM            (DQM)  
);

branchJump branchJump (
    .branch         (branch),
    .jump           (jump),
    .ALUFlags       (ALUFlags),
    .PCNextSrc      (PCNextSrc)
);

mux2x1 PCNextMux (
    .sel            (PCNextSrc),
    .inA            (PCPlus4),
    .inB            (PCTarget),
    .out            (PCNext)
);

programCounter programCounter (
    .clk            (clk),
    .rst            (rst),
    .PCNext         (PCNext),
    .PC             (PC)
);

instructionMemory instructionMemory (
    .readAddress    (PC),
    .readData       (instr)
);

adder PCPlus4Adder (
    .inA            (PC),
    .inB            (constant4),
    .out            (PCPlus4)
);

registerFile registerFile (
    .clk            (clk),
    .rst            (rst),
    .readAddress1   (readAddress1),
    .readAddress2   (readAddress2),
    .writeAddress   (writeAddress),
    .writeEnable    (regWrite),
    .writeData      (writeDataRegister),
    .readData1      (registerData1),
    .readData2      (registerData2)
);

immExt immExt (
    .immSrc         (immSrc),
    .instr          (instr),
    .immOut         (immExtOut)
);

mux2x1 ASrcmux (
    .sel            (ASrc),
    .inA            (PC),
    .inB            (registerData1),
    .out            (ALUDataA)
);

mux2x1 BSrcmux (
    .sel            (BSrc),
    .inA            (registerData2),
    .inB            (immExtOut),
    .out            (ALUDataB)
);

mux2x1 PCTargetMux (
    .sel            (PCTargetSrc),
    .inA            (registerData1),
    .inB            (PC),
    .out            (PCTargetOP)
);

store store (
    .funct3         (funct3),
    .dataIn         (registerData2),
    .dataOut        (storeOut)
);

load load (
    .funct3         (funct3),
    .dataIn         (memoryData),
    .dataOut        (loadOut)
);

ALU ALU (
    .srcA           (ALUDataA),
    .srcB           (ALUDataB),
    .ALUControl     (ALUControl),
    .ALUResult      (ALUResult),
    .flags          (ALUFlags)
);

adder PCTargetAdder (
    .inA            (PCTargetOP),
    .inB            (immExtOut),
    .out            (PCTarget)
);

dataMemory dataMemory (
    .clk            (clk),
    .rst            (rst),
    .readAddress    (ALUResult),
    .writeEnable    (memWrite),
    .writeData      (storeOut),
    .DQM            (DQM),
    .readData       (memoryData)
);

mux4x1 resultSrcMux (
    .sel            (resultSrc),
    .inA            (ALUResult),
    .inB            (loadOut),
    .inC            (immExtOut),
    .inD            (PCPlus4),
    .out            (writeDataRegister)
);

endmodule