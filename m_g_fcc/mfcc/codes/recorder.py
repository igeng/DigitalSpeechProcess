import numpy as np
import pyaudio
import struct
import wave

import keras.backend as K
K.clear_session()

import librosa.display
import librosa.feature
from keras import models
import matplotlib.pyplot as plt
from keras.preprocessing.image import ImageDataGenerator

nrow = 200
ncol = 200

BLOCKSIZE = 128

RATE = 22050
WIDTH = 2
CHANNELS = 1
LEN = 1 * RATE   # 1 second

model = models.load_model('mfcc_cnn_model_all.h5')


def is_silent(data, THRESHOLD):
    "Returns 'True' if below the threshold"
    return max(data) < THRESHOLD

def extract_mfcc(file, fmax):
    y, sr = librosa.load(file)
    
    plt.figure(figsize=(3, 3), dpi=100)
    
    S = librosa.feature.melspectrogram(y=y, sr=sr, n_fft=256, hop_length=128)
    librosa.display.specshow(librosa.amplitude_to_db(S), fmax=fmax)
    
    plt.xticks([])
    plt.yticks([])
    plt.tight_layout()
    plt.savefig('tmp/tmp/myImg.png', bbox_inches='tight', pad_inches=-0.1)
    
    plt.close()  
    return

def predict():
    # MFCCs of the test audio
    extract_mfcc('myNumber.wav', 8000)
    test_datagen = ImageDataGenerator(
            rescale=1./255,
            shear_range=0,
            zoom_range=0,
            horizontal_flip=False)
    test_generator = test_datagen.flow_from_directory(
            'tmp',
            target_size=(nrow, ncol),
            batch_size=1,
            class_mode='sparse')

    # Load the model
    Xts, _ = test_generator.next()

    # Predict the probability of each class
    yts = model.predict(Xts)
#    print (yts * 100)
    if np.max(yts) < 0.1:
        print ('Cannot Recognize!')

    # Choose the most likely class
    res = np.argmax(yts)
    print (res)
    
    return



##########  Recorder  ###########
flag = 0
while flag < 10:
    flag += 1
    
    # Output wave file
    output_wf = wave.open('myNumber.wav', 'w')
    # output_wf = wave.open('myVoice/9_richard_19.wav', 'w')
    output_wf.setframerate(RATE)
    output_wf.setsampwidth(WIDTH)
    output_wf.setnchannels(CHANNELS)

    p = pyaudio.PyAudio()
    stream = p.open(format = p.get_format_from_width(WIDTH),
                    channels = CHANNELS,
                    rate = RATE,
                    input = True,
                    output = True)
    
    start = False
    # Wait until voice detected
    while True:    
        input_string = stream.read(BLOCKSIZE, exception_on_overflow = False)
        input_value = struct.unpack('h' * BLOCKSIZE, input_string)
        silent = is_silent(input_value, 1000)
        if not silent:
            start = True
        
        if start:
            # Start recording
            print("Start")

            nBLOCK = int(LEN / BLOCKSIZE)
            numSilence = 0
            for n in range(0, nBLOCK):
                     
                if is_silent(input_value, 100):
                    numSilence += 1
 
                output_value = np.array(input_value)
        
                if numSilence > RATE/8000*5:
                    break
        
                output_value = output_value.astype(int)
                output_value = np.clip(output_value, -2**15, 2**15 - 1)

                ouput_string = struct.pack('h' * BLOCKSIZE, *output_value)
                output_wf.writeframes(ouput_string)
                
                input_string = stream.read(BLOCKSIZE, exception_on_overflow = False)
                input_value = struct.unpack('h' * BLOCKSIZE, input_string)
                
            print('Done')
            start = False
            
            predict()
            
            stream.stop_stream()
            stream.close()
            p.terminate()
            output_wf.close()           
            break

