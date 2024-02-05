%% （1）更新 14 讲到的 vpasolve 函数
clear; clc
syms x1 x2 x3
eqn = [abs(x1+x2) - abs(x3) == 0, x1 * x2 * x3 + 18 == 0, x1^2 * x2 + 3 * x3 == 0]
[x1, x2, x3] = vpasolve(eqn, [x1, x2, x3], [0, 0, 0])
[x1, x2, x3] = vpasolve(eqn, [x1, x2, x3], [1, 1, 1]) % 换一个初始值试试

%% （2）更新 14 讲到的 fsolve 函数
x0 = [0, 0, 0]; % 初始值
x = fsolve(@my_fun, x0)
% 换一个初始值试试
x0 = [1, 1, 1]; % 初始值
format long g % 显示更多的小数位数
x = fsolve(@my_fun, x0)

%% （3）粒子群算法（可以尝试多次，有可能找到多个解）
clear; clc
narvs = 3;
% 使用粒子群算法，不需要指定初始值，只需要给定一个搜索的范围
lb = -10 * ones(1, 3);
ub = 10 * ones(1, 3);
options = optimoptions('particleswarm', 'FunctionTolerance', 1e-12, 'MaxStallIterations', 100, 'MaxIterations', 20000, 'SwarmSize', 100);
[x, fval] = particleswarm(@Obj_fun, narvs, lb, ub, options)


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭