load ratio1;
load ratio2;
load ratio3;
load ratio4;
load ratio5;

ratio=ratio1+ratio2+ratio3+ratio4+ratio5;
ratio=ratio/5;

x=1:1:5;
plot(x,ratio,'-*r'); %���ԣ���ɫ�����
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'����','����','����','����','����'});
n=1:5;
%��ͼ�ϼ�˵������
for i = 1:length(ratio)
    text(n(i),ratio(i)-0.03,num2str(ratio(i)));
end
title('KNN �㷨ʶ���� ');
xlabel('������')
ylabel('ʶ����')
save('ratio.mat','ratio');