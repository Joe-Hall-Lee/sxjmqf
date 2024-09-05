%% 怎么输出偷窃的房屋编号？
% 注意：产生最大偷窃金额的方案不唯一，我们这里只要求输出任意一个方案即可。
% 例如 M = [1, 3, 2] 就有两种方案。
function [f, IND] = house_robber3(M)
% 输入的 M 就是每间房子里面的金额
% f 是能够偷窃到的最高金额，IND 是偷窃的房屋编号
n = length(M); % 一共多少间房子
if n == 1 % 只有一间房子
    f = M(1);
    IND = 1;
elseif n == 2 % 只有两间房子
    [f, IND] = max([M(1), M(2)]); % f 是最大值，IND 是最大值对应的下标
    % 注意这里的细节，我把 M(1) 和 M(2) 放在了中括号内构成了一个向量
    % 相当于是计算向量中最大的元素，为什么要这么做呢？因为我们要输出最大值对应的下标
    % 大家可以测试：[f, IND] = max([1, 2]) 和 [f, IND] = max(1, 2)
    % 后面这种写法会报错
else % 大于两间房子的情况
    FF = zeros(1, n); % DP 数组，保存 f(k)
    FF(1) = M(1);
    FF(2) = max(M(1), M(2));
    for i = 3:n
        FF(i) = max(FF(i-1), FF(i-2)+M(i));
    end
    f = FF(n);
    % FF 中可以提取出盗窃的房屋信息（这里的实现细节请看课件）
    IND = [];
    ind = find(FF == FF(end), 1);
    IND = [IND, ind];
    while FF(ind) > M(ind)
        ind = find(FF == (FF(ind) - M(ind)), 1);
        IND = [IND, ind];
    end
    IND = IND(end:-1:1); % 翻转一下（变成从小到大）
end
end
