import os
import librosa.display
import librosa.feature
import numpy as np
import matplotlib.pyplot as plt


def extract_mfcc(in_path, file, n_mels):
    y, sr = librosa.load(in_path + file, sr=16000)
    # print(sr)
    S = librosa.feature.melspectrogram(y=y, sr=sr, n_fft=1024, hop_length=256,n_mels=n_mels, fmin=100)
    # print(S.shape)
    plt.figure(figsize=(3, 3), dpi=100)
    librosa.display.specshow(librosa.power_to_db(S, ref=np.max), sr=sr)
    # print(librosa.power_to_db(S).shape)

    plt.xticks([])
    plt.yticks([])
    plt.tight_layout()
    plt.savefig('./google_commands/mfcc_images_tr/' + number + '/' + file[:-3] + 'png', bbox_inches='tight', pad_inches=-0.1)
    
    plt.close()   
    return



for i in range(0, 30):
    print(i)
    count = 0  # number of files processed
    number = str(i)
    in_path = './google_commands/audio_tr/' + number + '/'       # input directory
    # in_path = '222/'
    for wavfile in os.listdir(in_path):

        # Input file, fmax=fmax
        S = extract_mfcc(in_path, wavfile, 256)

        # Count processed files
        count += 1
        if count % 20 == 0:
            print ('%d files processed.' % count)

    print ('Done!\t%d files processed.' % count)
