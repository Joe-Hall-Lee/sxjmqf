%% 不定积分
clear; clc

syms x
y = x^2
int(y, x)
% x^3/3 % 注意，MATLAB 计算时不会给我们加上常数 C

syms x
y = 1 / x
int(y, x)
% log(x) % 注意，MATLAB 计算 1/x 形式的不定积分时不会给我们加上绝对值

syms x
y = x^2 / (1 + x^2)
int(y, x)
% x - atan(x)

syms x
y = 1 / (exp(x) + 1)
int(y, x)
% x - log(exp(x) + 1)

syms x a
y = 1 / sqrt(x^2-a^2)
int(y, x)
% log(x + (x^2 - a^2)^(1/2))

%% 定积分
syms x
y = sin(x)
int(y, x, 0, pi/2)
% 1

syms x a b
y = exp(x)
int(y, x, a, b)
% exp(b) - exp(a)

syms x
y = (sin(x))^2 / x^2
b = int(y, x, 0, +inf)
% pi/2

% 注意，不是所有的函数都可以利用 int 函数计算出最后的结果，例如：
syms x
y = 1 / exp(x) * log(x+2*x^2+sin(x))
int(y, x, 0, 4)
% int(exp(-x)*log(x + sin(x) + 2*x^2), x, 0, 4)

% 我们可以计算数值积分：数值积分可用于求定积分的近似值。在数值分析中，数值积分是计算定积分数值的方法和理论。
% 在数学分析中，给定函数的定积分的计算不总是可行的，许多定积分不能用已知的积分公式得到精确值。
y = @(x) 1 ./ exp(x) .* log(x+2.*x.^2+sin(x)) % 注意，写成函数句柄时，要用点乘或者点除
integral(y, 0, 4)

xx = 0:0.1:4;
yy = 1 ./ exp(xx) .* log(xx+2*xx.^2+sin(xx));
plot(xx, yy, '-')


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭