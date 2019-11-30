%�������е�������������
load A_fear.mat;
load F_happiness.mat;
load N_neutral.mat;
load T_sadness.mat;
load W_anger.mat;

NumberOfTrain=size(fearVec,2)*4/5; %���֮һ�����ã����֮��ѵ����

trainVector=[angerVec(:,1:NumberOfTrain),hapVec(:,1:NumberOfTrain),neutralVec(:,1:NumberOfTrain),sadnessVec(:,1:NumberOfTrain),fearVec(:,1:NumberOfTrain)]; % ����ѵ��������
testVector=[angerVec(:,(NumberOfTrain+1):size(angerVec,2)),hapVec(:,(NumberOfTrain+1):size(hapVec,2)),neutralVec(:,(NumberOfTrain+1):size(neutralVec,2)),sadnessVec(:,(NumberOfTrain+1):size(sadnessVec,2)),fearVec(:,(NumberOfTrain+1):size(fearVec,2))]; % ��������������
wksumk1=zeros(50,5);%���ÿһ��kֵ��Ӧ��5����з���׼ȷ��
%data:140*200
data=trainVector;

%���ÿ�����������ķ������
wknnvote=zeros(50,1);

%for k=1:50
k=20;
array=zeros(1,5);    %����ǩ
array_d=zeros(1,5);    %���ƽ������
temp=zeros(1,200);    %���������������ÿ��������Ľ���������
temp_d=zeros(1,200);    %��������temp[1:n]�е���������������������ƽ������
nh=zeros(1,40);
temp1=zeros(1,140);
totalTestNumber=size(fearVec,2)-NumberOfTrain;
emtionCounter=zeros(1,5);


 %������� 140*40
for label=1:5 %���
    n=data(:,(label*40-39):label*40); %������� 140*40
    q=0;
for g=1:40 % n_1 �������������
    q=q+1;
    for j=1:140 % n_1_j �����ĵ�jά��
        for h=1:40 %��������������������
            %�ҳ��ڵ�jά������������n_1�ĵ�jά������ֵ��С������n_11_j
            nh(h)=abs(n(j,g)-n(j,h));
            nh(g)=1;
        end
        [~,hh]=min(nh);
        temp(j)=hh;%����һ����������140��ά���Ϸֱ���140������������ֵ��С
    end
    
    for j=1:140
        temp1(j)=norm(n(:,temp(j))-n(:,g));%����ŷ�Ͼ���
        %temp1(j)=sqrt(sum((n(:,temp(j))-n(:,g)).^2));
    end
    temp1=unique(temp1);
    [~,gg]=max(temp1);
    temp1(gg)=[];
    temp_d(q)=mean(temp1);
    %q=q+1;
end    
    array_d(label)=mean(temp_d(1:q));
    array(label)=label;
end

% ÿһ�б�ʾĳ����������������ѵ���������ľ���
distanceMatrix=zeros(size(trainVector,2),size(testVector,2)); 
% ����ÿ������������ѵ���������������ľ���
%distanceMatrix:200*50
for i=1:size(testVector,2)
    for j=1:size(trainVector,2)
        distanceMatrix(j,i)=norm(testVector(:,i)-trainVector(:,j)); %����ŷ�Ͼ���
    end
end

%all=[an fe ha ne sa];  %��ŷ��5������ϲ�
all=distanceMatrix;

w=zeros(1,k);%�ҵ������������ŷ�Ͼ�����С��k��������
label=zeros(1,k);%�ҵ�w�ж�Ӧ�����������ǩ
recog_ratio=zeros(1,k);%�������������ŷ�Ͼ������������ƽ�������ֵ֮��
weight=zeros(1,5);%���ÿ������Ȩ��

for recog_i=1:50

recogVec=all(:,recog_i);
w=zeros(1,k);%�ҵ������������ŷ�Ͼ�����С��k��������
label=zeros(1,k);%�ҵ�w�ж�Ӧ�����������ǩ
recog_ratio=zeros(1,k);%�������������ŷ�Ͼ������������ƽ�������ֵ֮��
weight=zeros(1,5);%���ÿ������Ȩ��


%g=[A H];
d=numel(recogVec);%���������е�Ԫ�ظ���
c=lowtohigh(recogVec,d);%��f�ڵ�Ԫ�ش�С������
 num1=0;    %������¼����F��Ĵ���
 num2=0;    %������¼����H��Ĵ���
 num3=0;    %������¼����N��Ĵ���
 num4=0;    %������¼����S��Ĵ���
 num5=0;    %������¼����A��Ĵ���
 for i=1:k
    for j=1:d
        if (c(i)==recogVec(j))
            if j<=numel(recogVec(1:40))     %���ѡ�е�ŷ�����F��
                num1=num1+1;
                label(i)=1;
            elseif j<=numel(recogVec(1:80)) %���ѡ�е�ŷ�����H��
                num2=num2+1;
                label(i)=2;
            elseif j<=numel(recogVec(1:120))%���ѡ�е�ŷ�����N��
                num3=num3+1;
                label(i)=3;
            elseif j<=numel(recogVec(1:160))%���ѡ�е�ŷ�����S��
                num4=num4+1;
                label(i)=4;
            elseif j<=numel(recogVec(1:200))%���ѡ�е�ŷ�����A��
                num5=num5+1;
                label(i)=5;
            end
            w(i)=j;%�ҵ������������ŷ�Ͼ�����С��k��������
        end
    end
 end
 
 %��ֵ
%threshold=0.2;
 
 for i=1:k
     %ÿ��������N_i�������������ľ���d_i��N_i�����ƽ������array_d�Ĳ�ֵ֮��
    recog_ratio(i) = abs(recogVec(w(i))-array_d(label(i)))/array_d(label(i));
    %if  ratio < threshold
        weight(label(i))=weight(label(i))+1+5*recog_ratio(i);
    %end
 end
 
 [~,p]=max(weight);
 
%ͳ��ÿ�����������ķ�����

 if((recog_i>=1&&recog_i<=10)&&p==1)
     emtionCounter(1)=emtionCounter(1)+1;
     wknnvote(recog_i)=1;
 elseif((recog_i>=11&&recog_i<=20)&&p==2)
     emtionCounter(2)=emtionCounter(2)+1;
     wknnvote(recog_i)=2;
 elseif((recog_i>=21&&recog_i<=30)&&p==3)
     emtionCounter(3)=emtionCounter(3)+1;
     wknnvote(recog_i)=3;
 elseif((recog_i>=31&&recog_i<=40)&&p==4)
     emtionCounter(4)=emtionCounter(4)+1;
     wknnvote(recog_i)=4;
 elseif((recog_i>=41&&recog_i<=50)&&p==5)
     emtionCounter(5)=emtionCounter(5)+1;
     wknnvote(recog_i)=5;
 end
end

wknnvote1=wknnvote;
save('wknnvote1.mat','wknnvote1')
% %%��ȡ����kֵ
% wkratio1=emtionCounter./totalTestNumber;
% wksumk1(k,:)=wkratio1;
% end
% save('wksumk1.mat','wksumk1');
%% ��ʾ���
wkratio1=emtionCounter./totalTestNumber;
%bar(ratio);%��������ͼ
x=1:1:5;
plot(x,wkratio1,'-*r'); %���ԣ���ɫ�����
%xlim([0,6])
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'����','����','����','����','����'});
n=1:5;
%��ͼ�ϼ�˵������
for i = 1:length(wkratio1)
    text(n(i),wkratio1(i)-0.03,num2str(wkratio1(i)));
end
title(strcat('WKNN �㷨ʶ����\_ ',strcat('K = ',num2str(k))));
xlabel('������')
ylabel('ʶ����')
save('wkratio1.mat','wkratio1');

