import os


sOriginalFolder = r'F:\SpeechOcean_HeadsetRecording_XiaoAiTongXue\xatx_1050_stereo'
sDesireFolder = r'F:\SpeechOcean_HeadsetRecording_XiaoAiTongXue\xatx_1050_mono_16k'


if os.path.exists(sDesireFolder) == False:
    os.mkdir(sDesireFolder)

for root, dirs, files in os.walk(sOriginalFolder):
    for SrcFilenames in files:
        sSrcFilenames = os.path.join(root, SrcFilenames)
        sSrcFilename = os.path.splitext(sSrcFilenames)[1]
        if sSrcFilename not in ['.wav', '.WAV']:
            continue

        print(sSrcFilenames + r' Converting')

        sDstFilenames = sSrcFilenames.replace(sOriginalFolder, sDesireFolder)
        
        sCurrentSubFolder = sDstFilenames.replace(sDesireFolder,'')
        sCurrentSubFolder = sCurrentSubFolder.replace(SrcFilenames,'')

        sCurrentFolder = sDesireFolder
        for sFolders in sCurrentSubFolder.split('\\'):
            sCurrentFolder = os.path.join(sCurrentFolder,sFolders)
            if os.path.exists(sCurrentFolder) == False:
                os.mkdir(sCurrentFolder)
        
        sCmd = 'sox ' + sSrcFilenames + ' -r 16000 ' + sDstFilenames + ' remix 1'
        os.system(sCmd)

        print(sSrcFilenames + r' Done')
print(r'Sox Converting Done')