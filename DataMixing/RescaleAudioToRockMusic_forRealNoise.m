clear; clc; warning('OFF');

sInterferenceFolder = 'C:\sse\iot_test\recording\';                %
sScaledInterferenceFolder = 'C:\sse\iot_test\recording\';          %

%--------------------------------------------------------------------------
% Calculate average RMS for all recordings
%--------------------------------------------------------------------------

sRealNoiseInputFolder = 'RealNoise';     % Add subfolder name to ''
sRealNoiseOutputFolder = 'RealNoise_rescaled';    % Add subfolder name to ''


sRockMusicInput_Criteria = 'C:\sse\iot_test\recording\Interference_Rescaled_Criteria\Sax\';

fAverageRMS_RockMusic_Criteria = CalculateRMS_Music_7ch(sRockMusicInput_Criteria);

lInterferenceList = dir([sInterferenceFolder, sRealNoiseInputFolder]);
lInterferenceList = lInterferenceList(3:end);
iCountInterSubFolder = length(lInterferenceList);

for i = 1:iCountInterSubFolder

    sInterferenceFileName = [lInterferenceList(i).folder,'\',lInterferenceList(i).name];
    fAverageRMS_RealNoise = CalculateRMS_Music_7ch(sInterferenceFileName);
    fScaleFactor_SM2RM = fAverageRMS_RockMusic_Criteria./fAverageRMS_RealNoise;
    
    sRescaledFileName = [sScaledInterferenceFolder,sRealNoiseOutputFolder,'\',lInterferenceList(i).name];
    mkdir(sRescaledFileName);

    AudioRescale(sInterferenceFileName,sRescaledFileName,fScaleFactor_SM2RM);
    
    disp(['Rescaling file ',lInterferenceList(i).name])
end


