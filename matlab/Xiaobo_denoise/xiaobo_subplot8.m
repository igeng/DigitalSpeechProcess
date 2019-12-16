%实验要求二：小波硬阈值语音降噪
clear all; clc; close all;

[xx, fs] = audioread('yes.wav');           % 读入数据文件
xx=xx-mean(xx);                         % 消除直流分量
x=xx/max(abs(xx));                      % 幅值归一化
N=length(x);
%-------------------------加入指定强度的噪声---------------------------------
SNR1=20;                                 % 设置信噪比SNR
SNR2=10;
SNR3=5;
SNR4=0;
s1=awgn(x,SNR1,'measured','db');               % 叠加噪声
s2=awgn(x,SNR2,'measured','db');
s3=awgn(x,SNR3,'measured','db');
s4=awgn(x,SNR4,'measured','db');

wname='db7';

jN=6;  %分解的层数
signal1=Wavelet_Hard(s1,jN,wname);
signal1=signal1/max(abs(signal1));

signal2=Wavelet_Hard(s2,jN,wname);
signal2=signal2/max(abs(signal2));

signal3=Wavelet_Hard(s3,jN,wname);
signal3=signal3/max(abs(signal3));

signal4=Wavelet_Hard(s4,jN,wname);
signal4=signal4/max(abs(signal4));

time=(0:N-1)/fs;                        % 设置时间
% 作图
subplot 421; plot(time,s1,'k'); grid; axis tight;
ylabel('20db混合语音')
subplot 422; plot(time,signal1,'k'); grid; axis tight;
ylabel('小波降噪结果')

subplot 423; plot(time,s2,'k'); grid; axis tight;
ylabel('10db混合语音')
subplot 424; plot(time,signal2,'k'); grid; axis tight;
ylabel('小波降噪结果')

subplot 425; plot(time,s3,'k'); grid; axis tight;
ylabel('5db混合语音')
subplot 426; plot(time,signal3,'k'); grid; axis tight;
ylabel('小波降噪结果')

subplot 427; plot(time,s4,'k'); grid; axis tight;
ylabel('0db混合语音')
subplot 428; plot(time,signal4,'k'); grid; axis tight;
ylabel('小波降噪结果')
%--------------------------------------------------------------------------
