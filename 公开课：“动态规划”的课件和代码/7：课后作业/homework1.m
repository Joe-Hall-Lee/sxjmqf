% 作业 1：爬楼梯
% 题目来源：力扣 70. 爬楼梯
% 链接：https://leetcode-cn.com/problems/climbing-stairs
function F = homework1(n)
if n == 1
    F = 1;
elseif n == 2
    F = 2;
else
    FF = ones(1, n); % 初始化 DP 数组
    FF(2) = 2;
    for i = 3:n
        FF(i) = FF(i-1) + FF(i-2);
    end
    F = FF(n);
end
end