load knn_k
load wknn_k

wk_k_nn=wknn_k-knn_k;

figure(1);
x=1:1:20;
plot(x,wknn_k(1:20),'-*r',x,knn_k(1:20),'--ok');
xlabel('�������ݼ�')
ylabel('���ʶ����ȷ��')
% title('��ͬKֵ�µ�KNN�㷨��W-KNN�㷨ʶ����ȷ��');
legend('W-KNN','KNN','Location','SouthEast');   %���½Ǳ�ע

[kkk,iii]=max(wk_k_nn)
figure(2);
x=1:1:50;
%plot(x,wk_k_nn,'-.k');
bar(wk_k_nn)
% n=1:1:50;
% %��ͼ�ϼ�˵������
% for i = 1:length(wk_k_nn)
%     text(n(i),wk_k_nn(i)-0.03,num2str(wk_k_nn(i)));
% end
xlabel('����ڲ���K')
ylabel('�����㷨������ȷ�ʲ�ֵ')
title('��ͬKֵ�µ�W-KNN�㷨��KNN�㷨ʶ����ȷ�ʵĲ�ֵ');
save('wk_k_nn.mat','wk_k_nn');