%% 怎么输出所走的路线？
function [f, path] = max_gift_value2(M)
% 输入的 M 就是棋盘中每个礼物的价值
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
% 根据程序中得到的 DP 数组（FF）来推出对应的路径 path
path = zeros(m, n); % path 全为 0 和 1 组成，1 表示经过该格子
i = m;
j = n;
while i ~= 1 || j ~= 1 % 只要没有回到原点
    path(i, j) = 1; % 把 path 矩阵的第 i 行第 j 列变成 1（表示访问了这个格子）
    if i == 1 % 如果到了第一行
        path(1, 1:j) = 1; % 剩余的路径沿着左边一直走就可以了
        break % 退出循环
    end
    if j == 1 % 如果到了第一列
        path(1:i, 1) = 1; % 剩余的路径沿着上方一直走就可以了
        break % 退出循环
    end
    tmp1 = FF(i-1, j); % 上方单元格 FF 的值
    tmp2 = FF(i, j-1); % 左边单元格 FF 的值
    ind = find([tmp1, tmp2] == (FF(i, j) - M(i, j)), 1); % 看哪个值等于 FF(i, j) - M(i, j)
    if ind == 1 % 如果上方单元格 FF 的值等于 FF(i, j) - M(i, j)
        i = i - 1; % 说明上一步沿着上方来的
    else % 如果左边单元格 FF 的值等于 FF(i, j) - M(i, j)
        j = j - 1; % 说明上一步沿着左边来的
    end
end
end
