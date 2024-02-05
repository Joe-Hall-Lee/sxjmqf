%% 随机权重的粒子群算法 PSO：求解函数 y = x1^2 + x2^2 - x1 * x2 - 10 * x1 - 4 * x2 + 60 在 [-15, 15] 内的最小值（动画演示）
clear; clc

%% 绘制函数的图形
x1 = -15:1:15;
x2 = -15:1:15;
[x1, x2] = meshgrid(x1, x2);
y = x1.^2 + x2.^2 - x1 .* x2 - 10 * x1 - 4 * x2 + 60;
mesh(x1, x2, y)
xlabel('x1');
ylabel('x2');
zlabel('y'); % 加上坐标轴的标签
axis vis3d % 冻结屏幕高宽比，使得一个三维对象的旋转不会改变坐标轴的刻度显示
hold on % 不关闭图形，继续在上面画图

%% 粒子群算法中的预设参数（参数的设置不是固定的，可以适当修改）
n = 30; % 粒子数量
narvs = 2; % 变量个数
c1 = 2; % 每个粒子的个体学习因子，也称为个体加速常数
c2 = 2; % 每个粒子的社会学习因子，也称为社会加速常数
w_max = 0.9; % 最大惯性权重，通常取 0.9
w_min = 0.4; % 最小惯性权重，通常取 0.4
sigma = 0.3; % 正态分布的随机扰动项的标准差（一般取 0.2-0.5）
K = 100; % 迭代的次数
vmax = [6, 6]; % 粒子的最大速度
x_lb = [-15, -15]; % x 的下界
x_ub = [15, 15]; % x 的上界

%% 初始化粒子的位置和速度
x = zeros(n, narvs);
for i = 1:narvs
    x(:, i) = x_lb(i) + (x_ub(i) - x_lb(i)) * rand(n, 1); % 随机初始化粒子所在的位置在定义域内
end
v = -vmax + 2 * vmax .* rand(n, narvs); % 随机初始化粒子的速度（这里我们设置为[-vmax, vmax]）

%% 计算适应度
fit = zeros(n, 1); % 初始化这 n 个粒子的适应度全为 0
for i = 1:n % 循环整个粒子群，计算每一个粒子的适应度
    fit(i) = Obj_fun2(x(i, :)); % 调用 Obj_fun2 函数来计算适应度
end
pbest = x; % 初始化这 n 个粒子迄今为止找到的最佳位置（是一个 n * narvs 的向量）
ind = find(fit == min(fit), 1); % 找到适应度最小的那个粒子的下标
gbest = x(ind, :); % 定义所有粒子迄今为止找到的最佳位置（是一个 1 * narvs 的向量）

%% 在图上标上这 n 个粒子的位置用于演示
h = scatter3(x(:, 1), x(:, 2), fit, '*r'); % scatter3 是绘制三维散点图的函数（这里返回 h 是为了得到图形的句柄，未来我们对其位置进行更新）

%% 迭代K次来更新速度与位置
fitnessbest = ones(K, 1); % 初始化每次迭代得到的最佳的适应度
for d = 1:K % 开始迭代，一共迭代 K 次
    for i = 1:n % 依次更新第 i 个粒子的速度与位置
        w = w_min + (w_max - w_min) * rand(1) + sigma * randn(1);
        v(i, :) = w * v(i, :) + c1 * rand(1) * (pbest(i, :) - x(i, :)) + c2 * rand(1) * (gbest - x(i, :)); % 更新第i个粒子的速度
        % 如果粒子的速度超过了最大速度限制，就对其进行调整
        for j = 1:narvs
            if v(i, j) < -vmax(j)
                v(i, j) = -vmax(j);
            elseif v(i, j) > vmax(j)
                v(i, j) = vmax(j);
            end
        end
        x(i, :) = x(i, :) + v(i, :); % 更新第 i 个粒子的位置
        % 如果粒子的位置超出了定义域，就对其进行调整
        for j = 1:narvs
            if x(i, j) < x_lb(j)
                x(i, j) = x_lb(j);
            elseif x(i, j) > x_ub(j)
                x(i, j) = x_ub(j);
            end
        end
        fit(i) = Obj_fun2(x(i, :)); % 重新计算第 i 个粒子的适应度
        if fit(i) < Obj_fun2(pbest(i, :)) % 如果第 i 个粒子的适应度小于这个粒子迄今为止找到的最佳位置对应的适应度
            pbest(i, :) = x(i, :); % 那就更新第 i 个粒子迄今为止找到的最佳位置
        end
        if fit(i) < Obj_fun2(gbest) % 如果第i个粒子的适应度小于所有的粒子迄今为止找到的最佳位置对应的适应度
            gbest = pbest(i, :); % 那就更新所有粒子迄今为止找到的最佳位置
        end
    end
    fitnessbest(d) = Obj_fun2(gbest); % 更新第 d 次迭代得到的最佳的适应度
    pause(0.1) % 暂停0.1s
    h.XData = x(:, 1); % 更新散点图句柄的 x 轴的数据（此时粒子的位置在图上发生了变化）
    h.YData = x(:, 2); % 更新散点图句柄的 y 轴的数据（此时粒子的位置在图上发生了变化）
    h.ZData = fit; % 更新散点图句柄的 z 轴的数据（此时粒子的位置在图上发生了变化）
end

figure(2)
plot(fitnessbest) % 绘制出每次迭代最佳适应度的变化图
xlabel('迭代次数');
disp('最佳的位置是：'); disp(gbest)
disp('此时最优值是：'); disp(Obj_fun2(gbest))


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭