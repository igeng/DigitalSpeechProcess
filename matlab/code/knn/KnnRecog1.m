%% knn�������������òɼ�����������ź��������ݽ��з���ʶ��
clc
clear all;
close all;

%% �������е�������������
load W_anger.mat;
load F_happiness.mat;
load N_neutral.mat;
load T_sadness.mat;
load A_fear.mat;
NumberOfTrain=size(fearVec,2)*4/5; %���֮һ�����ã����֮��ѵ����
trainVector=[angerVec(:,1:NumberOfTrain),hapVec(:,1:NumberOfTrain),neutralVec(:,1:NumberOfTrain),sadnessVec(:,1:NumberOfTrain),fearVec(:,1:NumberOfTrain)]; % ����ѵ��������
testVector=[angerVec(:,(NumberOfTrain+1):size(angerVec,2)),hapVec(:,(NumberOfTrain+1):size(hapVec,2)),neutralVec(:,(NumberOfTrain+1):size(neutralVec,2)),sadnessVec(:,(NumberOfTrain+1):size(sadnessVec,2)),fearVec(:,(NumberOfTrain+1):size(fearVec,2))]; % ��������������
sumk1=zeros(50,5);%���ÿһ��kֵ��Ӧ��5����з���׼ȷ��
knnvote=zeros(50,1);%���ÿ�����������ķ������

%for k=1:50
k=20; %k �����
distanceMatrix=zeros(size(trainVector,2),size(testVector,2)); % ÿһ�б�ʾĳ����������������ѵ���������ľ���
%% ����ÿ������������ѵ���������������ľ���
for i=1:size(testVector,2)
    for j=1:size(trainVector,2)
        distanceMatrix(j,i)=norm(testVector(:,i)-trainVector(:,j)); %����ŷ�Ͼ���
    end
end
%% ͳ�Ʒ����� ��������Ӧ����������������trainVector��testVector��������λ����������ͣ�
totalTestNumber=size(fearVec,2)-NumberOfTrain;
emtionCounter=zeros(1,5);
n1=NumberOfTrain;
n2=n1+NumberOfTrain;
n3=n2+NumberOfTrain;
n4=n3+NumberOfTrain;
n5=n4+NumberOfTrain;
p1=size(fearVec,2)-NumberOfTrain;
p2=p1+size(hapVec,2)-NumberOfTrain;
p3=p2+size(neutralVec,2)-NumberOfTrain;
p4=p3+size(sadnessVec,2)-NumberOfTrain;
p5=p4+size(angerVec,2)-NumberOfTrain;
if(n5~=size(trainVector,2)||p5~=size(testVector,2))
    disp('data error')
    return;
end

for i=1:size(distanceMatrix,2)
    flag=zeros(1,5);
    [sortVec,index]=sort(distanceMatrix(:,i));
    % ͳ��K�������и���������
    for j=1:k
        if(n1>=index(j)&&index(j)>=1)
            flag(1)=flag(1)+1;
        elseif(n2>=index(j)&&index(j)>n1)
            flag(2)=flag(2)+1;
        elseif(n3>=index(j)&&index(j)>n2)
            flag(3)=flag(3)+1;
        elseif(n4>=index(j)&&index(j)>n3)
            flag(4)=flag(4)+1;
        else
            flag(5)=flag(5)+1;
        end
    end
    
    [~,index1]=sort(flag);
    
    % ���K��������������������������ʵ�ʵ����һ�£�����Ϊ�㷨ʶ����ȷ����Ӧcounter��һ��
    % ͳ��ÿ�����������ķ�����
    if((p1>=i&&i>=1)&&index1(5)==1)
        emtionCounter(index1(5))=emtionCounter(index1(5))+1;
        knnvote(i)=1;
    elseif((p2>=i&&i>p1)&&index1(5)==2)
        emtionCounter(index1(5))=emtionCounter(index1(5))+1;
        knnvote(i)=2;
    elseif((p3>=i&&i>p2)&&index1(5)==3)
        emtionCounter(index1(5))=emtionCounter(index1(5))+1;
        knnvote(i)=3;
    elseif((p4>=i&&i>p3)&&index1(5)==4)
        emtionCounter(index1(5))=emtionCounter(index1(5))+1;
        knnvote(i)=4;
    elseif((p5>=i&&i>p4)&&index1(5)==5)
        emtionCounter(index1(5))=emtionCounter(index1(5))+1;
        knnvote(i)=5;
    end
    
    %����ÿ��������ʶ����
    knnvote(i)=index1(5);
end

knnvote1=knnvote;
save('knnvote1.mat','knnvote1')
%%��ȡ����kֵ
%ratio=emtionCounter./totalTestNumber;
%sumk1(k,:)=ratio;
%end
%save('sumk1.mat','sumk1');
%% ��ʾ���
ratio1=emtionCounter./totalTestNumber;
x=1:1:5;
plot(x,ratio1,'-*r'); %���ԣ���ɫ�����
%xlim([0,6])
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'����','����','����','����','����'});
n=1:5;
%��ͼ�ϼ�˵������
for i = 1:length(ratio1)
    text(n(i),ratio1(i)-0.03,num2str(ratio1(i)));
end
title(strcat('KNN �㷨ʶ����\_ ',strcat('K = ',num2str(k))));
xlabel('������')
ylabel('ʶ����')
save('ratio1.mat','ratio1');