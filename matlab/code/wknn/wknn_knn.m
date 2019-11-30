load wkratio;
load ratio;


x=1:1:5;
plot(x,wkratio,'-*r',x,ratio,'-ob'); %线性，颜色，标记
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'惊恐','高兴','中性','悲伤','生气'});
n=1:5;
%给图上加说明文字
for i = 1:length(wkratio)
    text(n(i),wkratio(i)+0.05,num2str(wkratio(i)));
end
for i = 1:length(ratio)
    text(n(i),ratio(i)-0.05,num2str(ratio(i)));
end
title('WKKNN-KNN 算法识别结果 ');
xlabel('情感类别')
ylabel('识别率')
legend('wknn','knn','Location','SouthWest');   %右上角标注