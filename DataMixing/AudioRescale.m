function AudioRescale(InputFolder,OutputFolder,ScaleFactor)

sInputFileCh0 = [InputFolder,'\ch0.wav'];
sInputFileCh1 = [InputFolder,'\ch1.wav'];
sInputFileCh2 = [InputFolder,'\ch2.wav'];
sInputFileCh3 = [InputFolder,'\ch3.wav'];
sInputFileCh4 = [InputFolder,'\ch4.wav'];
sInputFileCh5 = [InputFolder,'\ch5.wav'];
sInputFileCh6 = [InputFolder,'\ch6.wav'];

sOutputFileCh0 = [OutputFolder,'\ch0.wav'];
sOutputFileCh1 = [OutputFolder,'\ch1.wav'];
sOutputFileCh2 = [OutputFolder,'\ch2.wav'];
sOutputFileCh3 = [OutputFolder,'\ch3.wav'];
sOutputFileCh4 = [OutputFolder,'\ch4.wav'];
sOutputFileCh5 = [OutputFolder,'\ch5.wav'];
sOutputFileCh6 = [OutputFolder,'\ch6.wav'];


[fInputAudioCh0,fs] = audioread(sInputFileCh0);
[fInputAudioCh1,~] = audioread(sInputFileCh1);
[fInputAudioCh2,~] = audioread(sInputFileCh2);
[fInputAudioCh3,~] = audioread(sInputFileCh3);
[fInputAudioCh4,~] = audioread(sInputFileCh4);
[fInputAudioCh5,~] = audioread(sInputFileCh5);
[fInputAudioCh6,~] = audioread(sInputFileCh6);

audiowrite(sOutputFileCh0, fInputAudioCh0.*ScaleFactor, fs);
audiowrite(sOutputFileCh1, fInputAudioCh1.*ScaleFactor, fs);
audiowrite(sOutputFileCh2, fInputAudioCh2.*ScaleFactor, fs);
audiowrite(sOutputFileCh3, fInputAudioCh3.*ScaleFactor, fs);
audiowrite(sOutputFileCh4, fInputAudioCh4.*ScaleFactor, fs);
audiowrite(sOutputFileCh5, fInputAudioCh5.*ScaleFactor, fs);
audiowrite(sOutputFileCh6, fInputAudioCh6.*ScaleFactor, fs);


end