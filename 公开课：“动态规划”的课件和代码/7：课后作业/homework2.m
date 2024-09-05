% 作业 2：机器人走格子
% 题目来源：力扣 62. 不同路径
% 链接：https://leetcode-cn.com/problems/unique-paths/
function f = homework2(m, n)
% 格子有 m 行 n 列
FF = ones(m, n); % 初始化 DP 数组全为 1
% 循环计算右下部分的元素
for i = 2:m
    for j = 2:n
        tem1 = FF(i, j-1); % 左侧过来
        tem2 = FF(i-1, j); % 上面过来
        FF(i, j) = tem1 + tem2;
    end
end
f = FF(m, n);
end
