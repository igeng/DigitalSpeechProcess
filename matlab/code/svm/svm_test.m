load rate1;
load rate2;
load rate3;
load rate4;
load rate5;

rate=rate1+rate2+rate3+rate4+rate5;
rate=rate./5;

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
save('rate.mat','rate');