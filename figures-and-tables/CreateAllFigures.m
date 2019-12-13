% This script creates all figures of the paper "Predicting wave heights for
% marine design by prioritizing extreme events in a global model" by 
% A.F. Haselsteiner and K-D. Thoben (https://arxiv.org/pdf/1911.12835.pdf).
% 
% This script requires Matlab2019a or newer and the following toolboxes:
% image_toolbox, map_toolbox, statistics_toolbox .

% If true, distributions are fitted, otherwise they are loaded.
DO_FIT_DISTRIBUTIONS = 0;
DO_SUPPLEMENTAL_FIGURE = 0;

if DO_FIT_DISTRIBUTIONS
    load datasets-provided-ABCDEF.mat
    load datasets-retained-ABCDEF.mat
    [Dists, Errors] = fitDistributions(0, 0, 1);
    pdTranslated = Dists.pdTranslated;
    pdExponentiatedMLE = Dists.pdExponentiatedMLE;
    pdExponentiatedWLS = Dists.pdExponentiatedWLS;
    maeTranslated = Errors.maeTranslated;
    maeExponentiatedMLE = Errors.maeExponentiatedMLE;
    maeExponentiatedWLS = Errors.maeExponentiatedWLS;
end

for i = 1:13
    fileName = ['CreateFigure' num2str(i)];
    run(fileName)
end
if DO_SUPPLEMENTAL_FIGURE
    run('CreateFigureS1.m');
end
