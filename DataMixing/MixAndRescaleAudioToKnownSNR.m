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
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% It is prefered to have all Interference recordings arranged like:
% - XXX_Room_XXX_Walls
%   - 60_Degree
%     - SoftMusic_VolXX
%     - RockMusic_VolXX
%     - ComicDialog_VolXX
%     - Speech_VolXX
% Please give XXX\XXX_Room_XXX_Walls\60_Degree\ to Folder variants
%--------------------------------------------------------------------------

sWuWRecordingsFolder = '';
sInterferenceFolder = '';
sInterferedFolder = '';

mkdir(sInterferedFolder);

%--------------------------------------------------------------------------
% Scale Interference
% Scaling factor change for 3-5m
%--------------------------------------------------------------------------
iDesiredSNR = 0;
fDesiredSNRLinear = 10.^(iDesiredSNR./20);


%--------------------------------------------------------------------------

iSmoothWindow = 10;      %For Speech Detection, don't change
iNoiseToleration = 10;   %For Speech Detection, don't change

sInterferenceFolder_CD = [sInterferenceFolder,''];
sInterferenceFolder_S = [sInterferenceFolder,''];
sInterferenceFolder_RM = [sInterferenceFolder,''];
sInterferenceFolder_SM = [sInterferenceFolder,''];

fAverageRMS_RM = CalculateRMS_Music_7ch(sInterferenceFolder_RM);

lInterferenceList = dir(sInterferenceFolder);
lInterferenceList = lInterferenceList(3:end);
iCountInterSubFolder = length(lInterferenceList);

sDesireFolder_SNR = [sInterferedFolder,'SNR',num2str(iDesiredSNR),'dB\'];
    
for i = 2:5
    sWuWRecordingSubFolder = [sWuWRecordingsFolder,num2str(i),'m\'];
    lWuWRecordingSubList = dir(sWuWRecordingSubFolder);
    lWuWRecordingSubList = lWuWRecordingSubList(3:end);
    iCountWuW = length(lWuWRecordingSubList);

    sDesiredFolder = [sDesireFolder_SNR,num2str(i),'m\'];    
    mkdir(sDesiredFolder);
    
    for ii = 1:iCountWuW
    
        sCurrentFolder = [lWuWRecordingSubList(ii).folder,'\',lWuWRecordingSubList(ii).name];
        fAverageRMS_WuW = CalculateRMS_Speech_7ch(sCurrentFolder);

        fScaleFactor_RM2WuW = fAverageRMS_WuW./fAverageRMS_RM./fDesiredSNRLinear;

        [fWuWAudioCh0,fWuWAudioCh1,fWuWAudioCh2,fWuWAudioCh3,fWuWAudioCh4,fWuWAudioCh5,fWuWAudioCh6] =...
                Rescale_Digital(sCurrentFolder, fScaleFactor_RM2WuW);

        for j = 1:iCountInterSubFolder
            sInterSubFolder = [lInterferenceList(j).folder, lInterferenceList(j).name,'\'];
            lInterSubSubFolder = dir(sInterSubFolder);
            lInterSubSubFolder = lInterSubSubFolder(3:end);
            iCountInter = length(lInterSubSubFolder);
            
            for jj = 1:iCountInter
                
                sCurrentFolder = [lInterSubSubFolder(jj).folder, lInterSubSubFolder(jj).name, '\'];
                
                [fInterAudioCh0,fInterAudioCh1,fInterAudioCh2,fInterAudioCh3,fInterAudioCh4,fInterAudioCh5,fInterAudioCh6] =...
                    Rescale_Digital(sCurrentFolder, fScaleFactor_RM2WuW);

                fMixAudioCh0 = LoopInterferenceWithWuW(fWuWAudioCh0,fInterAudioCh0);
                fMixAudioCh1 = LoopInterferenceWithWuW(fWuWAudioCh1,fInterAudioCh1);
                fMixAudioCh2 = LoopInterferenceWithWuW(fWuWAudioCh2,fInterAudioCh2);
                fMixAudioCh3 = LoopInterferenceWithWuW(fWuWAudioCh3,fInterAudioCh3);
                fMixAudioCh4 = LoopInterferenceWithWuW(fWuWAudioCh4,fInterAudioCh4);
                fMixAudioCh5 = LoopInterferenceWithWuW(fWuWAudioCh5,fInterAudioCh5);
                fMixAudioCh6 = LoopInterferenceWithWuW(fWuWAudioCh6,fInterAudioCh6);
                
                sDesiredFolder = [sDesireFolder_SNR,num2str(i),'m\',lInterSubSubFolder(jj).name,'_',lWuWRecordingSubList(ii).name,'\'];
                mkdir(sDesiredFolder);
                
                sMixAudioFileNameCh0 = [sDesiredFolder,'ch0.wav'];
                sMixAudioFileNameCh1 = [sDesiredFolder,'ch1.wav'];
                sMixAudioFileNameCh2 = [sDesiredFolder,'ch2.wav'];
                sMixAudioFileNameCh3 = [sDesiredFolder,'ch3.wav'];
                sMixAudioFileNameCh4 = [sDesiredFolder,'ch4.wav'];
                sMixAudioFileNameCh5 = [sDesiredFolder,'ch5.wav'];
                sMixAudioFileNameCh6 = [sDesiredFolder,'ch6.wav'];
                
                audiowite(sMixAudioFileNameCh0,fMixAudioCh0,16000);
                audiowite(sMixAudioFileNameCh1,fMixAudioCh1,16000);
                audiowite(sMixAudioFileNameCh2,fMixAudioCh2,16000);
                audiowite(sMixAudioFileNameCh3,fMixAudioCh3,16000);
                audiowite(sMixAudioFileNameCh4,fMixAudioCh4,16000);
                audiowite(sMixAudioFileNameCh5,fMixAudioCh5,16000);
                audiowite(sMixAudioFileNameCh6,fMixAudioCh6,16000);
                
            end
        end
    end
    
end
    