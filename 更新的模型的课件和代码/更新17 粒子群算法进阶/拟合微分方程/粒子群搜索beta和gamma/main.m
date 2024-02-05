clear; clc
load mydata.mat % 导入数据（共三列，分别是 S、I、R 的数量）
global true_s true_i true_r n % 定义全局变量
n = size(mydata, 1); % 一共有多少行数据
true_s = mydata(:, 1);
true_i = mydata(:, 2);
true_r = mydata(:, 3);
figure(1)
% plot(1:n, true_s, 'r-', 1:n, true_i, 'b-', 1:n, true_r, 'g-') % S 的数量太大了
% legend('S', 'I', 'R')
plot(1:n, true_i, 'b-', 1:n, true_r, 'g-') % 单独画出 I 和 R 的数量
legend('I', 'R')

% 粒子群算法来求解
lb = [0, 0];
ub = [1, 1];
options = optimoptions('particleswarm', 'Display', 'iter', 'SwarmSize', 100, 'PlotFcn', 'pswplotbestf');
[h, fval] = particleswarm(@Obj_fun, 2, lb, ub, options) % h 就是要优化的参数，fval 是目标函数值
% options = optimoptions('particleswarm', 'SwarmSize', 100, 'FunctionTolerance', 1e-12, 'MaxStallIterations', 100, 'MaxIterations', 100000);
% [h, fval] = particleswarm(@Obj_fun, 2, lb, ub, options) % h 就是要优化的参数，fval 是目标函数值

beta = h(1); % 易感染者与已感染者接触且被传染的强度
gamma = h(2); % 康复率
[t, p] = ode45(@(t, x) SIR_fun(t, x, beta, gamma), [1:n], [true_s(1), true_i(1), true_r(1)]);
p = round(p); % 对 p 进行四舍五入（人数为整数）
sse = sum((true_s - p(:, 1)).^2+(true_i - p(:, 2)).^2+(true_r - p(:, 3)).^2) % 计算残差平方和


figure(3) % 真实的人数和拟合的人数放到一起看看
plot(1:n, true_i, 'b-', 1:n, true_r, 'g-')
hold on
plot(1:n, p(:, 2), 'b--', 1:n, p(:, 3), 'g--')
legend('I', 'R', '拟合的I', '拟合的R')

% 预测未来的趋势
N = 27; % 计算 N 天
[t, p] = ode45(@(t, x) SIR_fun(t, x, beta, gamma), [1:N], [true_s(1), true_i(1), true_r(1)]);
p = round(p); % 对 p 进行四舍五入（人数为整数）
figure(4)
plot(1:n, true_i, 'b-', 1:n, true_r, 'g-')
hold on
plot(1:N, p(:, 2), 'b--', 1:N, p(:, 3), 'g--')
legend('I', 'R', '拟合的I', '拟合的R')


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭