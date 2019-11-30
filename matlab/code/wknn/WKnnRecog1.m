%载入各情感的特征向量矩阵
load A_fear.mat;
load F_happiness.mat;
load N_neutral.mat;
load T_sadness.mat;
load W_anger.mat;

NumberOfTrain=size(fearVec,2)*4/5; %五分之一测试用，五分之四训练用

trainVector=[angerVec(:,1:NumberOfTrain),hapVec(:,1:NumberOfTrain),neutralVec(:,1:NumberOfTrain),sadnessVec(:,1:NumberOfTrain),fearVec(:,1:NumberOfTrain)]; % 构建训练样本集
testVector=[angerVec(:,(NumberOfTrain+1):size(angerVec,2)),hapVec(:,(NumberOfTrain+1):size(hapVec,2)),neutralVec(:,(NumberOfTrain+1):size(neutralVec,2)),sadnessVec(:,(NumberOfTrain+1):size(sadnessVec,2)),fearVec(:,(NumberOfTrain+1):size(fearVec,2))]; % 构建测试样本集
wksumk1=zeros(50,5);%存放每一个k值对应的5种情感分类准确率
%data:140*200
data=trainVector;

%存放每个测试样本的分类类别
wknnvote=zeros(50,1);

%for k=1:50
k=20;
array=zeros(1,5);    %类别标签
array_d=zeros(1,5);    %类别平均距离
temp=zeros(1,200);    %保存计算具体类别中每个样本点的近邻样本点
temp_d=zeros(1,200);    %保存数组temp[1:n]中的样本与其最近邻样本点的平均距离
nh=zeros(1,40);
temp1=zeros(1,140);
totalTestNumber=size(fearVec,2)-NumberOfTrain;
emtionCounter=zeros(1,5);


 %类别样本 140*40
for label=1:5 %类别
    n=data(:,(label*40-39):label*40); %类别样本 140*40
    q=0;
for g=1:40 % n_1 各个类别样本数
    q=q+1;
    for j=1:140 % n_1_j 样本的第j维度
        for h=1:40 %该类别的其他所有样本点
            %找出在第j维特征上与样本n_1的第j维特征差值最小的样本n_11_j
            nh(h)=abs(n(j,g)-n(j,h));
            nh(g)=1;
        end
        [~,hh]=min(nh);
        temp(j)=hh;%对于一个样本，在140个维度上分别有140个其他样本差值最小
    end
    
    for j=1:140
        temp1(j)=norm(n(:,temp(j))-n(:,g));%计算欧氏距离
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

% 每一列表示某个测试语音与所有训练集样本的距离
distanceMatrix=zeros(size(trainVector,2),size(testVector,2)); 
% 计算每个测试样本和训练样本集各样本的距离
%distanceMatrix:200*50
for i=1:size(testVector,2)
    for j=1:size(trainVector,2)
        distanceMatrix(j,i)=norm(testVector(:,i)-trainVector(:,j)); %计算欧氏距离
    end
end

%all=[an fe ha ne sa];  %将欧距5个矩阵合并
all=distanceMatrix;

w=zeros(1,k);%找到与待分类样本欧氏距离最小的k个样本点
label=zeros(1,k);%找到w中对应样本点的类别标签
recog_ratio=zeros(1,k);%保存近邻样本的欧氏距离与样本类别平均距离差值之比
weight=zeros(1,5);%存放每个类别的权重

for recog_i=1:50

recogVec=all(:,recog_i);
w=zeros(1,k);%找到与待分类样本欧氏距离最小的k个样本点
label=zeros(1,k);%找到w中对应样本点的类别标签
recog_ratio=zeros(1,k);%保存近邻样本的欧氏距离与样本类别平均距离差值之比
weight=zeros(1,5);%存放每个类别的权重


%g=[A H];
d=numel(recogVec);%返回数组中的元素个数
c=lowtohigh(recogVec,d);%对f内的元素从小到大排
 num1=0;    %用来记录被判F类的次数
 num2=0;    %用来记录被判H类的次数
 num3=0;    %用来记录被判N类的次数
 num4=0;    %用来记录被判S类的次数
 num5=0;    %用来记录被判A类的次数
 for i=1:k
    for j=1:d
        if (c(i)==recogVec(j))
            if j<=numel(recogVec(1:40))     %如果选中的欧距出自F类
                num1=num1+1;
                label(i)=1;
            elseif j<=numel(recogVec(1:80)) %如果选中的欧距出自H类
                num2=num2+1;
                label(i)=2;
            elseif j<=numel(recogVec(1:120))%如果选中的欧距出自N类
                num3=num3+1;
                label(i)=3;
            elseif j<=numel(recogVec(1:160))%如果选中的欧距出自S类
                num4=num4+1;
                label(i)=4;
            elseif j<=numel(recogVec(1:200))%如果选中的欧距出自A类
                num5=num5+1;
                label(i)=5;
            end
            w(i)=j;%找到与待分类样本欧氏距离最小的k个样本点
        end
    end
 end
 
 %阈值
%threshold=0.2;
 
 for i=1:k
     %每个样本点N_i与待分类样本点的距离d_i和N_i的类别平均距离array_d的差值之比
    recog_ratio(i) = abs(recogVec(w(i))-array_d(label(i)))/array_d(label(i));
    %if  ratio < threshold
        weight(label(i))=weight(label(i))+1+5*recog_ratio(i);
    %end
 end
 
 [~,p]=max(weight);
 
%统计每个测试样本的分类结果

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
% %%求取最优k值
% wkratio1=emtionCounter./totalTestNumber;
% wksumk1(k,:)=wkratio1;
% end
% save('wksumk1.mat','wksumk1');
%% 显示结果
wkratio1=emtionCounter./totalTestNumber;
%bar(ratio);%绘制条形图
x=1:1:5;
plot(x,wkratio1,'-*r'); %线性，颜色，标记
%xlim([0,6])
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'生气','高兴','中性','悲伤','惊恐'});
n=1:5;
%给图上加说明文字
for i = 1:length(wkratio1)
    text(n(i),wkratio1(i)-0.03,num2str(wkratio1(i)));
end
title(strcat('WKNN 算法识别结果\_ ',strcat('K = ',num2str(k))));
xlabel('情感类别')
ylabel('识别率')
save('wkratio1.mat','wkratio1');

