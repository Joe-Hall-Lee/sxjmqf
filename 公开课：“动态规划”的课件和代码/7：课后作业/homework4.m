% 作业 4：掷骰子等于目标和的方法数
% 题目来源：力扣 1155. 掷骰子等于目标和的方法数
% 链接：https://leetcode-cn.com/problems/number-of-dice-rolls-with-target-sum
function f = homework4(m, f, S)
% m 个骰子，每个骰子 f 个面，需要掷出总点数为 S
FF = zeros(m, S); % 初始化 DP 数组
% 处理第一列
FF(1, 1) = 1; % 第一个元素为 1，其余位置元素为 0。
% 处理第一行
for j = 1:S
    if j <= f
        FF(1, j) = 1; % 前 f 个元素（如果有的话）为 1，其余位置元素为 0。
    end
end
% 循环计算右下部分的元素
for i = 2:m
    for j = 2:S
        for k = 1:f
            if j > k
                FF(i, j) = FF(i, j) + FF(i-1, j-k);
            else
                break
            end
        end
    end
end
f = FF(m, S);
end