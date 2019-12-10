% Creates supplementary Table 4 of https://arxiv.org/pdf/1911.12835.pdf .

DO_COMPUTATION = 0;

if DO_COMPUTATION
    load datasets-provided-ABCDEF.mat
    [Dists, Errors] = fitDistributions(1, 0, 0);
    pdExponentiatedMLE = Dists.pdExponentiatedMLE;
    pdExponentiatedWLS = Dists.pdExponentiatedWLS;
else
    load fitted-distributions
end

alphaMLE = cell(6,1);
betaMLE = cell(6,1);
deltaMLE = cell(6,1);
alphaWLS = cell(6,1);
betaWLS = cell(6,1);
deltaWLS = cell(6,1);
for i = 1:6
    alphaMLE{i} = [num2str(pdExponentiatedMLE(i).Alpha, '%.4f') '±' num2str(pdExponentiatedMLE(i).ParameterSE(1), '%.4f')];
    betaMLE{i} = [num2str(pdExponentiatedMLE(i).Beta, '%.4f') '±' num2str(pdExponentiatedMLE(i).ParameterSE(2), '%.4f')];
    deltaMLE{i} = [num2str(pdExponentiatedMLE(i).Delta, '%.4f') '±' num2str(pdExponentiatedMLE(i).ParameterSE(3), '%.4f')];
    alphaWLS{i} = [num2str(pdExponentiatedWLS(i).Alpha, '%.4f') '±' num2str(pdExponentiatedWLS(i).ParameterSE(1), '%.4f')];
    betaWLS{i} = [num2str(pdExponentiatedWLS(i).Beta, '%.4f') '±' num2str(pdExponentiatedWLS(i).ParameterSE(2), '%.4f')];
    deltaWLS{i} = [num2str(pdExponentiatedWLS(i).Delta, '%.4f') '±' num2str(pdExponentiatedWLS(i).ParameterSE(3), '%.4f')];
end

Dataset = {'A'; 'A'; 'B'; 'B'; 'C'; 'C'; 'D'; 'D'; 'E'; 'E'; 'F'; 'F'};
alpha = cell(12, 1);
beta = cell(12, 1);
delta = cell(12, 1);
Method = cell(12, 1);
for i = 1:12
    if mod(i, 2) == 1
        Method{i} = 'MLE';
        alpha{i} = alphaMLE{ceil(i/2)};
        beta{i} = betaMLE{ceil(i/2)};
        delta{i} = deltaMLE{ceil(i/2)};
    else
        Method{i} = 'WLS';
        alpha{i} = alphaWLS{ceil(i/2)};
        beta{i} = betaWLS{ceil(i/2)};
        delta{i} = deltaWLS{ceil(i/2)};
    end
end


T4 = table(Dataset, Method, alpha, beta, delta)
