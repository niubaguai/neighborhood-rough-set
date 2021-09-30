% 清
clc;
clear;
% 加载数据
data_array = load('testData.mat');
data_array=data_array.unnamed;
% 定义变量
% delta是衡量两个样本间距离的阈值，他是一个变量，后面使用优化算法来选取。现在先固定：离散型数据：0，连续性数据：0.1
delta = 0  % 对于离散型数据

[m,n]=size(data_array); % m表示样本数，n表示属性数
feature_lft=(1:n-1); %feature_lft表示条件属性
sample_lft=(1:m); %sample_lft表示选择的样本
array_cur=[] %
%neiborghood_array = zeros(m,m,3) % 定义一个三维矩阵
neiborghood_temp = [] % 临时存放邻域类
neiborghood_array = [] % 存放某个属性下的领域类

% 对每个子属性
for f=1:length(feature_lft)
    for i=1:length(sample_lft)
        xi=data_array(i, f) % xi代表每次选中f属性的 第i个样本，注意是样本
        for j=1:length(sample_lft)
            xj=data_array(j, f)
            % 计算两个样本在同一子属性下的距离
            % 使用定义好的函数
            dist = dist_E(xi,xj)
            if dist<=delta
                neiborghood_temp = [neiborghood_temp, j] % 领域类，在一个属性下的一个样本的领域类
            end
        end
        neiborghood_array = [neiborghood_array; neiborghood_temp] % 添加新的一行
        neiborghood_temp = [] % 清空
    end
    % 清空
    neiborghood_array = []
    % 计算依赖度
end


% 1、计算每个样本的领域类
