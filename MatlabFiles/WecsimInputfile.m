% clear; close all
%% Simulation Data
simu = simulationClass();
simu.simMechanicsFile = 'ellipsoidSMC.slx';
simu.solver='ode45';                    % 'ode4' for fixed step or 'ode45' for variable step
simu.mode = 'normal';                   % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
simu.explorer='off';                     % Turn SimMechanics Explorer (on/off)
simu.startTime = 0;
simu.rampTime = 30;
simu.endTime=350;
simu.dt = 0.01;
simu.rho=1025;
simu.stateSpace=1; %Fr state space added and can be used with regular waves
simu.nonlinearDt = 3*simu.dt;

%% Wave Information
 Regular Waves
 waves = waveClass('regular');
 waves.height = 0.8222;
 waves.period = 6;

%% Body Data
body(1) = bodyClass('C:/Users/um1023/Documents/SMC-Signum/RegularCIC_SMCcontroller/hydroData/ellipsoid.h5');
%body(1).hydroDataFile = 'C:/Users/um1023/Documents/RegularCIC_Fuzzycontroller/RegularCIC_Fuzzycontroller/hydroData/ellipsoid.h5';
body(1).mass = 'equilibrium';
body(1).inertia = ...
    [1.375264e6 1.375264e6 1.341721e6];
body(1).geometryFile = 'geometry/elipsoid.stl' ;
body(1).quadDrag.cd=[1 0 1 0 1 0];
body(1).quadDrag.area=[25 0 pi*5^2 0 pi*5^5 0];

%% Selection of Linear and Nonlinear hydro forces
body(1).nonlinearHydro = 2;                       % Non-linear

%% PTO and Constraint Parameters
% Fixed Constraint
% constraint(1) = constraintClass('Constraint1');
% constraint(1).location = [0 0 -12.5];

% Translational PTO
pto(1) = ptoClass('PTO1');
pto(1).stiffness=0;
pto(1).damping=0;
pto(1).location = [0 0 -12.5];

%% Controller

%% Controller: Sliding Mode Controller (SMC)


controller(1).m = 133918.300000000+199883.890680326;         % Estimated WEC body mass
%controller(1).m = 133376+1.495e5;         % Estimated WEC body mass
%%
% Define controller parameters (optional, only if you want to access in simulation or workspace)
%controller(1).a1 = 10;         % Sliding surface gain
%controller(1).l = 0.01;     % Reaching gain
%%
controller(1).c = 117291.501000088; 
%controller(1).c = 1.1443e+05; 
%controller(1).FLC.SaturationLimit = 80000000000e40;
%save('C:\Users\um1023\Documents\RegularCIC_Fuzzycontroller\RegularCIC_Fuzzycontroller\Results\ControlFLC.mat')
