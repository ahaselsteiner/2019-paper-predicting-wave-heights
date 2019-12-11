# Repo for `Predicting wave heights for marine design'

This is the repository for the paper 'Predicting wave heights for marine design by prioritizing extreme events in a global model' by A. F. Haselsteiner and K.-D. Thoben that is available at https://arxiv.org/pdf/1911.12835.pdf .

It contains the following things:
 * Matlab files to reproduce all figures that are presented in the paper
   * CreateAllFigures.m creates all figures
   * CreateFigure1.m creates Figure 1 (and so forth)
 * Matlab files to reproduce all tables that contain results of the analysis
   * CreateAllTables.m creats all tables
   * CreateTable3.m creates Table 1 (and so forth)
 * Matlab workspaces that contain the used datasets and the fitted distributions
   * datasets-provided-ABCDEF.mat holds the provided datasets (A, B, C, ...)
   * datasets-retained-ABCDEF.mat holds the retained datasets (Ar, Br, Cr, ...)
   * fitted-distributions.mat holds the fitted distributions (alternatively, they can be fitted by using the function fitDistributions.m)
 * Matlab classes for the four considered distributions
   * ExponentiatedWeibull.m (the class has its own repository, https://github.com/ahaselsteiner/exponentiated-weibull )
   * TranslatedWeibull.m (the class has its own repository, https://github.com/ahaselsteiner/translated-weibull )
   * Beta3pSecondKind.m (the class has its own repository, https://github.com/ahaselsteiner/beta-3p-second-kind )
   * GeneralizedGamma.m (the class has its own repository, https://github.com/ahaselsteiner/generalized-gamma )
