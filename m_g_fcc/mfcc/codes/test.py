# for a in range(60):
#     print('/home/pycharm/mfcc'+str(a+1)+'.csv')
#     print('/home/pycharm/ft' + str(a+1) + '.csv')
#     print('/home/pycharm/fm' + str(a+1) + '.csv')
#     print('iteration'+str(a))
#
#
import os
import librosa.display
import librosa.feature
import numpy as np
import audioread
import wave
y = wave.open('/home/igeng/PycharmProjects/google_recog/Spoken_Number_Recognition_mfcc/codes/google_commands/audio_tr/0/bed_0.wav')
params = y.getparams()
nchannels, sampwidth, framerate, nframes = params[:4]
print(framerate)