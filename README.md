# Wave Energy Converter (WEC) Simulation with Advanced Controllers
This repository contains a WEC-Sim based model to simulate and evaluate different control strategies applied to a point absorber wave energy converter. The implemented controllers aim to maximize the absorbed energy from wave motion.

# 🚀 Overview

This project includes:

PI Controller: A traditional proportional-integral controller.

SMC (Sliding Mode Controller): A robust nonlinear controller.

SMC-Singular: Enhanced SMC with singularity-based logic.

SMC-Tanh: SMC with tanh-based smoothing for reduced chattering.

# 📁 Repository Structure


wecSimInputFile.m          # Main simulation setup file

ellipsoidSMC.slx           # Simulink model of the WEC system

hydroData/ellipsoid.h5           # Hydrodynamic data file (BEM output)

geometry/elipsoid.stl           # Geometry of the WEC body

Results/                   # Output data saved here      


# 📦 Requirements

MATLAB (R2020a or later)

Simulink

WEC-Sim toolbox

Hydrodynamic coefficients file (generated via NEMOH, Capytaine, or WAMIT)

# 🛠️ How to Run

📦 Requirements

MATLAB (R2020a or later)

Simulink

WEC-Sim toolbox

Hydrodynamic coefficients file (generated via NEMOH, Capytaine, or WAMIT)

git clone https://github.com/Energy-Control-and-Optimization-Lab/Control-codesign-of-wave-energy-converters.git
cd your-repo-name

# Set Up WEC-Sim

Ensure the WEC-Sim toolbox is on your MATLAB path:

addpath('path_to_wecSim');
wecSim

# Configure Simulation

Open and edit wecSimInputFile.m to:

Select the desired controller

Verify .h5 and .stl file paths

Choose wave type (e.g., irregular with 'JS' for JONSWAP)

# Run the Simulation

In MATLAB:
wecSim
