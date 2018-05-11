function CutAndSaveUtterancesAlternative(sOriginalRecordingsDir, sProcessedAudioDir, sCuttedAudioDir_180D, sCuttedAudioDir_300D, iLeadingSilence)

    if ~exist(sCuttedAudioDir_180D,'dir')
        mkdir(sCuttedAudioDir_180D);
    end
    if ~exist(sCuttedAudioDir_300D,'dir')
        mkdir(sCuttedAudioDir_300D);
    end

    lWuWRecordingList = dir(sOriginalRecordingsDir);
    lWuWRecordingList = lWuWRecordingList(3:end);
    iCountWuW = length(lWuWRecordingList);

    iOffset = 0;


    for k = 1:2
    
        for j = 1:4

            sProcessedAudioFullFilename = [sProcessedAudioDir,'\WuWxatx_0',char(j-1),'\sseout',char(k),'.wav'];
            [fProcessedAudio,fs] = audioread(sProcessedAudioFullFilename);
            
            fProcessedAudio = fProcessedAudio(1+iLeadingSilence : end);
            iProcessedAudioLength = length(fProcessedAudio);
            
            for i = 1:iSubCountWuW

                sWuWRecordingFilename = lWuWRecordingList(i).name;
                sWuWRecordingFullFilename = [sOriginalRecordingsDir, sWuWRecordingFilename];
                [fOriginalAudio, ~] = audioread(sWuWRecordingFullFilename);

                [fCuttedProcessedAudio, iOffset] = CutUtterance(fProcessedAudio, fOriginalAudio, iOffset, iProcessedAudioLength);
                sCuttedAudioFullFilename_180D = [sCuttedAudioDir_180D, sWuWRecordingFilename];
                audiowrite(sCuttedAudioFullFilename_180D, fCuttedProcessedAudio, fs);
                
                [fCuttedProcessedAudio, iOffset] = CutUtterance(fProcessedAudio, fOriginalAudio, iOffset, iProcessedAudioLength);
                sCuttedAudioFullFilename_300D = [sCuttedAudioDir_300D, sWuWRecordingFilename];
                audiowrite(sCuttedAudioFullFilename_300D, fCuttedProcessedAudio, fs);

                disp([char(i), 'th of ',char(iCountWuW),' WuW Utterances Cutted and Saved']);

            end

        end
    end
end