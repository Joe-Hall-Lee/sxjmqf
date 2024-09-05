function F = fib_dg(n)
% 利用递归求解斐波那契数列
if n == 0 % 递归的第一个出口
    F = 0;
elseif n == 1 % 递归的第二个出口
    F = 1;
else
    F = fib_dg(n-1) + fib_dg(n-2);
end
end
