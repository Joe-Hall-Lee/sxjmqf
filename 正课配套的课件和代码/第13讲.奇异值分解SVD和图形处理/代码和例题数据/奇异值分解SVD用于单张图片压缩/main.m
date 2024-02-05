clear,clc; 
% function []= photo_compress(photo_address, save_address, ratio, greycompress)
    % 函数作用：利用自定义的 mysvd 函数对图形进行压缩
    % 输入变量
    %     photo_address: 要压缩的图片存放的位置（建议输入完整的路径，如果 MATLAB 的工作文件夹没有切换到图片所在的文件夹就会报错）
    %     save_address: 将压缩后的图片保存的位置（建议输入完整的路径）
    %     ratio: 要保留原矩阵的特征比例（100% 表示不压缩）
    %     greycompress: 如果该值等于 1，则会彩色的原图片转换为灰色图片后再压缩；默认值为 0，表示不进行转换
    % 输出变量
    %     无（不需要输出，因为函数运行过程中已经将图片保存了）

photo_compress('赫本.jpg',  'compress_赫本1.jpg',  0.5);
photo_compress('赫本.jpg',  'compress_赫本2.jpg',  0.7);
photo_compress('赫本.jpg',  'compress_赫本3.jpg',  0.9);
photo_compress('千与千寻.jpg', 'compress_千与千寻.jpg', 0.8) ;
photo_compress('千与千寻.jpg', 'compress_gray_千与千寻.jpg', 0.8, 1); % 先转换为灰色图片后再压缩 



% 注意：如果下面的代码运行出错或结果和理想的不同，请检查你的 MATLAB 版本是否为较早的版本。
% 更多关于 MATLAB 图形处理的资料：https://ww2.mathworks.cn/help/matlab/graphics.html
% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭