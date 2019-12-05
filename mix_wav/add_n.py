import soundfile as sf
import os
import numpy as np
import math
import random


# 对纯语音数据添加噪声数据
def Get_Data(Voice, noise, Vn, snr):
    Data, Fs = sf.read(Voice)
    data, fs = sf.read(noise)
    print(Fs)
    print(fs)
    if fs == Fs and len(Data)<=len(data):
        Average_Energy = np.sum(Data ** 2) / len(Data)
        average_energy = np.sum(data ** 2) / len(data)
        k = math.sqrt(Average_Energy / average_energy / 10 ** (snr * 0.1))
        print(Average_Energy, average_energy, k)
        num = random.randint(8000,len(data)-len(Data)-8000)
        Data_new = Data + data[num:len(Data)+num] * k
        print(Vn)
        sf.write(Vn, Data_new, 8000)
        return Data, data, Data_new
    else:
        print('error: fs!=Fs or len(Voice)>len(noise)')
        return 0, 0, 0


def main(Voicedir, Noisedir, snr):
    # 遍历噪声文件
    for files in os.listdir(Noisedir):
        print(Noisedir)
        Noise_wav = os.path.join(Noisedir, files)
        print(Noise_wav)
        new_dir = Noisedir + '_' + files.split('.')[0] + '_' + str(snr)
        print(new_dir)
        # print('*',new_dir)

        # 三个参数分别返回1.父目录Rootdir 2.所有文件夹名字（不含路径） 3.所有文件名字（不含路径）
        # 遍历纯语音文件
        for Parent, Dirnames, Filenames in os.walk(Voicedir):
            print(Voicedir)
            print(Parent)
            print(Dirnames)
            print(Filenames)
            for Dirname in Dirnames:
                Dirs = os.path.join(Parent, Dirname)
                print(Dirs)
                for Files in os.listdir(Dirs):
                    Voice_wav = os.path.join(Dirs, Files)

                    # Noisedir噪声父目录            files噪声文件名
                    # Noise_wav噪声

                    # Parent/Voicedir语音父目录     Dirname语音文件夹名
                    # Dirs语音文件夹目录           Files语音文件名
                    # Voice_wav语音

                    # new_dir含噪语音父目录
                    # path含噪语音目录
                    # VN含噪语音

                    path = os.path.join(new_dir, Dirname)
                    if not os.path.exists(path):
                        os.makedirs(path)
                    VN = os.path.join(path, Files)

                    print(Voice_wav, Noise_wav, VN, snr)

                    Voice_Data, noise_data, Voice_noise = Get_Data(Voice_wav, Noise_wav, VN, snr)


if __name__ == '__main__':
    SNR = [0, 5, 10, 20, 30]  # 信噪比
    # 在python3中不用担心斜杆正反的烦恼，但是反斜杠要加\去除特殊转义作用，或者加r''
    voicedir = r'G:\DSP_python\mix_wav\wav'  # 纯语音文件目录
    noisedir = r'G:\DSP_python\mix_wav\noise'  # 噪声文件目录
    for i in SNR:
        main(voicedir, noisedir, i)
        print(i)

# 纯语音文件夹下再建立文件夹，然后才放语音文件.wav
# 纯噪声直接放噪声文件.wav