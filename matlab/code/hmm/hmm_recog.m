% 读入待识别语音
% 1-h,2-s,3-a,4-f,5-n
load recog_data.mat;

sumh=0;
sums=0;
suma=0;
sumf=0;
sumn=0;

fprintf('开始识别\n');

for ii=1:5
    for jj=1:10
        %j = 2;
        rec_sph=recognition_data{ii}{jj}; % 随机选择一条待识别语音
        fprintf('该语音的真实情感为%d\n',ii);
        rec_fea = mfcc(rec_sph);  % 特征提取

        % 求出当前语音关于各情感hmm的p(X|M)
        for i=1:5
            pxsm(i) = viterbi(hmm{i}, rec_fea); 
        end
        [d,n] = max(pxsm); % 判决，将该最大值对应的序号作为识别结果
        if(n==1 && ii==1)
            sumh=sumh+1;
        elseif(n==2 && ii==2)
            sums=sums+1;
        elseif(n==3 && ii==3)
            suma=suma+1;
        elseif(n==4 && ii==4)
            sumf=sumf+1;
        elseif(n==5 && ii==5)
            sumn=sumn+1;
        end
        fprintf('该语音情感识别结果为%d\n',n)
    end
end

rate=[sumh/10, sums/10, suma/10, sumf/10, sumn/10];
rate
bar(rate,0.5);
set(gca,'XTickLabel',{'高兴','悲伤','生气','害怕','中性'});
ylabel('识别率');
xlabel('五种基本情感');