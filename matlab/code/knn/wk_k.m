load knn_k
load wknn_k

wk_k_nn=wknn_k-knn_k;

figure(1);
x=1:1:20;
plot(x,wknn_k(1:20),'-*r',x,knn_k(1:20),'--ok');
xlabel('德语数据集')
ylabel('情感识别正确率')
% title('不同K值下的KNN算法与W-KNN算法识别正确率');
legend('W-KNN','KNN','Location','SouthEast');   %右下角标注

[kkk,iii]=max(wk_k_nn)
figure(2);
x=1:1:50;
%plot(x,wk_k_nn,'-.k');
bar(wk_k_nn)
% n=1:1:50;
% %给图上加说明文字
% for i = 1:length(wk_k_nn)
%     text(n(i),wk_k_nn(i)-0.03,num2str(wk_k_nn(i)));
% end
xlabel('最近邻参数K')
ylabel('两种算法分类正确率差值')
title('不同K值下的W-KNN算法与KNN算法识别正确率的差值');
save('wk_k_nn.mat','wk_k_nn');