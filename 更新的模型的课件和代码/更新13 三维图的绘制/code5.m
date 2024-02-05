%% MATLAB 绘制隐函数的图形

% fimplicit3(f) 在默认区间 [-5 5] 上绘制 f(x ,y, z) = 0 定义的三维隐函数。
f = @(x, y, z) x.^2 + y.^2 - z.^2; % 函数句柄（在拟合那一节里面介绍过），这里要注意，要用点运算符
fimplicit3(f)
xlabel('x轴');
ylabel('y轴');
zlabel('z轴'); % 加上坐标轴的标签
interval = [-5, 5, -5, 5, 0, 5]; % 指定范围
fimplicit3(f, interval)
fimplicit3(f, interval, 'EdgeColor', 'none', 'FaceAlpha', 0.5) % 去掉边缘颜色，调整透明度


% fimplicit3(f, interval) 为 x、y 和 z 指定绘图区间。
f = @(x, y, z) (x.^2 + (9 / 4) * y.^2 + z.^2 - 1).^3 - x.^2 .* z.^3 - (9 / 80) * y.^2 .* z.^3;
fimplicit3(f, [-1.5, 1.5, -1.5, 1.5, -1.5, 1.5], 'EdgeColor', 'none', 'FaceAlpha', 0.5);
% 该函数在 2016b 版本中推出，之前没有，老版本 MATLAB 可参考：https://www.ilovematlab.cn/thread-260987-1-1.html


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭