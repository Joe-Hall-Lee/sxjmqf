function [posit_x] = Mid2Max(x, best)
M = max(abs(x-best));
posit_x = 1 - abs(x-best) / M;
end


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭