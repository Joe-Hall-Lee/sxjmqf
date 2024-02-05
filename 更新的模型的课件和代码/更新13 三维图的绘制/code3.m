%% contour 函数: 绘制等高线图

[x, y] = meshgrid(-3:0.1:3);
% 一个语句太长时，可以加上三个点然后在下一行继续写
z = 3 * (1 - x).^2 .* exp(-(x.^2)-(y + 1).^2) ...
    -10 * (x / 5 - x.^3 - y.^5) .* exp(-x.^2-y.^2) ...
    -1 / 3 * exp(-(x + 1).^2-y.^2); % MATLAB 中内置的 peaks 函数，常常作为演示使用
% edit peaks

%% contour(x, y, z) 在 x-y 平面绘制等高线图，MATLAB 会自动选择等高线的层级
contour(x, y, z)
xlabel('x轴');
ylabel('y轴'); % 加上坐标轴的标签

%% contour(x, y, z, n) 在 x-y 平面绘制等高线图，n 是一个标量，那么 MATLAB 会将等高线的层数设置为 n，且会自动选择层所在的高度。
contour(x, y, z, 5)
contour(x, y, z, 5, 'LineWidth', 2) % 设置线的宽度为 2
contour(x, y, z, 5, '--') % 设置等高线为虚线
contour(x, y, z, 5, 'ShowText', 'on') % 显示每一层的高度
contour(x, y, z, 5, '--', 'ShowText', 'on', 'LineWidth', 2) % 可以组合起来使用
colorbar % 显示颜色栏，也可以手动插入
xlabel('x轴');
ylabel('y轴'); % 加上坐标轴的标签

%% contour(x, y, z, levels) 若想得到固定的 n 个高度的等高线，将 levels 可以设置为 n 元行向量，其中向量中的值为高度值。
maxz = max(max(z))
minz = min(min(z))
levels = linspace(minz, maxz, 10) % 从最小值到最大值，等分成 10 个点
contour(x, y, z, levels, 'ShowText', 'on', 'LineWidth', 1) % 最小值或者最大值可能显示不出来，因为 MATLAB 会帮我们自动调整
xlabel('x轴');
ylabel('y轴'); % 加上坐标轴的标签

% 思考如果只想画出高度为 3 的单等高线怎么办?
contour(x, y, z, [3, 3], 'ShowText', 'on')
xlabel('x轴');
ylabel('y轴'); % 加上坐标轴的标签

%% contourf 函数：和 contour 函数类似，只不过画出来的等高线图有颜色填充
contourf(x, y, z, levels, 'ShowText', 'on')
xlabel('x轴');
ylabel('y轴'); % 加上坐标轴的标签

%% contour3 函数：3 维等高线图，等高线不再投影到 x-y 平面
contour3(x, y, z, levels, 'ShowText', 'on')
xlabel('x轴');
ylabel('y轴');
zlabel('z轴'); % 加上坐标轴的标签


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭
