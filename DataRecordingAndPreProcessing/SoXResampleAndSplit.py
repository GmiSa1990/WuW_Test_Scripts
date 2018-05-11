import os


sOriginalFolder = r'C:\sse\iot_test\recording\RealNoise\Pantry'
sDesireFolder   = r'C:\sse\iot_test\recording\RealNoise\Pantry'


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
        sDstFileFolder = sDstFilenames[:-4]
        
        sCurrentSubFolder = sDstFileFolder.replace(sDesireFolder,'')
        sCurrentFolder = sDesireFolder
        for sFolders in sCurrentSubFolder.split('\\'):
            sCurrentFolder = os.path.join(sCurrentFolder,sFolders)
            if os.path.exists(sCurrentFolder) == False:
                os.mkdir(sCurrentFolder)
        
        sDstFilename = sDstFileFolder + r'\ch0.wav'
        sCmd = 'sox ' + sSrcFilenames + ' -r 16000 ' + sDstFilename + ' remix 1'
        os.system(sCmd)
        sDstFilename = sDstFileFolder + r'\ch1.wav'
        sCmd = 'sox ' + sSrcFilenames + ' -r 16000 ' + sDstFilename + ' remix 2'
        os.system(sCmd)
        sDstFilename = sDstFileFolder + r'\ch2.wav'
        sCmd = 'sox ' + sSrcFilenames + ' -r 16000 ' + sDstFilename + ' remix 3'
        os.system(sCmd)
        sDstFilename = sDstFileFolder + r'\ch3.wav'
        sCmd = 'sox ' + sSrcFilenames + ' -r 16000 ' + sDstFilename + ' remix 4'
        os.system(sCmd)
        sDstFilename = sDstFileFolder + r'\ch4.wav'
        sCmd = 'sox ' + sSrcFilenames + ' -r 16000 ' + sDstFilename + ' remix 5'
        os.system(sCmd)
        sDstFilename = sDstFileFolder + r'\ch5.wav'
        sCmd = 'sox ' + sSrcFilenames + ' -r 16000 ' + sDstFilename + ' remix 6'
        os.system(sCmd)
        sDstFilename = sDstFileFolder + r'\ch6.wav'
        sCmd = 'sox ' + sSrcFilenames + ' -r 16000 ' + sDstFilename + ' remix 7'
        os.system(sCmd)
        
        print(sSrcFilenames + r' Done')
print(r'Sox Converting Done')