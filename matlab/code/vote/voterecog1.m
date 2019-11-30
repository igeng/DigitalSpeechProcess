%knn
load knnvote1;
load ratio1;

%wknn
load wknnvote1;
load wkratio1;

%bpnn
load bpnnvote1;
load sum1;

%svm
load svmvote1;
load rate1;

testvote1=[wknnvote1 bpnnvote1 svmvote1];
testrat1=[wkratio1; sum1; rate1];

for i=1:5
    [~,index1(i)]=max(testrat1(:,i));
end

recogvote=zeros(50,1);

for i=1:50
    if(testvote1(i,1)==testvote1(i,2))
        recogvote(i)=testvote1(i,1);
    end
    
    if(testvote1(i,1)==testvote1(i,3))
        recogvote(i)=testvote1(i,1);
    end
    
    if(testvote1(i,2)==testvote1(i,3))
        recogvote(i)=testvote1(i,2);
    end
    
    if((testvote1(i,1)~=testvote1(i,2))&&(testvote1(i,1)~=testvote1(i,3))&&(testvote1(i,2)~=testvote1(i,3)))
        [~,index1]=max([wkratio1(testvote1(i,1)) sum1(testvote1(i,2)) rate1(testvote1(i,3))]);
        recogvote(i)=testvote1(i,index1);
%         if(i>=1&&i<=10)
%             recogvote(i)=testvote1(i,index1(1));
%         end
%         
%         if(i>=11&&i<=20)
%             recogvote(i)=testvote1(i,index1(2));
%         end
%         
%         if(i>=21&&i<=30)
%             recogvote(i)=testvote1(i,index1(3));
%         end
%         
%         if(i>=31&&i<=40)
%             recogvote(i)=testvote1(i,index1(4));
%         end
%         
%         if(i>=41&&i<=50)
%             recogvote(i)=testvote1(i,index1(5));
%         end
     end
    
end

recogsum=[0 0 0 0 0];
for i=1:50
    if(i>=1&&i<=10&&recogvote(i)==1)
        recogsum(1)=recogsum(1)+1;
    end
    
    if(i>=11&&i<=20&&recogvote(i)==2)
        recogsum(2)=recogsum(2)+1;
    end
    
    if(i>=21&&i<=30&&recogvote(i)==3)
        recogsum(3)=recogsum(3)+1;
    end
    
    if(i>=31&&i<=40&&recogvote(i)==4)
        recogsum(4)=recogsum(4)+1;
    end
    
    if(i>=41&&i<=50&&recogvote(i)==5)
        recogsum(5)=recogsum(5)+1;
    end
end

recograte1=recogsum./10;

figure(1);
x=1:1:5;
plot(x,recograte1,'-*k');
ylim([0,1]);
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'生气','高兴','中性','悲伤','惊恐'});
n=1:5;
%给图上加说明文字
for i = 1:length(recograte1)
    text(n(i),recograte1(i)-0.03,num2str(recograte1(i)));
end
title('投票1分类结果');
xlabel('情感类别')
ylabel('识别率')
save('recograte1.mat','recograte1')



