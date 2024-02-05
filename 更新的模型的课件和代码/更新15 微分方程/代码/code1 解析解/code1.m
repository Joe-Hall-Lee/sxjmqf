%% 例 1
clear; clc
dsolve('y-Dy=2*x', 'x') % 这里要指定自变量为 x
% 2*x + C1*exp(x) + 2 % 这里的 C1 表示任意常数，有时候也会出现 C2、C3 等
dsolve('y-Dy=2*x') % 如果不指定自变量的话，会默认自变量为 t，x 会看成一个常数
% 2*x + C1*exp(t)

% 注意：最新版本的 MATLAB 会逐渐淘汰上面那种写法（虽然我个人觉得上面的写法更方便）
% 下面这种写法是新版的 MATLAB 推荐的方式（和我们上一讲符号运算中解方程的写法类似）
syms y(x)
eqn = (y - diff(y, x) == 2 * x); % 注意原来方程中的“=”一定要改成“==”
dsolve(eqn)

%% 如果微分方程中还有其他的未知参数怎么办？
% 方法 1
dsolve('y-Dy=a*x', 'x') % a 是一个未知的参数
% 方法 2
syms y(x) a
eqn = (y - diff(y, x) == a * x);
dsolve(eqn)

%% 例 2
% 方法 1
dsolve('y-Dy=2*x', 'y(0)=3', 'x')
% 2*x + exp(x) + 2
% 方法 2
syms y(x)
eqn = (y - diff(y, x) == 2 * x);
cond = (y(0) == 3);
dsolve(eqn, cond)
% 2*x + exp(x) + 2

%% 例 3
% 方法 1
dsolve('D2y+4*Dy+29*y=0', 'y(0)=0,Dy(0)=15', 'x')
% 3*sin(5*x)*exp(-2*x)
% 方法 2
syms y(x)
eqn = (diff(y, x, 2) + 4 * diff(y, x) + 29 * y == 0);
Dy = diff(y, x); % 定义变量 Dy 为 y 的一阶导数
cond = [(y(0) == 0), (Dy(0) == 15)]; % 有两个条件，可以写到一个向量中保存
dsolve(eqn, cond)
% 3*sin(5*x)*exp(-2*x)

%% 例 4
% 方法 1
[x, y, z] = dsolve('Dx=2*x-3*y+3*z+t', 'Dy=4*x-5*y+3*z+t', 'Dz=4*x-4*y+2*z+t', 't')

% 方法 2
syms x(t) y(t) z(t)
eqn1 = (diff(x, t) == 2 * x - 3 * y + 3 * z + t);
eqn2 = (diff(y, t) == 4 * x - 5 * y + 3 * z + t);
eqn3 = (diff(z, t) == 4 * x - 4 * y + 2 * z + t);
eqns = [eqn1, eqn2, eqn3];
[x, y, z] = dsolve(eqns)
% x = exp(2*t)*(C2- (exp(-2*t)*(2*t + 1))/4) + C3*exp(-t)
% y = exp(2*t)*(C2 - (exp(-2*t)*(2*t + 1))/4) + C3*exp(-t) + C4*exp(-2*t)
% z = exp(2*t)*(C2 - (exp(-2*t)*(2*t + 1))/4) + C4*exp(-2*t)

simplify(y) % simplify 函数可以简化表达式
latex(y) % 转换成 latex 代码，复制到 Axmath 或者 word 自带的公式编辑器（低版本不知道支不支持）
% 如果太过于复杂的话可能会报错，大家可以自己测试

%% 不是所有的微分方程都可以，导弹追击那一题就没有解析解
% 假设 v = 100
[x, y] = dsolve('Dx = 3*100*(20+sqrt(2)/2*100*t-x)/sqrt((20+sqrt(2)/2*100*t-x)^2+(sqrt(2)/2*100*t-y)^2)', 'Dy = 3*100*(sqrt(2)/2*100*t-y)/sqrt((20+sqrt(2)/2*100*t-x)^2+(sqrt(2)/2*100*t-y)^2)', 'x(0)=0,y(0)=0', 't')
% 警告: Unable to find symbolic solution.


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭