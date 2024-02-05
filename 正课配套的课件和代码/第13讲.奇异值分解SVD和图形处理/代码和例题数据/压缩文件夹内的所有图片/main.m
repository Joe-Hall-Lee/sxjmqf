clear, clc;
% function [] = photo_compress(photo_address, save_address, ratio, greycompress)
% 函数作用：利用自定义的 mysvd 函数对图形进行压缩
% 输入变量
%     photo_address: 要压缩的图片存放的位置（建议输入完整的路径，如果 MATLAB 的工作文件夹没有切换到图片所在的文件夹就会报错）
%     save_address: 将压缩后的图片保存的位置（建议输入完整的路径）
%     ratio：要保留原矩阵的特征比例（100% 表示不压缩）
%     greycompress: 如果该值等于 1，则会彩色的原图片转换为灰色图片后再压缩；默认值为 0，表示不进行转换
% 输出变量
%     无（不需要输出，因为函数运行过程中已经将图片保存了）


% % 自己运行时路径一定要改成自己电脑上文件夹的路径，别直接用我的路径就运行了，可能会报错的。
folder_name = 'F:\Mathematics\Mathematical_Modeling\清风数学建模\hc_lzp\正课配套的课件和代码\第13讲.奇异值分解SVD和图形处理\代码和例题数据\压缩文件夹内的所有图片\葫芦娃七兄弟'; % 文件夹的绝对地址
% 在名为 folder_name 的文件夹下找到所有以 jpg 结尾的文件
dirOutput = dir(fullfile(folder_name, '*.jpg'));
% fullfile 函数可根据指定的文件夹和文件名构建完整的文件路径。
% dir 函数的作用: 返回指定路径的结构体类型的数组。数组中每一个元素以结构体类型存储着每个子文件的信息（文件名、创建时间等）。
files = {dirOutput.name}; % 将数组中的文件名保存到一个元胞数组中
n = length(files); % 图片的总数
ratio = 0.9; % 要保留的特征比例为 90%
for i = 1:n
    disp('---------------------------------------------------------------------------------------------')
    photoname = files(i); % 注意此时的 photoname 是一个 cell 字符串对象，需要转换为字符串
    % 如果我们直接把这个 cell 类型的变量，传递到其他函数中作为 string 类型使用，就会出现问题
    name = photoname{1}; % 直接这样取第一个元素就可以，cell 数组中取元素使用大括号
    photo_address = fullfile(folder_name, name); %图片的绝对地址
    disp(photo_address)
    save_address = fullfile(folder_name, strcat('compress_', name)); % 压缩后文件的保存地址
    photo_compress(photo_address, save_address, ratio)
    disp('---------------------------------------------------------------------------------------------')
end


% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭