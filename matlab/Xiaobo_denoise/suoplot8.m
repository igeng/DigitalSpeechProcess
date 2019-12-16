clear all; clc; close all;

[xx, fs] = audioread('yes.wav');           % ���������ļ�
xx=xx-mean(xx);                         % ����ֱ������
x=xx/max(abs(xx));                      % ��ֵ��һ��

IS=0.25;                                % ����ǰ���޻��γ���
wlen=200;                               % ����֡��Ϊ25ms
inc=80;                                 % ����֡��Ϊ10ms
SNR1=20;                                 % ���������SNR
SNR2=10;
SNR3=5;
SNR4=0;

N=length(x);                            % �źų���
time=(0:N-1)/fs;                        % ����ʱ��

signal1=awgn(x,SNR1,'measured','db');               % ��������
signal2=awgn(x,SNR2,'measured','db');               % ��������
signal3=awgn(x,SNR3,'measured','db');               % ��������
signal4=awgn(x,SNR4,'measured','db');               % ��������
snr1=SNR_Calc(x,signal1);            % �����ʼ�����
NIS=fix((IS*fs-wlen)/inc +1);           % ��ǰ���޻���֡��

a=4; b=0.001;                           % ���ò���a��b
output1=SpectralSub(signal1,wlen,inc,NIS,a,b);% �׼�
output2=SpectralSub(signal2,wlen,inc,NIS,a,b);
output3=SpectralSub(signal3,wlen,inc,NIS,a,b);
output4=SpectralSub(signal4,wlen,inc,NIS,a,b);
% snr2=SNR_Calc(x,output);            % �����׼���������
% snr=snr2-snr1;
% fprintf('snr1=%5.4f   snr2=%5.4f   snr=%5.4f\n',snr1,snr2,snr);

% ��ͼ
subplot 421; plot(time,signal1,'k'); grid; axis tight;
ylabel('20db�������')
subplot 422; plot(time,output1,'k'); grid; axis tight;
ylabel('�׼���������')

subplot 423; plot(time,signal2,'k'); grid; axis tight;
ylabel('10db�������')
subplot 424; plot(time,output2,'k'); grid; axis tight;
ylabel('�׼���������')

subplot 425; plot(time,signal3,'k'); grid; axis tight;
ylabel('5db�������')
subplot 426; plot(time,output3,'k'); grid; axis tight;
ylabel('�׼���������')

subplot 427; plot(time,signal4,'k'); grid; axis tight;
ylabel('0db�������')
subplot 428; plot(time,output4,'k'); grid; axis tight;
ylabel('�׼���������')

audiowrite('yes_white_20db.wav',signal1,fs);
audiowrite('yes_white_10db.wav',signal2,fs);
audiowrite('yes_white_5db.wav',signal3,fs);
audiowrite('yes_white_0db.wav',signal4,fs);

