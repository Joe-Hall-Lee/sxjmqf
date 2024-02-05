%% 注意：以下代码需要较新版本的 MATLAB 才能运行（最好是 2016 版本及以上）
% 如果运行出错请下载新版的 MATLAB 代码再运行

%% MATLAB 作无向图
% （1）无权重（每条边的权重默认为 1）
% 函数 graph(s, t)：可在 s 和 t 中的对应节点之间创建边，并生成一个图
% s 和 t 都必须具有相同的元素数；这些节点必须都是从 1 开始的正整数，或都是字符串元胞数组。
s1 = [1, 2, 3, 4];
t1 = [2, 3, 1, 1];
G1 = graph(s1, t1);
plot(G1)
% 注意，编号最好是从 1 开始连续编号，不要自己随便定义编号
s1 = [1, 2, 3, 4];
t1 = [2, 3, 1, 1];
G1 = graph(s1, t1);
plot(G1)

% 注意字符串元胞数组是用大括号包起来的哦
s2 = {'学校', '电影院', '网吧', '酒店'};
t2 = {'电影院', '酒店', '酒店', 'KTV'};
G2 = graph(s2, t2);
plot(G2, 'linewidth', 2) % 设置线的宽度
% 下面的命令是在画图后不显示坐标
set(gca, 'XTick', [], 'YTick', []);

% （2）有权重
% 函数 graph(s, t, w)：可在 s 和 t 中的对应节点之间以 w 的权重创建边，并生成一个图
s = [1, 2, 3, 4];
t = [2, 3, 1, 1];
w = [3, 8, 9, 2];
G = graph(s, t, w);
plot(G, 'EdgeLabel', G.Edges.Weight, 'linewidth', 2)
set(gca, 'XTick', [], 'YTick', []);

%% MATLAB 作有向图
% 无权图 digraph(s, t)
s = [1, 2, 3, 4, 1];
t = [2, 3, 1, 1, 4];
G = digraph(s, t);
plot(G)
set(gca, 'XTick', [], 'YTick', []);

% 有权图 digraph(s, t, w)
s = [1, 2, 3, 4];
t = [2, 3, 1, 1];
w = [3, 8, 9, 2];
G = digraph(s, t, w);
plot(G, 'EdgeLabel', G.Edges.Weight, 'linewidth', 2)
set(gca, 'XTick', [], 'YTick', []);

% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭