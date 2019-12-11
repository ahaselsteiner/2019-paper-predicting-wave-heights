% Creates Fig. 1 of https://arxiv.org/pdf/1911.12835.pdf

fig1 = figure('Position', [100 100 400 150]);
ax1 = subplot(1, 2, 1);
ax2 = subplot(1, 2, 2);

load datasets-provided-ABCDEF.mat
if ~exist('DO_FIT_DISTRIBUTIONS') || ~DO_FIT_DISTRIBUTIONS % is set in CreateAllTables.m
	load fitted-distributions
end
datasets = {'A', 'B', 'C', 'D', 'E', 'F', 'Ar', 'Br', 'Cr', 'Dr', 'Er', 'Fr'};

for i = 1
    set(fig1, 'CurrentAxes', ax1);
    datasetName = datasets{i};
    x = getHsDataset(datasetName);
    histogramColor = [0.9 0.9 0.9];
    histogram(x, 'normalization', 'pdf', 'binwidth', 0.2, ...
        'facecolor', histogramColor);
    hold on
    xi = sort(x);
        f = pdTranslated(i).pdf(xi);
    plot(xi, f, '-r', 'linewidth', 1.5);  
    xlim([ -0.1 4.2])
    ylabel('Probability density (-)');
    xlabel('Significant wave height (m)');
    box off
    
    % Show only the tail, p_i > 0.99.
    set(fig1, 'CurrentAxes', ax2);
    histogram(x, 'normalization', 'pdf', 'binwidth', 0.2, ...
        'facecolor', histogramColor);
    hold on
    f = pdTranslated(i).pdf(xi);
    plot(xi, f, '-r', 'linewidth', 1.5);    
    n = length(x);
    j = [1:1:n];
    pi = (j - 0.5) / n;
    f = pdTranslated(i).pdf(xi);
    index = find(pi > 0.99, 1);
    threshold = xi(index);
    xlim([threshold ceil(max(xi))]);    
    ylim([0 1.5 * pdTranslated(i).pdf(threshold)])
    xlabel('Significant wave height (m)');
    box off
    
end
