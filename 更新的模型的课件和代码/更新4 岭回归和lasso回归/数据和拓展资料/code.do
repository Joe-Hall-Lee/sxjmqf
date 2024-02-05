// 清空工作区数据
clear
// 安装 lassopack 命令，见课件
// findit lassopack   
// 导入数据，注意修改 Excel 文件的地址
import excel "F:\Mathematics\Mathematical_Modeling\清风数学建模\hc_lzp\更新的模型的课件和代码\更新4 岭回归和lasso回归\数据和拓展资料\棉花产量论文作业的数据.xlsx", sheet("data") firstrow
// 注意：这里自变量的量纲相同所以不用标准化，如果需要标准化，那么可以借助 MATLAB 的 zscore 函数，或者直接使用 SPSS（“分析”——“描述统计”——“描述”：在描述列表的方框左下角，看到“将标准化得分另存为变量（Z）之后点击打勾，然后确定。）
// Stata 中也有相应的标准化变量的命令，不过一次只能标准化一个变量，例如：egen Y = std(单产)，这个代码就表示将单产标准化，得到的变量记为 Y
cvlasso 单产 种子费 化肥费 农药费 机械费 灌溉费, lopt seed(520)



// 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
// 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭