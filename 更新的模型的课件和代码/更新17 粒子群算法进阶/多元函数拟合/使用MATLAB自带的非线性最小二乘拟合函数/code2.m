%% 非线性最小二乘拟合函数 lsqcurvefit
clear; clc
load data_x_y
k0 = [0, 0];
lb = [];
ub = [];
[k, fval] = lsqcurvefit(@fit_fun, k0, x, y, lb, ub)
% Choose between 'trust-region-reflective' (default) and 'levenberg-marquardt'.
options = optimoptions('lsqcurvefit', 'Algorithm', 'levenberg-marquardt');
[k, fval] = lsqcurvefit(@fit_fun, k0, x, y, lb, ub, options)


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭