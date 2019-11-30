function [rate,svmvote]=svmclassfiction1(samples,test)   %构造五种情感分类器
train1=samples(1:80,:);%用来构造生气-高兴分类模型训练样本
train2=[samples(1:40,:);samples(81:120,:)];%用来构造生气-中性分类模型训练样本
train3=[samples(1:40,:);samples(121:160,:)];%用来构造生气-悲伤分类模型训练样本
train4=[samples(1:40,:);samples(161:200,:)];%用来构造生气-害怕分类模型训练样本
train5=[samples(41:80,:);samples(81:120,:)];%用来构造高兴-中性分类模型训练样本
train6=[samples(41:80,:);samples(121:160,:)];%用来构造高兴-悲伤分类模型训练样本
train7=[samples(41:80,:);samples(161:200,:)];%用来构造高兴-害怕分类模型训练样本
train8=[samples(81:120,:);samples(121:160,:)];%用来构造中性-悲伤分类模型训练样本
train9=[samples(81:120,:);samples(161:200,:)];%用来构造中性-害怕分类模型训练样本
train10=[samples(121:160,:);samples(161:200,:)];%用来构造悲伤-害怕分类模型训练样本

for i=1:40                %正类样本标记
    trainlabel(i)=1;
end
for i=40:80               %负类样本标记
    trainlabel(i)=-1;
end
trainlabel=trainlabel';

%构造两类SVM分类模型
svmStruct1= fitcsvm(train1,trainlabel);    
svmStruct2= fitcsvm(train2,trainlabel);    
svmStruct3= fitcsvm(train3,trainlabel);   
svmStruct4= fitcsvm(train4,trainlabel);    
svmStruct5= fitcsvm(train5,trainlabel);    
svmStruct6= fitcsvm(train6,trainlabel);    
svmStruct7= fitcsvm(train7,trainlabel);   
svmStruct8= fitcsvm(train8,trainlabel);    
svmStruct9= fitcsvm(train9,trainlabel);    
svmStruct10= fitcsvm(train10,trainlabel);  
sumang=0; %生气情感正确识别个数
sumhap=0; %高兴情感正确识别个数
sumneu=0; %中性情感正确识别个数
sumsad=0; %悲伤情感正确识别个数
sumfea=0; %害怕情感正确识别个数

%存放每个测试样本的分类类别
svmvote=zeros(50,1);

for i=1:50
    for k=1:5
        votes(k)=0;   %多个SVM分类器将待测样本规定为某一类别个数
    end
    %for j=1:10
       %C(j) = ClassificationSVM(svmStruct(j),test(i,:));
    %end
    C(1) = predict(svmStruct1,test(i,:));
    C(2) = predict(svmStruct2,test(i,:));
    C(3) = predict(svmStruct3,test(i,:));
    C(4) = predict(svmStruct4,test(i,:));
    C(5) = predict(svmStruct5,test(i,:));
    C(6) = predict(svmStruct6,test(i,:));
    C(7) = predict(svmStruct7,test(i,:));
    C(8) = predict(svmStruct8,test(i,:));
    C(9) = predict(svmStruct9,test(i,:));
    C(10) = predict(svmStruct10,test(i,:));
    if(C(1)==1)    %第一个判决器结果
         votes(1)=votes(1)+1;  %生气情感获得票数
    elseif(C(1)==-1)
         votes(2)=votes(2)+1;  %高兴情感获得票数
    end
    if(C(2)==1)    %第二个判决器结果
         votes(1)=votes(1)+1;  %生气情感获得票数
    elseif(C(2)==-1)
         votes(3)=votes(3)+1;  %中性情感获得票数
    end
    if(C(3)==1)    %第三个判决器结果
         votes(1)=votes(1)+1;  %生气情感获得票数
    elseif(C(3)==-1)
         votes(4)=votes(4)+1;  %悲伤情感获得票数
    end
     if(C(4)==1)    %第四个判决器结果
         votes(1)=votes(1)+1;  %生气情感获得票数
    elseif(C(4)==-1)
         votes(5)=votes(5)+1;  %害怕情感获得票数
     end
     if(C(5)==1)    %第五个判决器结果
         votes(2)=votes(2)+1;  %高兴情感获得票数
    elseif(C(5)==-1)
         votes(3)=votes(3)+1;  %中性情感获得票数
     end
     if(C(6)==1)    %第六个判决器结果
         votes(2)=votes(2)+1;  %高兴情感获得票数
    elseif(C(6)==-1)
         votes(4)=votes(4)+1;  %悲伤情感获得票数
     end
     if(C(7)==1)    %第七个判决器结果
         votes(2)=votes(2)+1;  %高兴情感获得票数
    elseif(C(7)==-1)
         votes(5)=votes(5)+1;  %害怕情感获得票数
     end
     if(C(8)==1)    %第八个判决器结果
         votes(3)=votes(3)+1;  %中性情感获得票数
     elseif(C(8)==-1)
         votes(4)=votes(4)+1;  %悲伤情感获得票数
     end
     if(C(9)==1)    %第九个判决器结果
         votes(3)=votes(3)+1;  %中性情感获得票数
     elseif(C(9)==-1)
        votes(5)=votes(5)+1;  %害怕情感获得票数
     end
     if(C(10)==1)    %第十个判决器结果
         votes(4)=votes(4)+1;  %悲伤情感获得票数
     elseif(C(10)==-1)
         votes(5)=votes(5)+1;  %害怕情感获得票数
    end
   if(i>=1&&i<=10&&votes(1)>votes(2)&&votes(1)>votes(3)&&votes(1)>votes(4)&&votes(1)>votes(5))
       sumang=sumang+1;  %生气类样本正确识别个数
       %svmvote(i)=1;
   end
   if(i>=11&&i<=20&&votes(2)>votes(1)&&votes(2)>votes(3)&&votes(2)>votes(4)&&votes(2)>votes(5))
       sumhap=sumhap+1;  %高兴类样本正确识别个数
       %svmvote(i)=2;
   end
    if(i>=21&&i<=30&&votes(3)>votes(2)&&votes(3)>votes(1)&&votes(3)>votes(4)&&votes(3)>votes(5))
       sumneu=sumneu+1;  %中性类样本正确识别个数
       %svmvote(i)=3;
    end
    if(i>=31&&i<=40&&votes(4)>votes(1)&&votes(4)>votes(2)&&votes(4)>votes(3)&&votes(4)>votes(5))
       sumsad=sumsad+1;  %悲伤类样本正确识别个数
       %svmvote(i)=4;
    end
    if(i>=41&&i<=50&&votes(5)>votes(1)&&votes(5)>votes(3)&&votes(5)>votes(4)&&votes(5)>votes(2))
       sumfea=sumfea+1;  %害怕类样本正确识别个数
       %svmvote(i)=5;
    end
    
    if(votes(1)>=votes(2)&&votes(1)>=votes(3)&&votes(1)>=votes(4)&&votes(1)>=votes(5))
       svmvote(i)=1;  
    end
    if(votes(2)>=votes(1)&&votes(2)>=votes(3)&&votes(2)>=votes(4)&&votes(2)>=votes(5))
       svmvote(i)=2;
    end
    if(votes(3)>=votes(2)&&votes(3)>=votes(1)&&votes(3)>=votes(4)&&votes(3)>=votes(5))
       svmvote(i)=3;  
    end
    if(votes(4)>=votes(1)&&votes(4)>=votes(2)&&votes(4)>=votes(3)&&votes(4)>=votes(5))
       svmvote(i)=4;  
    end
    if(votes(5)>=votes(1)&&votes(5)>=votes(3)&&votes(5)>=votes(4)&&votes(5)>=votes(2))
       svmvote(i)=5;  
    end
 end
rate=[sumang/10,sumhap/10,sumneu/10,sumsad/10,sumfea/10];
rate