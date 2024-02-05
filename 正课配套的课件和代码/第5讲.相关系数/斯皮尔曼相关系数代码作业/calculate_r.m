function [r] = calculate_r(X, Y)
% % 输入值：
% X: 列向量
% Y: 列向量，且与 X 同维度
% % 返回值：
% r: X 和 Y 的斯皮尔曼相关系数（第一种定义方法）

RX = rank_data(X); % 调用自定义函数 rank_data 来计算 X 的等级
RY = rank_data(Y); % 调用自定义函数 rank_data 来计算 Y 的等级
d = RX - RY; % 计算 X 和 Y 等级差
n = size(X, 1); % 计算样本个数 n
r = 1 - (6 * sum(d.*d)) / (n * (n^2 - 1)); % 利用公式计算斯皮尔曼相关系数

end


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭