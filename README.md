# Intro-to-VLSI-CAD-Labs

This repository contains Verilog hardware design lab assignments for **Introduction to VLSI CAD** course at National Cheng Kung University (NCKU), covering fundamental VLSI design concepts and CAD tools.


## Structure

- **[Lab2: Introduction to Combinational Circuits](Lab2/)** - Basic digital circuits including ALU, FFO detector, and merge sort hardware
- **[Lab3: Advanced Arithmetic Circuits](Lab3/)** - Fixed-point multipliers, logarithmic interpolation, and synthesis comparison
- **[Lab4: Register Files and Data Paths](Lab4/)** - Register file design, image repair system, FIFO, and shooting game
- **[Lab5: Sequential Circuits and State Machines](Lab5/)** - Moore/Mealy FSMs, sequence detector, factorial calculator, washing machine controller
- **[Lab6: Cubic Interpolation](Lab6/)** - 1D image enlargement using cubic interpolation
- **[Lab7: Bicubic Interpolation](Lab7/)** - 2D image scaling with bicubic interpolation

Each lab folder contains detailed documentation in its own README.md file.

## How to Run

Navigate to the specific lab directory (e.g., `Lab2/Homework/`) and use the following Makefile commands:

| Situation | Command | Example |
|-----------|---------|---------|
| Simulation for ProbX | `make probX` | `make probA_1` |
| Dump waveform for ProbX | `make nWaveX` | `make nWaveA_1` |
| Open superlint for ProbX | `make superlintX` | `make superlintA_1` |
| Post-synthesis simulation for ProbX | `make probX_syn` | `make probA_1_syn` |
| Delete built files | `make clean` | |

## Note

Lab assignment spec PDFs are not included in this repository due to confidentiality restrictions.
