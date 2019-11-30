function [sum,bpnnvote,Y]=bpnn(trainsample,testsample,class)
%输入参数：
%trainsample是训练样本,testsample是测试样本,class表示训练样本的类别，与trainsample中数据对应
%sum：五种基本情感的识别率
for i=1:140
    feature(:,i)= trainsample(:,i);
end
%特征值归一化
%[input,minI,maxI] = premnmx( feature')  ;
[input,PS] = mapminmax(feature',-1,1);
minI=PS.xmin;
maxI=PS.xmax;

%构造输出矩阵
s = length( class ) ;
output = zeros( s , 5  ) ;
for i = 1 : s 
   output( i , class( i )  ) = 1 ;
end

%创建神经网络
%创建前馈神经网络
%net = newff( minmax(input) , [10 5] , { 'logsig' 'purelin' } , 'traingdx' ) ;
net = newff( input,output' , [10] , { 'logsig' 'purelin' } , 'traingdx' ) ; 
net.divideFcn = '';


%设置训练参数
net.trainparam.show = 50 ;
net.trainparam.epochs = 150 ;
net.trainparam.goal = 1e-6 ;
net.trainParam.lr = 0.05 ;

%开始训练
net = train( net, input , output' ) ;

%读取测试数据
for i=1:140
    featuretest(:,i)= testsample(:,i);
end
 c=testsample(:,141);
%测试数据归一化
%testInput = tramnmx(featuretest' , minI, maxI ) ;
testInput = mapminmax('apply',featuretest',PS);

%仿真
Y = sim( net , testInput ) 

sum=[0 0 0 0 0]; %每类情感正确识别个数

%存放每个测试样本的分类类别
bpnnvote=zeros(50,1);

%统计识别正确样本数 
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