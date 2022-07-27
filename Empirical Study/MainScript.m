clc
clear all

%Read Data from Excel Files
% RawExcelData = xlsread('Group3.xlsx','Visual');
RawExcelData = xlsread('Group4.xlsx','Weight');

%Generate LPCM Matrices from Empirical Data from Group 1 and 2
% LPCMmatrixData = ProcessExcelData(RawExcelData);

%Generate LPCM Matrices from Empirical Data from Group 3 and 4
LPCMmatrixData = ProcessExcelData2(RawExcelData);

% n will give us number of participants
[n, ~] = size(LPCMmatrixData);

% True Weight Matrix will be needed to evaluate closeness of 
% Priority Vectors from True Weights
TrueWeights = [0.2000 0.1778 0.1556 0.1333 0.1111...
               0.0889 0.0667 0.0444 0.0222];          

TrueWeightMatrix = zeros(9,9);
for i = 1:9
    for j = 1:9
    TrueWeightMatrix(i,j) = TrueWeights(i)./TrueWeights(j);       
    end
end

%Preallocations
CIVwithPCM = cell(n,1);
CIVwithTrueWeights = cell(n,1);
CR = cell(n,1);

%Preallocations for Debugging and validations
% CrispInconsistentMatrix = cell(n,1);
% FuzzyInconsistentMatrix = cell(n,1);
% NormalizedCrispWeightsData = cell(n,1);
% UnnormalizedFuzzyWeights = cell(n,1);

for i = 1:n

LPCMmatrix = LPCMmatrixData{i,1};

%Define Crisp Scale to be Used 
% Saaty Scale of 1 - 9
NumericScale = [1/9 1/8 1/7 1/6 1/5 1/4 1/3 1/2 1 ...
                    2.00 3.00 4.00 5.00 6.00 7.00 8.00 9.00];
% Personalized Scale
% NumericScale = IndividualizeScale(LPCMmatrix);
 
%Based on Selected Scale, generate NPCM
NPCMmatrix = LPCMtoCrispNPCM(LPCMmatrix, NumericScale);
    
CR{i,1} = CalculateConsistency(NPCMmatrix);

%If Crisp Scale is Used
%Logarithmic Least Squares Method
%     CrispWeights = CrispLLSM(NPCMmatrix);
%Saaty Original Eigen Vector Approach
%     CrispWeights = Eigenvector(NPCMmatrix);

%     %If Fuzzy Scale is Used
    alpha = 0.99;
    FuzzyMatrix   = FuzzifyMatrix(alpha, NPCMmatrix);
    
%     FuzzyWeights  = Boender(FuzzyMatrix);
%     FuzzyWeights  = ModifiedLLSM(FuzzyMatrix);
    FuzzyWeights  = Buckley(FuzzyMatrix);

% Defuzzifcation of Fuzzy Weights
 CrispWeights = zeros(1,9);
 for p = 1:9
     x = 0:0.000005:1;
%      mf = trimf(x,FuzzyWeights{1,p});
     mf = trapmf(x,FuzzyWeights{1,p});
     CrispWeights(1,p) = defuzz(x,mf,'centroid');
 end

    NormalizedCrispWeights  = CrispWeights/sum(CrispWeights);
    % Find Compatibility between IPCM and calculated normalized Weights
    CIVwithPCM{i,1} = Compatibility(NPCMmatrix, NormalizedCrispWeights);
    % Find Compatibility between true weights and calculated normalized Weights
    CIVwithTrueWeights{i,1} = Compatibility(TrueWeightMatrix, NormalizedCrispWeights);

    % Storage used to debugging and validation
%     CrispInconsistentMatrix{i,1} = InconsistentMatrix;
%     FuzzyInconsistentMatrix{i,1} = FuzzyMatrix;
%     UnnormalizedFuzzyWeights{i,1} = FuzzyWeights;
%     NormalizedCrispWeightsData{i,1} = NormalizedCrispWeights;

end
