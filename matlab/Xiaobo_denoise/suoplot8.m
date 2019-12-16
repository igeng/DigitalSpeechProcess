clear all; clc; close all;

[xx, fs] = audioread('yes.wav');           % 读入数据文件
xx=xx-mean(xx);                         % 消除直流分量
x=xx/max(abs(xx));                      % 幅值归一化

IS=0.25;                                % 设置前导无话段长度
wlen=200;                               % 设置帧长为25ms
inc=80;                                 % 设置帧移为10ms
SNR1=20;                                 % 设置信噪比SNR
SNR2=10;
SNR3=5;
SNR4=0;

N=length(x);                            % 信号长度
time=(0:N-1)/fs;                        % 设置时间

signal1=awgn(x,SNR1,'measured','db');               % 叠加噪声
signal2=awgn(x,SNR2,'measured','db');               % 叠加噪声
signal3=awgn(x,SNR3,'measured','db');               % 叠加噪声
signal4=awgn(x,SNR4,'measured','db');               % 叠加噪声
snr1=SNR_Calc(x,signal1);            % 计算初始信噪比
NIS=fix((IS*fs-wlen)/inc +1);           % 求前导无话段帧数

a=4; b=0.001;                           % 设置参数a和b
output1=SpectralSub(signal1,wlen,inc,NIS,a,b);% 谱减
output2=SpectralSub(signal2,wlen,inc,NIS,a,b);
output3=SpectralSub(signal3,wlen,inc,NIS,a,b);
output4=SpectralSub(signal4,wlen,inc,NIS,a,b);
% snr2=SNR_Calc(x,output);            % 计算谱减后的信噪比
% snr=snr2-snr1;
% fprintf('snr1=%5.4f   snr2=%5.4f   snr=%5.4f\n',snr1,snr2,snr);

% 作图
subplot 421; plot(time,signal1,'k'); grid; axis tight;
ylabel('20db混合语音')
subplot 422; plot(time,output1,'k'); grid; axis tight;
ylabel('谱减法降噪结果')

subplot 423; plot(time,signal2,'k'); grid; axis tight;
ylabel('10db混合语音')
subplot 424; plot(time,output2,'k'); grid; axis tight;
ylabel('谱减法降噪结果')

subplot 425; plot(time,signal3,'k'); grid; axis tight;
ylabel('5db混合语音')
subplot 426; plot(time,output3,'k'); grid; axis tight;
ylabel('谱减法降噪结果')

subplot 427; plot(time,signal4,'k'); grid; axis tight;
ylabel('0db混合语音')
subplot 428; plot(time,output4,'k'); grid; axis tight;
ylabel('谱减法降噪结果')

audiowrite('yes_white_20db.wav',signal1,fs);
audiowrite('yes_white_10db.wav',signal2,fs);
audiowrite('yes_white_5db.wav',signal3,fs);
audiowrite('yes_white_0db.wav',signal4,fs);

