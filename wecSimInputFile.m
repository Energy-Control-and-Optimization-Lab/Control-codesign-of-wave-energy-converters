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
%simu.endTime=T_f;
simu.dt = 0.01;
simu.rho=1025;
simu.stateSpace=1; %Fr state space added and can be used with regular waves
simu.nonlinearDt = 3*simu.dt;

%% Wave Information
% Regular Waves
waves = waveClass('regular'); %Before we were using regularCIC and line 13 of the code was not there with line 13 we can not use RegularCIC
waves.height = 0.8222;
waves.period = 6;

%% Irregular Waves using JS Spectrum with Equal Energy and Seeded Phase
% waves = waveClass('irregular');           % Initialize Wave Class and Specify Type
% waves.height = 0.8222;                       % Significant Wave Height [m]
% waves.period = 6;                         % Peak Period [s]
% waves.spectrumType = 'JS';                % Specify Wave Spectrum Type
% waves.bem.option = 'EqualEnergy';         % Uses 'EqualEnergy' bins (default) 
% waves.phaseSeed = 1;                      % Phase is seeded so eta is the same
%% Body Data
body(1) = bodyClass('C:/Users/um1023/Documents/ST-SMC/RegularCIC_SMCcontroller/hydroData/ellipsoid.h5');
%body(1).hydroDataFile = 'C:/Users/um1023/Documents/RegularCIC_Fuzzycontroller/RegularCIC_Fuzzycontroller/hydroData/ellipsoid.h5';
body(1).mass = 'equilibrium';
body(1).inertia = ...
    [1.375264e6 1.375264e6 1.341721e6];
body(1).geometryFile = 'geometry/elipsoid.stl' ;
body(1).quadDrag.cd=[1 0 1 0 1 0];
body(1).quadDrag.area=[25 0 pi*5^2 0 pi*5^5 0];
%% Selection of Linear and Nonlinear hydro forces
body(1).nonlinearHydro = 2;                       % Non-linear
%body(1).nonlinearHydro = 1;                       % weak Non-linear
%body(1).nonlinearHydro = 0;                       % linear hydro

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

% Define controller parameters (optional, only if you want to access in simulation or workspace)
%controller(1).a1 = 10;         % Sliding surface gain (results taken)
%controller(1).a1 = 10;         % Sliding surface gain (results taken)
%controller(1).m = 133376;         % Estimated WEC body mass
controller(1).m = 133918.300000000+199883.890680326;         % Estimated WEC body mass
%controller(1).l = 0.01;     % Reaching gain
controller(1).c = 117291.501000088; 
%% working best with no control force limit so far results
% controller(1).a1=1;
% controller(1).fi1=1;
% controller(1).alfa=0.5;
% controller(1).k1=1;
% controller(1).k2=100;
% controller(1).l=1;
%% linear
% controller(1).a1=83.6;
% controller(1).fi1=100000;
% controller(1).alfa=0.5;
% controller(1).k1=0.01;
% controller(1).k2=500;
% controller(1).l=1;
%% cf
controller(1).a1=1;
controller(1).fi1=0.1;
controller(1).alfa=0.1;
controller(1).k1=100;
controller(1).k2=100;
controller(1).l=0.000001;
%% working best with no control force limit
% controller(1).a1=83.6;
% controller(1).fi1=1000;
% controller(1).alfa=0.99;
% controller(1).k1=100;
% controller(1).k2=100;
% controller(1).l=0.0001;
%% working best with no control force limit so far results
% controller(1).a1=200;
% controller(1).fi1=100000;
% controller(1).alfa=0.5;
% controller(1).k1=0.1;
% controller(1).k2=5;
% controller(1).l=1;
%% working best with no control force limit so far results real ST-SMC
% controller(1).a1=83.6;
% controller(1).fi1=100000;
% controller(1).alfa=0.99;
% controller(1).k1=10;
% controller(1).k2=5;
% controller(1).l=1;
%% working best with no control force limit so far results stsmc best energy not position
% % controller(1).a1=83.6;
% % controller(1).fi1=100000;
% % controller(1).alfa=0.99;
% % controller(1).k1=1;
% % controller(1).k2=50;
% % controller(1).l=1;
%% working best with no control force limit so far results stsmc best energy
% controller(1).a1=83.6;
% controller(1).fi1=10000;
% controller(1).alfa=0.99;
% controller(1).k1=1;
% controller(1).k2=5;
% controller(1).l=1;
%% working fine with limit 3.5e5, 3.2e5 working giving best energy but in opposite dir
% controller(1).a1=2000;
% controller(1).fi1=1000;
% controller(1).alfa=0.99;
% controller(1).k1=20;
% controller(1).k2=14;
% controller(1).l=0.001;
%%
%controller(1).c = 1.1443e+05; 
%controller(1).FLC.SaturationLimit = 80000000000e40;
%save('C:\Users\um1023\Documents\RegularCIC_Fuzzycontroller\RegularCIC_Fuzzycontroller\Results\ControlFLC.mat')

