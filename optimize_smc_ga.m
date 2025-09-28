function optimize_smc_ga
%% ====== Initialize WEC-Sim (define T_f BEFORE calling wecSimInputFile) ======
clc; clear;

% Inputs that your wecSimInputFile expects:
T_f = 350;         % <- define this first (your input file uses it)
%Hs  = 0.8222;
%Tp  = 6;

SimFileName = 'ellipsoidSMC';   % model name (no .slx needed in sim call)

run('wecSimInputFile');         % now T_f exists, so this won’t error
clear simu waves body cable pto constraint ptoSim mooring
runWecSimCML = 1;
run('initializeWecSim');

%% ====== GA setup: decision variables & bounds ======
% Tune the gains you mentioned in the SMC law:
%   N4 = sign(s/fi1);
%   P1 = k1*N4*smode;
%   P2 = k2*N4;           % (edit if your P2 differs)
%   G  = (l/a1)*(P1+P2);
%   u  = (-Fr) + Fext - (Fextc - G)*m;  u = -u;
%
% Decision vector (edit ranges as needed):
% x = [k1, k2, fi1, l]
LB = [   1,   1, 1e-5, 1e-3];
UB = [1e5, 1e5, 1, 100.0 ];
nvars = numel(LB);

% Fitness returns J = -accEnergy (so GA maximizes energy)
fitness = @(x) energy_cost_local(x, SimFileName, T_f);

opts = optimoptions('ga', ...
    'PopulationSize'    , 36, ...
    'MaxGenerations'    , 30, ...
    'EliteCount'        , 4, ...
    'CrossoverFraction' , 0.8, ...
    'MutationFcn'       , {@mutationadaptfeasible}, ...
    'UseVectorized'     , false, ...
    'Display'           , 'iter', ...
    'PlotFcn'           , {@gaplotbestf, @gaplotscorediversity});

%% ====== Run GA ======
[xbest, fbest] = ga(fitness, nvars, [], [], [], [], LB, UB, [], opts);

k1  = xbest(1);
k2  = xbest(2);
fi1 = xbest(3);
l   = xbest(4);

fprintf('\nBest SMC gains:\n  k1=%.6g  k2=%.6g  fi1=%.6g  l=%.6g\n', k1, k2, fi1, l);
fprintf('Best GA cost (=-Energy) = %.6g\n', fbest);

% Push best back and validate once more
assignin('base','k1',k1);
assignin('base','k2',k2);
assignin('base','fi1',fi1);
assignin('base','l',l);

[~, Ebest] = energy_cost_local(xbest, SimFileName, T_f);
fprintf('Final validation accEnergy = %.6g (J)\n', Ebest);
end

%% ================== Local fitness (no extra files needed) ==================
function [J, E] = energy_cost_local(x, modelName, T_f)
% x = [k1, k2, fi1, l]
J = 1e9; E = -Inf;
try
    % 1) Push GA gains into base workspace (SMC block should read these)
    assignin('base','k1',  x(1));
    assignin('base','k2',  x(2));
    assignin('base','fi1', x(3));
    assignin('base','l',   x(4));

    % Clear any stale energy before sim
    if evalin('base','exist(''accEnergy'',''var'')')
        evalin('base','clear accEnergy');
    end

    % 2) Run simulation
    simOut = sim(modelName, ...
        'StopTime', num2str(T_f), ...
        'SaveOutput', 'on', ...
        'ReturnWorkspaceOutputs', 'on');

    % 3) Prefer accEnergy from base workspace
    if evalin('base','exist(''accEnergy'',''var'')')
        En = evalin('base','accEnergy');
        E = extract_final_energy(En);
    else
        % Fallback: E = ∫ u * v dt from logsout (if you log them)
        E = try_energy_from_logs(simOut);
    end

    if ~isfinite(E)
        J = 1e8;   % penalize invalid energy
    else
        J = -E;    % maximize energy
    end

catch ME
    warning('energy_cost_local: %s', ME.message);
    J = 1e9; E = -Inf;
end
end

%% --------------------- Helpers ---------------------
function E = extract_final_energy(En)
% Accepts scalar, timeseries, timetable, or "Structure with time"
E = -Inf;
try
    if isnumeric(En) && isscalar(En)
        E = En;
    elseif isa(En,'timeseries')
        E = En.Data(end);
    elseif istimetable(En)
        v = En.Variables; if ~isempty(v), E = v(end,1); end
    elseif isstruct(En) && isfield(En,'time') && isfield(En,'signals')
        E = En.signals.values(end);
    else
        tmp = double(En); if numel(tmp)>1, tmp = tmp(end); end
        E = tmp;
    end
catch
    E = -Inf;
end
end

function E = try_energy_from_logs(simOut)
% Attempts E = ∫ u(t)*v(t) dt using logsout signals
E = -Inf;
try
    if ~isprop(simOut,'logsout') || isempty(simOut.logsout), return; end
    logs = simOut.logsout;

    uSig   = try_get_signal(logs, {'u','U','control','Control'});
    velSig = try_get_signal(logs, {'vel','velocity','Vel','Velocity','vz','heaveVel'});

    if isempty(uSig) || isempty(velSig), return; end

    [tu,u]   = ts_to_arrays(uSig);
    [tv,vel] = ts_to_arrays(velSig);

    tmin = max(tu(1), tv(1));
    tmax = min(tu(end), tv(end));
    if tmax <= tmin, return; end

    N = min(numel(tu), numel(tv));
    t = linspace(tmin, tmax, N)';
    u_i   = interp1(tu, u,   t, 'linear', 'extrap');
    vel_i = interp1(tv, vel, t, 'linear', 'extrap');

    P = u_i .* vel_i;      % instantaneous power
    E = trapz(t, P);       % energy (J)
catch
    E = -Inf;
end
end

function sig = try_get_signal(logs, names)
sig = [];
for k = 1:numel(names)
    try
        sig = logs.getElement(names{k});
        if ~isempty(sig), return; end
    catch
    end
end
end

function [t,y] = ts_to_arrays(sig)
if isa(sig.Values,'timeseries')
    t = sig.Values.Time(:);
    y = sig.Values.Data(:);
elseif istimetable(sig.Values)
    t = seconds(sig.Values.Time - sig.Values.Time(1));
    y = sig.Values.Variables(:,1);
else
    t = sig.Values.time(:);
    y = sig.Values.signals.values(:);
end
end
