% Creates supplementary Fig. 1 of https://arxiv.org/pdf/1911.12835.pdf
% Note that if you reproduce this figure, the results will be slightly 
% different than in the paper because we are using randomly drawn
% samples.

pdTrue = ExponentiatedWeibull(1, 1, 2);
n = 100000;
nOfSamples = 100;
alphaEstimated = nan(nOfSamples, 1);
betaEstimated = nan(nOfSamples, 1);
deltaEstimated = nan(nOfSamples, 1);
pdEstimated = ExponentiatedWeibull.empty(nOfSamples, 0);
for i = 1:nOfSamples
    sample = pdTrue.drawSample(n);
    pdEstimated(i) = ExponentiatedWeibull();
    pdEstimated(i).fitDist(sample, 'WLS');
    alphaEstimated(i) = pdEstimated(i).Alpha;
    betaEstimated(i) = pdEstimated(i).Beta;
    deltaEstimated(i) = pdEstimated(i).Delta;
end

figS1 = figure('position', [100 100 500, 180]);
subplot(1, 3, 1)
hold on
plot([0.5 1.5], [1 1], ':k', 'linewidth', 1)
h = boxplot(alphaEstimated, {'$$\hat{\alpha}$$'});
set(h,{'linew'},{1})
bp = gca;
bp.XAxis.TickLabelInterpreter = 'latex';
%text(1.15, 1, [num2str(mean(alphaEstimated), '%1.3f') '+-' ...
%    num2str(std(alphaEstimated), '%1.3f')], 'fontsize', 8, ...
%    'verticalalignment', 'bottom'); 
box off

subplot(1, 3, 2)
hold on
plot([0.5 1.5], [1 1], ':k')
h = boxplot(betaEstimated, {'$$\hat{\beta}$$'});
set(h,{'linew'},{1});
bp = gca;
bp.XAxis.TickLabelInterpreter = 'latex';
%text(1.15, 1, [num2str(mean(betaEstimated), '%1.3f') '+-' ...
%    num2str(std(betaEstimated), '%1.3f')], 'fontsize', 8, ...
%    'verticalalignment', 'bottom');
box off

subplot(1, 3, 3)
hold on
plot([0.5 1.5], [2 2], ':k');
h = boxplot(deltaEstimated, {'$$\hat{\delta}$$'});
set(h,{'linew'},{1});
bp = gca;
bp.XAxis.TickLabelInterpreter = 'latex';
%text(1.15, 2, [num2str(mean(deltaEstimated), '%1.3f') '+-' ...
%    num2str(std(deltaEstimated), '%1.3f')], 'fontsize', 8, ...
%    'verticalalignment', 'bottom'); 
box off
suptitle(['Parameter estimation, true parameters: ' ...
    num2str(pdTrue.Alpha) ', ' num2str(pdTrue.Beta) ', ' num2str(pdTrue.Delta)]);
