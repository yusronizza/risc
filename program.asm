/* Initialize Registers */
lui x1, 0x12345         
lui x2, 0x67890        
addi x3, x0, 10       
addi x4, x0, -5        
addi x5, x0, 0         

/* Arithmetic Operations (R-type) */
add x6, x1, x2 
sub x7, x6, x2         
sll x8, x3, x4         
slt x9, x4, x3          
sltu x10, x4, x3       
xor x11, x1, x2        
srl x12, x11, x3        
sra x13, x11, x3        
or x14, x1, x2          
and x15, x1, x2         

/* Immediate Operations (I-type) */
addi x16, x3, 5         
slti x17, x4, 0         
sltiu x18, x4, 0        
xori x19, x1, 0xFF    
ori x20, x2, 0x0F     
andi x21, x2, 0xFF    
slli x22, x3, 2         
srli x23, x3, 1         
srai x24, x3, 1         

/* Memory Operations (S-type) */
sw x6, 0(x5)            
sh x7, 2(x5)            
sb x8, 4(x5)            

/* Branch Operations (B-type) */
beq x3, x3, 0x2
add x0, x0, x0
bne x3, x4, 0x2
add x0, x0, x0
blt x4, x3, 0x2
add x0, x0, x0
bge x3, x4, 0x2
add x0, x0, x0
bltu x4, x3, 0x2
add x0, x0, x0
bgeu x3, x4, 0x2    

/* Upper Immediate Operations (U-type) */
lui x25, 0xABCDE        
auipc x26, 0x1000       

/* Jump Operations (J-type) */
jal x27, 0x4        
jalr x28, 0(x1)         

/* Branch Labels */
addi x30, x0, 1     
addi x31, x0, 2     
addi x30, x0, 3     
addi x31, x0, 4     
addi x30, x0, 5     
addi x31, x0, 6     
addi x29, x0, 99