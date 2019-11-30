%����SVM���������ʶ��
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
%ÿ����ʮ��������Ϊѵ������
%ÿ��ʮ��������Ϊ��������
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

%����SVM���ຯ��
[rate1,svmvote1]=svmclassfiction1(train,test);%����SVM���ຯ��

%��ͼ
figure(1)
%bar(rate,0.5);
x=1:1:5;
plot(x,rate1,'-*r'); %���ԣ���ɫ�����
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'����','����','����','����','����'});
n=1:5;
%��ͼ�ϼ�˵������
for i = 1:length(rate1)
    text(n(i),rate1(i)-0.03,num2str(rate1(i)));
end
title('SVM �㷨ʶ���� ');
xlabel('���ֻ���������')
ylabel('ʶ����')
save('rate1.mat','rate1');
save('svmvote1.mat','svmvote1');