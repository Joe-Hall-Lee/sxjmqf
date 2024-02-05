% 更新 15 里面我们讲过的 SIR 模型
clear; clc
load mydata.mat % 导入数据（共三列，分别是 S、I、R 的数量）
n = size(mydata, 1); % 一共有多少行数据
true_s = mydata(:, 1);
true_i = mydata(:, 2);
true_r = mydata(:, 3);
figure(1)
plot(1:n, true_s, 'r-', 1:n, true_i, 'b-', 1:n, true_r, 'g-') % S 的数量太大了
legend('S', 'I', 'R')
plot(1:n, true_i, 'b-', 1:n, true_r, 'g-') % 单独画出真实的 I 和 R 的数量
hold on % 等会接着在这个图形上面画图

% 随便先给一组参数来计算微分方程的数值解
beta = 0.1; % 易感染者与已感染者接触且被传染的强度
gamma = 0.01; % 康复率
[t, p] = ode45(@(t, x) SIR_fun(t, x, beta, gamma), [1:n], [true_s(1), true_i(1), true_r(1)]);
% p 就是计算的数值解，它有三列，分别是 S、I、R 的数量
p = round(p); % 对 p 进行四舍五入（人数为整数）
% 注意，四舍五入后有可能出现总人数之和不为 10000 的情况，例如为 9999 或 10001 ，但是这种误差可以忽略不计。
plot(1:n, p(:, 2), 'b--', 1:n, p(:, 3), 'g--')
legend('I', 'R', '拟合的I', '拟合的R')
hold off % 和 hold on 对应
% 计算残差平方和
sse = sum((true_s - p(:, 1)).^2+(true_i - p(:, 2)).^2+(true_r - p(:, 3)).^2)

%% 网格法搜索（枚举法） 地毯式搜索
BETA = 0.1:0.01:0.3; % 估计一个 BETA 所在的范围
GAMMA = 0.01:0.001:0.1; % 估计一个 GAMMA 所在的范围
n1 = length(BETA);
n2 = length(GAMMA);
SSE = zeros(n1, n2); % 初始化残差平方和矩阵
for i = 1:n1
    for j = 1:n2
        beta = BETA(i);
        gamma = GAMMA(j);
        [t, p] = ode45(@(t, x) SIR_fun(t, x, beta, gamma), [1:n], [true_s(1), true_i(1), true_r(1)]);
        % p 就是计算的数值解，它有三列，分别是 S、I、R 的数量
        p = round(p); % 对 p 进行四舍五入（人数为整数）
        % 计算残差平方和
        sse = sum((true_s - p(:, 1)).^2+(true_i - p(:, 2)).^2+(true_r - p(:, 3)).^2);
        SSE(i, j) = sse;
    end
end
% 画出 SSE 这个矩阵的热力图，放到论文中显得高大上
figure(2)
pcolor(GAMMA, BETA, SSE) % 注意，这里 GAMMA 和 BETA 的顺序不能反了（类似于更新 13 里面的 mesh 函数的用法）
colorbar % 加上颜色条
% 找到 SSE 最小的那组参数
min_sse = min(min(SSE)); % 注意，min(SSE) 是找出每一列的最小值，因此我们还需要再使用一次 min 函数才能找到整个矩阵里面的最小值
[r, c] = find(SSE == min_sse, 1); % find 后面加了一个 1，表示返回第一个最小值所在的行和列的序号
beta = BETA(r)
gamma = GAMMA(c)

figure(3)
plot(1:n, true_i, 'b-', 1:n, true_r, 'g-') % 单独画出真实的 I 和 R 的数量
hold on
[t, p] = ode45(@(t, x) SIR_fun(t, x, beta, gamma), [1:n], [true_s(1), true_i(1), true_r(1)]);
% p 就是计算的数值解，它有三列，分别是 S、I、R 的数量
p = round(p); % 对 p 进行四舍五入（人数为整数）
plot(1:n, p(:, 2), 'b--', 1:n, p(:, 3), 'g--')
legend('I', 'R', '拟合的I', '拟合的R')
hold off
% 计算残差平方和
sse = sum((true_s - p(:, 1)).^2+(true_i - p(:, 2)).^2+(true_r - p(:, 3)).^2)
% beta = 0.2100
% gamma = 0.0420
% sse = 2302

%% 思考：能不能再让这个找到的结果更好点？
BETA = 0.2:0.0001:0.22; % 缩小 BETA 所在的搜索范围
GAMMA = 0.041:0.0001:0.043; % 缩小 GAMMA 所在的搜索范围
% 这样可能会陷入局部最优解！
% beta = 0.2094
% gamma = 0.0415
% sse = 2219

% 下个视频我们讲的粒子群算法，得到的结果为：
% beta = 0.2067
% gamma = 0.0388
% sse = 2185

% 总结：
% 搜索的精度越高（网格划分得越细），搜索耗费的时间越长
% 如果缩小网格搜索范围（可以减少搜索时间）可能会让我们找到的解陷入局部最优
% 另外，如果我们有多个要搜索的变量，网格搜索法就很难办了，多重循环会大大增加搜索时间！


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭
