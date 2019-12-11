% This script creates the tables of the paper "Predicting wave heights for
% marine design by prioritizing extreme events in a global model" by 
% A.F. Haselsteiner and K-D. Thoben (https://arxiv.org/pdf/1911.12835.pdf).
% 
% This script requires Matlab2019a or newer and the following toolboxes:
% image_toolbox, map_toolbox, statistics_toolbox .

for i = 3:4
    fileName = ['CreateTable' num2str(i)];
    run(fileName)
end
run('CreateTableS1');