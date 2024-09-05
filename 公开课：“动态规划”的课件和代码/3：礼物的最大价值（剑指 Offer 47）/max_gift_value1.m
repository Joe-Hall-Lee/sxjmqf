% 题目来源：剑指 Offer 47: 礼物的最大价值
function f = max_gift_value1(M)
% 输入的M就是棋盘中每个礼物的价值
[m, n] = size(M); % 棋盘 m 行 n 列
FF = M; % 初始化 DP 数组和 M 完全相同，用来保存 f(i, j)
% 计算 FF 的第一列
FF(:, 1) = cumsum(M(:, 1)); % cumsum 函数用来计算累加和
% 计算 FF 的第一行
FF(1, :) = cumsum(M(1, :));
% 循环计算右下部分的元素
for i = 2:m
    for j = 2:n
        tem1 = FF(i, j-1) + M(i, j); % 从左边来
        tem2 = FF(i-1, j) + M(i, j); % 从上面来
        FF(i, j) = max(tem1, tem2);
    end
end
f = FF(m, n);
end