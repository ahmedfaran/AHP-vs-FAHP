clc
clear all

% Standard Default Setup to Generate Random Numbers
rng('default');
rng(1);

% Define Experimental Conditions to Generate Numerical DataSet
MatrixSizes = [3 7 11 15];
BetaParameters = [0 0.2 0.4 0.6 0.8 1.00];
FuzzificationLevels = [0.1 0.2 0.3 0.4];
iter = 200;

% Parameterize the Experimental Conditions
Parameters.MatrixSizes = MatrixSizes;
Parameters.BetaParameters = BetaParameters;
Parameters.FuzzificationLevels = FuzzificationLevels;
Parameters.iter = iter;

FinalDataSet = GenerateDataSet(Parameters);



