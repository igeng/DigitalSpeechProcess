load recograte1;
load recograte2;
load recograte3;
load recograte4;
load recograte5;

recog=recograte1+recograte2+recograte3+recograte4+recograte5;
recog=recog/5;

x=1:1:5;
plot(x,recog,'-*r'); %���ԣ���ɫ�����
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'����','����','����','����','����'});
n=1:5;
%��ͼ�ϼ�˵������
for i = 1:length(recog)
    text(n(i),recog(i)-0.03,num2str(recog(i)));
end
title('ͶƱ�㷨ʶ���� ');
xlabel('������')
ylabel('ʶ����')
save('recog.mat','recog');
