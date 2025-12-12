# Final Project 9299_9634 – Signal Generator

## Overview
This MATLAB project allows users to generate and manipulate various types of signals with multiple regions and operations. It supports both manual input and an automatic mode that generates random signals.

## Features
- **Signal Types**:  
  1. DC  
  2. Ramp  
  3. Polynomial  
  4. Exponential  
  5. Sinusoidal  
  6. Gaussian Pulse  
  7. Sawtooth Wave  

- **Operations on Signals**:  
  - Amplitude Scaling  
  - Time Reversal  
  - Time Shift  
  - Expansion & Compression  
  - Addition of Random Noise  
  - Smoothing using Moving Average  

- **Regions & Breakpoints**:  
  - Split the time axis into multiple regions with user-defined breakpoints.  
  - Generate different signals for each region.  

- **Auto Mode**:  
  - Automatically generates 10 random signals.  
  - Random sampling frequency, breakpoints, and signal parameters.  
  - Saves all generated signals as PNG files.  

## How to Use
1. Run the main MATLAB script.  
2. Enter sampling frequency, start and end of the time axis.  
3. Define number of breakpoints and their positions (or leave default).  
4. Choose signal type from the menu.  
5. Enter parameters for each region when prompted.  
6. Choose any operation to apply on the generated signal.  
7. View the plotted signal; the figure will be automatically saved.  
8. For AUTO MODE, the program will generate and save 10 random signals without user input.

## Notes
- Works best on **MATLAB Desktop**.  
- On MATLAB Online or Live Script, input prompts may behave differently.  
- All figures are saved in the same directory as the script.

## Files
- `main.m` – Main script to run the project.  
- `functions.m` – Contains `generate_signal`, `apply_operation`, and `save_figure` functions.  
- `FigureX.png` – Saved plots of generated signals.

## Author
Ziad & David
