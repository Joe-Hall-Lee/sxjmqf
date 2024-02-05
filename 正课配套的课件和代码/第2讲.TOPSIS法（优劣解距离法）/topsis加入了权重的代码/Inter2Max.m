function [posit_x] = Inter2Max(x, a, b)
r_x = size(x, 1); % row of x
M = max([a - min(x), max(x) - b]);
posit_x = zeros(r_x, 1); % zeros 函数用法: zeros(3);zeros(3, 1); ones(3)
% 初始化 posit_x 全为0  初始化的目的是节省处理时间
for i = 1:r_x
    if x(i) < a
        posit_x(i) = 1 - (a - x(i)) / M;
    elseif x(i) > b
        posit_x(i) = 1 - (x(i) - b) / M;
    else
        posit_x(i) = 1;
    end
end
end


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭