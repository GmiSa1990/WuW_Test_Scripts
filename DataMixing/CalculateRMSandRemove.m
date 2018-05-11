clear all; clc;
warning('OFF');

iSmoothWin = 10;
iNoiseTol = 10;

iRMSUpTol = -25;
iRMSDownTol = -32;

% fSNR = zeros(1050,1);

raw_audio_location = 'D:\SpeechOcean_HeadsetRec_XATX\xatx_1050_mono_16k\';
recorded_audio_location_00 = 'D:\SpeechOcean_HeadsetRec_XATX\xatx_WuWRecordings_1000\xatx_WuTaiShan_WuWRecordings_20180227\';
recorded_audio_location_01 = 'D:\SpeechOcean_HeadsetRec_XATX\xatx_WuWRecordings_1000\xatx_Huangshan_WuWRecordings_20180227\';
recorded_audio_subfolder_00 = 'xatx_2m_180D';
recorded_audio_subfolder_01 = 'xatx_2m_300D';
recorded_audio_subfolder_02 = 'xatx_3m_180D';
recorded_audio_subfolder_03 = 'xatx_3m_300D';
recorded_audio_subfolder_04 = 'xatx_4m_180D';
recorded_audio_subfolder_05 = 'xatx_4m_300D';
recorded_audio_subfolder_06 = 'xatx_5m_180D';
recorded_audio_subfolder_07 = 'xatx_5m_300D';

MicInFileLocationList = dir(raw_audio_location);
MicInFileLocationList = MicInFileLocationList(3:end);
count_micin = length(MicInFileLocationList);

mkdir([recorded_audio_location_00,recorded_audio_subfolder_00]);
mkdir([recorded_audio_location_00,recorded_audio_subfolder_01]);
mkdir([recorded_audio_location_00,recorded_audio_subfolder_02]);
mkdir([recorded_audio_location_00,recorded_audio_subfolder_03]);
mkdir([recorded_audio_location_00,recorded_audio_subfolder_04]);
mkdir([recorded_audio_location_00,recorded_audio_subfolder_05]);
mkdir([recorded_audio_location_00,recorded_audio_subfolder_06]);
mkdir([recorded_audio_location_00,recorded_audio_subfolder_07]);
mkdir([recorded_audio_location_01,recorded_audio_subfolder_00]);
mkdir([recorded_audio_location_01,recorded_audio_subfolder_01]);
mkdir([recorded_audio_location_01,recorded_audio_subfolder_02]);
mkdir([recorded_audio_location_01,recorded_audio_subfolder_03]);
mkdir([recorded_audio_location_01,recorded_audio_subfolder_04]);
mkdir([recorded_audio_location_01,recorded_audio_subfolder_05]);
mkdir([recorded_audio_location_01,recorded_audio_subfolder_06]);
mkdir([recorded_audio_location_01,recorded_audio_subfolder_07]);

for i = 1:count_micin
    speech_location = [raw_audio_location, char(MicInFileLocationList(i).name)];
    
    [micinput_ch0,~] = audioread(speech_location);
    

    L_blks = ceil(length(micinput_ch0) / 256);
    L_zpad = L_blks * 256 - length(micinput_ch0);

    fBlkPwrCh0 = mean(reshape([micinput_ch0;zeros(L_zpad, 1)].^2, 256, L_blks),1);
    fSmBlkPwrCh0 = smoothdata(fBlkPwrCh0,'movmean',iSmoothWin);
    [fLowLimBlkPerCh0,~] = min(fSmBlkPwrCh0);
    iSpeechIndexBlkPwrCh0 = find(fSmBlkPwrCh0 >= fLowLimBlkPerCh0.*iNoiseTol);
    fInputCh0_RMS = sqrt(mean(fBlkPwrCh0(iSpeechIndexBlkPwrCh0)));
    fInputCh0_RMSindB = 20.*log10(fInputCh0_RMS);
    
    disp(' ');
    disp(MicInFileLocationList(i).name);
    disp(['RMS is: ', num2str(fInputCh0_RMSindB),'dBFS']);
%     
%     fSNR(i)= fInputCh0_RMSindB;
    
    desired_recording_folder = char(MicInFileLocationList(i).name);
    desired_recording_folder = desired_recording_folder(1:end-4);
    
    desired_recording_folder_00_00 = [recorded_audio_location_00,recorded_audio_subfolder_00,'\',desired_recording_folder];
    desired_recording_folder_00_01 = [recorded_audio_location_00,recorded_audio_subfolder_01,'\',desired_recording_folder];
    desired_recording_folder_00_02 = [recorded_audio_location_00,recorded_audio_subfolder_02,'\',desired_recording_folder];
    desired_recording_folder_00_03 = [recorded_audio_location_00,recorded_audio_subfolder_03,'\',desired_recording_folder];
    desired_recording_folder_00_04 = [recorded_audio_location_00,recorded_audio_subfolder_04,'\',desired_recording_folder];
    desired_recording_folder_00_05 = [recorded_audio_location_00,recorded_audio_subfolder_05,'\',desired_recording_folder];
    desired_recording_folder_00_06 = [recorded_audio_location_00,recorded_audio_subfolder_06,'\',desired_recording_folder];
    desired_recording_folder_00_07 = [recorded_audio_location_00,recorded_audio_subfolder_07,'\',desired_recording_folder];
    desired_recording_folder_01_00 = [recorded_audio_location_01,recorded_audio_subfolder_00,'\',desired_recording_folder];
    desired_recording_folder_01_01 = [recorded_audio_location_01,recorded_audio_subfolder_01,'\',desired_recording_folder];
    desired_recording_folder_01_02 = [recorded_audio_location_01,recorded_audio_subfolder_02,'\',desired_recording_folder];
    desired_recording_folder_01_03 = [recorded_audio_location_01,recorded_audio_subfolder_03,'\',desired_recording_folder];
    desired_recording_folder_01_04 = [recorded_audio_location_01,recorded_audio_subfolder_04,'\',desired_recording_folder];
    desired_recording_folder_01_05 = [recorded_audio_location_01,recorded_audio_subfolder_05,'\',desired_recording_folder];
    desired_recording_folder_01_06 = [recorded_audio_location_01,recorded_audio_subfolder_06,'\',desired_recording_folder];
    desired_recording_folder_01_07 = [recorded_audio_location_01,recorded_audio_subfolder_07,'\',desired_recording_folder];
    
    if ~exist(desired_recording_folder_00_00,'dir')
        disp('no folder')
        continue
    end
    
    if fInputCh0_RMSindB <= iRMSDownTol || fInputCh0_RMSindB >= iRMSUpTol
        disp('too low or too loud, Remove!')
        sCmd = ['RD /S /Q ', desired_recording_folder_00_00];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_00_01];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_00_02];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_00_03];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_00_04];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_00_05];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_00_06];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_00_07];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_01_00];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_01_01];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_01_02];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_01_03];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_01_04];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_01_05];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_01_06];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_01_07];
        system(sCmd);
    elseif find(micinput_ch0 > 0.98)
        disp('clipped, Remove!')
        sCmd = ['RD /S /Q ', desired_recording_folder_00_00];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_00_01];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_00_02];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_00_03];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_00_04];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_00_05];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_00_06];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_00_07];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_01_00];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_01_01];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_01_02];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_01_03];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_01_04];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_01_05];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_01_06];
        system(sCmd);
        sCmd = ['RD /S /Q ', desired_recording_folder_01_07];
        system(sCmd);
    end
    
end