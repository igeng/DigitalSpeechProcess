load ratio
load wkratio
load rate
load sumbp
load recog


figure(1);
subplot(2,2,1);
x=1:1:5;
plot(x,ratio,'-*r'); %线性，颜色，标记
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'生气','高兴','中性','悲伤','惊恐'});
n=1:5;
%给图上加说明文字
for i = 1:length(ratio)
    text(n(i),ratio(i)-0.03,num2str(ratio(i)));
end
title('KNN 算法识别结果 ');
xlabel('情感类别')
ylabel('识别正确率')

subplot(2,2,2);
x=1:1:5;
plot(x,wkratio,'-*r'); %线性，颜色，标记
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'生气','高兴','中性','悲伤','惊恐'});
n=1:5;
%给图上加说明文字
for i = 1:length(ratio)
    text(n(i),wkratio(i)-0.03,num2str(wkratio(i)));
end
title('W-KNN 算法识别结果 ');
xlabel('情感类别')
ylabel('识别正确率')

subplot(2,2,3);
x=1:1:5;
plot(x,rate,'-*r'); %线性，颜色，标记
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'生气','高兴','中性','悲伤','惊恐'});
n=1:5;
%给图上加说明文字
for i = 1:length(rate)
    text(n(i),rate(i)-0.03,num2str(rate(i)));
end
title('SVM 算法识别结果 ');
xlabel('情感类别')
ylabel('识别正确率')

subplot(2,2,4);
x=1:1:5;
plot(x,sumbp,'-*r'); %线性，颜色，标记
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'生气','高兴','中性','悲伤','惊恐'});
n=1:5;
%给图上加说明文字
for i = 1:length(sumbp)
    text(n(i),sumbp(i)-0.03,num2str(sumbp(i)));
end
title('BPNN 算法识别结果 ');
xlabel('情感类别')
ylabel('识别正确率')

figure(2)
x=1:1:5;
%4*5
f=[ratio' wkratio' rate' sumbp' recog'];
bar(f);
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'生气','高兴','中性','悲伤','惊恐'});
% title('5种算法分别对5种情感识别的正确率 ');
xlabel('语音情感类别')
ylabel('识别正确率')
legend('KNN','W-KNN','SVM','BPNN','投票','Location','SouthEast'); 

% figure(3)
five_sum=zeros(1,5);
five_sum(1)=sum(ratio);
five_sum(2)=sum(wkratio);
five_sum(3)=sum(rate);
five_sum(4)=sum(sumbp);
five_sum(5)=sum(recog);

figure(3)
five_sum=five_sum./5;
x=1:1:5;
plot(x,five_sum,'-*r'); %线性，颜色，标记
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'KNN','W-KNN','SVM','BPNN','投票'});
n=1:5;
%给图上加说明文字
for i = 1:length(five_sum)
    text(n(i),five_sum(i)-0.03,num2str(five_sum(i)));
end
% title('5种算法整体情感识别结果 ');
xlabel('5种情感识别算法')
ylabel('整体识别正确率')

figure(4)
x=1:1:5;
plot(x,ratio,'--ok',x,wkratio,'-*r',x,rate,'-.+m',x,sumbp,'--sk',x,recog,'-db');
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'生气','高兴','中性','悲伤','惊恐'});
% title('5种算法分别对5种情感识别的正确率 ');
xlabel('语音情感类别')
ylabel('识别正确率')
legend('KNN','W-KNN','SVM','BPNN','投票','Location','SouthEast'); 