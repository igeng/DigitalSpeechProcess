load sumk1
load sumk2
load sumk3
load sumk4
load sumk5

sumk=zeros(50,25);
sumk=sumk1+sumk2+sumk3+sumk4+sumk5;
sumk=sumk./5;
knn_k = sum(sumk,2);
[kk,ii]=max(knn_k)

figure(1);
x=1:1:50;   
knn_k=knn_k./5;
plot(x,knn_k,'-*r');
xlabel('最近邻参数k')
ylabel('分类正确率')
title('kNN算法在不同k值下的识别正确率');
save('sumk.mat','sumk');
save('knn_k.mat','knn_k');