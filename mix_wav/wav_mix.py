import numpy as np
import soundfile as sf
import librosa
import random
import os

sound_name = 'SI'


def switch(item):
    switcher = {
        0: 'babble',
        1: 'destroyerengine',
        2: 'destroyerops',
        3: 'factory1'
    }
    return switcher.get(item)


files = os.listdir('D:/毕设数据/TIMIT-TRAIN')

# 噪音的id
# [)
for i in range(0, 1000):
    # 随机噪声类型
    n_id = random.randint(0, 3)
    n_name = switch(n_id)
    # 原始语音
    a, a_sr = librosa.load('D:/毕设数据/TIMIT-TRAIN/' + files[i], sr=16000)
    # 噪音
    b, b_sr = librosa.load('D:/毕设数据/noise/' + n_name + '_train' + '.wav', sr=16000)
    # 随机取一段噪声，保证长度和纯净语音长度一致，保证不会越界
    start = random.randint(0, b.shape[0] - a.shape[0])
    # 切片
    n_b = b[int(start):int(start) + a.shape[0]]

    # 平方求和
    sum_s = np.sum(a ** 2)
    sum_n = np.sum(n_b ** 2)
    # 信噪比为0dB时的权重
    x = np.sqrt(sum_s / (sum_n * pow(10, -0.5)))

    noise = x * n_b
    target = a + noise
    sf.write('D:/毕设数据/train_data/1dB/mix_sound/' + files[i].split('.')[0] + '_' + n_name + '.wav', target, 16000)
    sf.write('D:/毕设数据/train_data/1dB/sound/' + files[i].split('.')[0] + '.wav', a, 16000)
    sf.write('D:/毕设数据/train_data/1dB/noise/' + files[i].split('.')[0] + '_' + n_name + '_train' + '.wav', noise, 16000)
