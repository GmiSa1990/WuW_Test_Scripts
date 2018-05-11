clear all;
clc;
warning('OFF');

%--------------------------------------------------------------------------
% It is prefered to have all Interference recordings arranged like:
% - XXX_Room_XXX_Walls
%   - 60_Degree
%     - SoftMusic_VolXX
%     - RockMusic_VolXX
%     - Speech_VolXX
% Please give XXX\XXX_Room_XXX_Walls\60_Degree\ to Folder variants.
% Each folder contains more than 1 interference recordings
%--------------------------------------------------------------------------

sInterferenceFolder = 'C:\NuanceSSE\RD\7MicUCACArray_SSE4pxTesting_ASRTest\Interference_Recordings\';                %
%sScalingFactorInterferenceFolder = '';   % It is prefered to have Rock Music recording as desired Scaling Factor recordings
sScaledInterferenceFolder = 'C:\NuanceSSE\RD\7MicUCACArray_SSE4pxTesting_ASRTest\Interference_Recordings_Rescaled\';          %

%--------------------------------------------------------------------------
% Calculate average RMS for all recordings
%--------------------------------------------------------------------------

sSoftMusicInputFolder = 'SoftMusic';     % Add subfolder name to ''
sRockMusicInputFolder = 'RockMusic';     % Add subfolder name to ''
%sComicDialogInputFolder = '';  % Add subfolder name to ''
sSpeechInputFolder = 'Speech';        % Add subfolder name to ''

sSoftMusicOutputFolder = 'SoftMusic';    % Add subfolder name to ''
sRockMusicOutputFolder = 'RockMusic';    % Add subfolder name to ''
%sComicDialogOutputFolder = ''; % Add subfolder name to ''
sSpeechOutputFolder = 'Speech';       % Add subfolder name to ''


sRockMusicInput_Criteria = 'C:\NuanceSSE\RD\7MicUCACArray_SSE4pxTesting_ASRTest\Interference_Recordings\RockMusic\Sax\';

fAverageRMS_RockMusic_Criteria = CalculateRMS_Music_7ch(sRockMusicInput_Criteria);

lInterferenceList = dir([sInterferenceFolder, sSoftMusicInputFolder]);
lInterferenceList = lInterferenceList(3:end);
iCountInterSubFolder = length(lInterferenceList);

for i = 1:iCountInterSubFolder

    sInterferenceFileName = [lInterferenceList(i).folder,'\',lInterferenceList(i).name];
    fAverageRMS_SoftMusic = CalculateRMS_Music_7ch(sInterferenceFileName);
    fScaleFactor_SM2RM = fAverageRMS_RockMusic_Criteria./fAverageRMS_SoftMusic;
    
    sRescaledFileName = [sScaledInterferenceFolder,sSoftMusicOutputFolder,'\',lInterferenceList(i).name];
    mkdir(sRescaledFileName);

    AudioRescale(sInterferenceFileName,sRescaledFileName,fScaleFactor_SM2RM);
    
    disp(['Rescaling file ',lInterferenceList(i).name])
end


lInterferenceList = dir([sInterferenceFolder, sRockMusicInputFolder]);
lInterferenceList = lInterferenceList(3:end);
iCountInterSubFolder = length(lInterferenceList);

for i = 1:iCountInterSubFolder

    sInterferenceFileName = [lInterferenceList(i).folder,'\',lInterferenceList(i).name];
    fAverageRMS_RockMusic = CalculateRMS_Music_7ch(sInterferenceFileName);
    fScaleFactor_RM2RM = fAverageRMS_RockMusic_Criteria./fAverageRMS_RockMusic;

    sRescaledFileName = [sScaledInterferenceFolder,sRockMusicOutputFolder,'\',lInterferenceList(i).name];
    mkdir(sRescaledFileName);
    
    AudioRescale(sInterferenceFileName,sRescaledFileName,fScaleFactor_RM2RM);
    
    disp(['Rescaling file ',lInterferenceList(i).name])
end


lInterferenceList = dir([sInterferenceFolder, sSpeechInputFolder]);
lInterferenceList = lInterferenceList(3:end);
iCountInterSubFolder = length(lInterferenceList);

for i = 1:iCountInterSubFolder

    sInterferenceFileName = [lInterferenceList(i).folder,'\',lInterferenceList(i).name];
    fAverageRMS_Speech = CalculateRMS_Speech_7ch(sInterferenceFileName);
    fScaleFactor_S2RM = fAverageRMS_RockMusic_Criteria./fAverageRMS_Speech;

    sRescaledFileName = [sScaledInterferenceFolder,sSpeechOutputFolder,'\',lInterferenceList(i).name];
    mkdir(sRescaledFileName);
    
    AudioRescale(sInterferenceFileName,sRescaledFileName,fScaleFactor_S2RM);
    
    disp(['Rescaling file ',lInterferenceList(i).name])
end

