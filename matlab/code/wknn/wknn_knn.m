load wkratio;
load ratio;


x=1:1:5;
plot(x,wkratio,'-*r',x,ratio,'-ob'); %���ԣ���ɫ�����
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'����','����','����','����','����'});
n=1:5;
%��ͼ�ϼ�˵������
for i = 1:length(wkratio)
    text(n(i),wkratio(i)+0.05,num2str(wkratio(i)));
end
for i = 1:length(ratio)
    text(n(i),ratio(i)-0.05,num2str(ratio(i)));
end
title('WKKNN-KNN �㷨ʶ���� ');
xlabel('������')
ylabel('ʶ����')
legend('wknn','knn','Location','SouthWest');   %���ϽǱ�ע