function MixLoopInterference_ScaleUpWuW(sCurrentWuWFolder, sCurrentInterFolder, fScaleFactor_RM2WuW, sDesiredFolder, WuWRecordingSubListName)

[fWuWAudioCh0, fWuWAudioCh1, fWuWAudioCh2, fWuWAudioCh3, fWuWAudioCh4, fWuWAudioCh5, fWuWAudioCh6] = ...
    Rescale_Digital(sCurrentWuWFolder, fScaleFactor_RM2WuW);

[fs, fInterAudioCh0,fInterAudioCh1,fInterAudioCh2,fInterAudioCh3,fInterAudioCh4,fInterAudioCh5,fInterAudioCh6] =...
    ReadAudio_Digital(sCurrentInterFolder);

fRMSWuW = CalculateRMS_Speech_DigitalAudio_7ch(fWuWAudioCh0, fWuWAudioCh1, fWuWAudioCh2, fWuWAudioCh3, fWuWAudioCh4, fWuWAudioCh5, fWuWAudioCh6);

if contains(sCurrentInterFolder,'Music')
    fRMSInterference = CalculateRMS_Music_DigitalAudio_7ch(fInterAudioCh0,fInterAudioCh1,fInterAudioCh2,fInterAudioCh3,fInterAudioCh4,fInterAudioCh5,fInterAudioCh6);
elseif contains(sCurrentInterFolder,'Speech')
    fRMSInterference = CalculateRMS_Speech_DigitalAudio_7ch(fInterAudioCh0,fInterAudioCh1,fInterAudioCh2,fInterAudioCh3,fInterAudioCh4,fInterAudioCh5,fInterAudioCh6);
else
    disp('Error');
end
    
iSNR = round(20.*log10(fRMSWuW./fRMSInterference));
    
sDesiredFolder = [sDesiredFolder,'\',WuWRecordingSubListName,'_',int2str(iSNR),'dBSNR'];
mkdir(sDesiredFolder);

fMixAudioCh0 = LoopInterferenceWithWuW(fWuWAudioCh0,fInterAudioCh0);
fMixAudioCh1 = LoopInterferenceWithWuW(fWuWAudioCh1,fInterAudioCh1);
fMixAudioCh2 = LoopInterferenceWithWuW(fWuWAudioCh2,fInterAudioCh2);
fMixAudioCh3 = LoopInterferenceWithWuW(fWuWAudioCh3,fInterAudioCh3);
fMixAudioCh4 = LoopInterferenceWithWuW(fWuWAudioCh4,fInterAudioCh4);
fMixAudioCh5 = LoopInterferenceWithWuW(fWuWAudioCh5,fInterAudioCh5);
fMixAudioCh6 = LoopInterferenceWithWuW(fWuWAudioCh6,fInterAudioCh6);

sMixAudioFileNameCh0 = [sDesiredFolder,'\ch0.wav'];
sMixAudioFileNameCh1 = [sDesiredFolder,'\ch1.wav'];
sMixAudioFileNameCh2 = [sDesiredFolder,'\ch2.wav'];
sMixAudioFileNameCh3 = [sDesiredFolder,'\ch3.wav'];
sMixAudioFileNameCh4 = [sDesiredFolder,'\ch4.wav'];
sMixAudioFileNameCh5 = [sDesiredFolder,'\ch5.wav'];
sMixAudioFileNameCh6 = [sDesiredFolder,'\ch6.wav'];

audiowrite(sMixAudioFileNameCh0,fMixAudioCh0,fs);
audiowrite(sMixAudioFileNameCh1,fMixAudioCh1,fs);
audiowrite(sMixAudioFileNameCh2,fMixAudioCh2,fs);
audiowrite(sMixAudioFileNameCh3,fMixAudioCh3,fs);
audiowrite(sMixAudioFileNameCh4,fMixAudioCh4,fs);
audiowrite(sMixAudioFileNameCh5,fMixAudioCh5,fs);
audiowrite(sMixAudioFileNameCh6,fMixAudioCh6,fs);

sScaledWuWFileNameCh0 = [sDesiredFolder,'\WuWRescaled_ch0.wav'];
sScaledWuWFileNameCh1 = [sDesiredFolder,'\WuWRescaled_ch1.wav'];
sScaledWuWFileNameCh2 = [sDesiredFolder,'\WuWRescaled_ch2.wav'];
sScaledWuWFileNameCh3 = [sDesiredFolder,'\WuWRescaled_ch3.wav'];
sScaledWuWFileNameCh4 = [sDesiredFolder,'\WuWRescaled_ch4.wav'];
sScaledWuWFileNameCh5 = [sDesiredFolder,'\WuWRescaled_ch5.wav'];
sScaledWuWFileNameCh6 = [sDesiredFolder,'\WuWRescaled_ch6.wav'];

audiowrite(sScaledWuWFileNameCh0,fWuWAudioCh0,fs);
audiowrite(sScaledWuWFileNameCh1,fWuWAudioCh1,fs);
audiowrite(sScaledWuWFileNameCh2,fWuWAudioCh2,fs);
audiowrite(sScaledWuWFileNameCh3,fWuWAudioCh3,fs);
audiowrite(sScaledWuWFileNameCh4,fWuWAudioCh4,fs);
audiowrite(sScaledWuWFileNameCh5,fWuWAudioCh5,fs);
audiowrite(sScaledWuWFileNameCh6,fWuWAudioCh6,fs);

end