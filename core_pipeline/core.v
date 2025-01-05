`timescale 1ns / 1ps

module core ();

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

/******************/
/*FETCH STAGE WIRE*/
/******************/

wire [31:0] PCPlus4_IF;
wire [31:0] PCNext_IF;
wire [31:0] PC_IF;
wire [31:0] instr_IF;


/*******************/
/*DECODE STAGE WIRE*/
/*******************/

wire [31:0] instr_ID;

/*Decode Instruction Parser*/
wire [2:0]  funct3_ID           = instr_ID[14:12];
wire [6:0]  OPCode_ID           = instr_ID[6:0];
wire        funct75_ID          = instr_ID[30];
wire [4:0]  readAddress1_ID     = instr_ID[19:15];
wire [4:0]  readAddress2_ID     = instr_ID[24:20];
wire [4:0]  writeAddress_ID     = instr_ID[11:7];
wire [31:0] readData1_ID;
wire [31:0] readData2_ID;
wire [31:0] immOut_ID;
wire [31:0] PC_ID;
wire [31:0] PCPlus4_ID;

/*Decode Control Signal*/
wire [5:0]  branch_ID;
wire        jump_ID;
wire        regWrite_ID;
wire [2:0]  immSrc_ID;
wire        ASrc_ID;
wire        BSrc_ID;
wire        PCTargetSrc_ID;
wire [3:0]  ALUControl_ID;
wire        memWrite_ID;
wire [1:0]  resultSrc_ID;
wire [1:0]  DQM_ID;

/********************/
/*EXECUTE STAGE WIRE*/
/********************/

/*Execute Control Signal*/
wire        PCNextSrc_EX;
wire  [5:0] branch_EX;
wire        jump_EX;
wire        regWrite_EX;
wire        ASrc_EX;
wire        BSrc_EX;
wire        PCTargetSrc_EX;
wire  [3:0] ALUControl_EX;
wire        memWrite_EX;
wire  [1:0] resultSrc_EX;
wire  [1:0] DQM_EX;
wire  [2:0] funct3_EX;

wire [31:0] readData1_EX;
wire [31:0] readData2_EX;
wire [31:0] immOut_EX;
wire  [4:0] readAddress1_EX;
wire  [4:0] readAddress2_EX;
wire  [4:0] writeAddress_EX;
wire [31:0] PC_EX;
wire [31:0] PCPlus4_EX;

wire [31:0] ALUResult_EX;
wire  [3:0] ALUFlags_EX;
wire [31:0] storeOut_EX;
wire [31:0] PCTarget_EX;
wire [31:0] PCTargetOP_EX;

/**************************/
/*MEMORY ACCESS STAGE WIRE*/
/**************************/
wire        regWrite_MEM;
wire        memWrite_MEM;
wire [1:0]  resultSrc_MEM;
wire [1:0]  DQM_MEM;
wire [2:0]  funct3_MEM;
wire [31:0] ALUResult_MEM;
wire [31:0] storeOut_MEM;
wire [31:0] immOut_MEM;
wire  [4:0] writeAddress_MEM;
wire [31:0] PCPlus4_MEM;

wire [31:0] memoryData_MEM;
wire [31:0] loadOut_MEM;

/**********************/
/*WRITEBACK STAGE WIRE*/
/**********************/
wire        regWrite_WB;
wire  [1:0] resultSrc_WB;
wire [31:0] ALUResult_WB;
wire [31:0] loadOut_WB;
wire [31:0] immOut_WB;
wire [31:0] PCPlus4_WB;
wire [31:0] writeDataRegister_WB;
wire  [4:0] writeAddress_WB;

/****************************/
/*HAZARD UNIT CONTROL SIGNAL*/
/****************************/
wire stall_IF;
wire stall_ID;
wire flush_ID;
wire flush_EX;
wire [1:0] AFwdSrc_EX;
wire [1:0] BFwdSrc_EX;

/**********************/
/*MODULE INSTANTIATION*/
/**********************/

/* FETCH */
mux2x1 PCNextMux (
    .sel            (PCNextSrc_EX),
    .inA            (PCPlus4_IF),
    .inB            (PCTarget_EX),
    .out            (PCNext_IF)
);

programCounter programCounter (
    .clk            (clk),
    .rst            (rst),
    .en             (stall_IF),
    .PCNext         (PCNext_IF),
    .PC             (PC_IF)
);

instructionMemory instructionMemory (
    .readAddress    (PC_IF),
    .readData       (instr_IF)
);

/* Constant 4 For PC Counter Plus 4*/
// wire [31:0] constant4 = 32'b00000000_00000000_00000000_00000100;
wire [31:0] constant4 = 32'b00000000_00000000_00000000_00000001;

adder PCPlus4Adder (
    .inA            (PC_IF),
    .inB            (constant4),
    .out            (PCPlus4_IF)
);

regFetchDecode regFetchDecode (
    .clk            (clk),
    .rst            (rst),
    .en             (stall_ID),
    .clr            (flush_ID),
    .instr_IF       (instr_IF),
    .PC_IF          (PC_IF),
    .PCPlus4_IF     (PCPlus4_IF),
    .instr_ID       (instr_ID),
    .PC_ID          (PC_ID),
    .PCPlus4_ID     (PCPlus4_ID)
);

/* DECODE */
controlUnit controlUnit (
    .OPCode         (OPCode_ID), 
    .funct3         (funct3_ID),
    .funct75        (funct75_ID),
    .branch         (branch_ID),
    .jump           (jump_ID),
    .regWrite       (regWrite_ID),
    .immSrc         (immSrc_ID),
    .ASrc           (ASrc_ID),
    .BSrc           (BSrc_ID),
    .PCTargetSrc    (PCTargetSrc_ID),
    .ALUControl     (ALUControl_ID),
    .memWrite       (memWrite_ID),
    .resultSrc      (resultSrc_ID),
    .DQM            (DQM_ID)  
);

registerFile registerFile (
    .clk            (clk),
    .rst            (rst),
    .writeEnable    (regWrite_ID),
    .readAddress1   (readAddress1_ID),
    .readAddress2   (readAddress2_ID),
    .writeAddress   (writeAddress_ID),
    .writeData      (writeDataRegister_WB),
    .readData1      (readData1_ID),
    .readData2      (readData2_ID)
);

immExt immExt (
    .immSrc         (immSrc_ID),
    .instr          (instr_ID),
    .immOut         (immOut_ID)
);

regDecodeExecute regDecodeExecute (
    .clk                (clk),
    .clr                (flush_EX),
    .branch_ID          (branch_ID),
    .jump_ID            (jump_ID),
    .regWrite_ID        (regWrite_ID),
    .ASrc_ID            (ASrc_ID),
    .BSrc_ID            (BSrc_ID),
    .PCTargetSrc_ID     (PCTargetSrc_ID),
    .ALUControl_ID      (ALUControl_ID),
    .memWrite_ID        (memWrite_ID),
    .resultSrc_ID       (resultSrc_ID),
    .DQM_ID             (DQM_ID),
    .funct3_ID          (funct3_ID),
    .readData1_ID       (readData1_ID),
    .readData2_ID       (readData2_ID),
    .immOut_ID          (immOut_ID),
    .readAddress1_ID    (readAddress1_ID),
    .readAddress2_ID    (readAddress2_ID),
    .writeAddress_ID    (writeAddress_ID),
    .PC_ID              (PC_ID),
    .PCPlus4_ID         (PCPlus4_ID),
    .branch_EX          (branch_EX),
    .jump_EX            (jump_EX),
    .regWrite_EX        (regWrite_EX),
    .ASrc_EX            (ASrc_EX),
    .BSrc_EX            (BSrc_EX),
    .PCTargetSrc_EX     (PCTargetSrc_EX),
    .ALUControl_EX      (ALUControl_EX),
    .memWrite_EX        (memWrite_EX),
    .resultSrc_EX       (resultSrc_EX),
    .DQM_EX             (DQM_EX),
    .funct3_EX          (funct3_EX),
    .readData1_EX       (readData1_EX),
    .readData2_EX       (readData2_EX),
    .immOut_EX          (immOut_EX),
    .readAddress1_EX    (readAddress1_EX),
    .readAddress2_EX    (readAddress2_EX),
    .writeAddress_EX    (writeAddress_EX),
    .PC_EX              (PC_EX),
    .PCPlus4_EX         (PCPlus4_EX)
);

/* EXECUTE */
branchJump branchJump (
    .branch         (branch_EX),
    .jump           (jump_EX),
    .ALUFlags       (ALUFlags_EX),
    .PCNextSrc      (PCNextSrc_EX)
);

wire [31:0] AFwdOut_EX;
mux3x1 AFwdMux (
    .sel            (AFwdSrc_EX),
    .inA            (readData1_EX),
    .inB            (ALUResult_MEM),
    .inC            (writeDataRegister_WB),
    .out            (AFwdOut_EX)
);

wire [31:0] BFwdOut_EX;
mux3x1 BFwdMux (
    .sel            (BFwdSrc_EX),
    .inA            (readData2_EX),
    .inB            (ALUResult_MEM),
    .inC            (writeDataRegister_WB),
    .out            (BFwdOut_EX)
);

wire [31:0] ALUDataA_EX;
mux2x1 ASrcmux (
    .sel            (ASrc_EX),
    .inA            (PC_EX),
    .inB            (AFwdOut_EX),
    .out            (ALUDataA_EX)
);

wire [31:0] ALUDataB_EX;
mux2x1 BSrcmux (
    .sel            (BSrc_EX),
    .inA            (BFwdOut_EX),
    .inB            (immOut_EX),
    .out            (ALUDataB_EX)
);

mux2x1 PCTargetMux (
    .sel            (PCTargetSrc_EX),
    .inA            (AFwdOut_EX),
    .inB            (PC_EX),
    .out            (PCTargetOP_EX)
);

ALU ALU (
    .srcA           (ALUDataA_EX),
    .srcB           (ALUDataB_EX),
    .ALUControl     (ALUControl_EX),
    .ALUResult      (ALUResult_EX),
    .flags          (ALUFlags_EX)
);

store store (
    .funct3         (funct3_EX),
    .dataIn         (BFwdOut_EX),
    .dataOut        (storeOut_EX)
);

adder PCTargetAdder (
    .inA            (PCTargetOP_EX),
    .inB            (immOut_EX),
    .out            (PCTarget_EX)
);

regExecuteMemory regExecuteMemory (
    .clk                (clk),
    .regWrite_EX        (regWrite_EX),
    .memWrite_EX        (memWrite_EX),
    .resultSrc_EX       (resultSrc_EX),
    .DQM_EX             (DQM_EX),
    .funct3_EX          (funct3_EX),
    .ALUResult_EX       (ALUResult_EX),
    .storeOut_EX        (storeOut_EX),
    .immOut_EX          (immOut_EX),
    .writeAddress_EX    (writeAddress_EX),
    .PCPlus4_EX         (PCPlus4_EX),
    .regWrite_MEM       (regWrite_MEM),
    .memWrite_MEM       (memWrite_MEM),
    .resultSrc_MEM      (resultSrc_MEM),
    .DQM_MEM            (DQM_MEM),
    .funct3_MEM         (funct3_MEM),
    .ALUResult_MEM      (ALUResult_MEM),
    .storeOut_MEM       (storeOut_MEM),
    .immOut_MEM         (immOut_MEM),
    .writeAddress_MEM   (writeAddress_MEM),
    .PCPlus4_MEM        (PCPlus4_MEM)
);

/* MEMORY ACCESS */
dataMemory dataMemory (
    .clk            (clk),
    .rst            (rst),
    .readAddress    (ALUResult_MEM),
    .writeEnable    (memWrite_MEM),
    .writeData      (storeOut_MEM),
    .DQM            (DQM_MEM),
    .readData       (memoryData_MEM)
);

load load (
    .funct3         (funct3_MEM),
    .dataIn         (memoryData_MEM),
    .dataOut        (loadOut_MEM)
);

regMemoryWriteback regMemoryWriteback (
    .clk                    (clk),
    .regWrite_MEM           (regWrite_MEM),
    .resultSrc_MEM          (resultSrc_MEM),
    .ALUResult_MEM          (ALUResult_MEM),
    .loadOut_MEM            (loadOut_MEM),
    .immOut_MEM             (immOut_MEM),
    .PCPlus4_MEM            (PCPlus4_MEM),
    .writeAddress_MEM       (writeAddress_MEM),
    .regWrite_WB            (regWrite_WB),
    .resultSrc_WB           (resultSrc_WB),
    .ALUResult_WB           (ALUResult_WB),
    .loadOut_WB             (loadOut_WB),
    .immOut_WB              (immOut_WB),
    .PCPlus4_WB             (PCPlus4_WB),
    .writeAddress_WB        (writeAddress_WB)
);

/* WRITEBACK */
mux4x1 resultSrcMux (
    .sel            (resultSrc_WB),
    .inA            (ALUResult_WB),
    .inB            (loadOut_WB),
    .inC            (immOut_WB),
    .inD            (PCPlus4_WB),
    .out            (writeDataRegister_WB)
);

/*HAZARD UNIT*/
hazardUnit hazardUnit (
    .readAddress1_ID    (readAddress1_ID),
    .readAddress2_ID    (readAddress2_ID),
    .PCNextSrc_EX       (PCNextSrc_EX),
    .readAddress1_EX    (readAddress1_EX),
    .readAddress2_EX    (readAddress2_EX),
    .writeAddress_EX    (writeAddress_EX),
    .resultSrc_EX       (resultSrc_EX),
    .writeAddress_MEM   (writeAddress_MEM),
    .regWrite_MEM       (regWrite_MEM),
    .writeAddress_WB    (writeAddress_WB),
    .regWrite_WB        (regWrite_WB),
    .stall_IF           (stall_IF),
    .flush_ID           (flush_ID),
    .stall_ID           (stall_ID),
    .flush_EX           (flush_EX),
    .AFwdSrc_EX         (AFwdSrc_EX),
    .BFwdSrc_EX         (BFwdSrc_EX)
);

endmodule