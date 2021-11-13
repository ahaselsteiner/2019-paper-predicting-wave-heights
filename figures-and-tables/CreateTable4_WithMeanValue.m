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
firstMomentMLE = cell(6,1);
secondMomentMLE = cell(6,1);
alphaWLS = cell(6,1);
betaWLS = cell(6,1);
deltaWLS = cell(6,1);
firstMomentWLS = cell(6,1);
secondMomentWLS = cell(6,1);
for i = 1:6
    alphaMLE{i} = [num2str(pdExponentiatedMLE(i).Alpha, '%.4f') '±' num2str(pdExponentiatedMLE(i).ParameterSE(1), '%.4f')];
    betaMLE{i} = [num2str(pdExponentiatedMLE(i).Beta, '%.4f') '±' num2str(pdExponentiatedMLE(i).ParameterSE(2), '%.4f')];
    deltaMLE{i} = [num2str(pdExponentiatedMLE(i).Delta, '%.4f') '±' num2str(pdExponentiatedMLE(i).ParameterSE(3), '%.4f')];
    firstMomentMLE{i} = num2str(pdExponentiatedMLE(i).kMoment(1), '%.4f');
    secondMomentMLE{i} = num2str(pdExponentiatedMLE(i).kMoment(2, true), '%.4f');
    alphaWLS{i} = [num2str(pdExponentiatedWLS(i).Alpha, '%.4f') '±' num2str(pdExponentiatedWLS(i).ParameterSE(1), '%.4f')];
    betaWLS{i} = [num2str(pdExponentiatedWLS(i).Beta, '%.4f') '±' num2str(pdExponentiatedWLS(i).ParameterSE(2), '%.4f')];
    deltaWLS{i} = [num2str(pdExponentiatedWLS(i).Delta, '%.4f') '±' num2str(pdExponentiatedWLS(i).ParameterSE(3), '%.4f')];
    firstMomentWLS{i} = num2str(pdExponentiatedWLS(i).kMoment(1), '%.4f');
    secondMomentWLS{i} = num2str(pdExponentiatedWLS(i).kMoment(2, true), '%.4f');
end

Dataset = {'A'; 'A'; 'A'; 'B'; 'B'; 'B'; 'C'; 'C'; 'C'; 'D'; 'D'; 'D'; 'E'; 'E'; 'D'; 'F'; 'F'; 'F'};
perDataset = 3;
alpha = cell(6 * perDataset, 1);
beta = cell(6 * perDataset, 1);
delta = cell(6 * perDataset, 1);
firstMoment = cell(6 * perDataset, 1);
secondMoment = cell(6 * perDataset, 1);
Method = cell(6 * perDataset, 1);
for i = 1:6 * perDataset
    datasetNr = ceil(i/perDataset);
    if mod(i, 3) == 1
        Method{i} = 'MLE';
        alpha{i} = alphaMLE{datasetNr};
        beta{i} = betaMLE{datasetNr};
        delta{i} = deltaMLE{datasetNr};
        firstMoment{i} = firstMomentMLE{datasetNr};
        secondMoment{i} = secondMomentMLE{datasetNr};
    elseif mod(i, 3) == 2
        Method{i} = 'WLS';
        alpha{i} = alphaWLS{datasetNr};
        beta{i} = betaWLS{datasetNr};
        delta{i} = deltaWLS{datasetNr};
        firstMoment{i} = firstMomentWLS{datasetNr};
        secondMoment{i} = secondMomentWLS{datasetNr};
    else
        Method{i} = 'Observed';
        switch datasetNr
            case 1
                hs = A.Hs;
            case 2
                hs = B.Hs;
            case 3
                hs = C.Hs;
            case 4
                hs = D.Hs;
            case 5
                hs = E.Hs;
            case 6
                hs = F.Hs;
        end
        firstMoment{i} = num2str(mean(hs), '%.4f');
        secondMoment{i} = num2str(std(hs)^2, '%.4f');
    end
end


T4 = table(Dataset, Method, alpha, beta, delta, firstMoment, secondMoment)
