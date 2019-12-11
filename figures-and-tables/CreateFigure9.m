% Creates Fig. 9 of https://arxiv.org/pdf/1911.12835.pdf

fig9 = figure('position', [100 100 800 400]);

load datasets-retained-ABCDEF.mat
if ~exist('DO_FIT_DISTRIBUTIONS') || ~DO_FIT_DISTRIBUTIONS % is set in CreateAllTables.m
	load fitted-distributions
end
datasetsRetained = {'Ar', 'Br', 'Cr', 'Dr', 'Er', 'Fr'};

for i=1:6, qqAxTranslated(i) = subplot(3,6,i); end
for i=1:6, qqAxExpMLE(i) = subplot(3,6,6+i); end
for i=1:6, qqAxExpWLS(i) = subplot(3,6,12+i); end
for i = 1:6
    datasetName = datasetsRetained{i};
    x = getHsDataset(datasetName);
    % Translated Weibull, MLE
    set(0, 'currentfigure', fig9);
    pdTranslated(i).qqplot(x, fig9, ...
        qqAxTranslated(i), [1 0 0])
    title(['Dataset ' datasetName]);
    if i == 1
        ylabel('Ordered values, hs (m)');
        text(5, 2, ['Transl. Weibull' char(10) 'fitted with MLE'], ...
            'horizontalalignment', 'center', 'color', 'red', 'fontsize', 6);
    else
        ylabel('');
    end
    xlabel('');

    % Exponentiated Weibull, MLE
    pdExponentiatedMLE(i).qqplot(x, fig9, ...
        qqAxExpMLE(i), [0 0 0]);
    title(datasetName);
    if i == 1
        ylabel('Ordered values, hs (m)');
        text(10.5, 3, ['Exp. Weibull' char(10) 'fitted with MLE'], ...
            'horizontalalignment', 'center', 'color', 'black', 'fontsize', 6);
    else
        ylabel('');
    end
    xlabel('');
    
    % Exponentiated Weibull, WLS
    pdExponentiatedWLS(i).qqplot(x, fig9, ...
        qqAxExpWLS(i), [0 0 1]);
    title(datasetName);
    if i == 1
        ylabel('Ordered values, hs (m)');
        text(7, 2.5, ['Exp. Weibull' char(10) 'fitted with WLS'], ...
            'horizontalalignment', 'center', 'color', 'blue', 'fontsize', 6);
    else
        ylabel('');
    end
    xlabel('Theoretical quantiles');
end
