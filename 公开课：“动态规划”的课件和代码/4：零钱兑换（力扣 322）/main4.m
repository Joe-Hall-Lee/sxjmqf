%% 零钱兑换（力扣 322）
coins = [1, 2, 5, 20];
S = 11;
f = coin_change1(coins, S)
% 3

%% 得到具体的硬币组合
coins = [1, 2, 5, 10, 20, 50, 100];
S = 67;
[f, IND] = coin_change2(coins, S)
% f = 4
% IND = 2     5    10    50


coins = [2, 5, 8, 15, 60];
S = 130;
[f, IND] = coin_change2(coins, S)
% f = 4
% IND = 2     8    60    60