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
xlabel('����ڲ���k')
ylabel('������ȷ��')
title('kNN�㷨�ڲ�ͬkֵ�µ�ʶ����ȷ��');
save('sumk.mat','sumk');
save('knn_k.mat','knn_k');