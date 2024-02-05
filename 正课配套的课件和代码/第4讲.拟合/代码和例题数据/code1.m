clear; clc
load  data1
plot(x, y, 'o')
% 给 x 和 y 轴加上标签
xlabel('x 的值')
ylabel('y 的值')
n = size(x, 1);
k = (n * sum(x.*y) - sum(x) * sum(y)) / (n * sum(x.*x) - sum(x) * sum(x))
b = (sum(x.*x) * sum(y) - sum(x) * sum(x.*y)) / (n * sum(x.*x) - sum(x) * sum(x))
hold on % 继续在之前的图形上来画图形
grid on % 显示网格线

% % 画出 y = kx + b 的函数图像 plot(x, y)
% % 传统的画法：模拟生成 x 和 y 的序列，比如要画出 [0, 5] 上的图形
% xx = 2.5: 0.1 :7  % 间隔设置的越小画出来的图形越准确
% yy = k * xx + b  % k 和 b 都是已知值
% plot(xx, yy, '-')

% 匿名函数的基本用法。
% handle = @(arglist) anonymous_function
% 其中 handle 为调用匿名函数时使用的名字。
% arglist 为匿名函数的输入参数，可以是一个，也可以是多个，用逗号分隔。
% anonymous_function 为匿名函数的表达式。
% 举个小例子
% z = @(x, y) x^2 + y^2;
% z(1, 2)
% % ans = 5
% fplot 函数可用于画出匿名一元函数的图形。
% fplot(f, xinterval) 将匿名函数 f 在指定区间 xinterval 绘图。xinterval = [xmin xmax] 表示定义域的范围

f = @(x) k * x + b;
fplot(f, [2.5, 7]);
legend('样本数据', '拟合函数', 'location', 'SouthEast')

y_hat = k * x + b; % y 的拟合值
SSR = sum((y_hat - mean(y)).^2) % 回归平方和
SSE = sum((y_hat - y).^2) % 误差平方和
SST = sum((y - mean(y)).^2) % 总体平方和
SST - SSE - SSR % 5.6843e-14 = 5.6843*10^-14 MATLAB 浮点数计算的一个误差
R_2 = SSR / SST


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭