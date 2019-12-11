% Creates Fig. 13 of https://arxiv.org/pdf/1911.12835.pdf

fig13 = figure('position', [100, 100, 950, 300], 'renderer', 'Painters');

load datasets-provided-ABCDEF.mat
if ~exist('DO_FIT_DISTRIBUTIONS') || ~DO_FIT_DISTRIBUTIONS % is set in CreateAllTables.m
	load fitted-distributions
end

datasetName = 'D';
v = D.V;
hs = D.Hs;

binWidth = 2;
minDataPointsInBin = 100;
nOfBins = ceil((max(v) / binWidth));

pdHs_Exp = ExponentiatedWeibull.empty(nOfBins, 0);
xi = cell(nOfBins, 1);
pstar_i = cell(nOfBins, 1);
xHat_2pWbl = cell(nOfBins, 1);
xHat_Exp = cell(nOfBins, 1);
hsInBin = cell(nOfBins,1);
lowerLimit = nan(nOfBins, 1);
upperLimit = nan(nOfBins, 1);

for i = 1:nOfBins
    lowerLimit(i) = (i - 1) * binWidth;
    upperLimit(i) = i * binWidth;
    vIsInBin = (v > lowerLimit(i)) .* (v < upperLimit(i));
    hsInBin{i} = hs(logical(vIsInBin));
    if length(hsInBin{i}) >= minDataPointsInBin
        xi{i} = sort(hsInBin{i});
        n = length(xi{i});
        j = [1:1:n]';
        pi = (j - 0.5) / n;
        pstar_i{i} = computePStar(pi, 1);
        
        pdHs_Exp(i) = ExponentiatedWeibull();
        pdHs_Exp(i).fitDist(hsInBin{i}, 'WLS');
        parmHat = wblfit(hsInBin{i});
        pdHs_2pWbl(i) = makedist('Weibull', parmHat(1), parmHat(2));

        xHat_2pWbl{i} = pdHs_2pWbl(i).icdf(pi);
        xHat_Exp{i} = pdHs_Exp(i).icdf(pi);
    end
end

for i = 1:length(pdHs_Exp)
    subplot(2, ceil(length(pdHs_Exp) / 2), i);
    plot(log10(xi{i}), pstar_i{i}, 'xk', 'markersize', 4, 'color', [0.5 0.5 0.5]);
    hold on
    plot(log10(xHat_2pWbl{i}), pstar_i{i}, '-k', 'linewidth', 1.5);
    plot(log10(xHat_Exp{i}), pstar_i{i}, '-.k', 'linewidth', 1.5);
    xticks = [0.2 0.5 1 2 4 6 8 10 12];
    set(gca, 'xtick', log10(xticks));
    set(gca, 'xticklabel', xticks);
    yticks = [0.05 0.1 0.2 0.5 0.9 0.99 0.9999];
    set(gca, 'ytick', computePStar(yticks, 1));
    if i > ceil(length(pdHs_Exp) / 2) && mod(i, 2) == 1
        xlabel('Significant wave height (m)');
    end
    if mod(i, ceil(length(pdHs_Exp) / 2)) == 1 
        ylabel('Probability (-)');
        set(gca, 'yticklabel', yticks);
    else
        set(gca, 'yticklabel', cell(length(yticks), 1));
    end
    if i == 1
        [hh,icons,plots,txt] = legend({['Dataset ' datasetName], ...
            '2-p. Weibull',  'Exp. Weibull'}, ...
            'location', 'southeast', 'fontsize', 6);
        set(hh, 'Box', 'off')
        p1 = icons(1).Position;
        p2 = icons(2).Position;
        p3 = icons(3).Position;
        icons(1).Position = [0.3 p1(2) 0];
        icons(2).Position = [0.3 p2(2) 0];
        icons(3).Position = [0.3 p3(2) 0];
        icons(5).XData = [0.125];
        icons(6).XData = [0.05 0.2];
        icons(8).XData = [0.05 0.2];
    end
    ylim(computePStar([0.05 0.999999], 1))
    grid on
    title([num2str(lowerLimit(i)) ' < v < ' num2str(upperLimit(i)) ' m/s']);
end

function pstar_i = computePStar(pi, delta)
    pstar_i = log10(-log(1 - pi.^(1 ./ delta)));
end
