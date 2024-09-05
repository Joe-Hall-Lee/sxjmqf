%% 线性整数规划问题

%% 例 1
c = [-20, -10]';
intcon = [1, 2]; % x1 和 x2 限定为整数
A = [5, 4; ...
    2, 5];
b = [24; 13];
lb = zeros(2, 1);
[x, fval] = intlinprog(c, intcon, A, b, [], [], lb)
fval = -fval

%% 例 2
c = [18, 23, 5]';
intcon = 3; % x3 限定为整数
A = [107, 500, 0; ...
    72, 121, 65; ...
    -107, -500, 0; ...
    -72, -121, -65];
b = [50000; 2250; -500; -2000];
lb = zeros(3, 1);
[x, fval] = intlinprog(c, intcon, A, b, [], [], lb)

%% 例 3
c = [-3; -2; -1];
intcon = 3; % x3 限定为整数
A = ones(1, 3);
b = 7;
Aeq = [4, 2, 1];
beq = 12;
lb = zeros(3, 1);
ub = [+inf; +inf; 1]; % x(3) 为 0-1 变量
[x, fval] = intlinprog(c, intcon, A, b, Aeq, beq, lb, ub)
