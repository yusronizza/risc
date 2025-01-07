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
```
## 🖼️ Architecture Overview

This processor follows the RV32I architecture with a 5-stage pipeline:
1. Instruction Fetch (IF): Fetches instructions from memory.
2. Instruction Decode (ID): Decodes the instruction and reads operands.
3. Execute (EX): Performs ALU operations or calculates branch targets.
4. Memory Access (MEM): Accesses data memory if needed.
5. Write Back (WB): Writes the result back to the register file.

---

## ⚙️ Simulation and Testing
Prerequisites
Verilog simulator (e.g., ModelSim, VCS, Icarus Verilog)
GTKWave (optional for waveform viewing)

---

## 🚧 Roadmap

- [x] RV32I Base Implementation
- [x] Basic Hazard Detection & Forwarding
- [ ] Branch Prediction (2-bit)
- [ ] RV32M (Multiplication & Division)
- [ ] Cache Integration
- [ ] Formal Verification
- [ ] Documentation
  - [x] Write detailed `README.md`
  - [ ] Add inline comments to code
  - [ ] Publish GitHub Pages for project documentation

---

## 📖 References
RISC-V Specification
Computer Organization and Design: RISC-V Edition

---

## 📝 License
This project is licensed under the MIT License. See the LICENSE file for details.

---

## ⭐ Support
If you find this project helpful, give it a ⭐! Feel free to reach out for collaboration or suggestions.

---

## 📫 Contact

Have questions, feedback, or want to collaborate? Feel free to reach out!

- 🌐 **Website:** [yusronizza.github.io](https://yusronizza.github.io)
- 📧 **Email:** [yusronizzafaradisa@gmail.com](mailto:yusronizzafaradisa@gmail.com)
- 🐦 **Twitter:** [@yusronizza_](https://twitter.com/yourusername)
- 💼 **LinkedIn:** [Yusron Izza Faradisa](https://linkedin.com/in/yusronizza)
- 🛠️ **GitHub:** [@yusronizza](https://github.com/yusronizza)

---

## 🤝 Contributing

Contributions are welcome! Feel free to submit pull requests or open issues for discussion.

**Contributions, issues, and feature requests are welcome!** Feel free to check out the [issues page](https://github.com/yusronizza/riscv/issues) to get started. 
