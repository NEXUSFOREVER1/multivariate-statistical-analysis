clear;clc;
data = readmatrix('聚类.xls');
data = data(:,2:end);
data = zscore(data);
y = data(:,1);

x = data(:,2:end);

co = corr(x,y);
[b,bint,r,rint,stats] = regress(y,x);
