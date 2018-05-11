clear;clc;

%% For Cutting Recording with ONE Angle

sOriginalRecordingsDir = 'C:\NuanceSSE\RD\7MicUCACArray_SSE4pxTesting_ASRTest\xatx_WuTaiShan_WuWRecordings_20180227\xatx_2m_300D\';
sProcessedAudioDir     = 'C:\NuanceSSE\RD\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessed\SH_RoomWuTaiShan\';
sCuttedAudioDir        = 'C:\NuanceSSE\RD\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessedCutted\SH_RoomWuTaiShan\';
sRecordedCleanDir      = 'C:\NuanceSSE\RD\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessed\SH_RoomWuTaiShan\NoSSEProcessing\Clean\';
sCuttedNoProcessingAudioDir = 'C:\NuanceSSE\RD\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessedCutted\SH_RoomWuTaiShan\NoSSEProcessing\';

% iSNR = [8, 5, 1];
sProcessLable = ['7Mic2Out';'7Mic1Out';'1Mic1Out'];

for i_sProcessLable = 1 : size(sProcessLable,1)
    
    sProcessedAudioSubDir = [sProcessedAudioDir, sProcessLable(i_sProcessLable,:), '\'];
    sCuttedAudioSubDir = [sCuttedAudioDir, sProcessLable(i_sProcessLable,:), '\'];
    
    mkdir(sCuttedAudioSubDir);
    
%     %Cut Clean Processed Audio
%     for i_iSNR = 1 : length(iSNR)
% 
%         sProcessedAudioSubSubDir = [sProcessedAudioSubDir, 'SNR', int2str(iSNR(i_iSNR)), 'dB\'];
%         sCuttedAudioSubSubDir = [sCuttedAudioSubDir, 'SNR', int2str(iSNR(i_iSNR)), 'dB\'];
%         
%         mkdir(sProcessedAudioSubSubDir);
%         mkdir(sCuttedAudioSubSubDir);
% 
%         iLeadingSilence = 60000;
% 
%         if ~exist(sCuttedAudioDir,'dir')
%             mkdir(sCuttedAudioDir);
%         end
% 
%         CutAndSaveUtterances(sOriginalRecordingsDir, sProcessedAudioSubSubDir, sCuttedAudioSubSubDir, iLeadingSilence);
%     end
    
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



%Cut NoSSEProcessingAudio

sCuttedAudioSubSubDir = [sCuttedNoProcessingAudioDir, 'Clean\'];

mkdir(sCuttedAudioSubSubDir);

iLeadingSilence = 60000;

if ~exist(sCuttedAudioDir,'dir')
    mkdir(sCuttedAudioDir);
end

CutAndSaveUtterances_NoProcessing(sOriginalRecordingsDir, sRecordedCleanDir, sCuttedAudioSubSubDir, iLeadingSilence);


