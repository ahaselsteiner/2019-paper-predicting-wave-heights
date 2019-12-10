% Creates Fig. 12 of https://arxiv.org/pdf/1911.12835.pdf

fig12 =  figure('position', [100 100 800 350]);

load datasets-provided-ABCDEF.mat
if ~exist('DO_FIT_DISTRIBUTIONS') || ~DO_FIT_DISTRIBUTIONS % is set in CreateAllTables.m
	load fitted-distributions
end
datasetsProvided = {'A', 'B', 'C', 'D', 'E', 'F'};

for j = 1:2
    datasetName = datasetsProvided{j};
    x = getHsDataset(datasetName);
    xi = sort(x);
    n = length(x);
    i = [1:1:n]';
    pi = (i - 0.5) / n;
    pstar_i = computePStar(pi, 1);
    xHat_ExpMLE = pdExponentiatedMLE(j).icdf(pi);
    xHat_Translated = pdTranslated(j).icdf(pi);
    
    % 2 parameter Weibull
    parmHat = wblfit(x);
    pd2PWbl = ExponentiatedWeibull(parmHat(1), parmHat(2), 1);
    xHat_2pWbl = pd2PWbl.icdf(pi);
    subplot(1,2,j);
    plot(log10(xi), pstar_i, 'xk', 'markersize', 4, 'color', [0.5 0.5 0.5]);
    hold on
    plot(log10(xHat_2pWbl), pstar_i, '-k', 'linewidth', 1.5);
    plot(log10(xHat_Translated), pstar_i, '--k', 'linewidth', 1.5);
    plot(log10(xHat_ExpMLE), pstar_i, '-.k', 'linewidth', 1.5);
    xticks = [0.2 0.5 1 2 4 6 8 10 12];
    set(gca, 'xtick', log10(xticks));
    set(gca, 'xticklabel', xticks);
    xlabel('Significant wave height (m)');
    yticks = [0.05 0.1 0.2 0.5 0.8 0.9 0.95 0.99 0.999 0.9999 0.99999 0.999999];
    set(gca, 'ytick', computePStar(yticks, 1));
    if j == 1
        set(gca, 'yticklabel', yticks);
        ylabel('Probability (-)');
    else
        set(gca, 'yticklabel', cell(length(yticks), 1));
    end
    xlim(log10([0.16 13.5]));
    ylim(computePStar([0.05 0.999999], 1))
    grid on
    twoParamString = ['2-parameter Weibull ' char(10) '(\alpha = '...
        num2str(parmHat(1), '%.4f') ', \beta = ' num2str(parmHat(2), '%.4f') ')'];
    translatedString = ['Translated Weibull ' char(10) ...
        '(\alpha = ' num2str(pdTranslated(j).Alpha, '%.4f') ...
        ', \beta = ' num2str(pdTranslated(j).Beta, '%.4f') ...
        ', \gamma = ' num2str(pdTranslated(j).Gamma, '%.4f') ')'];
    expString = ['Exponentiated Weibull ' char(10) ...
        '(\alpha = ' num2str(pdExponentiatedMLE(j).Alpha, '%.4f') ...
        ', \beta = ' num2str(pdExponentiatedMLE(j).Beta, '%.4f') ...
        ', \delta = ' num2str(pdExponentiatedMLE(j).Delta, '%.4f') ')'];
    legend({['Dataset ' datasetName], twoParamString, translatedString, ...
        expString}, 'location', 'southeast', 'fontsize', 6);
    legend box off
end


function pstar_i = computePStar(pi, delta)
    pstar_i = log10(-log(1 - pi.^(1 ./ delta)));
end

