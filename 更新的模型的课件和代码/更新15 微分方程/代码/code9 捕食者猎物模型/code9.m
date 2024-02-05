clear; clc
% MATLAB 求不出来解析解
% dsolve('Dx1=x1*(0.9-0.1*x2)', 'Dx2=x2*(-0.6+0.02*x1)', 'x1(0)=25, x2(0)=2', 't')

% 下面用 ode45 函数求数值解
% 自变量 t 的范围为 0-15 年，食饵和捕食者（鲨鱼）初始值分别为 25 和 2
% 注意：战前和战后是战争开始前和战争开始后的简写哦
[t1, x1] = ode45('pre_war', [0, 15], [25, 2]); % 战前的微分方程
[t2, x2] = ode45('past_war', [0, 15], [25, 2]); % 战后的微分方程
% [t1, x1] = ode45('pre_war', [0:15], [25, 2]); % 战前的微分方程
% [t2, x2] = ode45('past_war', [0:15], [25, 2]); % 战后的微分方程

pre_prey = x1(:, 1);
pre_shark = x1(:, 2); % 战前的食饵和鲨鱼的数量
past_prey = x2(:, 1);
past_shark = x2(:, 2); % 战后的食饵和鲨鱼的数量

figure(1)
plot(pre_prey, pre_shark, '--r', past_prey, past_shark, '-b')
legend('战前', '战后')
title('鲨鱼和食饵数量变化的相轨线图')
xlabel('食饵数量'); ylabel('鲨鱼数量')

figure(2)
plot(t1, pre_prey, '--r', t1, pre_shark, '-r', t2, past_prey, '--b', t2, past_shark, '-b')
legend('战前食饵数量', '战前鲨鱼数量', '战后食饵数量', '战后鲨鱼数量')
xlabel('时间'); ylabel('数量')

% 鲨鱼比例 = 鲨鱼数量 /（鲨鱼数+食饵数）
pre_rate = pre_shark ./ (pre_prey + pre_shark); % 战前的鲨鱼比例
past_rate = past_shark ./ (past_prey + past_shark); % 战后的鲨鱼比例
figure(3)
plot(t1, pre_rate, '--r', t2, past_rate, '-b')
legend('战前的鲨鱼比例', '战后的鲨鱼比例')


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭