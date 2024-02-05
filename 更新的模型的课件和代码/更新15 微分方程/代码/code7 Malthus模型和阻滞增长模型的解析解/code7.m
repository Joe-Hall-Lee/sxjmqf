%% Malthus 模型（马尔萨斯模型）
clear; clc
x = dsolve('Dx=r*x', 'x(0)=x0', 't') % x = dsolve('Dx=r*x', 'x(t0)=x0', 't')
% x = x0 * exp(r*t)
% 怎么把上面这个式子中的 x0 和 r 替换成确定的值？
x0 = 100;
r = 0.1;
subs(x)

% 初始人口为 1000，画出 50 年且增长率分别为 0.5%、1%、1.5% 一直到 5% 的人口变化曲线
x0 = 1000;
for i = 1:10
    r = 0.005 * i;
    xx = subs(x);
    fplot(xx, [0, 50]) % fplot 函数可以绘制表达式的图形
    hold on
end

%% 阻滞增长模型（logistic 模型）
clear; clc
x = dsolve('Dx=r*(1-x/xm)*x', 'x(t0)=x0', 't') % 化简后和书上的结果一样
t0 = 0;
x0 = 1000;
xm = 10000;
r = 0.05;
xx = subs(x); % 10000 / (exp(log(9) - t/20) + 1)
fplot(xx, [0, 200])

% 如果不会用上面的 fplot 函数怎么办？
t = 0:200;
x = 10000 ./ (exp(log(9)-t/20) + 1);
plot(t, x, '-')


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的 查重要求非常严格，代码雷同也算作抄袭