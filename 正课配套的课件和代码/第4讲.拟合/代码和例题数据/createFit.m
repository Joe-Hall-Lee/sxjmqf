function [fitresult, gof] = createFit(year, population)
% CREATEFIT(YEAR, POPULATION)
%  创建一个拟合。
%
%  要进行 '无标题拟合 1' 拟合的数据:
%      X 输入: year
%      Y 输出: population
%  输出:
%      fitresult: 表示拟合的拟合对象。
%      gof: 带有拟合优度信息的结构体。
%
%  另请参阅 FIT, CFIT, SFIT.

%  由 MATLAB 于 22-Jul-2023 13:02:28 自动生成

%% 拟合: '无标题拟合 1'。
[xData, yData] = prepareCurveData(year, population);

% 设置 fittype 和选项。
ft = fittype('xm/(1+(xm/3.9-1)*exp(-r*(t-1790)))', 'independent', 't', 'dependent', 'x');
opts = fitoptions('Method', 'NonlinearLeastSquares');
opts.Display = 'Off';
opts.StartPoint = [0.02, 500];

% 对数据进行模型拟合。
[fitresult, gof] = fit(xData, yData, ft, opts);

% 绘制数据拟合图。
figure('Name', '无标题拟合 1');
h = plot(fitresult, xData, yData);
legend(h, 'population vs. year', 'fit function', 'Location', 'NorthEast', 'Interpreter', 'none');
% 为坐标区加标签
xlabel('year', 'Interpreter', 'none');
ylabel('population', 'Interpreter', 'none');
grid on
