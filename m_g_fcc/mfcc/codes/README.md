# Spoken Number Recognition

## File Architecture and Description
`./spoken_numbers_wav/*`   Mel Spectrogram images of dataset

`./tmp/tmp/*`   temp folder for the program

`./cnn_model.py`   build and train cnn model

`./extract_features_img.py`   plot Mel Spectrogram image of each audio files in dataset

`./generate_tr.py`   a tool to record your own speech as a part of dataset
 
 `./trimmer.py`   a tool to extend the length of an audio file to 1 second
 
 `./recorder.py`   the program to recognize the spoken number in real-time
 
 `./Recorder_GUI.py`   GUI for `recorder.py`
 
