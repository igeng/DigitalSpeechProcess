load recograte1;
load recograte2;
load recograte3;
load recograte4;
load recograte5;

recog=recograte1+recograte2+recograte3+recograte4+recograte5;
recog=recog/5;

x=1:1:5;
plot(x,recog,'-*r'); %线性，颜色，标记
ylim([0,1])
set(gca,'XTick',[1, 2, 3, 4, 5]);
set(gca,'XTickLabel',{'生气','高兴','中性','悲伤','惊恐'});
n=1:5;
%给图上加说明文字
for i = 1:length(recog)
    text(n(i),recog(i)-0.03,num2str(recog(i)));
end
title('投票算法识别结果 ');
xlabel('情感类别')
ylabel('识别率')
save('recog.mat','recog');
