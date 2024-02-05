function [RX] = rank_data(X)
% % 输入值：
% X: 列向量
% % 返回值：
% RX: 对应的 X 的等级

%  举个例子 X = [5 10 9 10 6]'
[~, index] = sort(X); % ~ 表示我们不需要第一个输出值（即我们排序后的 X [5 6 9 10 10]）
% 注意这里的 index = [1 5 3 2 4]' 是我们排序后的 X 在原向量中的位置
[~, RX] = sort(index); % 对 index 进行一次升序，得到的 RX 就是我们想要的等级 RX = [1 4 3 5 2]'
% 但是这个等级还有一点小问题，那就是没有考虑到相等取平均值的问题

for i = 1:size(X, 1) % 设置一个循环（假设此时程序运行到了 i = 2）
    position = (X == X(i)); % 得到 X 中与 X(i) 相等的位置，返回一个列向量，向量值全为 1 或 0
    % （i = 2 时，position = [0 1 0 1 0]'）
    RX(position == 1) = sum(RX.*position) / sum(position); % 对 RX 进行处理
    %  RX .* position = [0 4 0 5 0]'
    %  那么 sum(rx .* position) / sum(position) = (4+5) / 2 = 4.5
    %  RX(position == 1)  = 4.5: 对 rx 中与 position == 1 对应位置的元素（即第 2 和第 4 个位置）进行赋值操作
end
end

% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭