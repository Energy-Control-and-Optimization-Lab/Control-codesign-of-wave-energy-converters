# Control Strategies for Maximizing Energy Absorption
This project implements and compares multiple control strategies designed to enhance the energy absorption of a point absorber Wave Energy Converter (WEC) simulated in WEC-Sim. The focus is on optimizing the damping force applied by a direct-drive Power Take-Off (PTO) system using feedback control laws based on body heave motion. The control strategies implemented are:

1. Sliding Mode Controller (SMC)
A robust nonlinear control approach designed to force the system's state trajectory to reach and stay on a predefined sliding surface. The SMC improves energy capture in the presence of modeling uncertainties and external disturbances. The control law is discontinuous and switches based on the sign of the sliding variable, enabling high responsiveness but possibly introducing chattering.

2. Tanh-Based SMC (SMC-Tanh)
This version of SMC replaces the sign function with a smooth hyperbolic tangent function (tanh) to mitigate chattering while preserving robustness. It ensures a continuous control signal, which is more realistic for physical PTO actuators and improves numerical stability during simulation.


3. Proportional-Integral (PI) Controller
A classical feedback controller that applies a PTO force proportional to the heave velocity (P-term) and the integral of velocity error (I-term). It provides a baseline for comparison against advanced nonlinear methods. Although simple and robust, its ability to extract energy is limited under highly nonlinear sea states.



3. Singular Arc Solution
An improved variant of SMC that modifies the sliding surface and control law to avoid singularities and reduce chattering. It introduces a correction term to ensure well-behaved dynamics even near the origin of the phase plane, making it more suitable for low-velocity operation.
Each controller dynamically adjusts the PTO damping based on the system's velocity and estimated dynamics, aiming to synchronize the device motion with incoming wave excitation and maximize energy extraction.

# 📈 The performance of each controller is compared based on:

Total absorbed energy

Velocity and position response

Robustness to irregular wave conditions
