load rate1;
load rate2;
load rate3;
load rate4;
load rate5;

rate=rate1+rate2+rate3+rate4+rate5;
rate=rate./5;

x=1:1:5;
plot(x,rate,'-*r'); %���ԣ���ɫ�����
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'����','����','����','����','����'});
n=1:5;
%��ͼ�ϼ�˵������
for i = 1:length(rate)
    text(n(i),rate(i)-0.03,num2str(rate(i)));
end
title('SVM �㷨ʶ���� ');
xlabel('������')
ylabel('ʶ����')
save('rate.mat','rate');