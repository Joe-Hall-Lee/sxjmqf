clear; clc
global x y; % 将 x 和 y 定义为全局变量（方便在子函数中直接调用，要先声明）
load data_x_y % 数据集内里面有 x 和 y 两个变量
narvs = 2;
% 使用粒子群算法，不需要指定初始值，只需要给定一个搜索的范围
lb = [-10, -10];
ub = [10, 10];
[k, fval] = particleswarm(@Obj_fun, narvs, lb, ub)

% 使用粒子群算法后再利用 fmincon 函数混合求解
options = optimoptions('particleswarm', 'HybridFcn', @fmincon);
[k, fval] = particleswarm(@Obj_fun, narvs, lb, ub, options)


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭