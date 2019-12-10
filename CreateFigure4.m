% Creates Fig. 4 of https://arxiv.org/pdf/1911.12835.pdf

fig4 = figure('Position', [100 100 700 450]);

load datasets-provided-ABCDEF.mat
if ~exist('DO_FIT_DISTRIBUTIONS') || ~DO_FIT_DISTRIBUTIONS % is set in CreateAllTables.m
	load fitted-distributions
end
datasets = {'A', 'B', 'C', 'D', 'E', 'F', 'Ar', 'Br', 'Cr', 'Dr', 'Er', 'Fr'};

for i = 1:6
    ax(i) = subplot(2,3,i);
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
    
    % Show only the tail, p_i > 0.99.
    n = length(x);
    j = [1:1:n];
    pi = (j - 0.5) / n;
    f = pdTranslated(i).pdf(xi);
    index = find(pi > 0.99, 1);
    threshold = xi(index);
    xlim([threshold ceil(max(xi))]);    
    ylim([0 1.2 * pdExponentiatedWLS(i).pdf(threshold)])
    box off
    
    if i == 1
        legend({'Observations', 'Transl. Weibull fitted with MLE', ...
            'Exp. Weibull fitted with MLE', 'Exp. Weibull fitted with WLS'}, ...
            'fontsize', 6);
        legend box off
    end
    if mod(i, 3) == 1
        ylabel('Probability density (-)');
    end
    if i > 3
        xlabel('Significant wave height (m)');
    end
    title(['Dataset ' num2str(datasetName)]);
end
