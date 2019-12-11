% Creates Fig. 8 of https://arxiv.org/pdf/1911.12835.pdf

fig8 = figure('position', [100 100 400 300]);

if ~exist('DO_FIT_DISTRIBUTIONS') || ~DO_FIT_DISTRIBUTIONS % is set in CreateAllTables.m
	load fitted-distributions
end
datasetsProvided = {'A', 'B', 'C', 'D', 'E', 'F'};

pe = 1 / (50 * 365.25 * 24);
for i = 1:6
    Hs50_Translated(i) = pdTranslated(i).icdf(1 - pe);
    Hs50_expMLE(i) = pdExponentiatedMLE(i).icdf(1 - pe);
    Hs50_expWLS(i) = pdExponentiatedWLS(i).icdf(1 - pe);
end

hold on
scatter([1:6], Hs50_Translated, 80, 'or', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7);
scatter([1:6], Hs50_expMLE, 80, 'dk', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7);
scatter([1:6], Hs50_expWLS, 80, 'sb', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7);
ylabel('50-year return value, Hs50 (m)');
set(gca, 'xtick', [1:6]);
set(gca, 'xticklabel', datasetsProvided);
xlabel('Dataset');
legend({'Translated Weibull distribution with MLE', ...
    'Exp. Weibull distribution with MLE', ...
    'Exp. Weibull distribution with WLS', ...
    }, 'location', 'northwest');
legend box off
xlim([0.7 6.3])
ylim([4.5 25])
