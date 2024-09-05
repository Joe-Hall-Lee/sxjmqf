%% 怎么得到具体的硬币组合
function [f, IND] = coin_change2(coins, S)
FF = +inf * ones(1, S+2);
FF(S+2) = 0; % 最后一个元素改为 0
for x = 1:S
    tmp = x - coins;
    tmp(tmp < 0) = S + 1;
    tmp(tmp == 0) = S + 2;
    FF(x) = min(FF(tmp)) + 1;
end
% 利用 FF 来计算 IND
IND = []; % IND 表示我们选择的硬币组合，初始化为空向量
if FF(S) < +inf % 存在能凑成 S 的组合
    f = FF(S);
    ind = S; % ind 先指向最后一个位置 S
    while FF(ind) > 1 % 如果 FF(ind) = 1 时就不用寻找了
        indd = ind; % 保存前一个位置
        tmp = ind - coins;
        tmp(tmp < 0) = S + 1; % FF 下标为 S + 1 的元素为 +inf
        tmp(tmp == 0) = S + 2; % FF 最后一个元素为 0
        ind = tmp(find(FF(tmp) == (FF(ind) - 1), 1)); % 找到新的位置
        IND = [IND, indd - ind]; % 两个位置之差就是我们要添加的硬币
    end
    IND = [IND, ind]; % FF(ind) = 1 时，把 ind 也放入到 IND 中
else % 如果没有任何一种硬币组合能组成总金额 S 就返回 -1
    f = -1;
end
end
