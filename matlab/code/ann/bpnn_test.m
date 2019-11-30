load sum1;
load sum2;
load sum3;
load sum4;
load sum5;

sumbp=sum1+sum2+sum3+sum4+sum5;
sumbp=sumbp./5;

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
ylabel('识别率')
save('sumbp.mat','sumbp');