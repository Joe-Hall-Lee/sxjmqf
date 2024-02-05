% 分段三次埃尔米特插值
x = -pi:pi;
y = sin(x);
new_x = -pi:0.1:pi;
p = pchip(x, y, new_x);
figure(1); % 在同一个脚本文件里面，要想画多个图，需要给每个图编号，否则只会显示最后一个图
plot(x, y, 'o', new_x, p, 'r-')

% plot 函数用法:
% plot(x1, y1, x2, y2)
% 线方式：- 实线；: 点线；-. 虚点线；-- 波折线
% 点方式：. 圆点；+ 加号；* 星号；x x 形；o 小圆
% 颜色：y 黄；r 红；g 绿；b 蓝；w 白；k 黑；m 紫；c 青


% 三次样条插值和分段三次埃尔米特插值的对比
x = -pi:pi;
y = sin(x);
new_x = -pi:0.1:pi;
p1 = pchip(x, y, new_x); % 分段三次埃尔米特插值
p2 = spline(x, y, new_x); % 三次样条插值
figure(2);
plot(x, y, 'o', new_x, p1, 'r-', new_x, p2, 'b-')
legend('样本点', '三次埃尔米特插值', '三次样条插值', 'Location', 'SouthEast') % 标注显示在东南方向
% 说明：
% legend(string1, string2, string3, …)
% 分别将字符串 1、字符串 2、字符串 3……标注到图中，每个字符串对应的图标为画图时的图标。
% Location 用来指定标注显示的位置


% n 维数据的插值
x = -pi:pi;
y = sin(x);
new_x = -pi:0.1:pi;
p = interpn(x, y, new_x, 'spline');
% 等价于 p = spline(x, y, new_x);
figure(3);
plot(x, y, 'o', new_x, p, 'r-')

% 人口预测（注意：一般我们很少使用插值算法来预测数据，随着课程的深入，后面的章节会有更适合预测的算法供大家选择，例如灰色预测、拟合预测等）
population = [133126, 133770, 134413, 135069, 135738, 136427, 137122, 137866, 138639, 139538];
year = 2009:2018;
p1 = pchip(year, population, 2019:2021) % 分段三次埃尔米特插值预测
p2 = spline(year, population, 2019:2021) % 三次样条插值预测
figure(4);
plot(year, population, 'o', 2019:2021, p1, 'r*-', 2019:2021, p2, 'bx-')
legend('样本点', '三次埃尔米特插值预测', '三次样条插值预测', 'Location', 'SouthEast')

% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭