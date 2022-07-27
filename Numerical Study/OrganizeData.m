function [CompleteData] = OrganizeData(Parameters, CR, NPCMDataSet, FNPCMDataSet)

MatrixSizes = Parameters.MatrixSizes; 
BetaParameters = Parameters.BetaParameters;
FuzzificationLevels = Parameters.FuzzificationLevels;
iter = Parameters.iter;
   
k = 1;
EC = 1;

for n = MatrixSizes
    for iterations = 1:iter
        for beta = BetaParameters   
            for alpha = FuzzificationLevels                  
               if CR{EC} <= 0.1
               ConsRat     = CR{EC}; 
               NPCM        = NPCMDataSet{EC};
               FNPCM       = FNPCMDataSet{EC};
                    
               CompleteData{k,1} = n;
               CompleteData{k,2} = alpha;
               CompleteData{k,3} = beta;
               CompleteData{k,4} = ConsRat;
                    
               if ConsRat >= 0 && ConsRat <= 0.03
               CompleteData{k,5} = 1;
               elseif ConsRat > 0.03 && ConsRat <= 0.06
               CompleteData{k,5} = 2;
               elseif ConsRat > 0.06 && ConsRat <= 0.1
               CompleteData{k,5} = 3;
               end
                   
               CompleteData{k,6} = NPCM;
               CompleteData{k,7} = FNPCM;
               CompleteData{k,8} = k;
               k = k + 1;
               
               end   
               EC = EC + 1;
            end             
        end
    end
end

end