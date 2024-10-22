clear; clc
global x y; % 将 x 和 y 定义为全局变量（方便在子函数中直接调用，要先声明）
load data_x_y % 数据集内里面有 x 和 y 两个变量
k0 = [0, 0]; %初始值，注意，这个初始值的选取确实挺难，需要尝试。
lb = [];
ub = [];
% lb = [-1, -1];
% ub = [2, 2];
[k, fval] = fmincon(@Obj_fun, k0, [], [], [], [], lb, ub)

%% 求解无约束非线性函数的最小值的两个函数
[k, fval] = fminsearch(@Obj_fun, k0) % Nelder-Mead 单纯形法求解最小值，适用于解决不可导或求导复杂的函数优化问题
[k, fval] = fminunc(@Obj_fun, k0) % 拟牛顿法求解无约束最小值，适用于解决求导容易的函数优化问题

%% 计算拟合值和实际值的相对误差
y_hat = exp(-k(1)*x(:, 1)) .* sin(k(2)*x(:, 2)) + x(:, 3).^2; % 计算拟合值
res_rate = abs(y-y_hat) ./ y; % 相对误差
plot(res_rate) % 每个样本对应的相对误差
mean(res_rate) % 平均相对误差


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭