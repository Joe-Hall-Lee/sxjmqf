%% 调用 ode45 函数求解微分方程 df1，自变量为 x，范围为 [0, 2]，初始值 y(0)=3，因变量为 y
clear; clc
[x, y] = ode45('df1', [0, 2], 3); % [x,y] = ode45(@df1,[0,2],3);
% [x, y] = ode23('df1', [0, 2], 3);
% [x, y] = ode113('df1', [0, 2], 3);
% [x, y] = ode15s('df1', [0, 2], 3); % 刚性
figure(1)
plot(x, y, 'r*-') % 画出 x 和 y 的函数图像，用红色的直线和 * 标记

%%  下面我们直接画出微分方程的解析解的图像进行对比
hold on
x = 0:0.01:2;
y = exp(x) + 2 * x + 2;
plot(x, y, 'b-') % 蓝色的直线
% 从图中可以看出，ode45 函数得到的数值解的精度很高。

%% 设定相对误差和绝对误差，这样可以提高微分方程数值解的精度
options = odeset('reltol', 1e-4, 'abstol', 1e-8);
[x, y] = ode45('df1', [0, 2], 3, options);

%%  如果觉得 x 的间隔不够小，我们可以指定要求解的位置
[x, y] = ode45('df1', [0:0.001:2], 3, options);


% Dormand, J. R. and P. J. Prince, “A family of embedded Runge-Kutta formulae,” J. Comp. Appl. Math., Vol. 6, 1980, pp. 19–26.


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭