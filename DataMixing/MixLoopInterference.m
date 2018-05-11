function MixLoopInterference(sCurrentWuWFolder, sCurrentInterFolder, fScaleFactor_RM2WuW, sDesiredFolder, WuWRecordingSubListName)

[fs, fWuWAudioCh0, fWuWAudioCh1, fWuWAudioCh2, fWuWAudioCh3, fWuWAudioCh4, fWuWAudioCh5, fWuWAudioCh6] = ...
    ReadAudio_Digital(sCurrentWuWFolder);

[fInterAudioCh0,fInterAudioCh1,fInterAudioCh2,fInterAudioCh3,fInterAudioCh4,fInterAudioCh5,fInterAudioCh6] =...
    Rescale_Digital(sCurrentInterFolder, fScaleFactor_RM2WuW);

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

end