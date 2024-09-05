%% 求硬币兑换的方案数
function [f, FF] = coin_change_numbers(coins, S)
% 这里也可以返回 FF，FF 就是 DP 数组，1992 年国赛那一题有用
coins = sort(coins); % 先排个序
m = length(coins); % 一共 m 种硬币
FF = zeros(m, S); % 初始化 DP 数组
% FF(i, j): 只能使用前 i 种面值的硬币来凑出总金额 j 的钱的方案数目
% 初始化第一行（只有第 1 种硬币，需要凑出金额为 j 的钱）
FF(1, :) = (mod(1:S, coins(1)) == 0);
% 初始化第一列（只能使用前 i 种面值的硬币，需要凑出金额为 1 的钱的方法数）
FF(:, 1) = (coins(1) == 1);
% i, j > 1 的情况
for i = 2:m % 使用了前 i 种面值的硬币
    for j = 2:S % 凑出金额为 j 的钱
        if j - coins(i) < 0
            % 如果第 i 个硬币的面值比j还要大，那第 i 个硬币没起到作用
            FF(i, j) = FF(i-1, j);
        elseif j - coins(i) == 0
            % 如果第 i 个硬币的面值等于 j，那有了第 i 个硬币后相当于多了 1 种方法
            FF(i, j) = FF(i-1, j) + 1;
        else
            % 如果第 i 个硬币的面值小于 j，那就可以等价于两部分之和：
            FF(i, j) = FF(i-1, j) + FF(i, j-coins(i));
        end
    end
end
f = FF(m, S);
end
