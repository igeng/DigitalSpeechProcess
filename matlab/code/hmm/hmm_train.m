clear all;
% ����ѵ�����ݼ�tra_data.mat
load train_data.mat;
% �������е�������������
load A_fear.mat;
load F_happiness.mat;
load N_neutral.mat;
load T_sadness.mat;
load W_anger.mat;
% 1-h,2-s,3-a,4-f,5-n

N = 6;   % hmm��״̬��
M = [5,5,5,5,5,5]; % ÿ��״̬��Ӧ�Ļ��ģ�ͳɷ���

for i = 1:length(train_data)  % ���ֵ�ѭ��
    fprintf('\n�������%d����������\n',i);
    for k = 1:length(train_data{i})  % ��������ѭ��
      obs(k).sph = train_data{i}{k};  % ���i�ĵ�k������
      
      
      obs(k).fea = mfcc(obs(k).sph);  % ��������ȡmfcc��������
    end
    
    fprintf('\nѵ�����%d��hmm\n',i);
    hmm_temp=inithmm(obs,N,M); %��ʼ��hmmģ��
    hmm{i}=baum_welch(hmm_temp,obs); %��������hmm�ĸ�����
end
fprintf('\nѵ����ɣ�\n');


