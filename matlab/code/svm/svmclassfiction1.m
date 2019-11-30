function [rate,svmvote]=svmclassfiction1(samples,test)   %����������з�����
train1=samples(1:80,:);%������������-���˷���ģ��ѵ������
train2=[samples(1:40,:);samples(81:120,:)];%������������-���Է���ģ��ѵ������
train3=[samples(1:40,:);samples(121:160,:)];%������������-���˷���ģ��ѵ������
train4=[samples(1:40,:);samples(161:200,:)];%������������-���·���ģ��ѵ������
train5=[samples(41:80,:);samples(81:120,:)];%�����������-���Է���ģ��ѵ������
train6=[samples(41:80,:);samples(121:160,:)];%�����������-���˷���ģ��ѵ������
train7=[samples(41:80,:);samples(161:200,:)];%�����������-���·���ģ��ѵ������
train8=[samples(81:120,:);samples(121:160,:)];%������������-���˷���ģ��ѵ������
train9=[samples(81:120,:);samples(161:200,:)];%������������-���·���ģ��ѵ������
train10=[samples(121:160,:);samples(161:200,:)];%�������챯��-���·���ģ��ѵ������

for i=1:40                %�����������
    trainlabel(i)=1;
end
for i=40:80               %�����������
    trainlabel(i)=-1;
end
trainlabel=trainlabel';

%��������SVM����ģ��
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
sumang=0; %���������ȷʶ�����
sumhap=0; %���������ȷʶ�����
sumneu=0; %���������ȷʶ�����
sumsad=0; %���������ȷʶ�����
sumfea=0; %���������ȷʶ�����

%���ÿ�����������ķ������
svmvote=zeros(50,1);

for i=1:50
    for k=1:5
        votes(k)=0;   %���SVM�����������������涨Ϊĳһ������
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
    if(C(1)==1)    %��һ���о������
         votes(1)=votes(1)+1;  %������л��Ʊ��
    elseif(C(1)==-1)
         votes(2)=votes(2)+1;  %������л��Ʊ��
    end
    if(C(2)==1)    %�ڶ����о������
         votes(1)=votes(1)+1;  %������л��Ʊ��
    elseif(C(2)==-1)
         votes(3)=votes(3)+1;  %������л��Ʊ��
    end
    if(C(3)==1)    %�������о������
         votes(1)=votes(1)+1;  %������л��Ʊ��
    elseif(C(3)==-1)
         votes(4)=votes(4)+1;  %������л��Ʊ��
    end
     if(C(4)==1)    %���ĸ��о������
         votes(1)=votes(1)+1;  %������л��Ʊ��
    elseif(C(4)==-1)
         votes(5)=votes(5)+1;  %������л��Ʊ��
     end
     if(C(5)==1)    %������о������
         votes(2)=votes(2)+1;  %������л��Ʊ��
    elseif(C(5)==-1)
         votes(3)=votes(3)+1;  %������л��Ʊ��
     end
     if(C(6)==1)    %�������о������
         votes(2)=votes(2)+1;  %������л��Ʊ��
    elseif(C(6)==-1)
         votes(4)=votes(4)+1;  %������л��Ʊ��
     end
     if(C(7)==1)    %���߸��о������
         votes(2)=votes(2)+1;  %������л��Ʊ��
    elseif(C(7)==-1)
         votes(5)=votes(5)+1;  %������л��Ʊ��
     end
     if(C(8)==1)    %�ڰ˸��о������
         votes(3)=votes(3)+1;  %������л��Ʊ��
     elseif(C(8)==-1)
         votes(4)=votes(4)+1;  %������л��Ʊ��
     end
     if(C(9)==1)    %�ھŸ��о������
         votes(3)=votes(3)+1;  %������л��Ʊ��
     elseif(C(9)==-1)
        votes(5)=votes(5)+1;  %������л��Ʊ��
     end
     if(C(10)==1)    %��ʮ���о������
         votes(4)=votes(4)+1;  %������л��Ʊ��
     elseif(C(10)==-1)
         votes(5)=votes(5)+1;  %������л��Ʊ��
    end
   if(i>=1&&i<=10&&votes(1)>votes(2)&&votes(1)>votes(3)&&votes(1)>votes(4)&&votes(1)>votes(5))
       sumang=sumang+1;  %������������ȷʶ�����
       %svmvote(i)=1;
   end
   if(i>=11&&i<=20&&votes(2)>votes(1)&&votes(2)>votes(3)&&votes(2)>votes(4)&&votes(2)>votes(5))
       sumhap=sumhap+1;  %������������ȷʶ�����
       %svmvote(i)=2;
   end
    if(i>=21&&i<=30&&votes(3)>votes(2)&&votes(3)>votes(1)&&votes(3)>votes(4)&&votes(3)>votes(5))
       sumneu=sumneu+1;  %������������ȷʶ�����
       %svmvote(i)=3;
    end
    if(i>=31&&i<=40&&votes(4)>votes(1)&&votes(4)>votes(2)&&votes(4)>votes(3)&&votes(4)>votes(5))
       sumsad=sumsad+1;  %������������ȷʶ�����
       %svmvote(i)=4;
    end
    if(i>=41&&i<=50&&votes(5)>votes(1)&&votes(5)>votes(3)&&votes(5)>votes(4)&&votes(5)>votes(2))
       sumfea=sumfea+1;  %������������ȷʶ�����
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