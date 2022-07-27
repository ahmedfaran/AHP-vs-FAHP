function[FinalDataSet] = GenerateDataSet(Parameters)

% Experimental Conditions
MatrixSizes = Parameters.MatrixSizes; 
BetaParameters = Parameters.BetaParameters;
FuzzificationLevels = Parameters.FuzzificationLevels;
iter = Parameters.iter;

% Preallocations
NumberOfMatrices = iter*length(MatrixSizes)*length(BetaParameters)*length(FuzzificationLevels);
% = iter * n * alpha * beta

CR           = cell(NumberOfMatrices,1);
NPCMDataSet  = cell(NumberOfMatrices,1);
FNPCMDataSet = cell(NumberOfMatrices,1);

z = 1;
for n = MatrixSizes
    for iterations = 1:iter        
    % Generate Perfectly Consistent Crisp Matrix
    CompMatrix = GenerateConsistentMatrix(n);
        % Add Inconsistency in a Comparison Matrix     
        for beta = BetaParameters    
        NPCM =  AddInconsistency(n, beta, CompMatrix);            
          % Fuzzify Matrices 
          for alpha = FuzzificationLevels
          FNPCM   = FuzzifyMatrix(n, alpha, NPCM);
          %Calculate inconsistency of crisp NPCM
          CR{z,1} = CalculateConsistency(NPCM);
          
          if CR{z,1} <0.00001
          CR{z,1} = 0;
          end
          
          NPCMDataSet{z,1}  = NPCM;         
          FNPCMDataSet{z,1} = FNPCM;
     
          z = z + 1;             
          end
        end
    end
end

CompleteData = OrganizeData(Parameters, CR, NPCMDataSet, FNPCMDataSet);

FinalDataSet = CleanData(CompleteData);

end