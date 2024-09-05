% 作业 3：机器人走有障碍的格子
% 题目来源：力扣 63. 不同路径 II
% 链接：https://leetcode-cn.com/problems/unique-paths-ii/
function f = homework3(obstacle)
% obstacle 是障碍物矩阵，全为 0 和 1 组成，1 表示有障碍物
[m, n] = size(obstacle);
FF = ones(m, n); % 初始化 DP 数组
% 处理第一列
for i = 1:m
    if obstacle(i, 1) == 1 % 发现了障碍物
        FF(i:end, 1) = 0; % 障碍物所处的位置以及下方的位置对应的 f(i, j) = 0
        break
    end
end
% 处理第一行
for j = 1:n
    if obstacle(1, j) == 1
        FF(1, j:end) = 0; % 障碍物所处的位置以及右边的位置对应的 f(i, j) = 0
        break
    end
end
% 循环计算右下部分的元素
for i = 2:m
    for j = 2:n
        if obstacle(i, j) == 1
            FF(i, j) = 0;
        else
            FF(i, j) = FF(i, j-1) + FF(i-1, j);
        end
    end
end
f = FF(m, n);
end
