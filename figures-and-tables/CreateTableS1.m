% Creates supplementary Table 1 of https://arxiv.org/pdf/1911.12835.pdf .

DO_COMPUTATION = 0;

if DO_COMPUTATION
    load datasets-provided-ABCDEF.mat
    [Dists, Errors] = fitDistributions(0, 1, 0);
    pdTranslated = Dists.pdTranslated;
    pdExponentiatedMLE = Dists.pdExponentiatedMLE;
    pdExponentiatedWLS = Dists.pdExponentiatedWLS;
    pdGamma = Dists.pdGamma;
    pdBeta = Dists.pdBeta;
    maeTranslated = Errors.maeTranslated;
    maeExponentiatedMLE = Errors.maeExponentiatedMLE;
    maeExponentiatedWLS = Errors.maeExponentiatedWLS;
    maeGamma = Errors.maeGamma;
    maeBeta = Errors.maeBeta;
else
    load fitted-distributions
end


Distribution = {'Translated Weibull'; 'Exponentiated Weibull'; 'Generalized gamma'; '3-parameter Beta'};
temp = [maeTranslated; maeExponentiatedMLE; maeGamma; maeBeta];
Mean = mean(temp')';
Std = std(temp')';

A = cell(4, 1);
B = cell(4, 1);
C = cell(4, 1);
D = cell(4, 1);
E = cell(4, 1);
F = cell(4, 1);
MeanAndStandardDeviation = cell(4, 1);
for i = 1:4
    A{i} = num2str(temp(i, 1), '%.4f');
    B{i} = num2str(temp(i, 2), '%.4f');
    C{i} = num2str(temp(i, 3), '%.4f');
    D{i} = num2str(temp(i, 4), '%.4f');
    E{i} = num2str(temp(i, 5), '%.4f');
    F{i} = num2str(temp(i, 6), '%.4f');
    MeanAndStandardDeviation{i} = [num2str(Mean(i), '%.4f') '±' num2str(Std(i), '%.4f')];
end

TS1 = table(Distribution, A, B, C, D, E, F, MeanAndStandardDeviation)
