load ratio
load wkratio
load rate
load sum

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
ylabel('识别率')

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
ylabel('识别率')

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
ylabel('识别率')

subplot(2,2,4);
x=1:1:5;
plot(x,sum,'-*r'); %线性，颜色，标记
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'生气','高兴','中性','悲伤','惊恐'});
n=1:5;
%给图上加说明文字
for i = 1:length(sum)
    text(n(i),sum(i)-0.03,num2str(sum(i)));
end
title('BPNN 算法识别结果 ');
xlabel('情感类别')
ylabel('识别率')

figure(2)
x=1:1:5;
%4*5
f=[ratio' wkratio' rate' sum'];
bar(f);
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'生气','高兴','中性','悲伤','惊恐'});
title('四种算法分别对五种情感识别的正确率 ');
xlabel('情感类别')
ylabel('识别率')
legend('KNN','W-KNN','SVM','BPNN','Location','EastOutside'); 

