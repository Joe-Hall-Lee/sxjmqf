%% 01 背包问题（01 Knapsack problem）
function f = knapsack01problem1(p, w, W)
% 输入：p: 物品的利润；w: 物品的重量；W: 背包的容量
% 为了编程方便，假设 W 是大于等于 2 的正整数；w 中每个元素都是大于等于 1 的正整数
m = length(p); % 物品个数
FF = zeros(m, W); % 初始化 DP 数组
% FF(i,j): 前 i 件物品选择性的放入容量为 j 的背包中所能获得的最大利润
if w(1) <= W % 初始化第一行
    FF(1, w(1):end) = p(1);
end
for i = 2:m % 初始化第一列
    FF(i, 1) = max([p(w(1:i) == 1), 0]);
end
% i, j > 1 的情况
for i = 2:m
    for j = 2:W
        if w(i) > j % 第 i 件物品的重量 w(i) 比背包的容量 j 还要大
            FF(i, j) = FF(i-1, j);
        elseif w(i) == j % 第 i 件物品的重量 w(i) 等于背包的容量 j
            FF(i, j) = max(FF(i-1, j), p(i)); % 不放进去和放进去取较大的值
        else % 第 i 件物品的重量 w(i) 小于背包的容量 j
            FF(i, j) = max(FF(i-1, j), p(i)+FF(i-1, j-w(i))); % 不放进去和放进去取较大的值
        end
    end
end
f = FF(m, W);
end
