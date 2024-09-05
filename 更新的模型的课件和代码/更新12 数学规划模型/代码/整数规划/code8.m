%% 背包问题（货车运送货物的问题）
c = -[540, 200, 180, 350, 60, 150, 280, 450, 320, 120]; % 目标函数的系数矩阵（最大化问题记得加负号）
intcon = [1:10]; % 整数变量的位置（一共 10 个决策变量，均为 0-1 整数变量）
A = [6, 3, 4, 5, 1, 2, 3, 5, 4, 2];
b = 30; % 线性不等式约束的系数矩阵和常数项向量（物品的重量不能超过 30）
Aeq = [];
beq = []; % 不存在线性等式约束
lb = zeros(10, 1); % 约束变量的范围下限
ub = ones(10, 1); % 约束变量的范围上限
% 最后调用 intlinprog() 函数
[x, fval] = intlinprog(c, intcon, A, b, Aeq, beq, lb, ub)
fval = -fval
