function [CrispWeights] = CrispLLSM(InconsistentMatrix)

CrispWeights = geomean(InconsistentMatrix,2);


end
