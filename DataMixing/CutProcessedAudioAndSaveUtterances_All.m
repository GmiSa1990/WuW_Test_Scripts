clear; clc;

%% Cutting Recording

sOriginalRecordingsDir = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\xatx_WuTaiShan_WuWRecordings_20180227\xatx_2m_300D\';
sProcessedAudioDir     = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessed\SH_RoomWuTaiShan2\';
sCuttedAudioDir        = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessedCutted\SH_RoomWuTaiShan2\';

sProcessLable = {'7Mic1Out'};
%sProcessLable = {'7Mic2Out_SSE4p1','7Mic2Out_SSE4p2'};
sSNR          = {'SNR8dB'}; %,'SNR5dB','SNR1dB'

for i_sProcessLable = 1% : length(sProcessLable)
    
    sProcessedAudioSubDir = [sProcessedAudioDir, sProcessLable{i_sProcessLable}, '\'];
    sCuttedAudioSubDir    = [sCuttedAudioDir   , sProcessLable{i_sProcessLable}, '\'];
    
    mkdir(sCuttedAudioSubDir);
    
    %Cut Clean Processed Audio
    if 0
        for i_sSNR = 1 : length(sSNR)

            sProcessedAudioSubSubDir = [sProcessedAudioSubDir, sSNR{i_sSNR}, '\'];
            sCuttedAudioSubSubDir    = [sCuttedAudioSubDir   , sSNR{i_sSNR}, '\'];

            mkdir(sProcessedAudioSubSubDir);
            mkdir(sCuttedAudioSubSubDir);

            iLeadingSilence = 60000;

            if ~exist(sCuttedAudioDir,'dir')
                mkdir(sCuttedAudioDir);
            end

            CutAndSaveUtterances(sOriginalRecordingsDir, sProcessedAudioSubSubDir, sCuttedAudioSubSubDir, iLeadingSilence);
        end
    end
    
    %Cut Clean Processed Audio
    sProcessedAudioSubSubDir = [sProcessedAudioSubDir, 'Clean\'];
    sCuttedAudioSubSubDir = [sCuttedAudioSubDir, 'Clean\'];

    mkdir(sCuttedAudioSubSubDir);

    iLeadingSilence = 60000;

    if ~exist(sCuttedAudioDir,'dir')
        mkdir(sCuttedAudioDir);
    end

    CutAndSaveUtterances_Clean(sOriginalRecordingsDir, sProcessedAudioSubSubDir, sCuttedAudioSubSubDir, iLeadingSilence);
    
    
end


if 0
    sRecordedCleanDir      = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessed\SH_RoomWuTaiShan\NoSSEProcessing\Clean\';
    sCuttedNoProcessingAudioDir = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessedCutted\SH_RoomWuTaiShan\NoSSEProcessing\';
    %Cut NoSSEProcessingAudio

    sCuttedAudioSubSubDir = [sCuttedNoProcessingAudioDir, 'Clean\'];

    mkdir(sCuttedAudioSubSubDir);

    iLeadingSilence = 60000;

    if ~exist(sCuttedAudioDir,'dir')
        mkdir(sCuttedAudioDir);
    end

    CutAndSaveUtterances_NoProcessing(sOriginalRecordingsDir, sRecordedCleanDir, sCuttedAudioSubSubDir, iLeadingSilence);
end

