import soundfile as sf
from gtgram import gtgram

data, fs = sf.read(r'G:\DSP2\paper\CFCC\adai_CFCC\wav\5_Agnes_40.wav')
y = gtgram(data, fs, 400, 160, 64, 0)
print(y)
print(y.shape)