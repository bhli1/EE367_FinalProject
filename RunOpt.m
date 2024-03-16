close all
clear all
addpath('Functions')
addpath 'reticolo_allege_v9'
addpath('reticolo_allege_v9/refractive index/')

% Initialize optimization parameters
% Default values and descriptions found in 'Functions/Initialize.m'
OptParm = Initialize();

% Defines target output angle
target_angle = 0;

% Device parameters
% OptParm.Input.Wavelength = 550;
list_wl = linspace(400,700,50);
OptParm.Input.WavelengthRange = list_wl;
%The target Ground Truth spectrum:
SpGT = ones(size(list_wl)); % abs(gamma_sp./(1i*(list_wl-550)+gamma_sp)); % gamma_sp = 30;
OptParm.Input.SpectrumGroundTruth = SpGT;
OptParm.Input.FoMWeight = ones(size(SpGT));
OptParm.Input.Polarization = 'TM';
OptParm.Optimization.Target = [1];
OptParm.Optimization.SGD.NPatch = 5;
OptParm.Geometry.Thickness = 425; % Device layer thickness

% Compute necessary period corresponding to target angle
period = [800, 50]; % [OptParm.Input.Wavelength*OptParm.Optimization.Target/(sind(target_angle)-sind(OptParm.Input.Theta)),0.5*OptParm.Input.Wavelength];
OptParm.Geometry.Period = period;

% Define # of Fourier orders
OptParm.Simulation.Fourier = [20,0];

% Run robust optimization
OptParm.Optimization.Robustness.StartDeviation = [0]; % Starting edge deviation values
OptParm.Optimization.Robustness.EndDeviation = OptParm.Optimization.Robustness.StartDeviation; % Ending edge deviation values
OptParm.Optimization.Robustness.Weights = [1];

% Plot efficiency history
OptParm.Display.PlotEfficiency = 1;

OptParm.Checkpoint.File = 'TORun'; % Checkpoint file name
% Run optimizations
optout = OptimizeDevice(OptParm);
