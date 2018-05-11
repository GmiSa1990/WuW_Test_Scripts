import os


sOriginalFolder = r'C:\Users\Administrator\Desktop\ASR_Team\SpeechOcean_HeadsetRecording_XiaoAiTongXue\xatx_300_forCalibration_bak'
sDesireFolder = r'C:\Users\Administrator\Desktop\ASR_Team\SpeechOcean_HeadsetRecording_XiaoAiTongXue\xatx_300_forCalibration_stereo'


if os.path.exists(sDesireFolder) == False:
    os.mkdir(sDesireFolder)

for root, dirs, files in os.walk(sOriginalFolder):
    for SrcFilenames in files:
        sSrcFilenames = os.path.join(root, SrcFilenames)
        if os.path.splitext(sSrcFilenames)[1] not in ['.wav', '.WAV']:
            continue

        sDstFilenames = sSrcFilenames.replace(sOriginalFolder, sDesireFolder)
        
        sCmd = 'sox ' + sSrcFilenames + ' -c2 ' + sDstFilenames
        os.system(sCmd)
print(r'Sox Converting Done')