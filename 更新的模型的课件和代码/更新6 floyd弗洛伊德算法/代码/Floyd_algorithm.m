function [dist, path] = Floyd_algorithm(D)

%% 该函数用于求解一个权重邻接矩阵任意两个节点之间的最短路径
% 输入：
%     D 是权重邻接矩阵
% 输出：
%     dist 是最短距离矩阵，其元素 dist_ij 表示表示 i, j 两个节点的最短距离
%     path 是路径矩阵，其元素 path_ij 表示起点为 i，终点为 j 的两个节点之间的最短路径要经过的节点

n = size(D, 1); % 计算节点的个数

% 初始化 dist 矩阵
dist = D;

% 下面我们来初始化 path 矩阵
path = zeros(n);
for j = 1:n
    path(:, j) = j; % 将第 j列的元素变为j
end
for i = 1:n
    path(i, i) = -1; % 将主对角线元素变为 -1
end

% 下面开始三个循环
for k = 1:n % 中间节点 k 从 1 - n 循环
    for i = 1:n % 起始节点 i 从 1 - n 循环
        for j = 1:n % 终点节点 j 从 1 - n 循环
            if dist(i, j) > dist(i, k) + dist(k, j) % 如果 i, j 两个节点间的最短距离大于 i 和 k 的最短距离 + k和 j 的最短距离
                dist(i, j) = dist(i, k) + dist(k, j); % 那么我们就令这两个较短的距离之和取代 i, j 两点之间的最短距离
                path(i, j) = path(i, k); % 起点为 i，终点为 j 的两个节点之间的最短路径要经过的节点更新为 path(i, k)
                % 注意，上面一行语句不能写成 path(i, j) = k; 这是网上很多地方都容易犯的错误，在 PPT 11 页中会告诉大家为什么不能这么写
            end
        end
    end
end

end


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭