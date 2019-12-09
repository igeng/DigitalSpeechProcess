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
batch_size_ts = 5

model = models.load_model('mfcc_cnn_model_all.h5')

def predict():
    test_data_dir = './myRecording/mfcc_images_ts_0db'
    test_datagen = ImageDataGenerator(
        rescale=1. / 255,
        shear_range=0,
        zoom_range=0,
        horizontal_flip=False)
    test_generator = test_datagen.flow_from_directory(
        test_data_dir,
        target_size=(nrow, ncol),
        batch_size=batch_size_ts,
        class_mode='sparse')

    # Load the model
    Xts, _ = test_generator.next()

    # Predict the probability of each class
    yts = model.predict(Xts)
    #    print (yts * 100)
    if np.max(yts) < 0.1:
        print('Cannot Recognize!')

    # Choose the most likely class
    res = np.argmax(yts)
    print(res)

    return

if __name__=='__main__':
    print('Start')
    predict()
    print('Done')
