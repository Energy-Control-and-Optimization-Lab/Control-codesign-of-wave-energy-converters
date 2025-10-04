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

### 2. Set Up WEC-Sim

In MATLAB, add WEC-Sim to your path:

cd('C:\Users\um1023\Documents\WEC-Sim')
addWecSimSource
```

### 3. Configure Simulation

Open and edit `wecSimInputFile.m`:

- Ensure correct paths to `.h5` and `.stl` files
- Choose wave type and characteristics (e.g., JONSWAP spectrum)

### 4. Run the Simulation

```matlab
wecSim
```

Simulation results (heave motion, PTO force, absorbed energy, etc.) will be saved in the `Results/` folder.

---

## 📈 Output Data

- Time series of body motion
- PTO force and displacement
- Instantaneous and total absorbed power
- Plots and data files for comparison across controllers

---



---


---

## 📬 Contact
Arezoo.Hasankhani@unh.edu
