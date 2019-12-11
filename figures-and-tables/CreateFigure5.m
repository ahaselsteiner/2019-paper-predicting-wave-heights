% Creates Fig. 5 of https://arxiv.org/pdf/1911.12835.pdf

fig5 = figure('position', [100 100 800 400]);

load datasets-provided-ABCDEF.mat
if ~exist('DO_FIT_DISTRIBUTIONS') || ~DO_FIT_DISTRIBUTIONS % is set in CreateAllTables.m
	load fitted-distributions
end
datasetsProvided = {'A', 'B', 'C', 'D', 'E', 'F'};

for i=1:6, qq_ax_provided_trans_wbl(i) = subplot(3,6,i); end
for i=1:6, qq_ax_provided_exp_mle(i) = subplot(3,6,6+i); end
for i=1:6, qq_ax_provided_exp_wls(i) = subplot(3,6,12+i); end
for i = 1:6
    datasetName = datasetsProvided{i};
    x = getHsDataset(datasetName);
    % Translated Weibull, MLE
    set(0, 'currentfigure', fig5);
    pdTranslated(i).qqplot(x, fig5, ...
        qq_ax_provided_trans_wbl(i), [1 0 0])
    title(['Dataset ' datasetName]);
    if i == 1
        ylabel('Ordered values, hs (m)');
        text(4.2, 2, ['Transl. Weibull' char(10) 'fitted with MLE'], ...
            'horizontalalignment', 'center', 'color', 'red', 'fontsize', 6);
    else
        ylabel('');
    end
    xlabel('');

    % Exponentiated Weibull, MLE
    pdExponentiatedMLE(i).qqplot(x, fig5, ...
        qq_ax_provided_exp_mle(i), [0 0 0]);
    title(datasetName);
    if i == 1
        ylabel('Ordered values, hs (m)');
        text(5, 12, ['Exp. Weibull' char(10) 'fitted with MLE'], ...
            'horizontalalignment', 'center', 'color', 'black', 'fontsize', 6);
    else
        ylabel('');
    end
    xlabel('');
    
    % Exponentiated Weibull, WLS
    pdExponentiatedWLS(i).qqplot(x, fig5, ...
        qq_ax_provided_exp_wls(i), [0 0 1]);
    title(datasetName);
    if i == 1
        ylabel('Ordered values, hs (m)');
        text(4, 9, ['Exp. Weibull' char(10) 'fitted with WLS'], ...
            'horizontalalignment', 'center', 'color', 'blue', 'fontsize', 6);
    else
        ylabel('');
    end
    xlabel('Theoretical quantiles');
end
