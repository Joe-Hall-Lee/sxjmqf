%%  第一步：把数据复制到工作区，并将这个矩阵命名为 X
% （1）在工作区右键，点击新建（Ctrl + N)，输入变量名称为 X
% （2）在 Excel 中复制数据，再回到 MATLAB 中右键，点击粘贴 Excel数据（Ctrl + Shift + V）
% （3）关掉这个窗口，点击 X 变量，右键另存为，保存为 mat 文件（下次就不用复制粘贴了，只需使用 load 命令即可加载数据）
% （4）注意，代码和数据要放在同一个目录下，且 MATLAB 的当前文件夹也要是这个目录。
clear; clc
load data_water_quality.mat

%% 注意：如果提示:
% 错误使用 load
% 找不到文件或目录 'data_water_quality.mat'。
% 那么原因是你的 MATLAB 的当前文件夹中不存在这个文件
% 可以使用 cd 函数修改 MATLAB 的当前文件夹
% 比如说，我的代码和数据放在了：F:\Mathematics\Mathematical_Modeling\数学建模清风\hc_lzp\正课配套的课件和代码\第2讲.TOPSIS法（优劣解距离法）\代码和例题数据
% 那么我就可以输入命令：
% cd 'F:\Mathematics\Mathematical_Modeling\数学建模清风\hc_lzp\正课配套的课件和代码\第2讲.TOPSIS法（优劣解距离法）\代码和例题数据'

%%  第二步：判断是否需要正向化
[n, m] = size(X);
disp(['共有 ', num2str(n), ' 个评价对象，', num2str(m), ' 个评价指标'])
Judge = input(['这 ', num2str(m), ' 个指标是否需要经过正向化处理，需要请输入 1，不需要输入 0：']);

if Judge == 1
    Position = input('请输入需要正向化处理的指标所在的列，例如第 2、3、6 三列需要处理，那么你需要输入 [2, 3, 6]：'); % [2, 3, 4]
    disp('请输入需要处理的这些列的指标类型（1：极小型，2：中间型，3：区间型） ')
    Type = input('例如：第 2 列是极小型，第 3 列是区间型，第 6 列是中间型，就输入 [1, 3, 2]：'); % [2, 1, 3]
    % 注意，Position 和 Type 是两个同维度的行向量
    for i = 1:size(Position, 2) % 这里需要对这些列分别处理，因此我们需要知道一共要处理的次数，即循环的次数
        X(:, Position(i)) = Positivization(X(:, Position(i)), Type(i), Position(i));
        % Positivization 是我们自己定义的函数，其作用是进行正向化，其一共接收三个参数
        % 第一个参数是要正向化处理的那一列向量 X(:, Position(i))，回顾上一讲的知识，X(:, n) 表示取第 n 列的全部元素
        % 第二个参数是对应的这一列的指标类型（1：极小型，2：中间型，3：区间型）
        % 第三个参数是告诉函数我们正在处理的是原始矩阵中的哪一列
        % 该函数有一个返回值，它返回正向化之后的指标，我们可以将其直接赋值给我们原始要处理的那一列向量
    end
    disp('正向化后的矩阵 X =')
    disp(X)
end

%% 第三步：对正向化后的矩阵进行标准化
Z = X ./ repmat(sum(X.*X).^0.5, n, 1);
disp('标准化矩阵 Z =')
disp(Z)

%% 第四步：计算与最大值的距离和最小值的距离，并算出得分
D_P = sum([(Z - repmat(max(Z), n, 1)) .^ 2], 2).^0.5; % D+ 与最大值的距离向量
D_N = sum([(Z - repmat(min(Z), n, 1)) .^ 2], 2).^0.5; % D- 与最小值的距离向量
S = D_N ./ (D_P + D_N); % 未归一化的得分
disp('最后的得分为：')
stand_S = S / sum(S)
[sorted_S, index] = sort(stand_S, 'descend')

% A = magic(5) % 幻方矩阵
% M = magic(n)返回由 1 到 n^2 的整数构成并且总行数和总列数相等的n×n矩阵。阶次 n 必须为大于或等于 3 的标量。
% sort(A) 若 A 是向量不管是列还是行向量，默认都是对A进行升序排列。sort(A) 是默认的升序，而 sort(A, 'descend') 是降序排序。
% sort(A) 若 A 是矩阵，默认对 A 的各列进行升序排列
% sort(A, dim)
% dim = 1 时等效 sort(A)
% dim = 2 时表示对 A 中的各行元素升序排列
% A = [2, 1, 3, 8]
% MATLAB 中给一维向量排序是使用 sort 函数：sort（A），排序是按升序进行的，其中 A 为待排序的向量；
% 若欲保留排列前的索引，则可用 [sA, index] = sort(A, 'descend')，排序后，sA 是排序好的向量，index 是向量 sA 中对 A 的索引。
% sA  =  8     3     2     1
% index =  4     3     1     2

% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭