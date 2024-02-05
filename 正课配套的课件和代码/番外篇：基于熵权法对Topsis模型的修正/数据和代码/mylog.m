% 重新定义一个 mylog 函数，当输入的 p 中元素为 0 时，返回 0
function [lnp] = mylog(p)
n = length(p); % 向量的长度
lnp = zeros(n, 1); % 初始化最后的结果
for i = 1:n % 开始循环
    if p(i) == 0 % 如果第 i 个元素为 0
        lnp(i) = 0; % 那么返回的第 i 个结果也为 0
    else
        lnp(i) = log(p(i));
    end
end
end


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭