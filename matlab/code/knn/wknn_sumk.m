load wksumk1
load wksumk2
load wksumk3
load wksumk4
load wksumk5

wksumk=zeros(50,25);
wksumk=wksumk1+wksumk2+wksumk3+wksumk4+wksumk5;
%��ÿ��kֵ��ƽ����ÿ����е���ȷ��
wksumk=wksumk./5;
wknn_k = sum(wksumk,2);
[kk,ii]=max(wknn_k)

figure(1);
x=1:1:50;
%���ܵ�ʶ����ȷ��
wknn_k=wknn_k./5;
plot(x,wknn_k,'-*r');
xlabel('����ڲ���k')
ylabel('������ȷ��')
title('WA-kNN�㷨�ڲ�ͬkֵ�µ�ʶ����ȷ��');
save('wksumk.mat','wksumk');
save('wknn_k.mat','wknn_k');