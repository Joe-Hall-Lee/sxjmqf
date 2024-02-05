function [] = print_path(path, dist, i, j)

%% 该函数的作用是打印从 i 到 j 经过的最短路径
% 输入：
%     path 是使用 floyd 算法求出来的路径矩阵
%     dist 是使用 floyd 算法求出来的最短距离矩阵
%     i 是起始节点的编号
%     j 是终点节点的编号
% 输出：无

if i == j
    warning('起点和终点相同，请检查后重新输入') % 在屏幕中提示警告信息
    return; % 不运行下面的语句，直接退出函数
end
if path(i, j) == j % 如果 path(i, j) = j，则有两种可能：
    % （1）如果 dist(i, j) 为 Inf , 则说明从 i 到 j 没有路径可以到达
    if dist(i, j) == Inf
        disp(['从', num2str(i), '到', num2str(j), '没有路径可以到达'])
        % （2）如果 dist(i, j) 不为 Inf , 则说明从 i 到 j 可直接到达，且为最短路径
    else
        disp(['从 ', num2str(i), ' 到 ', num2str(j), ' 的最短路径为'])
        disp([num2str(i), ' ---> ', num2str(j)])
        disp(['最短距离为 ', num2str(dist(i, j))])
    end
else % 如果 path(i, j) ~= j，则说明中间经过了其他节点：
    k = path(i, j);
    result = [num2str(i), ' ---> ']; % 初始化要打印的这个字符串
    while k ~= j % 只要 k 不等于 j，就一直循环下去
        result = [result, num2str(k), ' ---> ']; % i 先走到 k 这个节点处
        k = path(k, j);
    end
    result = [result, num2str(k)];
    disp(['从 ', num2str(i), ' 到 ', num2str(j), ' 的最短路径为'])
    disp(result)
    disp(['最短距离为 ', num2str(dist(i, j))])
end

end


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭