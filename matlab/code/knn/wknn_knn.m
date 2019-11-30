load wkratio;
load ratio;


x=1:1:5;
plot(x,wkratio,'-*r',x,ratio,'-ob'); %线性，颜色，标记
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'生气','高兴','中性','悲伤','惊恐'});
n=1:5;
%给图上加说明文字
for i = 1:length(wkratio)
    text(n(i),wkratio(i)+0.05,num2str(wkratio(i)));
end
for i = 1:length(ratio)
    text(n(i),ratio(i)-0.05,num2str(ratio(i)));
end
% title('WKKNN-KNN 算法识别结果 ');
xlabel('德语数据集')
ylabel('识别正确率')
legend('W-KNN','KNN','Location','SouthWest');   %右上角标注