load wkratio1;
load wkratio2;
load wkratio3;
load wkratio4;
load wkratio5;

wkratio=wkratio1+wkratio2+wkratio3+wkratio4+wkratio5;
wkratio=wkratio/5;

x=1:1:5;
plot(x,wkratio,'-*r'); %���ԣ���ɫ�����
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'����','����','����','����','����'});
n=1:5;
%��ͼ�ϼ�˵������
for i = 1:length(wkratio)
    text(n(i),wkratio(i)-0.03,num2str(wkratio(i)));
end
title('W-KNN �㷨ʶ���� ');
xlabel('������')
ylabel('ʶ����')
save('wkratio.mat','wkratio');