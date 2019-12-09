import os,shutil

def mymovefile(srcfile,dstfile):
    if not os.path.isfile(srcfile):
        print("%s not exist!"%(srcfile))
    else:
        fpath,fname=os.path.split(dstfile)    #分离文件名和路径
        if not os.path.exists(fpath):
            os.makedirs(fpath)                #创建路径
        shutil.move(srcfile,dstfile)          #移动文件
        print("move %s -> %s"%( srcfile,dstfile))

def mycopyfile(srcfile,dstfile):
    if not os.path.isfile(srcfile):
        print("%s not exist!"%(srcfile))
    else:
        fpath,fname=os.path.split(dstfile)    #分离文件名和路径
        if not os.path.exists(fpath):
            os.makedirs(fpath)                #创建路径
        shutil.copyfile(srcfile,dstfile)      #复制文件
        print("copy %s -> %s"%( srcfile,dstfile))

# speaker_name = ['liuchanhg', 'wangzhe', 'zhaoquanyin', 'ZhaoZuoxiang']
# emo_name = ['angry', 'fear', 'happy', 'neutral', 'sad', 'surprise']
# spe_num = 1
# emo_num = 1
path_1 = '/media/igeng/DocData/thunder-download/speech_commands_v0.01/'
folder_1 = os.listdir(path_1)
print(folder_1)
new_folder = 0
for folder_name in folder_1:
    print(len(os.listdir(path_1 + folder_name)))
    print(folder_name)
    i = 0
    for wav_file in os.listdir(path_1 + folder_name):
        # for i in range(len(os.listdir(path_1 + folder_name))):
        srcfile = path_1 + folder_name + '/' + wav_file
        dstfile = '/home/igeng/PycharmProjects/google_recog/Spoken_Number_Recognition_mfcc/codes/google_commands/audio_tr/' + str(new_folder) + '/' + folder_name+'_'+str(i) + '.wav'
        shutil.copyfile(srcfile, dstfile)  # 复制文件
        print("copy %s -> %s" % (srcfile, dstfile))
        i += 1
    new_folder += 1
    # for wav_file in os.listdir(path_1 + folder_name):
    #     for wav_num in range(246, 251):
    #         srcfile='/media/igeng/DocData/DSP/casia/CASIA/CASIA_database_re/' + spe + '/' + emo + '/' + str(spe_num) + '_' + emo + '_' + str(wav_num) + '.wav'
    #         dstfile='/home/igeng/PycharmProjects/Emotion/Emotion_Recog_mfcc/codes/casia/audio_ts/' + str(emo_num) + '/' + str(spe_num) + '_' + emo + '_' + str(wav_num) + '.wav'
    #         shutil.copyfile(srcfile, dstfile)  # 复制文件
    #         print("copy %s -> %s" % (srcfile, dstfile))