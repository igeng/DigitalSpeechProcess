'''
Created on 2017.12.9

@author: Richard
'''

import os
import librosa.display
import librosa.feature
import numpy as np
import matplotlib.pyplot as plt
from codes.logamplitude import logamplitude

number = '0'

def extract_mfcc(in_path, file, n_mels):
    y, sr = librosa.load(in_path + file, sr=8000)
    print(sr)
    S = librosa.feature.melspectrogram(y=y, sr=sr, n_fft=1024, hop_length=256,n_mels=n_mels)#fmax=sr/2
    print('1')
    print('S[195:256, :]:')
    print(S)
    print(S[195:256, :].shape)
    plt.figure(figsize=(3, 3), dpi=100)
    # S[195:256, :] = S[0:61, :]
    librosa.display.specshow(logamplitude(S, ref_power=np.max, amin=1e-15))
    # librosa.display.specshow(librosa.power_to_db(S), sr=sr, fmax=fmax)
    print('2')
    # print(librosa.power_to_db(S)[195:256, :])
    print('logamplitude(S, amin=1e-15)[195:256, :]:')
    print(logamplitude(S, amin=1e-15, top_db=None))
    print('logamplitude(S, amin=1e-15)[195:256, :].shape:')
    print(logamplitude(S, amin=1e-15, top_db=None)[195:256, :].shape)
    print('3')
    print('logamplitude(S, ref_power=np.max, amin=1e-15)[195:256, :]:')
    print(logamplitude(S, ref_power=np.max, amin=1e-15))
    print(np.max(S))

    plt.xticks([])
    plt.yticks([])
    plt.tight_layout()
    # plt.colorbar(format='%+2.0f dB')
    plt.savefig('./myRecording/mfcc_images_test/' + number + '/' + file[:-3] + 'png', bbox_inches='tight', pad_inches=-0.1)

    print('4')
    print(plt.imread('./myRecording/mfcc_images_test/' + number + '/' + file[:-3] + 'png'))
    print(plt.imread('./myRecording/mfcc_images_test/' + number + '/' + file[:-3] + 'png').shape)

    plt.close()   
    return


count = 0       # number of files processed

in_path = './myRecording/audio_ts/' + number + '/'       # input directory
# in_path = '222/'
for wavfile in os.listdir(in_path):
    # Input file, fmax=fmax
    S = extract_mfcc(in_path, wavfile, 256)
    
    # Count processed files
    count += 1
    if count % 20 == 0:
        print ('%d files processed.' % count)

print ('Done!\t%d files processed.' % count)
