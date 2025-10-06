# WEC-Sim Control Strategy Evaluation

This repository contains a **WEC-Sim-based simulation framework** to evaluate and compare different control strategies for a **point absorber wave energy converter (WEC)**. The implemented controllers aim to maximize absorbed energy from incident waves by dynamically regulating the PTO (power take-off) system.

---

## 🚀 Overview

The simulation investigates the following control strategy:

- **SMC (Sliding Mode Controller)**: A robust nonlinear controller designed to handle system uncertainties.


---

## 📁 Repository Structure

```
.
├── wecSimInputFile.m            # Main configuration file for WEC-Sim
├── ellipsoidSMC.slx             # Simulink model containing WEC and controller logic
├── hydroData/
│   └── ellipsoid.h5             # Hydrodynamic coefficients file (from BEM tools)
├── geometry/
│   └── ellipsoid.stl            # STL file for the WEC geometry
├── Results/                     # Simulation outputs (absorbed power, motion, etc.)
```

---

## 📦 Requirements

Ensure the following software/tools are installed:

- MATLAB (R2020a or later)
- Simulink
- [WEC-Sim Toolbox]https://wec-sim.github.io/WEC-Sim/main/user/getting_started.html
- Hydrodynamic coefficients file (from NEMOH, Capytaine, or WAMIT)

---

## 🛠️ How to Run

### 1. Download WECSIM
https://wec-sim.github.io/WEC-Sim/main/user/getting_started.html

 WEC-Sim users should clone WEC-Sim’s Github repository​

Install GIT LFS Using Following Link​

https://git-lfs.com/​

After installation open git bash it will open a command window and run following commands to clone WEC-Sim​

>> git lfs install​

>> git clone https://github.com/WEC-Sim/WEC-Sim​

Local copy of WEC-Sim can easily be updated using following command​

>> git pull origin main
>> GiBash command for version 6 of Wecsim
Using v6.0 version of WECSIM​

$ cd C:/Users/um1023/Documents/WEC-Sim​

$ git fetch --all --tags​

$ git checkout v6.0

### 2. Set Up WEC-Sim

In MATLAB, add WEC-Sim to your path:

cd('C:\Users\um1023\Documents\WEC-Sim')

addWecSimSource

### 3. Run Simulation
Download files in following link
https://github.com/Energy-Control-and-Optimization-Lab/Control-codesign-of-wave-energy-converters/tree/main

Place the downloaded simulation in the folder of WECSIM

open maltab go to the directory of simulation folder

cd('C:\ SimulationFolder')

Change the path according to the location of your system for Geometry file and hydrodynamic file in wcsiminputfile following lines of codes to be changed according to location in your computer

body(1).geometryFile = 'geometry/elipsoid.stl' ;

body(1) = bodyClass('C:/Users/um1023/Documents/ST-SMC/RegularCIC_SMCcontroller/hydroData/ellipsoid.h5');
RUN "wecSim"

## 📬 Contact
Arezoo.Hasankhani@unh.edu
