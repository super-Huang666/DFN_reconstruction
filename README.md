# DFN_reconstruction 
## Description
DFN_reconstruction provides the MATLAB implementation of a framework for reconstructing three-dimensional discrete fracture networks (DFN) constrained by logging data.

The method integrates stochastic DFN generation with a simulated annealing (SA) optimization algorithm to iteratively adjust fracture parameters so that simulated borehole intersections reproduce the statistical characteristics observed in logging measurements.

The repository includes the full source code, an example dataset, and a quick-test script to verify the functionality of the reconstruction workflow.
## The repository includes
- Initial DFN generation
- Simulated annealing optimization for DFN reconstruction
- Borehole sampling simulation
## Usage
The workflow for running the DFN reconstruction program is summarized below.
### 1. Generate the initial DFN model
Before running the reconstruction procedure, ensure that the initial DFN model can be generated successfully. The initial fracture network provides the starting point for the simulated annealing optimization.
### 2. Set the initial parameters
Open the main program:
```bash
main_onewell.m
```
Define the initial parameters, including:
- Initial fracture parameters of the DFN model (e.g., fractal dimension, length exponent, normalization constant, total number of fractures)
- Parameters of the simulated annealing (SA) algorithm, such as temperature, cooling schedule, and iteration number
### 3. Input measured fracture statistics
Open the file:
```bash
onewellloadInitialData.m
```
In this file, input the measured fracture statistics derived from logging data, including:
- CFI – cumulative fracture intensity
- P10 – linear fracture density
These values serve as constraints for the DFN reconstruction.
### 4. Define parameter perturbation ranges and amplitudes
Open the file:
```bash
perturbParameters.m
```
Specify the perturbation ranges for fracture parameters.
These ranges control how the fracture parameters are adjusted during each simulated annealing iteration.
### 5. Run the reconstruction
After completing the above settings, run the main program:
```bash
main_onewell
```
The program will perform the simulated annealing optimization and output the perturbed DFN models, from which the optimal DFN model consistent with the logging data will be obtained.

