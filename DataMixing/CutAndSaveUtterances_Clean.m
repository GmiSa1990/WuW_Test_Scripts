function CutAndSaveUtterances_Clean(sOriginalRecordingsDir, sProcessedAudioDir, sCuttedAudioDir, iLeadingSilence)


    lWuWRecordingList = dir(sOriginalRecordingsDir);
    lWuWRecordingList = lWuWRecordingList(3:end);
    iCountWuW = length(lWuWRecordingList);

    lProcessedAudioList = dir(sProcessedAudioDir);
    lProcessedAudioList = lProcessedAudioList(3:end);
    iCountProcessed = length(lProcessedAudioList);
    


    for i = 1:3:iCountProcessed
        sProcessedAudioName = lProcessedAudioList(i).name;
        iIdxSlash = find(sProcessedAudioName == '_');
        sProcessedAudioSubDir_00 = [sProcessedAudioDir,lProcessedAudioList(i).name, '\'];
        sProcessedAudioSubDir_01 = [sProcessedAudioDir,lProcessedAudioList(i+1).name, '\'];
        sProcessedAudioSubDir_02 = [sProcessedAudioDir,lProcessedAudioList(i+2).name, '\'];
        sCuttedAudioSubDir = [sCuttedAudioDir, sProcessedAudioName(1: iIdxSlash(end-1)-1), '\'];
        
        mkdir(sCuttedAudioSubDir);
        
        lProcessedAudioSubList_00 = dir(sProcessedAudioSubDir_00);
        lProcessedAudioSubList_00 = lProcessedAudioSubList_00(3:end);

        
        lProcessedAudioSubList_01 = dir(sProcessedAudioSubDir_01);
        lProcessedAudioSubList_01 = lProcessedAudioSubList_01(3:end);

        lProcessedAudioSubList_02 = dir(sProcessedAudioSubDir_02);
        lProcessedAudioSubList_02 = lProcessedAudioSubList_02(3:end);
        
        iCountProcessedSub = length(lProcessedAudioSubList_00);
        
        for j = 1: iCountProcessedSub
            sAudioFilename = lProcessedAudioSubList_00(j).name;
            sCuttedAudioSubSubDir = [sCuttedAudioSubDir, sAudioFilename(1:end-4),'\'];
            
            mkdir(sCuttedAudioSubSubDir);
            
            sProcessedAudioFullFilename_00 = [sProcessedAudioSubDir_00, lProcessedAudioSubList_00(j).name];
            [fProcessedAudio_00,fs] = audioread(sProcessedAudioFullFilename_00);
            
            sProcessedAudioFullFilename_01 = [sProcessedAudioSubDir_01, lProcessedAudioSubList_01(j).name];
            [fProcessedAudio_01,fs] = audioread(sProcessedAudioFullFilename_01);
            
            sProcessedAudioFullFilename_02 = [sProcessedAudioSubDir_02, lProcessedAudioSubList_02(j).name];
            [fProcessedAudio_02,fs] = audioread(sProcessedAudioFullFilename_02);            


            fProcessedAudio_00 = fProcessedAudio_00(1+iLeadingSilence : end);
            iProcessedAudioLength_00 = length(fProcessedAudio_00);
            fProcessedAudio_01 = fProcessedAudio_01(1+iLeadingSilence : end);
            iProcessedAudioLength_01 = length(fProcessedAudio_01);
            fProcessedAudio_02 = fProcessedAudio_02(1+iLeadingSilence : end);
            iProcessedAudioLength_02 = length(fProcessedAudio_02);            
            
                
            iOffset_00 = 0;
            iOffset_01 = 0;
            iOffset_02 = 0;
            
            for k = 1:iCountWuW/3

                sWuWRecordingFilename_00 = lWuWRecordingList(k).name;
                sWuWRecordingFullFilename_00 = [sOriginalRecordingsDir, sWuWRecordingFilename_00,'\ch0.wav'];
                [fOriginalAudio_00, ~] = audioread(sWuWRecordingFullFilename_00);

                [fCuttedProcessedAudio_00, iOffset_00] = CutUtterance(fProcessedAudio_00, fOriginalAudio_00, iOffset_00, iProcessedAudioLength_00);

                sCuttedAudioFullFilename_00 = [sCuttedAudioSubSubDir, sWuWRecordingFilename_00,'.wav'];
                audiowrite(sCuttedAudioFullFilename_00, fCuttedProcessedAudio_00, fs);

                sWuWRecordingFilename_01 = lWuWRecordingList(k + iCountWuW/3).name;
                sWuWRecordingFullFilename_01 = [sOriginalRecordingsDir, sWuWRecordingFilename_01,'\ch0.wav'];
                [fOriginalAudio_01, ~] = audioread(sWuWRecordingFullFilename_01);

                [fCuttedProcessedAudio_01, iOffset_01] = CutUtterance(fProcessedAudio_01, fOriginalAudio_01, iOffset_01, iProcessedAudioLength_01);

                sCuttedAudioFullFilename_01 = [sCuttedAudioSubSubDir, sWuWRecordingFilename_01,'.wav'];
                audiowrite(sCuttedAudioFullFilename_01, fCuttedProcessedAudio_01, fs);                
                
                sWuWRecordingFilename_02 = lWuWRecordingList(k + iCountWuW/3*2).name;
                sWuWRecordingFullFilename_02 = [sOriginalRecordingsDir, sWuWRecordingFilename_02,'\ch0.wav'];
                [fOriginalAudio_02, ~] = audioread(sWuWRecordingFullFilename_02);

                [fCuttedProcessedAudio_02, iOffset_02] = CutUtterance(fProcessedAudio_02, fOriginalAudio_02, iOffset_02, iProcessedAudioLength_02);

                sCuttedAudioFullFilename_02 = [sCuttedAudioSubSubDir, sWuWRecordingFilename_02,'.wav'];
                audiowrite(sCuttedAudioFullFilename_02, fCuttedProcessedAudio_02, fs);   
                
%                 disp([int2str(k), 'th of ',int2str(iCountWuW/3),' WuW Utterances Cutted and Saved']);

            end
        end
    end
end