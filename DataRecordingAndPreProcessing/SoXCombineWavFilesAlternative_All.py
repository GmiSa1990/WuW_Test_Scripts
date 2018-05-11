import os

for k in range(2,6):

    sOriginalFolder_00 = r'D:\SpeechOcean_HeadsetRec_XATX\xatx_WuWRecordings_1000\xatx_WuTaiShan_WuWRecordings_20180227\xatx_' + str(k) + r'm_180D'
    sOriginalFolder_01 = r'D:\SpeechOcean_HeadsetRec_XATX\xatx_WuWRecordings_1000\xatx_WuTaiShan_WuWRecordings_20180227\xatx_' + str(k) + r'm_300D'
    sDstFolder = r'D:\SpeechOcean_HeadsetRec_XATX\xatx_WuWRecordings_1000\xatx_WuTaiShan_WuWRecordings_AltCombined\xatx_' + str(k) + r'm_180D300D'

    sSrcFilefolders_00 = []
    sSrcFilefolders_01 = []

    for root, dirs, files in os.walk(sOriginalFolder_00):
       for sSubFolder in dirs:
            sSrcFilefolders_00.append(os.path.join(root,sSubFolder))

    for root, dirs, files in os.walk(sOriginalFolder_01):
       for sSubFolder in dirs:
            sSrcFilefolders_01.append(os.path.join(root,sSubFolder))

    iLen = len(sSrcFilefolders_00)
    iLenEachLoop = iLen/3

    for j in range(0,3):
        sDstSubFolder = r'\WuWxatx_0'+str(j)
        sDstFullFolder = sDstFolder + sDstSubFolder
        if os.path.exists(sDstFullFolder) == False:
            os.mkdir(sDstFullFolder)
        print(r'Combining: '+sDstFullFolder)
        for i in range(1,iLenEachLoop):
            print('Combining'+str(i + j*iLenEachLoop))
            #import pdb; pdb.set_trace()
            if i == 1:
                sCmd = r'sox ' + sSrcFilefolders_00[0 + j*iLenEachLoop] + r'\ch0.wav ' + sSrcFilefolders_01[1 + j*iLenEachLoop] + r'\ch0.wav ' + sDstFullFolder + r'\ch0.wav'
                #print(sCmd)
                os.system(sCmd)
                sCmd = r'sox ' + sSrcFilefolders_00[0 + j*iLenEachLoop] + r'\ch1.wav ' + sSrcFilefolders_01[1 + j*iLenEachLoop] + r'\ch1.wav ' + sDstFullFolder + r'\ch1.wav'
                os.system(sCmd)
                sCmd = r'sox ' + sSrcFilefolders_00[0 + j*iLenEachLoop] + r'\ch2.wav ' + sSrcFilefolders_01[1 + j*iLenEachLoop] + r'\ch2.wav ' + sDstFullFolder + r'\ch2.wav'
                os.system(sCmd)
                sCmd = r'sox ' + sSrcFilefolders_00[0 + j*iLenEachLoop] + r'\ch3.wav ' + sSrcFilefolders_01[1 + j*iLenEachLoop] + r'\ch3.wav ' + sDstFullFolder + r'\ch3.wav'
                os.system(sCmd)
                sCmd = r'sox ' + sSrcFilefolders_00[0 + j*iLenEachLoop] + r'\ch4.wav ' + sSrcFilefolders_01[1 + j*iLenEachLoop] + r'\ch4.wav ' + sDstFullFolder + r'\ch4.wav'
                os.system(sCmd)
                sCmd = r'sox ' + sSrcFilefolders_00[0 + j*iLenEachLoop] + r'\ch5.wav ' + sSrcFilefolders_01[1 + j*iLenEachLoop] + r'\ch5.wav ' + sDstFullFolder + r'\ch5.wav'
                os.system(sCmd)
                sCmd = r'sox ' + sSrcFilefolders_00[0 + j*iLenEachLoop] + r'\ch6.wav ' + sSrcFilefolders_01[1 + j*iLenEachLoop] + r'\ch6.wav ' + sDstFullFolder + r'\ch6.wav'
                os.system(sCmd)
                #import pdb; pdb.set_trace()
            elif i % 2 == 0:
                sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch0.wav ' + sSrcFilefolders_00[i + j*iLenEachLoop] + r'\ch0.wav ' + sDstFullFolder + r'\ch0.wav'
                os.system(sCmd)
                #print(sCmd)
                sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch1.wav ' + sSrcFilefolders_00[i + j*iLenEachLoop] + r'\ch1.wav ' + sDstFullFolder + r'\ch1.wav'
                os.system(sCmd)
                sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch2.wav ' + sSrcFilefolders_00[i + j*iLenEachLoop] + r'\ch2.wav ' + sDstFullFolder + r'\ch2.wav'
                os.system(sCmd)
                sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch3.wav ' + sSrcFilefolders_00[i + j*iLenEachLoop] + r'\ch3.wav ' + sDstFullFolder + r'\ch3.wav'
                os.system(sCmd)
                sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch4.wav ' + sSrcFilefolders_00[i + j*iLenEachLoop] + r'\ch4.wav ' + sDstFullFolder + r'\ch4.wav'
                os.system(sCmd)
                sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch5.wav ' + sSrcFilefolders_00[i + j*iLenEachLoop] + r'\ch5.wav ' + sDstFullFolder + r'\ch5.wav'
                os.system(sCmd)
                sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch6.wav ' + sSrcFilefolders_00[i + j*iLenEachLoop] + r'\ch6.wav ' + sDstFullFolder + r'\ch6.wav'
                os.system(sCmd)
                os.remove(os.path.join(sDstFullFolder,'tmp_ch0.wav'))
                os.remove(os.path.join(sDstFullFolder,'tmp_ch1.wav'))
                os.remove(os.path.join(sDstFullFolder,'tmp_ch2.wav'))
                os.remove(os.path.join(sDstFullFolder,'tmp_ch3.wav'))
                os.remove(os.path.join(sDstFullFolder,'tmp_ch4.wav'))
                os.remove(os.path.join(sDstFullFolder,'tmp_ch5.wav'))
                os.remove(os.path.join(sDstFullFolder,'tmp_ch6.wav'))
            elif i % 2 == 1 and i != 1:
                sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch0.wav ' + sSrcFilefolders_01[i + j*iLenEachLoop] + r'\ch0.wav ' + sDstFullFolder + r'\ch0.wav'
                os.system(sCmd)
                #print(sCmd)
                sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch1.wav ' + sSrcFilefolders_01[i + j*iLenEachLoop] + r'\ch1.wav ' + sDstFullFolder + r'\ch1.wav'
                os.system(sCmd)
                sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch2.wav ' + sSrcFilefolders_01[i + j*iLenEachLoop] + r'\ch2.wav ' + sDstFullFolder + r'\ch2.wav'
                os.system(sCmd)
                sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch3.wav ' + sSrcFilefolders_01[i + j*iLenEachLoop] + r'\ch3.wav ' + sDstFullFolder + r'\ch3.wav'
                os.system(sCmd)
                sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch4.wav ' + sSrcFilefolders_01[i + j*iLenEachLoop] + r'\ch4.wav ' + sDstFullFolder + r'\ch4.wav'
                os.system(sCmd)
                sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch5.wav ' + sSrcFilefolders_01[i + j*iLenEachLoop] + r'\ch5.wav ' + sDstFullFolder + r'\ch5.wav'
                os.system(sCmd)
                sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch6.wav ' + sSrcFilefolders_01[i + j*iLenEachLoop] + r'\ch6.wav ' + sDstFullFolder + r'\ch6.wav'
                os.system(sCmd)
                os.remove(os.path.join(sDstFullFolder,'tmp_ch0.wav'))
                os.remove(os.path.join(sDstFullFolder,'tmp_ch1.wav'))
                os.remove(os.path.join(sDstFullFolder,'tmp_ch2.wav'))
                os.remove(os.path.join(sDstFullFolder,'tmp_ch3.wav'))
                os.remove(os.path.join(sDstFullFolder,'tmp_ch4.wav'))
                os.remove(os.path.join(sDstFullFolder,'tmp_ch5.wav'))
                os.remove(os.path.join(sDstFullFolder,'tmp_ch6.wav'))
                #import pdb; pdb.set_trace()
            os.rename(os.path.join(sDstFullFolder,'ch0.wav'),os.path.join(sDstFullFolder,'tmp_ch0.wav'))
            os.rename(os.path.join(sDstFullFolder,'ch1.wav'),os.path.join(sDstFullFolder,'tmp_ch1.wav'))
            os.rename(os.path.join(sDstFullFolder,'ch2.wav'),os.path.join(sDstFullFolder,'tmp_ch2.wav'))
            os.rename(os.path.join(sDstFullFolder,'ch3.wav'),os.path.join(sDstFullFolder,'tmp_ch3.wav'))
            os.rename(os.path.join(sDstFullFolder,'ch4.wav'),os.path.join(sDstFullFolder,'tmp_ch4.wav'))
            os.rename(os.path.join(sDstFullFolder,'ch5.wav'),os.path.join(sDstFullFolder,'tmp_ch5.wav'))
            os.rename(os.path.join(sDstFullFolder,'ch6.wav'),os.path.join(sDstFullFolder,'tmp_ch6.wav'))
            #import pdb; pdb.set_trace()

        os.rename(os.path.join(sDstFullFolder,'tmp_ch0.wav'),os.path.join(sDstFullFolder,'ch0.wav'))
        os.rename(os.path.join(sDstFullFolder,'tmp_ch1.wav'),os.path.join(sDstFullFolder,'ch1.wav'))
        os.rename(os.path.join(sDstFullFolder,'tmp_ch2.wav'),os.path.join(sDstFullFolder,'ch2.wav'))
        os.rename(os.path.join(sDstFullFolder,'tmp_ch3.wav'),os.path.join(sDstFullFolder,'ch3.wav'))
        os.rename(os.path.join(sDstFullFolder,'tmp_ch4.wav'),os.path.join(sDstFullFolder,'ch4.wav'))
        os.rename(os.path.join(sDstFullFolder,'tmp_ch5.wav'),os.path.join(sDstFullFolder,'ch5.wav'))
        os.rename(os.path.join(sDstFullFolder,'tmp_ch6.wav'),os.path.join(sDstFullFolder,'ch6.wav'))
        # os.remove(os.path.join(sDstFullFolder,'tmp_ch0.wav'))
        # os.remove(os.path.join(sDstFullFolder,'tmp_ch1.wav'))
        # os.remove(os.path.join(sDstFullFolder,'tmp_ch2.wav'))
        # os.remove(os.path.join(sDstFullFolder,'tmp_ch3.wav'))
        # os.remove(os.path.join(sDstFullFolder,'tmp_ch4.wav'))
        # os.remove(os.path.join(sDstFullFolder,'tmp_ch5.wav'))
        # os.remove(os.path.join(sDstFullFolder,'tmp_ch6.wav'))
        #import pdb; pdb.set_trace()
        print(r'Done: '+sDstFullFolder)
print('Combining Done!')