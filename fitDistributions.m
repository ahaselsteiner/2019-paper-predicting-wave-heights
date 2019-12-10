function [Dists, Errors] = fitDistributions(doBootstrap, doGammaAndBeta, ...
    doRetainedDatasets)
%FITDISTRIBUTION fits the considered distributions to the datasets.
%   [Dists, Errors] = FITDISTRIBUTION(P,A,B) returns the fitted
%   distributions and the mean absolute errors of the fits. If doBootstrap
%   is 1 bootstrap estimates for the standard error are computed. If
%   doGammaAndBeta is 1 the gamma and beta distributions are fitted too. If
%   doRetainedDatsets is 1 the retained datsets (Ar, Br, ...) are used too.

    rng default  % For reproducibility

    N_OF_BOOTSTRAP_SAMPLES = 100;
    datasets = {'A', 'B', 'C', 'D', 'E', 'F', 'Ar', 'Br', 'Cr', 'Dr', 'Er', 'Fr'};

    if doRetainedDatasets
        nOfDatasets = 12;
    else
        nOfDatasets = 6;
    end
    
    for i = 1:nOfDatasets
        datasetName = datasets{i};
        hs_sample = getHsDataset(datasetName);

        % Translated Weibull
        disp(['Estimating the parameters of a translated Weibull distribution ' ...
            'using MLE for dataset ' datasetName]);
        pdTranslated(i) = TranslatedWeibull();
        if doBootstrap
            pdTranslated(i).fitDistAndBootstrap(hs_sample, N_OF_BOOTSTRAP_SAMPLES);
        else
            pdTranslated(i).fitDist(hs_sample);
        end
        maeTranslated(i) = pdTranslated(i).meanabsoluteerror(hs_sample);

        % Exponentiated Weibull, MLE
        disp(['Estimating the parameters of an exponentiated Weibull distribution ' ...
            'using MLE for dataset ' datasetName]);
        pdExponentiatedMLE(i) = ExponentiatedWeibull();
        if doBootstrap
            pdExponentiatedMLE(i).fitDistAndBootstrap(hs_sample, 'MLE', N_OF_BOOTSTRAP_SAMPLES);
        else
            pdExponentiatedMLE(i).fitDist(hs_sample, 'MLE');
        end
        maeExponentiatedMLE(i) = pdExponentiatedMLE(i).meanabsoluteerror(hs_sample);

        % Exponentiated Weibull, WLS
        disp(['Estimating the parameters of an exponentiated Weibull distribution ' ...
            'using WLS for dataset ' datasetName]);
        pdExponentiatedWLS(i) = ExponentiatedWeibull();
        if doBootstrap
            pdExponentiatedWLS(i).fitDistAndBootstrap(hs_sample, 'WLS', N_OF_BOOTSTRAP_SAMPLES);
        else
            pdExponentiatedWLS(i).fitDist(hs_sample, 'WLS');
        end
        maeExponentiatedWLS(i) = pdExponentiatedWLS(i).meanabsoluteerror(hs_sample);

        if doGammaAndBeta
            if i <= 6
                % Gerneralized gamma
                disp(['Estimating the parameters of a generalized gamma distribution ' ...
                    'using MLE for dataset ' datasetName]);
                pdGamma(i) = GeneralizedGamma();
                pdGamma(i).fitDist(hs_sample);
                maeGamma(i) = pdGamma(i).meanabsoluteerror(hs_sample);

                % Beta of the second kind
                disp(['Estimating the parameters of a beta distribution of the ' ...
                    'second kind using MLE for dataset ' datasetName]);
                pdBeta(i) = Beta3pSecondKind();
                pdBeta(i).fitDist(hs_sample);
                maeBeta(i) = pdBeta(i).meanabsoluteerror(hs_sample);
            end
        end
    end
    Dists.pdTranslated = pdTranslated;
    Dists.pdExponentiatedMLE = pdExponentiatedMLE;
    Dists.pdExponentiatedWLS = pdExponentiatedWLS;
    Errors.maeTranslated = maeTranslated;
    Errors.maeExponentiatedMLE = maeExponentiatedMLE;
    Errors.maeExponentiatedWLS = maeExponentiatedWLS;
    if doGammaAndBeta
        Dists.pdGamma = pdGamma;
        Dists.pdBeta = pdBeta;
        Errors.maeGamma = maeGamma;
        Errors.maeBeta = maeBeta;
    end
end