# 5-bit Carry Look-Ahead Adder - VLSI Design Project

**Course:** VLSI Design (Monsoon 2025)  
**Institution:** International Institute of Information Technology, Hyderabad  
**Instructor:** Prof. Abhishek Srivastava, CVEST  
**Student:** Chanda Akshay Kumar  
**Roll Number:** 2024102014  
**Email:** chanda.kumar@students.iiit.ac.in

## Project Overview

This project presents the complete design, simulation, and implementation of a **5-bit Carry Look-Ahead (CLA) Adder** using 180nm CMOS technology. The adder operates at VDD = 1.8V and includes a comprehensive design flow from circuit-level simulations to FPGA implementation.

### Key Achievements
- **Maximum Operating Frequency:** 1281 MHz (Post-Layout)
- **Post-Layout Worst-case Delay:** 609.2 ps (Sum logic)
- **Post-Layout Best-case Delay:** 75 ps
- **Pre-Layout Worst-case Delay:** 621.3 ps
- **Pre-Layout Best-case Delay:** 222.3 ps
- **Technology:** TSMC 180nm CMOS process
- **Design Methodology:** Full custom VLSI design with hierarchical approach

## Table of Contents
- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Design Specifications](#design-specifications)
- [Directory Structure](#directory-structure)
- [Design Methodology](#design-methodology)
- [Simulation Results](#simulation-results)
- [Tools and Technologies](#tools-and-technologies)
- [Getting Started](#getting-started)
- [Results Summary](#results-summary)
- [References](#references)

## Architecture

### System Block Diagram

The 5-bit CLA adder consists of:

1. **Input D Flip-Flops:** 10 D flip-flops for registering 5-bit inputs A and B
2. **Propagate & Generate (P/G) Logic:** Computes propagate (pi = ai ⊕ bi) and generate (gi = ai · bi) signals
3. **Carry Look-Ahead Logic:** Parallel carry computation for reduced delay
4. **Sum Block:** Computes final sum bits (sumi = pi ⊕ ci)
5. **Output D Flip-Flops:** 6 D flip-flops for registering 5-bit sum and carry-out

### Key Design Features

- **Total D Flip-Flops:** 16 (10 input + 6 output)
- **Logic Style:** Static CMOS with NAND-based implementation
- **D Flip-Flop Type:** True Single Phase Clock (TSPC) for low setup/hold times
- **Carry Computation:** Parallel look-ahead with equations:
  - c₁ = g₀
  - c₂ = g₁ + p₁·g₀
  - c₃ = g₂ + p₂·g₁ + p₂·p₁·g₀
  - c₄ = g₃ + p₃·g₂ + p₃·p₂·g₁ + p₃·p₂·p₁·g₀
  - c₅ = g₄ + p₄·g₃ + p₄·p₃·g₂ + p₄·p₃·p₂·g₁ + p₄·p₃·p₂·p₁·g₀

## Design Specifications

### Technology Parameters
- **Process:** TSMC 180nm CMOS
- **Supply Voltage (VDD):** 1.8V
- **Channel Length:** Ln = Lp = 2λ = 0.18μm (equal for NMOS and PMOS)
- **Lambda (λ):** 0.09μm
- **PMOS/NMOS Width Ratio:** k = 2 (based on mobility ratio μn/μp ≈ 2)

### Transistor Sizing

#### Basic Gates

| Gate Type | NMOS Width (λ) | PMOS Width (λ) | Channel Length (λ) | Width (μm) |
|-----------|----------------|----------------|-------------------|------------|
| Inverter  | 20             | 40             | 2                 | 1.8/3.6    |
| NAND2     | 40             | 40             | 2                 | 3.6/3.6    |
| NAND3     | 60             | 40             | 2                 | 5.4/3.6    |
| NAND4     | 80             | 40             | 2                 | 7.2/3.6    |
| NAND5     | 100            | 40             | 2                 | 9.0/3.6    |

**Sizing Rule for n-input NAND:** Wn,series = n × 20λ to compensate for series resistance

#### D Flip-Flop (TSPC)

The True Single Phase Clock (TSPC) D flip-flop is optimized for:
- Low setup time: 68.9 ps (rise), 60.6 ps (fall)
- Low hold time: 34.7 ps
- Fast clock-to-Q delay: 85.67 ps (average)

### Output Load
Each output drives an inverter with Wp/Wn = 20λ/10λ

## Directory Structure

```
2024102014/
├── README.md                              # This file
├── 2024102014_ChandaAkshayKumar.tex      # Complete project report (LaTeX source)
├── 2024102014.pdf                        # Compiled project report
├── course_project_vlsid2025.pdf          # Project assignment specifications
│
├── Magic/                                 # MAGIC Layout files
│   ├── SCN6M_DEEP.09.tech27              # Technology file for 180nm
│   ├── TSMC_180nm.txt                    # TSMC 180nm parameters
│   ├── Inverter.mag/.ext/.spice          # Inverter layout and extraction
│   ├── NAND_2.mag                        # 2-input NAND gate layout
│   ├── NAND_3.mag/.ext/.spice            # 3-input NAND gate
│   ├── NAND_4.mag/.ext/.spice            # 4-input NAND gate
│   ├── NAND_5.mag/.ext/.spice            # 5-input NAND gate
│   ├── Xor.mag/.ext/.spice               # XOR gate (4×NAND2 implementation)
│   ├── dff.mag/.ext/.spice               # D flip-flop (TSPC)
│   ├── ckt_final.mag/.ext/.spice         # Complete CLA adder layout
│   └── ff&ckt.mag/.ext/.spice            # Integrated flip-flops and adder
│
├── Ngspice/                              # SPICE simulation files
│   ├── Pre_layout/                       # Pre-layout simulations
│   │   ├── Inv&Nand2345.cir             # All basic gates verification
│   │   ├── flipflop.cir                 # D flip-flop functional test
│   │   ├── flipflop_hold.cir            # Hold time characterization
│   │   ├── ckt_final.cir                # Complete adder without FFs
│   │   ├── ff&ckt.cir                   # Complete design with FFs
│   │   └── TSMC_180nm.txt               # Technology model file
│   │
│   └── Post_Layout/                      # Post-layout extracted simulations
│       ├── xor.cir                       # XOR post-layout verification
│       ├── dff.cir                       # D flip-flop post-layout
│       ├── dff_setup.cir                 # Setup time post-layout
│       ├── dff_hold.cir                  # Hold time post-layout
│       ├── ckt_final.cir                 # Complete adder post-layout
│       ├── ff&ckt.cir                    # Full design post-layout
│       └── TSMC_180nm.txt                # Technology model file
│
└── Verilog/                              # HDL implementation
    ├── main.v                            # Main structural Verilog modules
    ├── top.v                             # Top-level module
    ├── tb.v                              # Testbench (selected test cases)
    ├── tb_all.v                          # Comprehensive testbench (exhaustive)
    ├── top.xdc                           # FPGA constraints file
    ├── final                             # Compiled simulation executable
    ├── final_exhaustive                  # Exhaustive test executable
    ├── cla_adder_5bit.vcd               # Waveform dump (test cases)
    ├── cla_adder_5bit_exhaustive.vcd    # Waveform dump (exhaustive)
    ├── wave_form_test_cases.gtkw        # GTKWave configuration
    ├── wave_form_test_cases_all.gtkw    # GTKWave config (exhaustive)
    │
    └── FPGA/                             # Xilinx Vivado FPGA project
        ├── project_1.xpr                 # Vivado project file
        ├── tb_cla_adder_5bit_behav.wcfg  # Waveform configuration
        ├── project_1.hw/                 # Hardware implementation
        ├── project_1.runs/               # Synthesis and implementation runs
        │   ├── synth_1/                  # Synthesis outputs
        │   └── impl_1/                   # Implementation outputs
        ├── project_1.sim/                # Simulation files
        └── project_1.srcs/               # Source files
            └── constrs_1/                # Constraint files
```

## Design Methodology

### 1. Circuit Design and Sizing
- Transistor sizing based on mobility ratio (k = 2)
- Series NMOS scaling for multi-input NAND gates
- TSPC D flip-flop for optimal timing characteristics

### 2. Pre-Layout Simulation (NGSPICE)
- Individual gate verification (Inverter, NAND2-5, XOR)
- D flip-flop characterization (setup/hold/C2Q times)
- Complete adder functional verification
- Timing analysis and delay measurements

### 3. Physical Layout (MAGIC)
- Custom layout using SCN6M_DEEP.09.tech27 technology file
- Design rule checking (DRC)
- Layout versus schematic (LVS) verification
- Parasitic extraction

### 4. Post-Layout Simulation
- Extracted netlist simulation with parasitics
- Comparison with pre-layout results
- Worst-case delay analysis

### 5. HDL Implementation (Verilog)
- Structural description matching circuit topology
- Gate-level modeling with NAND primitives
- Comprehensive testbench with exhaustive testing
- Functional verification using Icarus Verilog and GTKWave

### 6. FPGA Prototyping
- Implementation on Xilinx FPGA
- Synthesis and place-and-route using Vivado
- Hardware testing and oscilloscope verification

## Simulation Results

### D Flip-Flop Timing Characteristics (Pre-Layout)

| Parameter | Value (ps) |
|-----------|------------|
| Setup Time (rise) | 68.9 |
| Setup Time (fall) | 60.6 |
| Hold Time | 34.7 |
| Clock-to-Q Delay (rise) | 49.58 |
| Clock-to-Q Delay (fall) | 121.75 |
| Clock-to-Q Delay (avg) | 85.67 |

### CLA Adder Performance

#### Pre-Layout Results

| Metric | Value |
|--------|-------|
| Worst-case Delay (tpd_max) | 621.3 ps |
| Best-case Delay (tpd_min) | 222.3 ps |
| Maximum Clock Frequency | 1231.52 MHz |
| Minimum Clock Period | 812 ps |

**Pre-Layout Clock Period Calculation:**
```
Tclk_min = tC2Q_max + tpd_CLA_max + tsetup_max
         = 121.75 ps + 621.3 ps + 68.93 ps
         = 812 ps
fmax = 1 / Tclk_min ≈ 1231.52 MHz
```

#### Post-Layout Results

| Metric | Value |
|--------|-------|
| Carry Logic Delay (worst) | 422 ps |
| Sum Logic Delay (worst) | 609.2 ps |
| Best-case Delay (tpd_min) | 75 ps |
| **Maximum Clock Frequency** | **1281 MHz** |
| Minimum Clock Period | 780.64 ps |

**Post-Layout Clock Period Calculation:**
```
Tclk_min = tC2Q_avg + tpd_adder_max + tsetup
         = 119.3 ps + 609.2 ps + 52.14 ps
         = 780.64 ps
fmax = 1 / Tclk_min ≈ 1281 MHz
```

### Pre-Layout vs Post-Layout Comparison

| Parameter | Pre-Layout | Post-Layout | Change |
|-----------|-----------|-------------|---------|
| Critical Path Delay | 864.8 ps | 847.2 ps | -3.86% ✓ |
| Maximum Frequency | 1231.52 MHz | 1281 MHz | +4.02% ✓ |
| DFF tC2Q (avg) | 85.67 ps | 86.85 ps | +1.38% |
| DFF tC2Q (max) | 121.75 ps | 119.3 ps | -2.01% ✓ |
| Setup Time (avg) | 64.75 ps | 47.67 ps | -26.4% ✓ |
| Hold Time | 34.7 ps | 33 ps | -4.90% ✓ |
| Adder Delay (max) | 621.3 ps | 609.2 ps | -1.95% ✓ |
| Adder Delay (min) | 222.3 ps | 75 ps | -66.3% ✓ |

**Note:** Post-layout results show improvement due to optimized layout and reduced parasitic effects in the actual implementation.

### Critical Path
The critical path goes through:
1. Input D flip-flop (clock-to-Q delay)
2. P/G logic (XOR for propagate, AND for generate)
3. Carry-5 computation (deepest carry chain with NAND5)
4. Sum-4 computation (XOR with carry)
5. Output D flip-flop (setup time)

## Tools and Technologies

### Design and Simulation Tools
- **NGSPICE** - Circuit-level SPICE simulation
- **MAGIC Layout Editor** - Custom IC layout design
- **Icarus Verilog** - Verilog HDL simulation
- **GTKWave** - Waveform viewer
- **Xilinx Vivado** - FPGA synthesis and implementation

### Technology Files
- **TSMC 180nm Process** - TSMC_180nm.txt
- **Technology File** - SCN6M_DEEP.09.tech27 (6 metal layers, deep submicron)

### Programming and Documentation
- **Verilog HDL** - Hardware description
- **LaTeX** - Technical documentation (IEEE format)
- **Python/Shell scripts** - Automation (if applicable)

## Getting Started

### Prerequisites
```bash
# Install required tools (Ubuntu/Debian)
sudo apt-get update
sudo apt-get install ngspice magic iverilog gtkwave

# For FPGA work, install Xilinx Vivado separately
```

### Running Pre-Layout Simulations

```bash
cd Ngspice/Pre_layout/

# Simulate basic gates
ngspice Inv&Nand2345.cir

# Simulate D flip-flop
ngspice flipflop.cir

# Simulate complete CLA adder
ngspice ckt_final.cir

# Simulate with flip-flops
ngspice ff&ckt.cir
```

### Running Post-Layout Simulations

```bash
cd Ngspice/Post_Layout/

# Run extracted netlists
ngspice dff.cir
ngspice ckt_final.cir
ngspice ff&ckt.cir
```

### MAGIC Layout Viewing

```bash
cd Magic/

# Open layout files
magic -T SCN6M_DEEP.09.tech27 Inverter.mag
magic -T SCN6M_DEEP.09.tech27 dff.mag
magic -T SCN6M_DEEP.09.tech27 ckt_final.mag

# Extract netlist
# In MAGIC command window:
# extract all
# ext2spice
```

### Verilog Simulation

```bash
cd Verilog/

# Compile and run selected test cases
iverilog -o final top.v main.v tb.v
vvp final
gtkwave cla_adder_5bit.vcd wave_form_test_cases.gtkw

# Compile and run exhaustive tests (all 1024 combinations)
iverilog -o final_exhaustive top.v main.v tb_all.v
vvp final_exhaustive
gtkwave cla_adder_5bit_exhaustive.vcd wave_form_test_cases_all.gtkw
```

### FPGA Implementation

```bash
cd Verilog/FPGA/

# Open in Vivado
vivado project_1.xpr

# Run synthesis, implementation, and generate bitstream
# Program FPGA and verify with oscilloscope
```

## Results Summary

### Performance Metrics

| Metric | Pre-Layout | Post-Layout | Improvement |
|--------|-----------|-------------|-------------|
| **Max Frequency** | 1231.52 MHz | **1281 MHz** | +4.02% |
| **Critical Path** | 864.8 ps | 847.2 ps | -3.86% |
| Adder Delay (worst) | 621.3 ps | 609.2 ps | -1.95% |
| Adder Delay (best) | 222.3 ps | 75 ps | -66.3% |
| DFF Clock-to-Q (max) | 121.75 ps | 119.3 ps | -2.01% |
| DFF Setup Time (avg) | 64.75 ps | 47.67 ps | -26.4% |
| DFF Hold Time | 34.7 ps | 33 ps | -4.90% |

### Key Accomplishments

✅ **Complete VLSI Design Flow** - From schematic to silicon  
✅ **Optimized TSPC Flip-Flops** - Low setup/hold times  
✅ **Parallel Carry Computation** - CLA architecture advantage  
✅ **Layout Design** - DRC and LVS clean  
✅ **Comprehensive Testing** - 1024 exhaustive test cases  
✅ **FPGA Verification** - Hardware demonstration successful  
✅ **Professional Documentation** - IEEE-format report with LaTeX

### Design Trade-offs

**Advantages:**
- High-speed operation (1281 MHz)
- Predictable timing with registered I/O
- Standard CMOS implementation (reliable)
- Modular hierarchical design

**Considerations:**
- Area overhead from 16 D flip-flops
- XOR implementation using 4 NAND gates (could be optimized)
- Static CMOS power consumption (no dynamic logic)

## Project Report

The complete project report (`2024102014_ChandaAkshayKumar.tex` compiled to `2024102014.pdf`) includes:

1. **Introduction** - Motivation and objectives
2. **Background Theory** - CLA adder concept and equations
3. **Proposed Architecture** - Block diagram and timing
4. **Circuit Design** - Detailed transistor sizing
5. **Pre-Layout Simulations** - NGSPICE results with waveforms
6. **Layout Design** - MAGIC stick diagrams and layouts
7. **Post-Layout Analysis** - Extracted simulation comparison
8. **HDL Implementation** - Verilog structural description
9. **FPGA Results** - Hardware demonstration
10. **Conclusion** - Summary and future work

## References

1. **Digital Logic and Computer Design** - Morris Mano
2. **Computer Architecture and Organization** - John P. Hayes
3. **CMOS VLSI Design (4th Edition)** - Weste and Harris
4. **Fundamentals of Digital Logic with Verilog Design** - Brown and Vranesic
5. **TSMC 180nm Process Documentation**
6. **NGSPICE User Manual**
7. **MAGIC Layout Tool Documentation**

## Course Information

- **Course Code:** VLSI Design
- **Semester:** Monsoon 2025
- **Instructor:** Prof. Abhishek Srivastava, CVEST
- **Institution:** IIIT Hyderabad
- **Project Duration:** November 1 - December 3, 2025
- **Demo/Viva:** December 4-5, 2025

## License

This project is submitted as part of academic coursework at IIIT Hyderabad. All rights reserved.

## Author

**Chanda Akshay Kumar**  
Roll Number: 2024102014  
B.Tech Electronics and Communication Engineering  
International Institute of Information Technology, Hyderabad  
Email: chanda.kumar@students.iiit.ac.in

---

**Note:** This project demonstrates a complete VLSI design flow including circuit design, simulation, layout, verification, HDL implementation, and FPGA prototyping for a 5-bit Carry Look-Ahead Adder using industry-standard tools and methodologies.
