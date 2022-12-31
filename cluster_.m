% 使用最短距离法系统聚类分析
clear; clc;
load('Region.mat');                 % 导入城市名变量
s = table2array(Region);            % 将城市名转化为string字符串类型
name = string(zeros(39,1));
for i = 1:39
    name(i) = string(s(i));
end
x = xlsread("聚类.xls",'A1:L40');   % 读取数据
x = x(:,1);
BX = zscore(x);                     % 标准化数据矩阵

Y = pdist(BX);                      % 用默认欧氏距离计算两两之间的距离
D = squareform(Y);                  % 欧氏距离矩阵，将两两之间的距离转换为方阵格式
Z = linkage(Y);                     % 最短距离法计算系统聚类树。

T = cluster(Z,4);                   % 调用聚类函数，将目标数据集分为4类
[H,T1]=dendrogram(Z,39,'Labels',name,'CheckCrossing',true,'Orientation','right');    % 画聚类图，H是一个线的句柄的向量
%title('系统聚类结果','FontSize',25);
xlabel('欧氏距离','FontSize',14);
ylabel('国家','FontSize',14);