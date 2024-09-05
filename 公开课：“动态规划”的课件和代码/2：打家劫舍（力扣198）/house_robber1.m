%% 题目来源：力扣 198. 打家劫舍
function f = house_robber1(M)
% 输入的 M 就是每间房子里面的金额
n = length(M); % 一共多少间房子
if n == 1 % 只有第 1 间房子可以偷时，f 应该等于这间房子的金额
    f = M(1);
elseif n == 2 % 只有前两间房子可以偷时，f 应该等于较大的金额
    f = max(M(1), M(2));
else % 超过三间房可以偷
    FF = zeros(1, n); % DP 数组，保存 f(k)
    FF(1) = M(1); % 边界条件
    FF(2) = max(M(1), M(2)); % 边界条件
    for i = 3:n % 利用状态转移方程循环计算
        FF(i) = max(FF(i-1), FF(i-2)+M(i));
    end
    f = FF(n); % 输出 FF 中最后一个元素，也就是原问题的解
end
end
