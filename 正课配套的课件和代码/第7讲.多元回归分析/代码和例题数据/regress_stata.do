// 按键盘上的 PageUp 可以使用上一次输入的代码（MATLAB 中是上箭头）
// 清除所有变量
clear
// 清屏，和 MATLAB 的 clc 类似
cls 
// 导入数据（其实是我们直接在界面上粘贴过来的，我们用鼠标点界面导入更方便，本条请删除后再复制到论文中，如果评委老师看到了就知道这不是你写的了）
// import excel "F:\Mathematics\Mathematical_Modeling\清风数学建模\hc_lzp\正课配套的课件和代码\第7讲.多元回归分析\代码和例题数据\课堂中讲解的奶粉数据.xlsx", sheet("Sheet1") firstrow
import excel "课堂中讲解的奶粉数据.xlsx", sheet("Sheet1") firstrow
// 定量变量的描述性统计
summarize 团购价元 评价量 商品毛重kg
// 定性变量的频数分布，并得到相应字母开头的虚拟变量
tabulate 配方, gen(A)
tabulate 奶源产地, gen(B)
tabulate 国产或进口, gen(C)
tabulate 适用年龄岁, gen(D)
tabulate 包装单位, gen(E)
tabulate 分类, gen(F)
tabulate 段位, gen(G)
// 下面进行回归
regress 评价量 团购价元 商品毛重kg
// 下面的语句可帮助我们把回归结果保存在 Word 文档中
// 在使用之前需要运行下面这个代码来安装下这个功能包（运行一次之后就可以注释掉了）
// ssc install reg2docx, all replace
// 如果安装出现 connection timed out 的错误，可以尝试换成手机热点联网，如果手机热点也不能下载，就不用这个命令吧，可以自己做一个回归结果表，如果觉得麻烦就直接把回归结果截图。
est store m1
reg2docx m1 using m1.docx, replace
// *** p<0.01 ** p<0.05 * p < 0.1

// Stata 会自动剔除多重共线性的变量
regress 评价量 团购价元 商品毛重kg A1 A2 A3 B1 B2 B3 B4 B5 B6 B7 B8 B9 C1 C2 D1 D2 D3 D4 D5 E1 E2 E3 E4 F1 F2 G1 G2 G3 G4
est store m2
reg2docx m2 using m2.docx, replace

// 得到标准化回归系数
regress 评价量 团购价元 商品毛重kg, b 

// 画出残差图
regress 评价量 团购价元 商品毛重kg A1 A2 A3 B1 B2 B3 B4 B5 B6 B7 B8 B9 C1 C2 D1 D2 D3 D4 D5 E1 E2 E3 E4 F1 F2 G1 G2 G3 G4
rvfplot 
// 残差与拟合值的散点图
graph export a1.png, replace
// 残差与自变量团购价的散点图
rvpplot  团购价元
graph export a2.png, replace

// 为什么评价量的拟合值会出现负数？
// 描述性统计并给出分位数对应的数值
summarize 评价量, d

// 作评价量的概率密度估计图
kdensity 评价量 
graph export a3.png, replace

// 异方差 BP 检验
estat hettest, rhs iid

// 异方差怀特检验
estat imtest, white

// 使用 OLS + 稳健的标准误
regress 评价量 团购价元 商品毛重kg A1 A2 A3 B1 B2 B3 B4 B5 B6 B7 B8 B9 C1 C2 D1 D2 D3 D4 D5 E1 E2 E3 E4 F1 F2 G1 G2 G3 G4, r
est store m3
reg2docx m3 using m3.docx, replace

// 计算 VIF
estat vif

// 逐步回归（一定要注意完全多重共线性的影响）
// 向前逐步回归（后面的 r 表示稳健的标准误）
stepwise reg 评价量 团购价元 商品毛重kg A1 A3 B1 B2 B3 B4 B5 B6 B7 B9 C1 D1 D2 D3 D4 E1 E2 E3 F1 G1 G2 G3,  r pe(0.05)
// 向后逐步回归（后面的 r 表示稳健的标准误）
stepwise reg 评价量 团购价元 商品毛重kg A1 A3 B1 B2 B3 B4 B5 B6 B7 B9 C1 D1 D2 D3 D4 E1 E2 E3 F1 G1 G2 G3,  r pr(0.05)
// 向后逐步回归的同时使用标准化回归系数（在 r 后面跟上一个 b 即可）
stepwise reg 评价量 团购价元 商品毛重kg A1 A3 B1 B2 B3 B4 B5 B6 B7 B9 C1 D1 D2 D3 D4 E1 E2 E3 F1 G1 G2 G3,  r b pr(0.05)


// 补充语法 (大家不需要具体地去学 Stata软件，掌握我课堂上教给大家的一些命令应对数学建模比赛就可以啦)
// 事实上大家学好 Excel，学好后应对 90% 的数据预处理问题都能解决
// (1) 用已知变量生成新的变量 
generate lny = log(评价量)  
generate price_square = 团购价元 ^2
generate interaction_term = 团购价元*商品毛重kg

// (2) 修改变量名称，因为用中文命名变量名称有时候可能容易出现未知 bug
rename 团购价元 price

// 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
// 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭
