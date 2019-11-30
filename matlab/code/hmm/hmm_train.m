clear all;
% 读入训练数据集tra_data.mat
load train_data.mat;
% 载入各情感的特征向量矩阵
load A_fear.mat;
load F_happiness.mat;
load N_neutral.mat;
load T_sadness.mat;
load W_anger.mat;
% 1-h,2-s,3-a,4-f,5-n

N = 6;   % hmm的状态数
M = [5,5,5,5,5,5]; % 每个状态对应的混合模型成分数

for i = 1:length(train_data)  % 数字的循环
    fprintf('\n计算情感%d的特征参数\n',i);
    for k = 1:length(train_data{i})  % 样本数的循环
      obs(k).sph = train_data{i}{k};  % 情感i的第k个语音
      
      
      obs(k).fea = mfcc(obs(k).sph);  % 对语音提取mfcc特征参数
    end
    
    fprintf('\n训练情感%d的hmm\n',i);
    hmm_temp=inithmm(obs,N,M); %初始化hmm模型
    hmm{i}=baum_welch(hmm_temp,obs); %迭代更新hmm的各参数
end
fprintf('\n训练完成！\n');


