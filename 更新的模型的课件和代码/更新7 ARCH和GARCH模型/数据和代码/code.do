clear // 清空变量
* （1）导入数据并生成时间序列（* 和 // 都可以用来注释一行）
insheet using "Bindex.csv"  //导入位于和代码同一文件夹下的 csv 数据文件
gen datevar = date(date,"YMD") // 将 csv 中的变量 date 转换为 stata 能识别的时间数据 datevar
format datevar %td // 对 datevar 的展示格式进行转换，转换后以“日月年”显示
label variable datevar "日期" // 设置 datevar 的标签为日期，主要用于画图时的展示
tsset datevar // 定义 datevar 是一个时间序列数据
gen time = _n // 定义一个从 1 到 n 的 time 序列，n 是观测值的个数，系统自动在后台记录的
tsset time // 将 time 这个序列定义为时间序列，后续滞后算子时需要用到


// 画深成 B 指的时间序列图
line index datevar   
graph export "深成B指的时间序列图.png", as(png) replace // 导出图片到本地文件夹

// 计算日收益率数据
gen r = 100 * (index - L.index) / L.index   // (今天的收盘价 - 昨天的收盘价) / 昨天的收盘价，L 是 lag 的缩写

// 对日收益率 r 进行描述性统计
summarize r  

// 做出日收益率的时间序列图
line r datevar
graph export "深成B指日收益率的时间序列图.png", as(png) replace   // 导出图片到本地文件夹


// 检验收益率序列 r 是否为单位根，检验方法是 ADF 检验（原假设：是单位根序列；备择假设：是平稳序列）
dfuller r
// MacKinnon approximate p-value for Z(t) = 0.0000  p 值为 0 意味着拒绝原假设，所以我们认为 r 序列平稳


// 观察 acf 图与 pacf 图 ，判断 AMRA 模型的阶数
ac r,lags(20)   // 自相关系数图，滞后 20 期
graph export "自相关系数图.png", as(png) replace // 导出图片到本地文件夹

pac r,lags(20)  // 偏自相关系数图，滞后 20 期
graph export "偏自相关系数图.png", as(png) replace // 导出图片到本地文件夹


// 根据 acf 和 pacf 图，初步判断使用四个备选的 ARMA 模型来拟合
set matsize 1500  // 把计算时支持的最大矩阵大小设置的大一点，否则计算机性能较差的电脑可能在计算中会报错
arima r, arima(3, 0, 3) // 用 ARIMA(3, 0, 3) 模型对 r 进行估计
estat ic // 得到 AIC 和 BIC，用于选择合适的模型（选小原则，详见第十一讲）
arima r, arima(8, 0, 8)
estat ic
arima r, arima(3, 0, 8)
estat ic
arima r, arima(8, 0, 3)
estat ic


// ARIMA(3, 0, 3) 模型的 AIC 值和 BIC 值的平均值最小，所以下面我们使用这个模型进行估计 
arima r, arima(3, 0, 3)

// 得到残差的预测值并生成残差分布直方图图
predict residess, residuals   // 保存残差
hist residess,norm freq // norm freq 表示加上标准正态分布的概率密度函数
graph export "残差分布直方图.png", as(png) replace // 导出图片到本地文件夹


// 检验残差是否为白噪声序列，检验方法为 Q 检验：原假设是白噪声，备择假设不是白噪声
wntestq residess, lag(12) // 对残差序列进行白噪声检验

// 生成残差的平方，并进行 Q 检验
gen ressq = residess^2   // 生成残差平方序列 ressq
wntestq ressq, lag(12) // 对残差平方序列 ressq 进行白噪声检验

// LM 检验：是否存在 ARCH 误差
reg ressq l.ressq l2.ressq l3.ressq l4.ressq l5.ressq  // 将残差平方项对其滞后项回归
gen LM_STAT=e(N)*e(r2) // 计算 LM 统计量
display LM_STAT  // 输出 LM 统计量
display chiprob(e(df_m),LM_STAT) // 计算 p 值


// 利用 AIC、BIC 选择合适的模型进行估计 
// 注意：扰动项的分布在金融数据中常服从 t 分布
// 正态分布下 GARCH(1, 1) 估计
arch r,arima(3 0 3) arch(1) garch(1)
estat ic
// t 分布下 GARCH(1, 1) 估计
arch r,arima(3 0 3) arch(1) garch(1) distribution(t 3)  // 自由度为 3 的 t 分布
estat ic
// 正态分布下 GARCH(2, 2) 估计
arch r,arima(3 0 3) arch(2) garch(2)
estat ic
// t 分布下 GARCH(2, 2) 估计
arch r,arima(3 0 3) arch(2) garch(2) distribution(t 3)
estat ic


// 得到拟合结果，并进行预测
arch r,arima(3 0 3) arch(1) garch(1) distribution(t 3)
tsappend ,add(10)  // 将时间延长 10 期
predict result // 对数据进行预测
tsline result r, legend(label(1 "预测值")  label(2 "真实值")) // 绘制拟合图
graph export "预测结果图.png", as(png) replace // 导出图片到本地文件夹



// 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
// 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭