import os

for j in range(2,6):

    sOriginalFolder_1 = r'D:\SpeechOcean_HeadsetRecording_XiaoAiTongXue\xatx_WuWRecordings_744\xatx_WuTaiShan_WuWRecordings_744\xatx_744_' + str(j) + r'm_180D'
    sOriginalFolder_2 = r'D:\SpeechOcean_HeadsetRecording_XiaoAiTongXue\xatx_WuWRecordings_744\xatx_WuTaiShan_WuWRecordings_744\xatx_744_' + str(j) + r'm_300D'
    sDstFolder = r'D:\SpeechOcean_HeadsetRecording_XiaoAiTongXue\xatx_WuWRecordings_744\xatx_WuTaiShan_WuWRecordings_744_Pairs\xatx_744_' + str(j) + r'm_180D300D'

    sSrcFilefolders_1 = []
    sSrcFilefolders_2 = []

    for root, dirs, files in os.walk(sOriginalFolder_1):
       for sSubFolder in dirs:
            sSrcFilefolders_1.append(os.path.join(root,sSubFolder))
    for root, dirs, files in os.walk(sOriginalFolder_2):
       for sSubFolder in dirs:
            sSrcFilefolders_2.append(os.path.join(root,sSubFolder))

    iLen_1 = len(sSrcFilefolders_1)
    iLen_2 = len(sSrcFilefolders_2)

    for i in range(0,iLen_1):
        sDstSubFolder = sSrcFilefolders_1[i].replace(sOriginalFolder_1,'')
        for sFolders in sDstSubFolder.split('\\'):
            sCurrentFolder = os.path.join(sDstFolder,sFolders)
            if os.path.exists(sCurrentFolder) == False:
                os.mkdir(sCurrentFolder)
        sDstFullFolder = sDstFolder + sDstSubFolder
        print(r'Combining: '+sDstFullFolder)
        sCmd = r'sox ' + sSrcFilefolders_1[i] + r'\ch0.wav ' + sSrcFilefolders_2[i] + r'\ch0.wav ' + sDstFullFolder + r'\ch0.wav'
        os.system(sCmd)
        sCmd = r'sox ' + sSrcFilefolders_1[i] + r'\ch1.wav ' + sSrcFilefolders_2[i] + r'\ch1.wav ' + sDstFullFolder + r'\ch1.wav'
        os.system(sCmd)
        sCmd = r'sox ' + sSrcFilefolders_1[i] + r'\ch2.wav ' + sSrcFilefolders_2[i] + r'\ch2.wav ' + sDstFullFolder + r'\ch2.wav'
        os.system(sCmd)
        sCmd = r'sox ' + sSrcFilefolders_1[i] + r'\ch3.wav ' + sSrcFilefolders_2[i] + r'\ch3.wav ' + sDstFullFolder + r'\ch3.wav'
        os.system(sCmd)
        sCmd = r'sox ' + sSrcFilefolders_1[i] + r'\ch4.wav ' + sSrcFilefolders_2[i] + r'\ch4.wav ' + sDstFullFolder + r'\ch4.wav'
        os.system(sCmd)
        sCmd = r'sox ' + sSrcFilefolders_1[i] + r'\ch5.wav ' + sSrcFilefolders_2[i] + r'\ch5.wav ' + sDstFullFolder + r'\ch5.wav'
        os.system(sCmd)
        sCmd = r'sox ' + sSrcFilefolders_1[i] + r'\ch6.wav ' + sSrcFilefolders_2[i] + r'\ch6.wav ' + sDstFullFolder + r'\ch6.wav'
        os.system(sCmd)
        print(r'Done: '+sDstFullFolder)

print(r'Combining Done')