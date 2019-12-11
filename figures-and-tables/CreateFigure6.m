% Creates Fig. 6 of https://arxiv.org/pdf/1911.12835.pdf

fig6 = figure('position', [100 100 700 300]);

load datasets-provided-ABCDEF.mat
if ~exist('DO_FIT_DISTRIBUTIONS') || ~DO_FIT_DISTRIBUTIONS % is set in CreateAllTables.m
	load fitted-distributions
end
datasetsProvided = {'A', 'B', 'C', 'D', 'E', 'F'};

upperYLimit = [0.10, 1.2, 3];
for i = 1:6
    datasetName = datasetsProvided{i};
    x = getHsDataset(datasetName);
    mae_3p(i) =  pdTranslated(i).meanabsoluteerror(x);
    mae_exp_mle(i) = pdExponentiatedMLE(i).meanabsoluteerror(x);
    mae_exp_wls(i) = pdExponentiatedWLS(i).meanabsoluteerror(x);
    % Compute MAE for 1%-tail
    hsi = sort(x);
    n = length(x);
    k = [1:n]';
    pi = (k - 0.5) ./ n;
    indice = find(pi > 0.99);
    hsi_high = hsi(indice);
    pi_high = pi(indice);
    hmae_3p(i) =  pdTranslated(i).meanabsoluteerror(hsi_high, pi_high);
    hmae_exp_mle(i) = pdExponentiatedMLE(i).meanabsoluteerror(hsi_high, pi_high);
    hmae_exp_wls(i) = pdExponentiatedWLS(i).meanabsoluteerror(hsi_high, pi_high);

    indice = find(pi > 0.999);
    hsi_veryhigh = hsi(indice);
    pi_veryhigh = pi(indice);
    vhmae_3p(i) =  pdTranslated(i).meanabsoluteerror(hsi_veryhigh, pi_veryhigh);
    vhmae_exp_mle(i) = pdExponentiatedMLE(i).meanabsoluteerror(hsi_veryhigh, pi_veryhigh);
    vhmae_exp_wls(i) = pdExponentiatedWLS(i).meanabsoluteerror(hsi_veryhigh, pi_veryhigh);
    mae_ax = subplot(1,3,1);
    hold on
end
r = rectangle('Position', [6.5, 0, 1, upperYLimit(1)], ...
    'FaceColor', [0.7 0.7 0.7 0.5], 'EdgeColor', 'none');
scatter([1:6], mae_3p, 80, 'or', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7);
scatter([1:6], mae_exp_mle, 80, 'dk', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7);
scatter([1:6], mae_exp_wls, 80, 'sb', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7);
scatter(7, mean(mae_3p), 80, 'ow', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7, 'LineWidth', 2);
scatter(7, mean(mae_exp_mle), 80, 'dw', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7, 'LineWidth', 2);
scatter(7, mean(mae_exp_wls), 80, 'sw', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7, 'LineWidth', 2);
ylabel('Mean absolute error (m)');
set(gca, 'xtick', [1:7]);
xTickLabelString = datasetsProvided;
xTickLabelString{end + 1} = 'Mean';
set(gca, 'xticklabel', xTickLabelString);
xlabel('Dataset');
xlim([0.7 7.5])
ylim([0 upperYLimit(1)]);
title('Whole range of datasets');

mae_ax = subplot(1,3,2);
hold on
r = rectangle('Position', [6.5, 0, 1, upperYLimit(2)], ...
    'FaceColor', [0.7 0.7 0.7 0.5], 'EdgeColor', 'none');
scatter([1:6], hmae_3p, 80, 'or', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7);
scatter([1:6], hmae_exp_mle, 80, 'dk', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7);
scatter([1:6], hmae_exp_wls, 80, 'sb', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7);
scatter(7, mean(hmae_3p), 80, 'ow', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7, 'LineWidth', 2);
scatter(7, mean(hmae_exp_mle), 80, 'dw', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7, 'LineWidth', 2);
scatter(7, mean(hmae_exp_wls), 80, 'sw', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7, 'LineWidth', 2);
set(gca, 'xtick', [1:7]);
set(gca, 'xticklabel', xTickLabelString);
ylim([0 upperYLimit(2)]);
xlabel('Dataset');
xlim([0.7 7.5])
title('Only the tail, pi > 0.99');

mae_ax = subplot(1,3,3);
hold on
r = rectangle('Position', [6.5, 0, 1, upperYLimit(3)], ...
        'FaceColor', [0.7 0.7 0.7 0.5], 'EdgeColor', 'none');
scatter([1:6], vhmae_3p, 80, 'or', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7);
scatter([1:6], vhmae_exp_mle, 80, 'dk', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7);
scatter([1:6], vhmae_exp_wls, 80, 'sb', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7);
scatter(7, mean(vhmae_3p), 80, 'ow', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7, 'LineWidth', 2);
scatter(7, mean(vhmae_exp_mle), 80, 'dw', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7, 'LineWidth', 2);
scatter(7, mean(vhmae_exp_wls), 80, 'sw', 'filled', ...
    'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 0.7, 'LineWidth', 2);
set(gca, 'xtick', [1:7]);
set(gca, 'xticklabel', xTickLabelString);
ylim([0 upperYLimit(3)]);
xlabel('Dataset');
xlim([0.7 7.5])
title('Only the very tail, pi > 0.999');

suptitle('');
hh = legend({'Transl. Weibull distribution with MLE', ...
    'Exp. Weibull distribution with MLE', ...
    'Exp. Weibull distribution with WLS', ...
    }, 'position', [0.5 0.95 0 0], 'Orientation','horizontal', ...
    'fontsize', 6);