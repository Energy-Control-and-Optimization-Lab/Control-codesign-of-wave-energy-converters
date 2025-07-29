% clc; clear all; close all;

%% hydro data
%hydro = struct();
%hydro = readWAMIT(hydro,'ellipsoid.out',[]);
%hydro = radiationIRF(hydro,60,[],[],[],[]);
%hydro = radiationIRFSS(hydo,[],[]);
%hydro = excitationIRF(hydro,100,[],[],[],[]);
%writeBEMIOH5(hydro)

%% Plot hydro data
% plotBEMIO(hydro)
% clc; clear all; close all;

%% hydro data
hydro = struct();
hydro = readWAMIT(hydro,'ellipsoid.out',[]);
hydro = radiationIRF(hydro,60,[],[],[],[]);
hydro = radiationIRFSS(hydro,[],[]);
hydro = excitationIRF(hydro,100,[],[],[],[]);
writeBEMIOH5(hydro)

%% Plot hydro data
% plotBEMIO(hydro)
