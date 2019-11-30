load wksumk1
load wksumk2
load wksumk3
load wksumk4
load wksumk5

wksumk=zeros(50,25);
wksumk=wksumk1+wksumk2+wksumk3+wksumk4+wksumk5;
%求每个k值下平均的每个情感的正确率
wksumk=wksumk./5;
wknn_k = sum(wksumk,2);
[kk,ii]=max(wknn_k)

figure(1);
x=1:1:50;
%求总的识别正确率
wknn_k=wknn_k./5;
plot(x,wknn_k,'-*r');
xlabel('最近邻参数k')
ylabel('分类正确率')
title('WA-kNN算法在不同k值下的识别正确率');
save('wksumk.mat','wksumk');
save('wknn_k.mat','wknn_k');