%% 灰色关联分析用于系统分析例题的讲解
clear; clc
load gdp.mat % 导入数据，一个 6 * 4 的矩阵
% 不会导入数据的同学可以看看第二讲 TOPSIS 模型，我们也可以自己在工作区新建变量，并把 Excel 的数据粘贴过来
% 注意 MATLAB 的当前文件夹一定要切换到有数据文件的这个文件夹内
Mean = mean(gdp); % 求出每一列的均值以供后续的数据预处理
gdp = gdp ./ repmat(Mean, size(gdp, 1), 1); % size(gdp, 1)=6, repmat(Mean, 6, 1) 可以将矩阵进行复制，复制为和 gdp 同等大小，然后使用点除（对应元素相除），这些在第一讲层次分析法都讲过
disp('预处理后的矩阵为：'); disp(gdp)
Y = gdp(:, 1); % 母序列
X = gdp(:, 2:end); % 子序列
absX0_Xi = abs(X-repmat(Y, 1, size(X, 2))) % 计算 |X0-Xi| 矩阵（在这里我们把 X0 定义为了 Y）
a = min(min(absX0_Xi)) % 计算两级最小差 a
b = max(max(absX0_Xi)) % 计算两级最大差 b
rho = 0.5; % 分辨系数取 0.5
gamma = (a + rho * b) ./ (absX0_Xi + rho * b) % 计算子序列中各个指标与母序列的关联系数
disp('子序列中各个指标的灰色关联度分别为：')
disp(mean(gamma))


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭