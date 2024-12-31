module ALU (
    input wire  [31:0]      srcA,
    input wire  [31:0]      srcB,
    input wire  [3:0]       ALUControl,
    output reg  [31:0]      ALUResult,
    output wire [3:0]       flags
);

// Operation List needed by Instruction
localparam ADD  = 4'b0000;
localparam SUB  = 4'b0001;
localparam AND  = 4'b0010;
localparam OR   = 4'b0011;
localparam SLT  = 4'b0100;
localparam SLL  = 4'b0101;
localparam SLTU = 4'b0110;
localparam XOR  = 4'b0111;
localparam SRL  = 4'b1000;
localparam SRA  = 4'b1001;

// Flag List
wire flag_N;
wire flag_Z;
wire flag_C;
wire flag_V;

// Wire for operation result
wire [32:0] a_sum_b;
wire carry_out;
wire [32:0] a_sub_b;
wire borrow_in;
wire [31:0] a_and_b;
wire [31:0] a_or_b;
wire [31:0] a_slt_b;
wire [31:0] a_sll_b;
wire [31:0] a_sltu_b;
wire [31:0] a_xor_b;
wire [31:0] a_srl_b;
wire [31:0] a_sra_b;
wire [32:0] mux_out;;

// Perform operation
assign a_sum_b      = srcA + srcB;
assign carry_out    = a_sum_b[32];
assign a_sub_b      = {1'b1, srcA} + {1'b0, ~srcB} + 32'h00000001;
assign borrow_in    = a_sub_b[32];
assign a_and_b      = srcA & srcB;
assign a_or_b       = srcA | srcB;
assign a_slt_b      = {30'b000000000000000000000000000000, (a_sum_b[31] ^ flag_V)};
assign a_sll_b      = srcA << srcB[4:0];
assign a_sltu_b     = {30'b000000000000000000000000000000, ((a_sum_b[31] == 1'b0) ? 1'b1 : 1'b0)} ;
assign a_xor_b      = srcA ^ srcB;
assign a_srl_b      = srcA >> srcB[4:0];
assign a_sra_b      = srcA >>> srcB[4:0];

/* MUX to select correct result */
always @* begin
    case (ALUControl)
        ADD     : ALUResult = a_sum_b[31:0];
        SUB     : ALUResult = a_sub_b[31:0];
        AND     : ALUResult = a_and_b;
        OR      : ALUResult = a_or_b;
        SLT     : ALUResult = a_slt_b;
        SLL     : ALUResult = a_sll_b;
        SLTU    : ALUResult = a_sltu_b;
        XOR     : ALUResult = a_xor_b;
        SRL     : ALUResult = a_srl_b;
        SRA     : ALUResult = a_sra_b;
        default : ALUResult = 32'h00000000;
    endcase
end

// Operation for assigning the flags
assign flag_N       = (ALUControl == ADD) ? ALUResult[31] :
                      (ALUControl == SUB) ? ALUResult[31] :
                      (ALUControl == SLT) ? ALUResult[31] :
                      (ALUControl == SRA) ? ALUResult[31] : 1'b0;
assign flag_Z       = &(~ALUResult);
assign flag_C       = (ALUControl == ADD) ? carry_out :
                      (ALUControl == SUB) ? ~borrow_in : 1'b0;
assign flag_V       = (~ALUControl[1]) & (srcA[31] ^ a_sum_b[31]) & (~(ALUControl[0] ^ srcA[31] ^ srcB[31]));

// Concat the final flags and MUX for the final ALU result
assign flags        = {flag_N, flag_Z, flag_C, flag_V};

endmodule