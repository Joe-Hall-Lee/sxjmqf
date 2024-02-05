%% MATLAB 自带的粒子群函数 particleswarm
% particleswarm 函数是求最小值的
% 如果目标函数是求最大值则需要添加负号从而转换为求最小值。
clear; clc
%  MATLAB 中粒子群算法函数的参考文献
%       Mezura-Montes, E., and C. A. Coello Coello. "Constraint-handling in nature-inspired numerical optimization: Past, present and future." Swarm and Evolutionary Computation. 2011, pp. 173–194.
%       Pedersen, M. E. "Good Parameters for Particle Swarm Optimization." Luxembourg: Hvass Laboratories, 2010.
%       Iadevaia, S., Lu, Y., Morales, F. C., Mills, G. B. & Ram, P. T. Identification of optimal drug combinations targeting cellular networks: integrating phospho-proteomics and computational network analysis. Cancer Res. 70, 6704-6714 (2010).
%       Liu, Mingshou , D. Shin , and H. I. Kang . "Parameter estimation in dynamic biochemical systems based on adaptive Particle Swarm Optimization." Information, Communications and Signal Processing, 2009. ICICS 2009. 7th International Conference on IEEE Press, 2010.

%% 求解函数 y = x1^2 + x2^2 - x1 * x2 - 10 * x1 - 4 * x2 + 60在 [-15, 15] 内的最小值（最小值为 8）
narvs = 2; % 变量个数
x_lb = [-15, -15]; % x 的下界（长度等于变量的个数，每个变量对应一个下界约束）
x_ub = [15, 15]; % x 的上界
[x, fval, exitflag, output] = particleswarm(@Obj_fun2, narvs, x_lb, x_ub)

%% 直接调用 particleswarm 函数进行求解测试函数
narvs = 30; % 变量个数
% Sphere 函数
% x_lb = -100 * ones(1, 30); % x 的下界
% x_ub = 100 * ones(1, 30); % x 的上界
% Rosenbrock 函数
x_lb = -30 * ones(1, 30); % x 的下界
x_ub = 30 * ones(1, 30); % x 的上界
% Rastrigin 函数
% x_lb = -5.12 * ones(1, 30); % x 的下界
% x_ub = 5.12 * ones(1, 30); % x 的上界
% Griewank 函数
% x_lb = -600 * ones(1, 30); % x 的下界
% x_ub = 600 * ones(1, 30); % x 的上界
[x, fval, exitflag, output] = particleswarm(@Obj_fun3, narvs, x_lb, x_ub)

%% 绘制最佳的函数值随迭代次数的变化图
options = optimoptions('particleswarm', 'PlotFcn', 'pswplotbestf')
[x, fval] = particleswarm(@Obj_fun3, narvs, x_lb, x_ub, options)

%% 展示函数的迭代过程
options = optimoptions('particleswarm', 'Display', 'iter');
[x, fval] = particleswarm(@Obj_fun3, narvs, x_lb, x_ub, options)

%% 修改粒子数量，默认的是：min(100, 10 * nvars)
options = optimoptions('particleswarm', 'SwarmSize', 50);
[x, fval] = particleswarm(@Obj_fun3, narvs, x_lb, x_ub, options)

%% 在粒子群算法结束后继续调用其他函数进行混合求解（hybrid n.混合物合成物; adj.混合的; 杂种的;）
options = optimoptions('particleswarm', 'HybridFcn', @fmincon);
[x, fval] = particleswarm(@Obj_fun3, narvs, x_lb, x_ub, options)

%% 惯性权重的变化范围，默认的是 0.1-1.1
options = optimoptions('particleswarm', 'InertiaRange', [0.2, 1.2]);
[x, fval] = particleswarm(@Obj_fun3, narvs, x_lb, x_ub, options)

%% 个体学习因子，默认的是 1.49（压缩因子）
options = optimoptions('particleswarm', 'SelfAdjustmentWeight', 2);
[x, fval] = particleswarm(@Obj_fun3, narvs, x_lb, x_ub, options)

%% 社会学习因子，默认的是 1.49（压缩因子）
options = optimoptions('particleswarm', 'SocialAdjustmentWeight', 2);
[x, fval] = particleswarm(@Obj_fun3, narvs, x_lb, x_ub, options)

%% 最大的迭代次数，默认的是 200 * nvars
options = optimoptions('particleswarm', 'MaxIterations', 10000);
[x, fval] = particleswarm(@Obj_fun3, narvs, x_lb, x_ub, options)

%% 领域内粒子的比例 MinNeighborsFraction，默认是 0.25
options = optimoptions('particleswarm', 'MinNeighborsFraction', 0.2);
[x, fval] = particleswarm(@Obj_fun3, narvs, x_lb, x_ub, options)

%% 函数容忍度 FunctionTolerance, 默认 1e-6, 用于控制自动退出迭代的参数
options = optimoptions('particleswarm', 'FunctionTolerance', 1e-8);
[x, fval] = particleswarm(@Obj_fun3, narvs, x_lb, x_ub, options)

%% 最大停滞迭代数 MaxStallIterations, 默认 20, 用于控制自动退出迭代的参数
options = optimoptions('particleswarm', 'MaxStallIterations', 50);
[x, fval] = particleswarm(@Obj_fun3, narvs, x_lb, x_ub, options)

%% 不考虑计算时间，同时修改三个控制迭代退出的参数
tic
options = optimoptions('particleswarm', 'FunctionTolerance', 1e-12, 'MaxStallIterations', 100, 'MaxIterations', 100000);
[x, fval] = particleswarm(@Obj_fun3, narvs, x_lb, x_ub, options)
toc

%% 在粒子群结束后调用其他函数进行混合求解
tic
options = optimoptions('particleswarm', 'FunctionTolerance', 1e-12, 'MaxStallIterations', 50, 'MaxIterations', 20000, 'HybridFcn', @fmincon);
[x, fval] = particleswarm(@Obj_fun3, narvs, x_lb, x_ub, options)
toc


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭