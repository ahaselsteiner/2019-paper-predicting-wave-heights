% Uses a logarithmic y-axis for Fig. 4 of https://arxiv.org/pdf/1911.12835.pdf

fig4 = figure('Position', [100 100 700 450]);

load datasets-provided-ABCDEF.mat
if ~exist('DO_FIT_DISTRIBUTIONS') || ~DO_FIT_DISTRIBUTIONS % is set in CreateAllTables.m
	load fitted-distributions
end
datasets = {'A', 'B', 'C', 'D', 'E', 'F', 'Ar', 'Br', 'Cr', 'Dr', 'Er', 'Fr'};

layout = tiledlayout(2,3);
lower_lim = 10^(-6);
upper_lim = 0.025;
for i = 1:6
    ax(i) = nexttile();
    datasetName = datasets{i};
    x = getHsDataset(datasetName);
    histogramColor = [0.9 0.9 0.9];
    h = histogram(x, 'normalization', 'pdf', 'binwidth', 0.5, ...
        'facecolor', histogramColor);
    xx = h.BinEdges + 0.5 * h.BinWidth;
    yy = h.BinCounts;
    yy(yy>10) = NaN;
    ystring = strings(length(yy), 1);
    for j = 1 : length(yy)
        if ~isnan(yy(j))
            ystring(j) = sprintf('%d', yy(j));
        end
    end
   
    hold on
    xi = sort(x);
    xi = [xi; 1.05 * max(xi)];
    
    f = pdTranslated(i).pdf(xi);
    plot(xi, f, '-r', 'linewidth', 1.5);    
    f = pdExponentiatedMLE(i).pdf(xi);
    plot(xi, f, '-.k', 'linewidth', 1.5);    
    f = pdExponentiatedWLS(i).pdf(xi);
    plot(xi, f, '--b', 'linewidth', 1.5); 
    
    text(xx(1:end-1),zeros(1,length(xx(1:end-1))) + lower_lim, ystring, ...
        'vert', 'bottom', 'horiz', 'center', 'fontsize', 6);  
    
    % Show only the tail, p_i > 0.99.
    n = length(x);
    j = [1:1:n];
    pi = (j - 0.5) / n;
    f = pdTranslated(i).pdf(xi);
    index = find(pi > 0.99, 1);
    threshold = xi(index);
    xlim([threshold ceil(max(xi))]);    
    ylim([lower_lim upper_lim])
    box off
    set(gca, 'YScale', 'log')
    set(gca,'YMinorTick','off')
    
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
exportgraphics(fig4,'hs-fig4_yaxis_log.pdf','Resolution',300) 
