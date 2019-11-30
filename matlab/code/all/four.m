load ratio
load wkratio
load rate
load sum

figure(1);
subplot(2,2,1);
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

subplot(2,2,2);
x=1:1:5;
plot(x,wkratio,'-*r'); %���ԣ���ɫ�����
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'����','����','����','����','����'});
n=1:5;
%��ͼ�ϼ�˵������
for i = 1:length(ratio)
    text(n(i),wkratio(i)-0.03,num2str(wkratio(i)));
end
title('W-KNN �㷨ʶ���� ');
xlabel('������')
ylabel('ʶ����')

subplot(2,2,3);
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

subplot(2,2,4);
x=1:1:5;
plot(x,sum,'-*r'); %���ԣ���ɫ�����
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'����','����','����','����','����'});
n=1:5;
%��ͼ�ϼ�˵������
for i = 1:length(sum)
    text(n(i),sum(i)-0.03,num2str(sum(i)));
end
title('BPNN �㷨ʶ���� ');
xlabel('������')
ylabel('ʶ����')

figure(2)
x=1:1:5;
%4*5
f=[ratio' wkratio' rate' sum'];
bar(f);
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'����','����','����','����','����'});
title('�����㷨�ֱ���������ʶ�����ȷ�� ');
xlabel('������')
ylabel('ʶ����')
legend('KNN','W-KNN','SVM','BPNN','Location','EastOutside'); 

