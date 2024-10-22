%% 在真正比赛中，我们往往会倾向于先去看有无解析解，如果没有解析解再考虑数值解
% [y1, y2, y3] = dsolve('Dy1=y2*y3', 'Dy2=-y1*y3', 'Dy3=-0.51*y1*y2', 'y1(0)=0,y2(0)=1,y3(0)=1', 'x')

%% 调用 ode45 函数求解微分方程 df2，自变量为 x，范围为 [0, 4*pi]; 因变量为 y1、y2 和 y3，初始值: y1(0) = 0, y2(0) = y3(0) = 1
[x, y] = ode45('df2', [0, 4 * pi], [0, 1, 1]); % 这里的y是一个有 3 列的矩阵！
plot(x, y(:, 1), 'o', x, y(:, 2), '*', x, y(:, 3), '+')
legend('y1', 'y2', 'y3') % 加上标注
axis([0, 4 * pi, -inf, +inf]) % 设置横坐标范围为 0-4pi，纵坐标范围不需要设置，写成 -inf 到 +inf


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭