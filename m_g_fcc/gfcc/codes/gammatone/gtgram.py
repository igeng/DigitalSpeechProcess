# Copyright 2014 Jason Heeris, jason.heeris@gmail.com
# 
# This file is part of the gammatone toolkit, and is licensed under the 3-clause
# BSD license: https://github.com/detly/gammatone/blob/master/COPYING
from __future__ import division
import numpy as np
from matplotlib import pyplot as plt
import librosa.display
import librosa.feature
import os
from codes.gammatone.filters import make_erb_filters, centre_freqs, erb_filterbank

"""
This module contains functions for rendering "spectrograms" which use gammatone
filterbanks instead of Fourier transforms.
"""

def round_half_away_from_zero(num):
    """ Implement the round-half-away-from-zero rule, where fractional parts of
    0.5 result in rounding up to the nearest positive integer for positive
    numbers, and down to the nearest negative number for negative integers.
    """
    return np.sign(num) * np.floor(np.abs(num) + 0.5)


def gtgram_strides(fs, window_time, hop_time, filterbank_cols):
    """
    Calculates the window size for a gammatonegram.
    
    @return a tuple of (window_size, hop_samples, output_columns)
    """
    nwin        = int(round_half_away_from_zero(window_time * fs))
    hop_samples = int(round_half_away_from_zero(hop_time * fs))
    columns     = (1
                    + int(
                        np.floor(
                            (filterbank_cols - nwin)
                            / hop_samples
                        )
                    )
                  )
        
    return (nwin, hop_samples, columns)


def gtgram_xe(wave, fs, channels, f_min):
    """ Calculate the intermediate ERB filterbank processed matrix """
    cfs = centre_freqs(fs, channels, f_min)
    fcoefs = np.flipud(make_erb_filters(fs, cfs))
    xf = erb_filterbank(wave, fcoefs)
    xe = np.power(xf, 2)
    return xe


def gtgram(
    wave,
    fs,
    window_time, hop_time,
    channels,
    f_min):
    """
    Calculate a spectrogram-like time frequency magnitude array based on
    gammatone subband filters. The waveform ``wave`` (at sample rate ``fs``) is
    passed through an multi-channel gammatone auditory model filterbank, with
    lowest frequency ``f_min`` and highest frequency ``f_max``. The outputs of
    each band then have their energy integrated over windows of ``window_time``
    seconds, advancing by ``hop_time`` secs for successive columns. These
    magnitudes are returned as a nonnegative real matrix with ``channels`` rows.
    
    | 2009-02-23 Dan Ellis dpwe@ee.columbia.edu
    |
    | (c) 2013 Jason Heeris (Python implementation)
    """
    xe = gtgram_xe(wave, fs, channels, f_min)    
    
    nwin, hop_samples, ncols = gtgram_strides(
        fs,
        window_time,
        hop_time,
        xe.shape[1]
    )
    
    y = np.zeros((channels, ncols))
    
    for cnum in range(ncols):
        segment = xe[:, cnum * hop_samples + np.arange(nwin)]
        y[:, cnum] = np.sqrt(segment.mean(1))
    return y

def extract_gfcc(in_path, file):
    y, sr = librosa.load(in_path + file, sr=16000)
    # S = librosa.feature.melspectrogram(y=y, sr=sr, n_fft=1024, hop_length=256, n_mels=n_mels)  # fmax=sr/2
    S = gtgram(y, sr, 0.064, 0.016, 256, 100)#0db:50,others:100
    plt.figure(figsize=(3, 3), dpi=100)
    librosa.display.specshow(librosa.power_to_db(S, ref=np.max),sr=sr)
    # librosa.display.specshow(librosa.power_to_db(S), sr=sr, fmax=fmax)
    plt.xticks([])
    plt.yticks([])
    plt.tight_layout()
    plt.savefig('/home/igeng/PycharmProjects/Spoken_Number_Recognition_gfcc/codes/myRecording/gfcc_images_tr_0db/' + number + '/' + file[:-3] + 'png', bbox_inches='tight', pad_inches=-0.1)
    plt.close()
    return

if __name__=='__main__':
    number = '0'
    count = 0  # number of files processed
    in_path = '/home/igeng/PycharmProjects/Spoken_Number_Recognition_gfcc/codes/myRecording/audio_tr_0db/' + number + '/'  # input directory
    # in_path = '222/'
    for wavfile in os.listdir(in_path):
        # Input file, fmax=fmax
        S = extract_gfcc(in_path, wavfile)

        # Count processed files
        count += 1
        if count % 20 == 0:
            print('%d files processed.' % count)

    print('Done!\t%d files processed.' % count)


