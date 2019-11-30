function [sum,bpnnvote,Y]=bpnn(trainsample,testsample,class)
%���������
%trainsample��ѵ������,testsample�ǲ�������,class��ʾѵ�������������trainsample�����ݶ�Ӧ
%sum�����ֻ�����е�ʶ����
for i=1:140
    feature(:,i)= trainsample(:,i);
end
%����ֵ��һ��
%[input,minI,maxI] = premnmx( feature')  ;
[input,PS] = mapminmax(feature',-1,1);
minI=PS.xmin;
maxI=PS.xmax;

%�����������
s = length( class ) ;
output = zeros( s , 5  ) ;
for i = 1 : s 
   output( i , class( i )  ) = 1 ;
end

%����������
%����ǰ��������
%net = newff( minmax(input) , [10 5] , { 'logsig' 'purelin' } , 'traingdx' ) ;
net = newff( input,output' , [10] , { 'logsig' 'purelin' } , 'traingdx' ) ; 
net.divideFcn = '';


%����ѵ������
net.trainparam.show = 50 ;
net.trainparam.epochs = 150 ;
net.trainparam.goal = 1e-6 ;
net.trainParam.lr = 0.05 ;

%��ʼѵ��
net = train( net, input , output' ) ;

%��ȡ��������
for i=1:140
    featuretest(:,i)= testsample(:,i);
end
 c=testsample(:,141);
%�������ݹ�һ��
%testInput = tramnmx(featuretest' , minI, maxI ) ;
testInput = mapminmax('apply',featuretest',PS);

%����
Y = sim( net , testInput ) 

sum=[0 0 0 0 0]; %ÿ�������ȷʶ�����

%���ÿ�����������ķ������
bpnnvote=zeros(50,1);

%ͳ��ʶ����ȷ������ 
for i=1:10
    if Y(1,i)>Y(2,i)&&Y(1,i)>Y(3,i)&&Y(1,i)>Y(4,i)&&Y(1,i)>Y(5,i)
        sum(1)=sum(1)+1;
        bpnnvote(i)=1;
    end
end
for i=11:20
    if Y(2,i)>Y(1,i)&&Y(2,i)>Y(3,i)&&Y(2,i)>Y(4,i)&&Y(2,i)>Y(5,i)
         sum(2)=sum(2)+1;
         bpnnvote(i)=2;
    end
end
for i=21:30
    if Y(3,i)>Y(1,i)&&Y(3,i)>Y(2,i)&&Y(3,i)>Y(4,i)&&Y(3,i)>Y(5,i)
       sum(3)=sum(3)+1;
       bpnnvote(i)=3;
    end
end
for i=31:40
    if Y(4,i)>Y(1,i)&&Y(4,i)>Y(2,i)&&Y(4,i)>Y(3,i)&&Y(4,i)>Y(5,i)
       sum(4)=sum(4)+1;
       bpnnvote(i)=4;
    end
end
for i=41:50
    if Y(5,i)>Y(1,i)&&Y(5,i)>Y(2,i)&&Y(5,i)>Y(3,i)&&Y(5,i)>Y(4,i)
       sum(5)=sum(5)+1;
       bpnnvote(i)=5;
    end
end

for i=1:50
    [~,bpnnvote(i)]=max(Y(:,i));
end
sum=sum./10;