function [fs,fInputAudioCh0,fInputAudioCh1,fInputAudioCh2,fInputAudioCh3,fInputAudioCh4,fInputAudioCh5,fInputAudioCh6] = ...
    ReadAudio_Digital(InputFolder)

sInputFileCh0 = [InputFolder,'\ch0.wav'];
sInputFileCh1 = [InputFolder,'\ch1.wav'];
sInputFileCh2 = [InputFolder,'\ch2.wav'];
sInputFileCh3 = [InputFolder,'\ch3.wav'];
sInputFileCh4 = [InputFolder,'\ch4.wav'];
sInputFileCh5 = [InputFolder,'\ch5.wav'];
sInputFileCh6 = [InputFolder,'\ch6.wav'];

[fInputAudioCh0,fs] = audioread(sInputFileCh0);
[fInputAudioCh1,~] = audioread(sInputFileCh1);
[fInputAudioCh2,~] = audioread(sInputFileCh2);
[fInputAudioCh3,~] = audioread(sInputFileCh3);
[fInputAudioCh4,~] = audioread(sInputFileCh4);
[fInputAudioCh5,~] = audioread(sInputFileCh5);
[fInputAudioCh6,~] = audioread(sInputFileCh6);


end