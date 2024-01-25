# 5-Stage Pipelined Processor

## Overview
This project focuses on the design and implementation of a 5-stage pipelined processor using the Verilog Hardware Description Language (VHDL). Following a Reduced Instruction Set Computing (RISC)-like architecture, the processor encompasses various components, each playing a crucial role in the execution of instructions.

## Design
We meticulously designed our own architecture, aiming to optimize as many instructions as possible for enhanced performance and efficiency. The architecture is tailored to meet the project requirements, ensuring a balanced and effective 5-stage pipeline. For detailed design specifications, refer to our [Design](https://miro.com/app/board/uXjVNK1hs4o=/).

## Components
1. **ALU**
   - **Functionality:**
     - Performs arithmetic and logical operations during the Execute stage.
     - Receives inputs from the Instruction Decode stage.
     - Generates the result for the Write Back stage.

2. **Control Unit**
   - **Functionality:**
     - Manages control signals for each stage of the pipeline.
     - Orchestrates the flow of data and signals between components.

3. **Memory**
   - **Functionality:**
     - Provides necessary data for load and store instructions during the Memory Access stage.
     - Interacts with the Memory Access stage for data transfer.

4. **Hazard Detection Unit**
   - **Functionality:**
     - Detects hazards, such as data hazards, and stalls the pipeline if needed.
     - Ensures correct data forwarding and maintains pipeline integrity.

5. **Forwarding Unit**
   - **Functionality:**
     - Facilitates the forwarding of data between pipeline stages to resolve hazards.
     - Improves performance by reducing stalls in the pipeline.

## Assembler
- **Functionality:**
  - Converts assembly programs into machine code according to the designed Instruction Set Architecture (ISA).
  - Generates a memory file containing the machine code for execution.

## Integration with Components
The components are seamlessly integrated to ensure a smooth flow of instructions through the pipeline. The ALU, Control Unit, Memory, Hazard Detection Unit, and Forwarding Unit collectively contribute to the effective execution of instructions.

Explore the Verilog source files to gain insights into the detailed implementation of each component. For further details, refer to the design documentation or project-specific documentation linked in the repository.
