load wkratio1;
load wkratio2;
load wkratio3;
load wkratio4;
load wkratio5;

wkratio=wkratio1+wkratio2+wkratio3+wkratio4+wkratio5;
wkratio=wkratio/5;

x=1:1:5;
plot(x,wkratio,'-*r'); %线性，颜色，标记
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'生气','高兴','中性','悲伤','惊恐'});
n=1:5;
%给图上加说明文字
for i = 1:length(wkratio)
    text(n(i),wkratio(i)-0.03,num2str(wkratio(i)));
end
title('W-KNN 算法识别结果 ');
xlabel('情感类别')
ylabel('识别率')
save('wkratio.mat','wkratio');