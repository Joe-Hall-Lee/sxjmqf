function F = factorial(n)
% 利用递归求正整数 n 的阶乘
if n == 1 % 递归的出口
    F = 1;
else
    F = n * factorial(n-1);
end
end
