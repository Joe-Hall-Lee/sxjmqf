%% 题目来源：零钱兑换（力扣 322）
function f = coin_change1(coins, S)
% coins: 不同面值的硬币，S: 总金额
% f(x) = min{f(x-c_i) for every c_i in coins} + 1
% x < 0 时, f(x) = +inf; x = 0 时, f(x) = 0
FF = +inf * ones(1, S+2); % 初始化 DP 数组全为正无穷
% 注意，这个 DP 数组长度为 S + 2，前面 S 个才是我们有用的
% FF(x) 为凑成目标金额 x(x ≤ S) 所需的最少的硬币个数
% 为什么这里还要在后面再加上两个元素呢？
% 后面大家就知道这样做的妙处了
FF(S+2) = 0; % 最后一个元素改为 0
for x = 1:S % 注意，FF 只需要更新前 S 个元素
    tmp = x - coins; % 计算出 'x-c_i' for every c_i in coins
    tmp(tmp < 0) = S + 1; % FF 下标为 S + 1 的元素为 +inf，所以我们把 tmp < 0 的位置变成 S + 1
    tmp(tmp == 0) = S + 2; % FF 下标为 S + 2 的元素为 0，所以我们把 tmp = 0 的位置变成 S + 2
    FF(x) = min(FF(tmp)) + 1; % f(x) = min{f(x-c_i) for every c_i in coins} + 1
end
if FF(S) < +inf
    f = FF(S);
else
    f = -1; % 如果没有任何一种硬币组合能组成总金额 S 就返回 -1
end
end
