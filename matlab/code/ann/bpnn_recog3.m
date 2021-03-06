%基于神经网络的语音情感识别
clc 
close all
clear all
load A_fear fearVec;
load F_happiness hapVec;
load N_neutral neutralVec;
load T_sadness sadnessVec;
load W_anger angerVec;

%5折验证
fearVec(:,[11:20 41:50]) = fearVec(:,[41:50 11:20]);
hapVec(:,[11:20 41:50]) = hapVec(:,[41:50 11:20]);
neutralVec(:,[11:20 41:50]) = neutralVec(:,[41:50 11:20]);
sadnessVec(:,[11:20 41:50]) = sadnessVec(:,[41:50 11:20]);
angerVec(:,[11:20 41:50]) = angerVec(:,[41:50 11:20]);

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
[sum3,bpnnvote3]=bpnn(trainsample,testsample,class);

figure(1)
x=1:1:5;
plot(x,sum3,'-*r'); %线性，颜色，标记
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'生气','高兴','中性','悲伤','惊恐'});
n=1:5;
%给图上加说明文字
for i = 1:length(sum3)
    text(n(i),sum3(i)-0.03,num2str(sum3(i)));
end
title('BPNN 算法识别结果 ');
xlabel('情感类别')
ylabel('识别率')
save('sum3.mat','sum3');
save('bpnnvote3.mat','bpnnvote3');