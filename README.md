# Synchronous FIFO Memory Buffer

A synthesizable, parameterized Synchronous FIFO (First-In, First-Out) memory buffer implemented in Verilog. This design is optimized for data buffering between components operating within the same clock domain.

## Features
- **Parameterized Architecture:** Easily configure `DATA_WIDTH` and `FIFO_DEPTH`.
- **Status Flags:** High-performance generation of `full`, `empty`, `almost_full`, and `almost_empty` warning thresholds.
- **Pointer Protection:** Internally protected logic prevents data corruption during accidental overflow or underflow conditions.

## Architecture & Block Diagram
The design utilizes a dual-port RAM array controlled by binary-coded read and write pointers, alongside tracking counters to compute predictive flags.

## Hardware Specifications
- **Language:** Verilog (IEEE 1364-2005)
- **Synthesis Tool:** Xilinx Vivado
- **Simulation Tool:** Vivado XSIM / ModelSim

## Simulation Results
*(Tip: Add a screenshot of your Vivado simulation waveforms here showing successful burst read/write operations!)*

## How to Run (Vivado)
1. Clone this repository.
2. Open Xilinx Vivado and select **Create Project**.
3. Add the source files from `/rtl` and testbench files from `/tb`.
4. Run Behavioral Simulation to view timing diagrams.
