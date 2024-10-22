clear; clc
options = odeset('reltol', 1e-4, 'abstol', 1e-8); % 设定相对误差和绝对误差，这样可以提高微分方程数值解的精度
% 下面的 [0, 0.1] 表示时间 t 的范围，因为我们导弹速度假设的是 200，所以这里的范围给小点
[t, y] = ode45('df5', [0, 0.1], [0, 0], options); % y 是因变量，第一列为导弹运行的横坐标，第二列为导弹运行的纵坐标
% [t, y] = ode45('df5', [0:0.0001:0.1], [0, 0], options); % y 是因变量，第一列为导弹运行的横坐标，第二列为导弹运行的纵坐标
x = y(:, 1);
y = y(:, 2);
plot(x, y, '*', 'MarkerSize', 1) % 画出导弹的运行轨迹
hold on
plot([20, 30], [0, 10]) % 画出 B 船的运行轨迹: x - y - 20 = 0
hold on
% 下面我们找到导弹与 B 船相撞的点（由于 MATLAB 浮点数计算的原因，距离足够近时即可认为相撞）
n = length(t); % 找到 MATLAB 计算微分方程的数值解时一共有多少个时间点
d = 0; % 初始化导弹飞行的距离
for i = 1:n % 开始循环
    dd = abs(x(i)-y(i)-20) / sqrt(2); % 利用点到直线的距离公式计算导弹和船的距离
    if dd < 0.001 % 如果这个距离足够小了，我们就认为相撞了，但再此之前别忘了判断导弹是否达到了有效射程
        for k = 2:i
            d = sqrt((x(k) - x(k-1))^2+(y(k) - y(k-1))^2) + d; % 以直代曲的思想求曲线的长度，即导弹飞行的距离
        end
        if d <= 50 % 导弹的有效射程为 50 个单位,如果没有达到 50 单位
            disp(['导弹飞行 ', num2str(d), ' 单位后击中 B 船'])
            disp(['导弹飞行的时间为 ', num2str(t(i)*60), ' 分钟']) % 输出导弹击中 B 船的时间（转换为分钟）
            disp('击中点的坐标：'); disp([x(i), y(i)]) % 输出导弹击中 B 船的坐标
            plot(x(i), y(i), 'r*');
            text(x(i)+0.5, y(i)+0.1, '击中点')
        end
        break; % 跳出循环
    end
end
if d > 50 || dd >= 0.001 % 如果射程大于 50 或导弹与 B 船的距离始终都没有小于 0.001（这个数需要根据实际情况调整）
    disp('导弹没有击中 B 船');
end

t(i) * 200 * 3 % 更快计算导弹飞行距离的公式：速度*时间
% 得到的结果和我们上面以直代曲的结果很接近


% 下面是以前使用蒙特卡罗模拟得到的解，大家可以对比下：
% 导弹飞行 27.8019 单位后击中 B 船
% 导弹飞行的时间为 2.7802 分钟
% 击中点的坐标：
%    26.5523    6.5523


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭