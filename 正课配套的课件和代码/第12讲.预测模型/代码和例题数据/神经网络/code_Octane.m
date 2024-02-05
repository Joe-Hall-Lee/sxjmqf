%% 注意
% MATLAB 2021b 版本后，神经网络拟合工具箱升级成了中文
% 如果直接使用课堂上的代码会报错，相应的解决方法请关注微信公众号
% "数学建模学习交流"，后台发送"894145"这六个数字，文章内有解决方法。

%% 下面是代码，MATLAB 2017a 至 MATLAB 2021a 版本通用
load data_Octane.mat
% 在 MATLAB 的菜单栏点击"APP"，再点击"神经网络拟合"

% 利用训练出来的神经网络模型对数据进行预测
% 例如我们要预测编号为 51 的样本，其对应的 401 个吸光度为：new_X(1,:)
% sim(net, new_X(1,:))
% 错误使用 network/sim (line 266)
% Input data sizes do not match net.inputs{1}.size.
% net.inputs{1}.size
 

net = results.Network;
% 这里要注意，我们要将指标变为列向量，然后再用 sim 函数预测
sim(net, new_X(1,:)')

%
% 写一个循环，预测接下来的十个样本的辛烷值
predict_y = zeros(10,1); % 初始化 predict_y
for i = 1: 10
    result = sim(net, new_X(i,:)');
    predict_y(i) = result;
end
disp('预测值为：')
disp(predict_y)



% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭