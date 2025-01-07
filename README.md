# 🚀 RISC-V 32-Bit Processor Design  

A **custom-designed RISC-V 32-bit processor**, developed from scratch using Verilog HDL, implementing the core functionalities of the RISC-V ISA. This project is aimed at providing a simple, modular, and extensible implementation of the RISC-V architecture for educational purposes, hobbyists, or as a foundation for advanced research.

---

## 📜 Features  
- **32-bit RISC-V ISA (RV32I)**: Implements the base integer instruction set (RV32I).  
- **Pipeline Design**: Modularized 5-stage pipeline architecture (IF, ID, EX, MEM, WB).  
- **Hazard Handling**: Supports data and control hazard detection and resolution (e.g., forwarding, stalling).  
- **Branch Prediction**: Optional 2-bit branch predictor implementation for improved performance.  
- **Memory Interface**: Simple instruction and data memory interface using synchronous RAM.  
- **Extendable**: Codebase is modular and designed for easy extension (e.g., RV32M for multiplication/division).  

---

## 📂 Project Structure  
```plaintext
├── rtl/                  # RTL Design Files (Verilog HDL)  
│   ├── alu.v             # Arithmetic Logic Unit  
│   ├── control_unit.v    # Control Unit  
│   ├── register_file.v   # Register File  
│   ├── hazard_unit.v     # Hazard Detection and Forwarding Unit  
│   ├── pipeline/         # Pipeline Stages (IF, ID, EX, MEM, WB)  
├── testbench/            # Testbenches for RTL Verification  
│   ├── alu_tb.v  
│   ├── cpu_tb.v  
├── docs/                 # Documentation and Diagrams  
│   ├── architecture.png  # Processor Architecture Diagram  
│   ├── pipeline.png      # Pipeline Diagram  
├── sim/                  # Simulation Scripts  
│   ├── compile.tcl       # Compilation Script  
│   ├── simulate.tcl      # Simulation Script  
├── LICENSE               # License File  
└── README.md             # Project Documentation  
