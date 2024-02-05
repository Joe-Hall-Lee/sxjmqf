%% 符号函数的三维图形绘制
clear; clc

%% plot3 函数（类似于 plot 函数，实际上可以认为画的是三维空间下的折线图）
% t = 0: 0.1: 4*pi; % 符号是 t，t 从 0 变动到 4pi，间隔设置为 0.1
t = linspace(0, 4*pi, 100); % 符号是 t，t 从 0 变动到 4pi，等分为 100 个点
x = sin(t) + 1; % 利用 t 计算 x 的值
y = cos(t); % 利用 t 计算 y 的值
z = t; % 利用 t 计算 z 的值
plot3(x, y, z) % 绘制三维空间下的折线图
plot3(x, y, z, 'r--')
% close % 关闭图形

%% fplot3 函数（2016a 版本推出的函数，老版本 MATLAB 用的是 ezplot3 函数，未来版本可能会被淘汰）
syms t % 符号是 t
x = sin(t) + 1;
y = cos(t);
z = t;
fplot3(x, y, z) % 默认 t 的变化范围为 [-5 5]
fplot3(x, y, z, [0, 4 * pi]) % 修改 t 的变化范围为 0 至 4pi
% close % 关闭图形

%% fmesh 三维网格图（2016a 版本推出的函数，老版本 MATLAB 用的是 ezmesh 函数，未来版本可能会被淘汰）
syms x y
z = x^2 + y^2;
fmesh(z) % 默认x的变化范围和y的变化范围都是 [-5 5]
fmesh(z, [-2, 2, -4, 4]) % 修改 x 的变化范围和 y 的变化范围分别为 [-2 2] 和 [-4 4]
% axis vis3d  % 冻结屏幕高宽比，使得一个三维对象的旋转不会改变坐标轴的刻度显示
% axis equal  % 设置屏幕高宽比，使得每个坐标轴的具有均匀的刻度间隔
fmesh(z, [-2, 2, -4, 4], 'MeshDensity', 11) % 设置每个方向计算的点数

% 画一朵花
syms u v
r = 2 + sin(7.*u+5.*v);
x = r .* cos(u) .* sin(v);
y = r .* sin(u) .* sin(v);
z = r .* cos(v);
% 可以直接用乘号
% r = 2 + sin(7*u+5*v);
% x = r * cos(u) * sin(v);
% y = r * sin(u) * sin(v);
% z = r * cos(v);
fmesh(x, y, z, [0, 2 * pi, 0, pi])
alpha(0.8)

%% fsurf 三维曲面图（2016a 版本推出的函数，老版本 MATLAB 用的是 ezsurf 函数，未来版本可能会被淘汰）
syms x y
z = x^2 + y^2;
fsurf(z) % 默认 x 的变化范围和 y 的变化范围都是[-5 5]
fsurf(z, [-2, 2, -4, 4]) % 修改x的变化范围和y的变化范围分别为[-2 2]和[-4 4]
% axis vis3d  % 冻结屏幕高宽比，使得一个三维对象的旋转不会改变坐标轴的刻度显示
% axis equal  % 设置屏幕高宽比，使得每个坐标轴的具有均匀的刻度间隔
fsurf(z, [-2, 2, -4, 4], 'MeshDensity', 11) % 设置每个方向计算的点数

% 画一朵花
syms u v
r = 2 + sin(7.*u+5.*v);
x = r .* cos(u) .* sin(v);
y = r .* sin(u) .* sin(v);
z = r .* cos(v);
fsurf(x, y, z, [0, 2 * pi, 0, pi])

%% fcontour 绘制等高线 (2016a 版本推出的函数，老版本 MATLAB 用的是 ezcontour 函数，未来版本可能会被淘汰）
syms x y
z = x^2 + y^2;
fcontour(z) % 默认 x 的变化范围和y的变化范围都是 [-5 5]
fcontour(z, [-2, 2, -4, 4]) % 修改 x 的变化范围和 y 的变化范围分别为 [-2 2] 和 [-4 4]
fcontour(z, 'fill', 'on') % 在等高线线条间进行填充


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭