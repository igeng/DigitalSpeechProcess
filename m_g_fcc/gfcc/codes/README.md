# Audio Recognition based on gfcc

## File Architecture and Description
`./audio_test_0db/*`   test aduio mixed noise.

`./gfcc_images_ts_0db/*`   Gammatone images extracted from audio.

`./cnn_model.py`   build and train cnn model

`./extract_features_img.py`   plot Gam Spectrogram image of each audio files in dataset

`./generate_tr.py`   a tool to record your own speech as a part of dataset
 
 `./trimmer.py`   a tool to extend the length of an audio file to 1 second
 
 `./recorder.py`   the program to recognize the spoken number in real-time
 
 `./Recorder_GUI.py`   GUI for `recorder.py`
 
