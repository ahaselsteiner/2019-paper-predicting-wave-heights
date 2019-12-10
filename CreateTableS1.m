% Creates supplementary Table 1 of https://arxiv.org/pdf/1911.12835.pdf .

DO_COMPUTATION = 1;

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
A = temp(:, 1);
B = temp(:, 2);
C = temp(:, 3);
D = temp(:, 4);
E = temp(:, 5);
F = temp(:, 6);
Mean = mean(temp')';
Std = std(temp')';

TS1 = table(Distribution, A, B, C, D, E, F, Mean, Std)
