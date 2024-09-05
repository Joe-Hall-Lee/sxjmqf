function F = fib_dg_memo(n)
% 利用带有备忘录的递归求解斐波那契数列
global memo % 备忘录定义成全局变量
if n == 1 || n == 2 % 两个出口
    F = 1;
elseif memo(n) ~= -1
    %  每次遇到一个子问题先去「备忘录」里查一查，
    %  如果发现之前已经解决过这个问题了，直接把答案拿出来用
    F = memo(n);
else
    %  每次算出某个子问题的答案后别急着返回，先记到「备忘录」里再返回
    memo(n) = fib_dg_memo(n-1) + fib_dg_memo(n-2);
    F = memo(n);
end
end
