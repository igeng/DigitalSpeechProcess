%基于SVM的语音情感识别
clc;
clear;
load A_fear fearVec;
load F_happiness hapVec;
load N_neutral neutralVec;
load T_sadness sadnessVec;
load W_anger angerVec;
sampleang=angerVec';
samplehap=hapVec';
sampleneu=neutralVec';
samplesad=sadnessVec';
samplefear=fearVec';
%每类四十个样本作为训练样本
%每类十个样本作为测试样本
%anger
train(1:40,:)=sampleang(1:40,:); 
test(1:10,:)=sampleang(41:50,:);
%happy
train(41:80,:)=samplehap(1:40,:);
test(11:20,:)=samplehap(41:50,:);
%neutral
train(81:120,:)=sampleneu(1:40,:);
test(21:30,:)=sampleneu(41:50,:);
%sadness
train(121:160,:)=samplesad(1:40,:);
test(31:40,:)=samplesad(41:50,:);
%fear
train(161:200,:)=samplefear(1:40,:);
test(41:50,:)=samplefear(41:50,:);

svmvote1=zeros(50,1);

%调用SVM分类函数
[rate1,svmvote1]=svmclassfiction1(train,test);%调用SVM分类函数

%绘图
figure(1)
%bar(rate,0.5);
x=1:1:5;
plot(x,rate1,'-*r'); %线性，颜色，标记
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'生气','高兴','中性','悲伤','惊恐'});
n=1:5;
%给图上加说明文字
for i = 1:length(rate1)
    text(n(i),rate1(i)-0.03,num2str(rate1(i)));
end
title('SVM 算法识别结果 ');
xlabel('五种基本情感类别')
ylabel('识别率')
save('rate1.mat','rate1');
save('svmvote1.mat','svmvote1');