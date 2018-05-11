import os
for kk in [180,300]:
    for k in range(2,6):

        sOriginalFolder = r'C:\Users\Administrator\Desktop\ASR_Team\xatx_WuWRecordings_744\xatx_WuTaiShan_WuWRecordings_744\xatx_744_' + str(k) + r'm_' + str(kk) + r'D'
        sDstFolder = r'C:\Users\Administrator\Desktop\ASR_Team\xatx_WuWRecordings_744\xatx_WuTaiShan_WuWRecordings_744_Combined\xatx_744_' + str(k) + r'm_' + str(kk) + r'D'

        sSrcFilefolders = []

        for root, dirs, files in os.walk(sOriginalFolder):
           for sSubFolder in dirs:
                sSrcFilefolders.append(os.path.join(root,sSubFolder))

        iLen = len(sSrcFilefolders)
        iLenEachLoop = iLen/4

        for j in range(0,4):
            sDstSubFolder = r'\xatx_WuWRecording_Combined0'+str(j)
            sDstFullFolder = sDstFolder + sDstSubFolder
            if os.path.exists(sDstFullFolder) == False:
                os.mkdir(sDstFullFolder)
            print(r'Combining: '+sDstFullFolder)
            for i in range(1,iLenEachLoop):
                print('Combining'+str(i + j*iLenEachLoop))
                if i == 1:
                    sCmd = r'sox ' + sSrcFilefolders[0 + j*iLenEachLoop] + r'\ch0.wav ' + sSrcFilefolders[1 + j*iLenEachLoop] + r'\ch0.wav ' + sDstFullFolder + r'\ch0.wav'
                    #print(sCmd)
                    os.system(sCmd)
                    sCmd = r'sox ' + sSrcFilefolders[0 + j*iLenEachLoop] + r'\ch1.wav ' + sSrcFilefolders[1 + j*iLenEachLoop] + r'\ch1.wav ' + sDstFullFolder + r'\ch1.wav'
                    os.system(sCmd)
                    sCmd = r'sox ' + sSrcFilefolders[0 + j*iLenEachLoop] + r'\ch2.wav ' + sSrcFilefolders[1 + j*iLenEachLoop] + r'\ch2.wav ' + sDstFullFolder + r'\ch2.wav'
                    os.system(sCmd)
                    sCmd = r'sox ' + sSrcFilefolders[0 + j*iLenEachLoop] + r'\ch3.wav ' + sSrcFilefolders[1 + j*iLenEachLoop] + r'\ch3.wav ' + sDstFullFolder + r'\ch3.wav'
                    os.system(sCmd)
                    sCmd = r'sox ' + sSrcFilefolders[0 + j*iLenEachLoop] + r'\ch4.wav ' + sSrcFilefolders[1 + j*iLenEachLoop] + r'\ch4.wav ' + sDstFullFolder + r'\ch4.wav'
                    os.system(sCmd)
                    sCmd = r'sox ' + sSrcFilefolders[0 + j*iLenEachLoop] + r'\ch5.wav ' + sSrcFilefolders[1 + j*iLenEachLoop] + r'\ch5.wav ' + sDstFullFolder + r'\ch5.wav'
                    os.system(sCmd)
                    sCmd = r'sox ' + sSrcFilefolders[0 + j*iLenEachLoop] + r'\ch6.wav ' + sSrcFilefolders[1 + j*iLenEachLoop] + r'\ch6.wav ' + sDstFullFolder + r'\ch6.wav'
                    os.system(sCmd)
                    #import pdb; pdb.set_trace()
                else:
                    sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch0.wav ' + sSrcFilefolders[i + j*iLenEachLoop] + r'\ch0.wav ' + sDstFullFolder + r'\ch0.wav'
                    os.system(sCmd)
                    #print(sCmd)
                    sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch1.wav ' + sSrcFilefolders[i + j*iLenEachLoop] + r'\ch1.wav ' + sDstFullFolder + r'\ch1.wav'
                    os.system(sCmd)
                    sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch2.wav ' + sSrcFilefolders[i + j*iLenEachLoop] + r'\ch2.wav ' + sDstFullFolder + r'\ch2.wav'
                    os.system(sCmd)
                    sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch3.wav ' + sSrcFilefolders[i + j*iLenEachLoop] + r'\ch3.wav ' + sDstFullFolder + r'\ch3.wav'
                    os.system(sCmd)
                    sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch4.wav ' + sSrcFilefolders[i + j*iLenEachLoop] + r'\ch4.wav ' + sDstFullFolder + r'\ch4.wav'
                    os.system(sCmd)
                    sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch5.wav ' + sSrcFilefolders[i + j*iLenEachLoop] + r'\ch5.wav ' + sDstFullFolder + r'\ch5.wav'
                    os.system(sCmd)
                    sCmd = r'sox ' + sDstFullFolder + r'\tmp_ch6.wav ' + sSrcFilefolders[i + j*iLenEachLoop] + r'\ch6.wav ' + sDstFullFolder + r'\ch6.wav'
                    os.system(sCmd)

                    #import pdb; pdb.set_trace()
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