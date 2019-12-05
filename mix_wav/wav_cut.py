from scipy.io import wavfile
import numpy as np
import soundfile as sf

sample_rate, sig = wavfile.read('D:/毕设数据/noise/factory1.wav')
# 采样率：1S内对声音信号的采样次数
# print("采样率: %d" % sample_rate)
# print(sig.shape)
# print(sig)
#
# if sig.dtype == np.int16:
#     print("PCM16位整形")


half = sig.shape[0]/2
data_train = sig[:int(half)]
data_test = sig[int(half):]

sf.write('D:/毕设数据/noise/factory1_train.wav', data_train, sample_rate)
sf.write('D:/毕设数据/noise/factory1_test.wav', data_test, sample_rate)

