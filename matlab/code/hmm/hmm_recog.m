% �����ʶ������
% 1-h,2-s,3-a,4-f,5-n
load recog_data.mat;

sumh=0;
sums=0;
suma=0;
sumf=0;
sumn=0;

fprintf('��ʼʶ��\n');

for ii=1:5
    for jj=1:10
        %j = 2;
        rec_sph=recognition_data{ii}{jj}; % ���ѡ��һ����ʶ������
        fprintf('����������ʵ���Ϊ%d\n',ii);
        rec_fea = mfcc(rec_sph);  % ������ȡ

        % �����ǰ�������ڸ����hmm��p(X|M)
        for i=1:5
            pxsm(i) = viterbi(hmm{i}, rec_fea); 
        end
        [d,n] = max(pxsm); % �о����������ֵ��Ӧ�������Ϊʶ����
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
        fprintf('���������ʶ����Ϊ%d\n',n)
    end
end

rate=[sumh/10, sums/10, suma/10, sumf/10, sumn/10];
rate
bar(rate,0.5);
set(gca,'XTickLabel',{'����','����','����','����','����'});
ylabel('ʶ����');
xlabel('���ֻ������');