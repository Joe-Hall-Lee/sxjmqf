%% surf 函数：绘制出在某一区间内完整的曲面图
% surf 函数和 mesh 函数的的调用格式基本相同
% 两者的区别：mesh 绘出彩色的线，surf 绘出彩色的面

%% 例题 1 的对比
[x, y] = meshgrid(linspace(0, 5, 11));
% [x ,y] = meshgrid([0:0.5:5]); % 或者直接写成 [x, y] = meshgrid(0:0.5:5);
z = x.^2 - y.^2;
subplot(1, 2, 1) % subplot(m, n, index)
mesh(x, y, z)
xlabel('x轴');
ylabel('y轴');
zlabel('z轴'); % 加上坐标轴的标签
axis vis3d % 冻结屏幕高宽比，使得一个三维对象的旋转不会改变坐标轴的刻度显示
title('mesh(x,y,z)')

subplot(1, 2, 2)
surf(x, y, z)
xlabel('x轴');
ylabel('y轴');
zlabel('z轴'); % 加上坐标轴的标签
axis vis3d % 冻结屏幕高宽比，使得一个三维对象的旋转不会改变坐标轴的刻度显示
% axis([0, 5, 0, 5, -inf, +inf])  % 设置坐标轴刻度范围
title('surf(x,y,z)')

%% 例题 2 的对比
[x, y] = meshgrid(-5:0.5:5); % 快速生成网格所需的数据
tem = sqrt(x.^2+y.^2) + 1e-12;
z = sin(tem) ./ tem; % 如果不对 tem 处理，那么 z 的最中间的一个值 0/0 = NaN
subplot(1, 2, 1)
mesh(x, y, z)
xlabel('x轴');
ylabel('y轴');
zlabel('z轴'); % 加上坐标轴的标签
axis vis3d % 冻结屏幕高宽比，使得一个三维对象的旋转不会改变坐标轴的刻度显示
title('mesh(x,y,z)')

subplot(1, 2, 2)
surf(x, y, z) % (X(j), Y(i), Z(i,j))是线框网格线的交点
xlabel('x轴');
ylabel('y轴');
zlabel('z轴'); % 加上坐标轴的标签
axis vis3d % 冻结屏幕高宽比，使得一个三维对象的旋转不会改变坐标轴的刻度显示
title('surf(x,y,z)')

%% surfc 函数：除了 surf 函数图形外，还在 xy 平面上绘制曲面的等高线
surfc(x, y, z)
xlabel('x轴');
ylabel('y轴');
zlabel('z轴'); % 加上坐标轴的标签
axis vis3d % 冻结屏幕高宽比，使得一个三维对象的旋转不会改变坐标轴的刻度显示

%% surfl 函数：加上了灯光效果,看起来自然点
surfl(x, y, z)
xlabel('x轴');
ylabel('y轴');
zlabel('z轴'); % 加上坐标轴的标签
axis vis3d % 冻结屏幕高宽比，使得一个三维对象的旋转不会改变坐标轴的刻度显示

%% 设置色彩模式
% shading 是用来处理色彩效果的，分以下三种：
% shading faceted 是默认的模式
% shading flat 在 faceted 的基础上去掉图上的网格线
% shading interp 在 flat 的基础上进行色彩的插值处理，使色彩平滑过渡
subplot(1, 3, 1)
surf(x, y, z) % (X(j), Y(i), Z(i, j))是线框网格线的交点
shading faceted % 默认的色彩模式
xlabel('x轴');
ylabel('y轴');
zlabel('z轴'); % 加上坐标轴的标签
axis vis3d % 冻结屏幕高宽比，使得一个三维对象的旋转不会改变坐标轴的刻度显示
title('shading faceted')

subplot(1, 3, 2)
surf(x, y, z) % (X(j), Y(i), Z(i,j))是线框网格线的交点
shading flat % 看起来光滑一点
xlabel('x轴');
ylabel('y轴');
zlabel('z轴'); % 加上坐标轴的标签
axis vis3d % 冻结屏幕高宽比，使得一个三维对象的旋转不会改变坐标轴的刻度显示
title('shading flat')

subplot(1, 3, 3)
surf(x, y, z) % (X(j), Y(i), Z(i,j))是线框网格线的交点
shading interp % 看起来最光滑
xlabel('x轴');
ylabel('y轴');
zlabel('z轴'); % 加上坐标轴的标签
axis vis3d % 冻结屏幕高宽比，使得一个三维对象的旋转不会改变坐标轴的刻度显示
title('shading interp')


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭