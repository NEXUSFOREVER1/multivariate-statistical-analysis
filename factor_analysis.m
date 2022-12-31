% Factor_analysis.m因子分析实现代码
clear;clc;
[X,textdata] = xlsread('data_final.xls');     % 从Excel文件中读取数据
obsname = [num2cell(X(:,1))];          % 提取textdata的第一个元素，即id
X = X(:,8:end);               % 提取X的第8至最后一列，即要分析的数据
varname = textdata(1,8:end);  % 提取textdata的第1行，第4至最后一列，即变量名

% ********************调用factoran函数根据原始观测数据作因子分析**********************
% 从原始数据变量相关系数矩阵出发，进行因子分析，公共因子数为3
% 进行因子旋转(最大方差旋转法)
[lambda,psi,T,stats,F] = factoran(X,3);
Contribute = 100*sum(lambda.^2)/7;     % 计算贡献率，因子载荷阵的列元素之和除以维数
CumCont = cumsum(Contribute);          % 计算累积贡献率

s = [varname' num2cell(lambda)];
%*************************将因子得分F分别按三个因子进行排序***************************
obsF = [obsname, num2cell(F)];         % 将id与因子得分放在一个元胞数组中显示
F1 = sortrows(obsF, 2);                % 按因子1得分排序
F2 = sortrows(obsF, 3);                % 按因子2得分排序
F3 = sortrows(obsF, 4);                % 按因子3得分排序

head = {'id','因子1','因子2','因子3'};
result = [head; obsF];                 % 按照id排序的结果
result1 = [head; F1];                  % 显示按因子1得分排序的结果
result2 = [head; F2];                  % 显示按因子2得分排序的结果
result3 = [head; F3];                  % 显示按因子3得分排序的结果

%*****************************绘制因子得分负值的散点图******************************
scatter3(-F(:,1),-F(:,2),-F(:,3),'magenta','filled','AlphaDataMode','auto');     % 作因子得分负值的散点图
xlabel('F1 Score','FontSize',12);      % 为X轴加标签
ylabel('F2 Score','FontSize',12);      % 为Y轴加标签
zlabel('F3 Score','FontSize',12);      % 为Z轴加标签
%title('三个因子得分情况','FontSize',29); % 标题
%box off;                               % 去掉坐标系右上的边框