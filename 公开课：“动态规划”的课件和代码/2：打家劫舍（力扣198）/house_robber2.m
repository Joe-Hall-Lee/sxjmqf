%% 通过状态压缩来节省空间消耗
function f = house_robber2(M)
% 输入的 M 就是每间房子里面的金额
n = length(M); % 一共多少间房子
if n == 1 % 只有第 1 间房子可以偷时，f 应该等于这间房子的金额
    f = M(1);
elseif n == 2 % 只有前两间房子可以偷时，f 应该等于较大的金额
    f = max(M(1), M(2));
else
    pre2 = M(1); % 保存F(i-2)的值
    pre1 = max(M(1), M(2)); % 保存F(i-1)的值
    for i = 3:n
        cur = max(pre1, pre2+M(i)); % 即 FF(i) = max(FF(i-1), FF(i-2)+M(i));
        pre2 = pre1; % F(i-2) 往前进 1 位变成 F(i-1)
        pre1 = cur; % F(i-1) 往前进 1 位变成 F(i)
    end
    f = cur; % 输出 FF(i)，此时 i = n，也就是原问题的解
end
end
