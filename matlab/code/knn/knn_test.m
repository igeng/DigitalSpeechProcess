load ratio1;
load ratio2;
load ratio3;
load ratio4;
load ratio5;

ratio=ratio1+ratio2+ratio3+ratio4+ratio5;
ratio=ratio/5;

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
save('ratio.mat','ratio');