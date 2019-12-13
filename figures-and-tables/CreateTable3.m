% Creates supplementary Table 3 of https://arxiv.org/pdf/1911.12835.pdf .

DO_COMPUTATION = 0;

if DO_COMPUTATION
    load datasets-provided-ABCDEF.mat
    [Dists, Errors] = fitDistributions(1, 0, 0);
    pdTranslated = Dists.pdTranslated;
else
    load fitted-distributions
end

alpha = cell(6,1);
beta = cell(6,1);
gamma = cell(6,1);
for i = 1:6
    alpha{i} = [num2str(pdTranslated(i).Alpha, '%.4f') '±' num2str(pdTranslated(i).ParameterSE(1), '%.4f')];
    beta{i} = [num2str(pdTranslated(i).Beta, '%.4f') '±' num2str(pdTranslated(i).ParameterSE(2), '%.4f')];
    gamma{i} = [num2str(pdTranslated(i).Gamma, '%.4f') '±' num2str(pdTranslated(i).ParameterSE(3), '%.4f')];
end
Dataset = {'A'; 'B'; 'C'; 'D'; 'E'; 'F'};

T3 = table(Dataset, alpha, beta, gamma)
