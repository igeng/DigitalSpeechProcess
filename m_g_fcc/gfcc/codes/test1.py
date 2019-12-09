# from codes.logamplitude import logamplitude
# S=[1.30601147e-11, 3.26720815e-12, 5.08253666e-15, 1.07505767e-14, 4.85975433e-15, 6.02928141e-14]
# print(logamplitude(S, amin=1e-15))
import librosa
import librosa.util.example_data
import numpy as np
y, sr = librosa.load(librosa.util.example_audio_file())
S = np.abs(librosa.stft(y))
librosa.logamplitude(S**2)