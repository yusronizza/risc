module branchJump (
    input [5:0] branch,
    input       jump,
    input [3:0] ALUFlags,
    output      PCNextSrc
);

// Assign each flag status individually
wire negative_flag  = ALUFlags[3];
wire zero_flag      = ALUFlags[2];
wire carry_flag     = ALUFlags[1];
wire overflow_flag  = ALUFlags[0];

/* Binary Comparison Logic*/
wire beq    = zero_flag & branch[5];
wire bne    = ((zero_flag == 1'b0) ? 1'b1 : 1'b0) & branch[4];
wire blt    = (negative_flag ^ overflow_flag) & branch[3];
wire bge    = (~(negative_flag ^ overflow_flag)) & branch[2];
wire bltu   = (~carry_flag) & branch[1];
wire bgeu   = (carry_flag) & branch[0];

// Jump Signal
wire jalr   = jump;
wire jal    = jump;

assign PCNextSrc = beq | bne | blt | bge | bltu | bgeu | jalr | jal ;

endmodule