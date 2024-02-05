function [ R , P ]= fun_spearman(X, kind)  
% % 输入值：
    % X: m * n 维数据矩阵，每一行表示一个样本，每一列表示一个指标；且 m >= 30 以及 n >= 2 
    % kind = 1: 单侧检验；kind = 2: 双侧检验（不输入默认为 2）
% % 返回值：
    % R: 斯皮尔曼相关系数矩阵（n * n 维）
    % P: 对应的 p 值矩阵（n * n 维）
    
    if nargin == 1  % 判断用户输入的参数，如果只输入了一个参数，则默认 kind = 2
        kind = 2;
    end

    [m,n] = size(X); % 计算样本个数和指标个数

    if m < 30  % 判断是否样本数太少
        disp('样本个数少于 30，请直接查临界值表进行假设检验')

    elseif n <2  % 判断是否指标数太少
        disp('指标个数太少，无法计算')

    elseif kind ~= 1 && kind ~= 2 % 判断 kind 是否为 1 或者 2
        disp('kind 只能取 1 或者 2')

    else  % 如果上述输入均没问题的话就执行下面的操作
        R = ones(n); % 初始化 R 矩阵
        P = ones(n); % 初始化 P 矩阵
        for i = 1: n
            for j = (i+1): n   % 这样设置循环只计算主对角线上半部分的值
                r = calculate_r(X(:, i), X(:, j));  % 用子函数 calculate_r 计算 i 和 j 两列的相关系数 r
                p = calculate_p(r, m, kind); % 用子函数 calculate_p 计算 p 值
                R(i, j) = r;  R(j, i) = r;  % 把计算出来的相关系数 r 填充到我们的 R 矩阵中，注意 R 矩阵对称
                P(i, j) = p; P(j, i) = p;  % 把计算出来的 p 值填充到我们的 P 矩阵中，注意 P 矩阵对称
            end
        end
    end
    
end

% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭