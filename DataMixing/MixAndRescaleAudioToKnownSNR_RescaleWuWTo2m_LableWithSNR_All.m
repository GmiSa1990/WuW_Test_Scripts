clear all;
clc;
warning('OFF');

%--------------------------------------------------------------------------
% It is prefered to have all WuW recordings arranged like:
% - XXX_Room_XXX_Walls
%   - 180_Degree
%     - 2m
%     - 3m
%     - 4m
%     - 5m
%   - 300_Degree
%     - 2m
%     - 3m
%     - 4m
%     - 5m
% Please give XXX\XXX_Room_XXX_Walls\180_Degree\Xm\ to Folder variants
% In all, 1000 utterances for each degree and distance, about 30min.
% So about 30min for each WuW recordings.
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% It is prefered to have all Interference recordings arranged like:
% - XXX_Room_XXX_Walls
%   - 60_Degree
%     - SoftMusic_VolXX
%     - RockMusic_VolXX
%     - Speech_VolXX
% Please give XXX\XXX_Room_XXX_Walls\60_Degree\ to Folder variants
% Interference will loop to the length of WuW.
% Every interference recording will contain one song.
%--------------------------------------------------------------------------

sWuWRecordingsFolder = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_Recordings_LSilence\SH_RoomWuTaiShan\';
sInterferenceFolder = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\Interference_Recordings_Rescaled_Part\';
sInterferedFolder = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_Interfered\SH_RoomWuTaiShan\';

iWuWDistanceMax = 4;

%sAngleLabel = 'm_180D300D\';
sAngleLabel = 'm_300D\';

mkdir(sInterferedFolder);

%--------------------------------------------------------------------------
% Scale Interference
% Scaling factor will remain unchanged for 3-5m
%--------------------------------------------------------------------------
iDesiredSNR = [8,5,1];
fDesiredSNRLinear = 10.^(iDesiredSNR./20);


%--------------------------------------------------------------------------

iSmoothWindow = 10;      %For Speech Detection, don't change
iNoiseToleration = 10;   %For Speech Detection, don't change

%--------------------------------------------------------------------------
% Scale Interference with 2m WuW Level
% Scaling factor change for 3-5m
%--------------------------------------------------------------------------

sInterferenceFolder_S = [sInterferenceFolder,'Speech'];  %Add subfolder name to ''
sInterferenceFolder_RM = [sInterferenceFolder,'RockMusic']; %Add subfolder name to ''
sInterferenceFolder_SM = [sInterferenceFolder,'SoftMusic']; %Add subfolder name to ''

sRockMusicInput_Criteria = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\Interference_Rescaled_Criteria\Sax\';

fAverageRMS_RM = CalculateRMS_Music_7ch(sRockMusicInput_Criteria);

lInterferenceList = dir(sInterferenceFolder);
lInterferenceList = lInterferenceList(3:end);
iCountInterSubFolder = length(lInterferenceList);

for snr = 1 : length(iDesiredSNR)

    sDesireFolder_SNR = [sInterferedFolder,'SNR',num2str(iDesiredSNR(snr)),'dB\'];
    mkdir(sDesireFolder_SNR)

    for i = 2:iWuWDistanceMax
        sWuWRecordingSubFolder = [sWuWRecordingsFolder,num2str(i),sAngleLabel];
        lWuWRecordingSubList = dir(sWuWRecordingSubFolder);
        lWuWRecordingSubList = lWuWRecordingSubList(3:end);
        iCountWuW = length(lWuWRecordingSubList);  % = 1

        sDesiredFolder = [sDesireFolder_SNR,num2str(i),sAngleLabel];    
        mkdir(sDesiredFolder);

        if i == 2   %Rescale to 2m speech
            fSpeechBlkCh0 = [];
            fSpeechBlkCh1 = [];
            fSpeechBlkCh2 = [];
            fSpeechBlkCh3 = [];
            fSpeechBlkCh4 = [];
            fSpeechBlkCh5 = [];
            fSpeechBlkCh6 = [];
            for ii = 1 : iCountWuW
                sWuWRecordingSubFolder = [lWuWRecordingSubList(ii).folder,'\',lWuWRecordingSubList(ii).name];
                [fSpeechBlkCh0_tmp, fSpeechBlkCh1_tmp, fSpeechBlkCh2_tmp, fSpeechBlkCh3_tmp, fSpeechBlkCh4_tmp, fSpeechBlkCh5_tmp, fSpeechBlkCh6_tmp] =...
                    DetectSpeechBlk_WuWSpeech_7ch(sWuWRecordingSubFolder);
                fSpeechBlkCh0 = [fSpeechBlkCh0, fSpeechBlkCh0_tmp];
                fSpeechBlkCh1 = [fSpeechBlkCh1, fSpeechBlkCh1_tmp];
                fSpeechBlkCh2 = [fSpeechBlkCh2, fSpeechBlkCh2_tmp];
                fSpeechBlkCh3 = [fSpeechBlkCh3, fSpeechBlkCh3_tmp];
                fSpeechBlkCh4 = [fSpeechBlkCh4, fSpeechBlkCh4_tmp];
                fSpeechBlkCh5 = [fSpeechBlkCh5, fSpeechBlkCh5_tmp];
                fSpeechBlkCh6 = [fSpeechBlkCh6, fSpeechBlkCh6_tmp];
            end

            fInputCh0_RMS = sqrt(mean(fSpeechBlkCh0));
            fInputCh1_RMS = sqrt(mean(fSpeechBlkCh1));
            fInputCh2_RMS = sqrt(mean(fSpeechBlkCh2));
            fInputCh3_RMS = sqrt(mean(fSpeechBlkCh3));
            fInputCh4_RMS = sqrt(mean(fSpeechBlkCh4));
            fInputCh5_RMS = sqrt(mean(fSpeechBlkCh5));
            fInputCh6_RMS = sqrt(mean(fSpeechBlkCh6));

            fAllRMSs = [fInputCh0_RMS,fInputCh1_RMS,fInputCh2_RMS,fInputCh3_RMS,fInputCh4_RMS,fInputCh5_RMS,fInputCh6_RMS];
            [fAverageRMS ,~] = max(fAllRMSs);


            %fScaleFactor_RM2WuW = fAverageRMS./fAverageRMS_RM./fDesiredSNRLinear;
            fScaleFactor_RM2WuW = fDesiredSNRLinear(snr).*fAverageRMS_RM./fAverageRMS; %To scale up WuW instead of Interference

        end

        for ii = 1:iCountWuW

        sCurrentWuWFolder = [lWuWRecordingSubList(ii).folder,'\',lWuWRecordingSubList(ii).name];

            for j = 1:iCountInterSubFolder
                sInterSubFolder = [lInterferenceList(j).folder,'\', lInterferenceList(j).name];
                lInterSubSubFolder = dir(sInterSubFolder);
                lInterSubSubFolder = lInterSubSubFolder(3:end);
                iCountInter = length(lInterSubSubFolder);

                for jj = 1:iCountInter

                    sCurrentInterFolder = [lInterSubSubFolder(jj).folder, '\', lInterSubSubFolder(jj).name];

                    sDesiredFolder = [sDesireFolder_SNR,num2str(i),sAngleLabel,lInterferenceList(j).name];
                    mkdir(sDesiredFolder);
                    sDesiredFolder = [sDesiredFolder,'\',lInterSubSubFolder(jj).name];
                    mkdir(sDesiredFolder);
    %                 sDesiredFolder = [sDesiredFolder,'\',lWuWRecordingSubList(ii).name];
    %                 mkdir(sDesiredFolder);

                    %MixLoopInterference(sCurrentWuWFolder, sCurrentInterFolder, fScaleFactor_RM2WuW, sDesiredFolder, lWuWRecordingSubList(ii).name);
                    MixLoopInterference_ScaleUpWuW(sCurrentWuWFolder, sCurrentInterFolder, fScaleFactor_RM2WuW, sDesiredFolder, lWuWRecordingSubList(ii).name);

                    disp(['Interfered ', sDesiredFolder]);
                end
            end
        end

    end
end