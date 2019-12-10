% Creates Fig. 3 of https://arxiv.org/pdf/1911.12835.pdf

fig3 = figure('Position', [100 100 700 300]);

load datasets-provided-ABCDEF.mat
if ~exist('DO_FIT_DISTRIBUTIONS') || ~DO_FIT_DISTRIBUTIONS % is set in CreateAllTables.m
	load fitted-distributions
end
datasets = {'A', 'B', 'C', 'D', 'E', 'F', 'Ar', 'Br', 'Cr', 'Dr', 'Er', 'Fr'};

for i = 1
    ax(i) = subplot(1,3,1:2);
    datasetName = datasets{i};
    x = getHsDataset(datasetName);
    histogramColor = [0.9 0.9 0.9];
    histogram(x, 'normalization', 'pdf', 'binwidth', 0.2, ...
        'facecolor', histogramColor);
    hold on
    xi = sort(x);
    
    f = pdTranslated(i).pdf(xi);
    plot(xi, f, '-r', 'linewidth', 1.5);    
    f = pdExponentiatedMLE(i).pdf(xi);
    plot(xi, f, '-.k', 'linewidth', 1.5);    
    f = pdExponentiatedWLS(i).pdf(xi);
    plot(xi, f, '--b', 'linewidth', 1.5); 
    legend({['Dataset ' datasetName], ...
        'Transl. Weibull fitted with maximum likelihood estimation', ...
        'Exp. Weibull fitted with maximum likelihood estimation', ...
        'Exp. Weibull fitted with weighted least squares'}, ...
        'fontsize', 6);
    legend box off
    ylabel('Probability density (-)');
    xlabel('Significant wave height, hs (m)');
    box off
    
    % Show only the tail, p_i > 0.99.
    subplot(1, 3, 3);
    histogram(x, 'normalization', 'pdf', 'binwidth', 0.2, ...
        'facecolor', histogramColor);
    hold on
    f = pdTranslated(i).pdf(xi);
    plot(xi, f, '-r', 'linewidth', 1.5);    
    f = pdExponentiatedMLE(i).pdf(xi);
    plot(xi, f, '-.k', 'linewidth', 1.5);    
    f = pdExponentiatedWLS(i).pdf(xi);
    plot(xi, f, '--b', 'linewidth', 1.5); 
    n = length(x);
    j = [1:1:n];
    pi = (j - 0.5) / n;
    f = pdTranslated(i).pdf(xi);
    index = find(pi > 0.99, 1);
    threshold = xi(index);
    xlim([threshold ceil(max(xi))]);    
    ylim([0 1.2 * pdExponentiatedWLS(i).pdf(threshold)])
    xlabel('Significant wave height, hs (m)');
    box off
end
