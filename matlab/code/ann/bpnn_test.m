load sum1;
load sum2;
load sum3;
load sum4;
load sum5;

sumbp=sum1+sum2+sum3+sum4+sum5;
sumbp=sumbp./5;

x=1:1:5;
plot(x,sumbp,'-*r'); %���ԣ���ɫ�����
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'����','����','����','����','����'});
n=1:5;
%��ͼ�ϼ�˵������
for i = 1:length(sumbp)
    text(n(i),sumbp(i)-0.03,num2str(sumbp(i)));
end
title('BPNN �㷨ʶ���� ');
xlabel('������')
ylabel('ʶ����')
save('sumbp.mat','sumbp');