function [FinalDataSet] = CleanData(CompleteDataSet)

CompleteData = cell2mat(CompleteDataSet(:,1:5));
% M(:,1)==b return true for all rows with first element equal to b
condition = CompleteData(:,5) == 0;

% Remove rows
CompleteDataSet(condition,:)=[];

condition = CompleteData(:,1) == 3 & CompleteData(:,5) == 1 ;
A_3_1 = CompleteDataSet(condition,:);
A_3_1 = A_3_1(1:200,:);

condition = CompleteData(:,1) == 3 & CompleteData(:,5) == 2 ;
A_3_2 = CompleteDataSet(condition,:);
A_3_2 = A_3_2(1:200,:);

condition = CompleteData(:,1) == 3 & CompleteData(:,5) == 3 ;
A_3_3 = CompleteDataSet(condition,:);
A_3_3 = A_3_3(1:200,:);

condition = CompleteData(:,1) == 7 & CompleteData(:,5) == 1 ;
A_7_1 = CompleteDataSet(condition,:);
A_7_1 = A_7_1(1:200,:);

condition = CompleteData(:,1) == 7 & CompleteData(:,5) == 2 ;
A_7_2 = CompleteDataSet(condition,:);
A_7_2 = A_7_2(1:200,:);

condition = CompleteData(:,1) == 7 & CompleteData(:,5) == 3 ;
A_7_3 = CompleteDataSet(condition,:);
A_7_3 = A_7_3(1:200,:);

condition = CompleteData(:,1) == 11 & CompleteData(:,5) == 1 ;
A_11_1 = CompleteDataSet(condition,:);
A_11_1 = A_11_1(1:200,:);

condition = CompleteData(:,1) == 11 & CompleteData(:,5) == 2 ;
A_11_2 = CompleteDataSet(condition,:);
A_11_2 = A_11_2(1:200,:);

condition = CompleteData(:,1) == 11 & CompleteData(:,5) == 3 ;
A_11_3 = CompleteDataSet(condition,:);
A_11_3 = A_11_3(1:200,:);

condition = CompleteData(:,1) == 15 & CompleteData(:,5) == 1 ;
A_15_1 = CompleteDataSet(condition,:);
A_15_1 = A_15_1(1:200,:);

condition = CompleteData(:,1) == 15 & CompleteData(:,5) == 2 ;
A_15_2 = CompleteDataSet(condition,:);
A_15_2 = A_15_2(1:200,:);

condition = CompleteData(:,1) == 15 & CompleteData(:,5) == 3 ;
A_15_3 = CompleteDataSet(condition,:);
A_15_3 = A_15_3(1:200,:);

FinalDataSet = vertcat(A_3_1,  A_3_2,  A_3_3, ...
                       A_7_1,  A_7_2,  A_7_3, ...
                       A_11_1, A_11_2, A_11_3,...
                       A_15_1, A_15_2, A_15_3);
                  
end