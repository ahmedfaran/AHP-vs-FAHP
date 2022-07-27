clc
clear all

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

[m, ~] = size(FinalDataSet);
CompatibilityIndex = cell(m,1);

for i = 1:m
NPCM  = FinalDataSet{i,6};
FNPCM = FinalDataSet{i,7};

% CrispWeights = CrispLLSM(NPCM);     % LLSM Method
% CrispWeights = Eigenvector(NPCM);   % Saaty EigenVector Method
FuzzyWeights = Boender(FNPCM);      % LLSM proposed by Boender 
% FuzzyWeights = ModifiedLLSM(FNPCM); % Constraint NLP Model
% FuzzyWeights = Buckley(FNPCM);      % Buckley Geometric Mean Method


% Defuzzify Weights using Centroid Defuzzification
[n,~] = size(FNPCM);
CrispWeights = zeros(1,n);

for k = 1:n
    x = 0:0.00005:1;
    mf = trimf(x,FuzzyWeights{1,k});
%     mf = trapmf(x,FuzzyWeights{1,k});
    CrispWeights(1,k) = defuzz(x, mf, 'centroid');
end  

NormalizedCrispWeights  = CrispWeights/sum(CrispWeights);
CompatibilityIndex{i,1} = Compatibility(NPCM, NormalizedCrispWeights);
i
end



