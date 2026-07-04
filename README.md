# UART-Protocol
## Overview

This project implements a Universal Asynchronous Receiver Transmitter (UART) protocol using Verilog HDL for reliable serial communication. The design includes UART Transmitter, UART Receiver, Baud Rate Generator, and a FIFO (First-In, First-Out) Buffer to enable efficient data buffering and continuous data transfer. The complete design was verified through simulation and successfully implemented on an FPGA using Xilinx Vivado.

## Features
- UART Transmitter (TX)
- UART Receiver (RX)
- Baud Rate Generator
- FIFO Buffer for temporary data storage
- Serial Data Transmission and Reception
- FPGA Implementation
- Functional Verification using Verilog Testbench

## System Architecture
The UART system consists of the following modules:
- UART Transmitter
- UART Receiver
- Baud Rate Generator
- Debounce module
- Top-Level UART Module (FIFO buffer included)

## UART Configuration
- Data Bits: 8
- Parity: None
- Stop Bits: 1
- FIFO

## FIFO Buffer
A FIFO (First-In, First-Out) buffer is integrated into the UART design to improve data handling between the transmitter and receiver.

## Tools Used
- Verilog HDL
- Xilinx Vivado
- Vivado Simulator
- FPGA Basys3 Board

## Project Structure
UART-Protocol/
- RTL/
- Testbench/
- Constraints/
- Images/
- Reports/
- README.md

## Verification

The UART design was verified using Verilog testbench.
Simulation waveforms confirmed the correct operation of the system.

## FPGA Implementation
The design was successfully:
- Synthesized
- Implemented
- Generated Bitstream
- Programmed onto an FPGA
- Verified on Hardware
  
## Results
- Successful UART Communication
- Correct FIFO Operation
- Functional Simulation Passed
- Successful FPGA Implementation
- Reliable Serial Data Transfer

## Future Scope
- Implementation of advanced UART features.
- Implementation of SPI Protocol
- Implementation of I2C Protocol
- Other embedded and communication protocols


## Author
Sita Mahalakshmi Sangisetti
