function [posit_x] = Min2Max(x)
posit_x = max(x) - x;
% posit_x = 1 / x; 如果 x 全部都大于 0，也可以这样正向化
end


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭