function[CrispWeights] = Defuzzify(FuzzyWeights, n)

CrispWeights = cell(n,1);

for i = 1:n
    x = 0:0.000005:1;
    mf = trimf(x,FuzzyWeights{1,i});
%    mf = trapmf(x,FuzzyWeights{1,i}); % For Buckley Method
    CrispWeights(1,i) = defuzz(x,mf,'centroid');
end

end