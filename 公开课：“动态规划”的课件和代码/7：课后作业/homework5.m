% 作业 5：编辑距离
% 题目来源：力扣 72. 编辑距离
% 链接：https://leetcode-cn.com/problems/edit-distance/
function f = homework5(word1, word2)
m = length(word1);
n = length(word2);
FF = ones(m, n); % 初始化 DP 数组
% 处理第一行
ind = strfind(word2, word1(1)); % 在 word2 中找 word1 的第一个字母
for j = 1:n
    if isempty(ind) % word1 的第 1 个字母不在 word2 中
        FF(1, j) = j;
        % word1 的第一个字母在 word2 中时，ind里面可能有多个位置，我们只需要首次出现的位置
    elseif ind(1) == 1 % word1 和 word2 的第 1 个字母相同
        FF(1, j) = j - 1;
    else
        % 如果位置不为 1，那么该位置之前的 FF(1, j) = j，该位置以及该位置之后的 FF(1, j) = j - 1
        if j < ind(1)
            FF(1, j) = j;
        else
            FF(1, j) = j - 1;
        end
    end
end
% 处理第一列
ind = strfind(word1, word2(1)); % 在 word1 中找 word2 的第一个字母
for i = 1:m
    if isempty(ind) % word2 的第 1 个字母不在 word1 中
        FF(i, 1) = i;
        % word2 的第一个字母在 word1 中时，ind 里面可能有多个位置，我们只需要首次出现的位置
    elseif ind(1) == 1 % word1 和 word2 的第 1 个字母相同
        FF(i, 1) = i - 1;
    else
        % 如果位置不为 1，那么该位置之前的 FF(i, 1) = i，该位置以及该位置之后的 FF(i, 1) = i - 1
        if i < ind(1)
            FF(i, 1) = i;
        else
            FF(i, 1) = i - 1;
        end
    end
end
% 循环计算右下部分的元素
for i = 2:m
    for j = 2:n
        tmp1 = FF(i-1, j-1) + (word1(i) ~= word2(j)) * 1;
        % 先把 word1[1..i-1] 变换到 word2[1...j-1]，消耗掉 FF(i-1, j-1) 步，
        % 再把 word1[i] 改成 word2[j]，就行了。
        % 这里分为两种情况：如果 word1[i] == word2[j]，什么也不用做，一共消耗 FF(i-1, j-1) 步；
        % 否则需要替换最后一个字符，一共消耗 FF(i-1,j-1) + 1 步。
        tmp2 = FF(i-1, j) + 1;
        % 先把 word1[1..i-1] 变换到 word2[1..j]，消耗掉 FF(i-1,j) 步，
        % 再把 word1[i] 删除，这样word1[1..i] 就完全变成了 word2[1..j] 了，
        % 一共消耗 FF(i-1, j) + 1 步。
        tmp3 = FF(i, j-1) + 1;
        % 先把 word1[1..i] 变换成 word2[1..j-1]，消耗掉 FF(i, j-1) 步
        % 接下来，再插入一个字符 word2[j], word1[1..i] 就完全变成了 word2[1..j] 了。
        % 一共消耗 FF(i, j-1) + 1 步。
        FF(i, j) = min([tmp1, tmp2, tmp3]);
        % 从上面三个问题来看，word1[1..i] 变换成 word2[1..j] 主要有三种操作
        % 哪种操作步数最少就用哪种。
    end
end
f = FF(m, n);
end
