import six
import librosa.display
import librosa.feature
import numpy as np

def logamplitude(S, ref_power=1.0, amin=1e-10, top_db=80.0):
    """Log-scale the amplitude of a spectrogram.

    Parameters
    ----------
    S : np.ndarray [shape=(d, t)]
        input spectrogram

    ref_power : scalar or function
        If scalar, `log(abs(S))` is compared to `log(ref_power)`.

        If a function, `log(abs(S))` is compared to `log(ref_power(abs(S)))`.

        This is primarily useful for comparing to the maximum value of `S`.

    amin    : float > 0[scalar]
        minimum amplitude threshold for `abs(S)` and `ref_power`

    top_db  : float >= 0 [scalar]
        threshold log amplitude at top_db below the peak:
        ``max(log(S)) - top_db``

    Returns
    -------
    log_S   : np.ndarray [shape=(d, t)]
        ``log_S ~= 10 * log10(S) - 10 * log10(abs(ref_power))``

    See Also
    --------
    perceptual_weighting

    Examples
    --------
    Get a power spectrogram from a waveform ``y``

    # >>> y, sr = librosa.load(librosa.util.example_audio_file())
    # >>> S = np.abs(librosa.stft(y))
    # >>> librosa.logamplitude(S**2)
    array([[-33.293, -27.32 , ..., -33.293, -33.293],
           [-33.293, -25.723, ..., -33.293, -33.293],
           ...,
           [-33.293, -33.293, ..., -33.293, -33.293],
           [-33.293, -33.293, ..., -33.293, -33.293]], dtype=float32)

    Compute dB relative to peak power

    # >>> librosa.logamplitude(S**2, ref_power=np.max)
    array([[-80.   , -74.027, ..., -80.   , -80.   ],
           [-80.   , -72.431, ..., -80.   , -80.   ],
           ...,
           [-80.   , -80.   , ..., -80.   , -80.   ],
           [-80.   , -80.   , ..., -80.   , -80.   ]], dtype=float32)


    Or compare to median power

    # >>> librosa.logamplitude(S**2, ref_power=np.median)
    array([[-0.189,  5.784, ..., -0.189, -0.189],
           [-0.189,  7.381, ..., -0.189, -0.189],
           ...,
           [-0.189, -0.189, ..., -0.189, -0.189],
           [-0.189, -0.189, ..., -0.189, -0.189]], dtype=float32)


    And plot the results

    # >>> import matplotlib.pyplot as plt
    # >>> plt.figure()
    # >>> plt.subplot(2, 1, 1)
    # >>> librosa.display.specshow(S**2, sr=sr, y_axis='log', x_axis='time')
    # >>> plt.colorbar()
    # >>> plt.title('Power spectrogram')
    # >>> plt.subplot(2, 1, 2)
    # >>> librosa.display.specshow(librosa.logamplitude(S**2, ref_power=np.max),
    # ...                          sr=sr, y_axis='log', x_axis='time')
    # >>> plt.colorbar(format='%+2.0f dB')
    # >>> plt.title('Log-Power spectrogram')
    # >>> plt.tight_layout()

    """

    # if amin <= 0:
    #     raise ParameterError('amin must be strictly positive')

    magnitude = np.abs(S)
    print('magnitude = np.abs(S):')
    print(magnitude)

    if six.callable(ref_power):
        # User supplied a function to calculate reference power
        __ref = ref_power(magnitude)
        print('ref_power(magnitude)')
        print(ref_power(magnitude))
    else:
        __ref = np.abs(ref_power)

    log_spec = 10.0 * np.log10(np.maximum(amin, magnitude))
    print('amin:')
    print(amin)
    print('magnitude:')
    print(magnitude)
    print('np.maximum(amin, magnitude):')
    print(np.maximum(amin, magnitude))
    print('np.maximum(amin, magnitude)_log_spec:')
    print(log_spec)

    log_spec -= 10.0 * np.log10(np.maximum(amin, __ref))
    print('np.maximum(amin, __ref):')
    print(np.maximum(amin, __ref))
    print('10.0 * np.log10(np.maximum(amin, __ref)):')
    print(10.0 * np.log10(np.maximum(amin, __ref)))
    print('np.maximum(amin, __ref)_log_spec:')
    print(log_spec)

    if top_db is not None:
        # if top_db < 0:
        #     raise ParameterError('top_db must be non-negative positive')
        log_spec = np.maximum(log_spec, log_spec.max() - top_db)
        print('return_log_spec')
        print(log_spec)

    return log_spec