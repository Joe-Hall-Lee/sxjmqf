clear; clc
load mydata.mat % 导入数据（共三列，分别是 S、I、R 的数量）
global true_s true_i true_r n % 定义全局变量
n = size(mydata, 1); % 一共有多少行数据
true_s = mydata(:, 1);
true_i = mydata(:, 2);
true_r = mydata(:, 3);
figure(1)
plot(1:n, true_i, 'b-', 1:n, true_r, 'g-') % 单独画出 I 和 R 的数量
legend('I', 'R')

% 粒子群算法来求解
% beta1, beta2, a, b
% 给定参数的搜索范围（根据题目来给），后期可缩小范围
lb = [0, 0, -1, -1];
ub = [1, 1, 1, 1];
% lb = [0 0 -0.2 -0.2];
% ub = [0.3 0.3 0.2 0.2];
options = optimoptions('particleswarm', 'Display', 'iter', 'SwarmSize', 200);
[h, fval] = particleswarm(@Obj_fun, 4, lb, ub, options) % h 就是要优化的参数，fval 是目标函数值，第二个输入参数 4 代表我们有 4 个变量需要搜索

beta1 = h(1); % t <= 15 时，易感染者与已感染者接触且被传染的强度
beta2 = h(2); % t > 15 时，易感染者与已感染者接触且被传染的强度
a = h(3); % 康复率 gamma = a + bt
b = h(4); % 康复率 gamma = a + bt
[t, p] = ode45(@(t, x) SIR_fun(t, x, beta1, beta2, a, b), [1:n], [true_s(1), true_i(1), true_r(1)]);
p = round(p); % 对 p 进行四舍五入（人数为整数）

figure(3) % 真实的人数和拟合的人数放到一起看看
plot(1:n, true_i, 'b-', 1:n, true_r, 'g-')
hold on
plot(1:n, p(:, 2), 'b--', 1:n, p(:, 3), 'g--')
legend('I', 'R', '拟合的I', '拟合的R')

% 预测未来的趋势
N = 27; % 计算 N 天
[t, p] = ode45(@(t, x) SIR_fun(t, x, beta1, beta2, a, b), [1:N], [true_s(1), true_i(1), true_r(1)]);
p = round(p); % 对 p 进行四舍五入（人数为整数）
figure(4)
plot(1:n, true_i, 'b-', 1:n, true_r, 'g-')
hold on
plot(1:N, p(:, 2), 'b--', 1:N, p(:, 3), 'g--')
legend('I', 'R', '拟合的I', '拟合的R')


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭