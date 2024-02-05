function [] = print_all_path(D)

%% 该函数的作用是求解一个权重邻接矩阵任意两个节点之间的最短路径，并打印所有的结果出来
% 输入：
%     D 是权重邻接矩阵
% 输出：无

[dist, path] = Floyd_algorithm(D); % 调用之前的 Floyd_algorithm 函数
n = size(D, 1);
if n == 1
    warning('请输入至少两阶以上的权重邻接矩阵') % 在屏幕中提示警告信息
    return; % 不运行下面的语句，直接退出函数
end

for i = 1:n
    for j = 1:n
        if i ~= j % 不等号用 ~= 表示
            print_path(path, dist, i, j); % 调用之前的 print_path 函数
            disp('-------------------------------------------')
            disp('  ')
        end
    end
end

end


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭