%% 符号变量的创建和简单运算
% 代码参考：我要自学网的龚飞老师《Matlab2016数值计算与智能算法》
clear; clc

% 简单符号变量的创建
syms x % 观察工作区，sym 是 symbolic 的缩写
syms a b c

% 符号方程的创建，两种方法
syms a x
y = a * x + x^2
% y = str2sym('a*x+x^2') % MATLAB 2017b 版本后推出

% 符号矩阵
syms alpha
M = [cos(alpha), -sin(alpha); ...
    sin(alpha), cos(alpha)]

%% 简单运算
syms a b c d e
y = a + b
% a + b
x = c - d
% c - d
y1 = x * y
% (a + b) * (c - d)
y2 = y1 / y
% c - d
y3 = y1^3
% (a + b)^3 * (c - d)^3
y4 = sqrt(y3)
% ((a + b)^3 * (c - d)^3)^(1 / 2)
y5 = exp(y4)
% exp(((a + b)^3 * (c - d)^3)^(1 / 2))

%% 符号表达式的整理
clear; clc

% 化简
syms a
y = (cot(a/2) - tan(a/2)) * (1 + tan(a) * tan(a/2))
simplify(y)
% 2 / sin(a)

%% 因式分解
factor(12) % 对常数进行因式分解
%      2     2     3
syms m n x
y = -24 * m^2 * x - 16 * n^2 * x
factor(y)
% [-8, x, 3*m^2 + 2*n^2]
y1 = m^3 - n^3
factor(y1)
% [m - n, m^2 + m*n + n^2]

%% 多项式展开
syms a x
y = a * (x^2 - a)^2 + (x - 2)
expand(y)
% a^3 - 2*a^2*x^2 + a*x^4 + x - 2

%% 合并
syms x y
z = (x + y)^2 * y + 5 * y * x - 2 * x^3
% expand(z) = - 2*x^3 + x^2*y + 2*x*y^2 + 5*x*y + y^3
collect(z, x)
% y*x^2 - 2*x^3 + (2*y^2 + 5*y)*x + y^3
collect(z, y)
% y^3 + 2*x*y^2 + (x^2 + 5*x)*y - 2*x^3

%% 计算分子与分母
% [z1, z2] = numden(2.5) % 会报错，因为 numden 的输入变量不能是数值，只能是符号变量
% ans = sym(2.5);  % sym 函数可以将数值 2.5 转换为符号
[z1, z2] = numden(sym(2.5)) % 对常数计算分子与分母
% z1 = 5
% z2 = 2
syms x y
z = 1 / x * y + x / (x^2 - 2 * y)
[z1, z2] = numden(z) % z1 分子，z2 分母
% z1 = - x^2*y - x^2 + 2*y^2
% z2 = x*(- x^2 + 2*y)

%% 让结果显示的更加自然
syms x y
M = (1 / x * y + x / (x^2 - 2 * y) - x^2 / (3 + y)^2)^2;
expand(M)
% y^2/x^2 + x^4/(y^4 + 12*y^3 + 54*y^2 + 108*y + 81) + (2*x^3)/(- x^2*y^2 - 6*x^2*y - 9*x^2 + 2*y^3 + 12*y^2 + 18*y) - (2*y)/(- x^2 + 2*y) + x^2/(x^4 - 4*x^2*y 

% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭