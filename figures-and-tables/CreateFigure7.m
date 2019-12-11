% Creates Fig. 7 of https://arxiv.org/pdf/1911.12835.pdf

fig7 = figure('position', [100 100 400 300]);

load datasets-provided-ABCDEF.mat
if ~exist('DO_FIT_DISTRIBUTIONS') || ~DO_FIT_DISTRIBUTIONS % is set in CreateAllTables.m
	load fitted-distributions
end
datasetsProvided = {'A', 'B', 'C', 'D', 'E', 'F'};

pe = 1 / (365.25 * 24);
for i = 1:6
    datasetName = datasetsProvided{i};
    x = getHsDataset(datasetName);
    xi = sort(x);
    n = length(x);
    j = [1:n]';
    pi = (j - 0.5) ./ n;
    indice = find(pi > 1 - pe, 1);
    Hs1_Empirical(i) = xi(indice);
    pe_empirical = 1 - pi(indice);
    Hs1_Translated(i) = pdTranslated(i).icdf(1 - pe_empirical);
    Hs1_ExpMLE(i) = pdExponentiatedMLE(i).icdf(1 - pe_empirical);
    Hs1_ExpWLS(i) = pdExponentiatedWLS(i).icdf(1 - pe_empirical);
end

HsStar1_Translated = Hs1_Translated ./ Hs1_Empirical;
HsStar1_ExpMLE = Hs1_ExpMLE ./ Hs1_Empirical;
HsStar1_ExpWLS = Hs1_ExpWLS ./ Hs1_Empirical;

LINE_WIDTH = 0.5;
hold on
myColors = distinguishable_colors(6);
scatter(ones(6,1), HsStar1_Translated, 60, myColors, 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7);
plot([1 - LINE_WIDTH/2, 1 + LINE_WIDTH/2], [mean(HsStar1_Translated), mean(HsStar1_Translated)], ...
    '-k', 'linewidth', 1.5);

scatter(ones(6,1)+1, HsStar1_ExpMLE, 60, myColors, 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7);
plot([2 - LINE_WIDTH/2, 2 + LINE_WIDTH/2], ...
    [mean(HsStar1_ExpMLE), mean(HsStar1_ExpMLE)], ...
    '-k', 'linewidth', 1.5);

scatter(ones(6,1)+2, HsStar1_ExpWLS, 60, myColors, 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7);
plot([3 - LINE_WIDTH/2, 3 + LINE_WIDTH/2], ...
    [mean(HsStar1_ExpWLS), mean(HsStar1_ExpWLS)], ...
    '-k', 'linewidth', 1.5);
plot([0.5 3.5], [1 1], '--k');

scatter([2.4:1/5:3.4], ones(6,1) - 0.45, 30, myColors, 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7);
text(2.05, 0.6,  'Dataset', 'horizontalalignment', 'left', 'fontsize', 6);
text([2.4:1/5:3.4], ones(6,1) - 0.4,  datasetsProvided, ...
    'horizontalalignment', 'center', 'fontsize', 6);
set(gca, 'xtick', [ 1 2 3]);
set(gca, 'xticklabel', {'Transl. Weibull with MLE', 'Exp. Weibull with MLE', 'Exp. Weibull with WLS'});
xtickangle(45)
ylabel('Normalized 1-year return value, Hs1* (-)')

