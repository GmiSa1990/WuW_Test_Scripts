function [OutputAudioCh0,OutputAudioCh1,OutputAudioCh2,OutputAudioCh3,OutputAudioCh4,OutputAudioCh5,OutputAudioCh6] = ...
    Rescale_Digital(InputFolder,ScaleFactor)

sInputFileCh0 = [InputFolder,'\WuWRescaled_ch0.wav'];
sInputFileCh1 = [InputFolder,'\WuWRescaled_ch1.wav'];
sInputFileCh2 = [InputFolder,'\WuWRescaled_ch2.wav'];
sInputFileCh3 = [InputFolder,'\WuWRescaled_ch3.wav'];
sInputFileCh4 = [InputFolder,'\WuWRescaled_ch4.wav'];
sInputFileCh5 = [InputFolder,'\WuWRescaled_ch5.wav'];
sInputFileCh6 = [InputFolder,'\WuWRescaled_ch6.wav'];

[fInputAudioCh0,fs] = audioread(sInputFileCh0);
[fInputAudioCh1,~] = audioread(sInputFileCh1);
[fInputAudioCh2,~] = audioread(sInputFileCh2);
[fInputAudioCh3,~] = audioread(sInputFileCh3);
[fInputAudioCh4,~] = audioread(sInputFileCh4);
[fInputAudioCh5,~] = audioread(sInputFileCh5);
[fInputAudioCh6,~] = audioread(sInputFileCh6);

OutputAudioCh0 = fInputAudioCh0.*ScaleFactor;
OutputAudioCh1 = fInputAudioCh1.*ScaleFactor;
OutputAudioCh2 = fInputAudioCh2.*ScaleFactor;
OutputAudioCh3 = fInputAudioCh3.*ScaleFactor;
OutputAudioCh4 = fInputAudioCh4.*ScaleFactor;
OutputAudioCh5 = fInputAudioCh5.*ScaleFactor;
OutputAudioCh6 = fInputAudioCh6.*ScaleFactor;

end