function F = fib_zdxs(n)
% 利用自底向上的思想求解斐波那契数列
FF = ones(1, n); % 初始化保存中间结果的数组（向量）全为 1
if n <= 2
    F = 1;
else
    for i = 3:n
        FF(i) = FF(i-1) + FF(i-2);
    end
    F = FF(n);
end
end
