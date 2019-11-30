%������������������ʶ��
clc 
close all
clear all
load A_fear fearVec;
load F_happiness hapVec;
load N_neutral neutralVec;
load T_sadness sadnessVec;
load W_anger angerVec;

%5����֤
fearVec(:,[21:30 41:50]) = fearVec(:,[41:50 21:30]);
hapVec(:,[21:30 41:50]) = hapVec(:,[41:50 21:30]);
neutralVec(:,[21:30 41:50]) = neutralVec(:,[41:50 21:30]);
sadnessVec(:,[21:30 41:50]) = sadnessVec(:,[41:50 21:30]);
angerVec(:,[21:30 41:50]) = angerVec(:,[41:50 21:30]);

trainsample(1:40,1:140)=angerVec(:,1:40)';
trainsample(41:80,1:140)=hapVec(:,1:40)';
trainsample(81:120,1:140)=neutralVec(:,1:40)';
trainsample(121:160,1:140)=sadnessVec(:,1:40)';
trainsample(161:200,1:140)=fearVec(:,1:40)';
trainsample(1:40,141)=1;
trainsample(41:80,141)=2;
trainsample(81:120,141)=3;
trainsample(121:160,141)=4; 
trainsample(161:200,141)=5;
testsample(1:10,1:140)=angerVec(:,41:50)';
testsample(11:20,1:140)=hapVec(:,41:50)';
testsample(21:30,1:140)=neutralVec(:,41:50)';
testsample(31:40,1:140)=sadnessVec(:,41:50)';
testsample(41:50,1:140)=fearVec(:,41:50)';
testsample(1:10,141)=1;
testsample(11:20,141)=2;
testsample(21:30,141)=3;
testsample(31:40,141)=4; 
testsample(41:50,141)=5;
class=trainsample(:,141);

[sum4,bpnnvote4]=bpnn(trainsample,testsample,class);

figure(1)
x=1:1:5;
plot(x,sum4,'-*r'); %���ԣ���ɫ�����
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'����','����','����','����','����'});
n=1:5;
%��ͼ�ϼ�˵������
for i = 1:length(sum4)
    text(n(i),sum4(i)-0.03,num2str(sum4(i)));
end
title('BPNN �㷨ʶ���� ');
xlabel('������')
ylabel('ʶ����')
save('sum4.mat','sum4');
save('bpnnvote4.mat','bpnnvote4');