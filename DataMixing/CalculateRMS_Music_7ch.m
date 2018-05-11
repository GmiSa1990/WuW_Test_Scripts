function fAverageRMS = CalculateRMS_Music_7ch(InputFolder)

sInputFileCh0 = [InputFolder,'\ch0.wav'];
sInputFileCh1 = [InputFolder,'\ch1.wav'];
sInputFileCh2 = [InputFolder,'\ch2.wav'];
sInputFileCh3 = [InputFolder,'\ch3.wav'];
sInputFileCh4 = [InputFolder,'\ch4.wav'];
sInputFileCh5 = [InputFolder,'\ch5.wav'];
sInputFileCh6 = [InputFolder,'\ch6.wav'];

[fInputAudioCh0,~] = audioread(sInputFileCh0);
[fInputAudioCh1,~] = audioread(sInputFileCh1);
[fInputAudioCh2,~] = audioread(sInputFileCh2);
[fInputAudioCh3,~] = audioread(sInputFileCh3);
[fInputAudioCh4,~] = audioread(sInputFileCh4);
[fInputAudioCh5,~] = audioread(sInputFileCh5);
[fInputAudioCh6,~] = audioread(sInputFileCh6);

L_blks = ceil(length(fInputAudioCh0) / 256);
L_zpad = L_blks * 256 - length(fInputAudioCh0);

fBlkPwrCh0 = mean(reshape([fInputAudioCh0;zeros(L_zpad, 1)].^2, 256, L_blks),1);
fInputCh0_RMS = sqrt(mean(fBlkPwrCh0));

fBlkPwrCh1 = mean(reshape([fInputAudioCh1;zeros(L_zpad, 1)].^2, 256, L_blks),1);
fInputCh1_RMS = sqrt(mean(fBlkPwrCh1));

fBlkPwrCh2 = mean(reshape([fInputAudioCh2;zeros(L_zpad, 1)].^2, 256, L_blks),1);
fInputCh2_RMS = sqrt(mean(fBlkPwrCh2));

fBlkPwrCh3 = mean(reshape([fInputAudioCh3;zeros(L_zpad, 1)].^2, 256, L_blks),1);
fInputCh3_RMS = sqrt(mean(fBlkPwrCh3));

fBlkPwrCh4 = mean(reshape([fInputAudioCh4;zeros(L_zpad, 1)].^2, 256, L_blks),1);
fInputCh4_RMS = sqrt(mean(fBlkPwrCh4));

fBlkPwrCh5 = mean(reshape([fInputAudioCh5;zeros(L_zpad, 1)].^2, 256, L_blks),1);
fInputCh5_RMS = sqrt(mean(fBlkPwrCh5));

fBlkPwrCh6 = mean(reshape([fInputAudioCh6;zeros(L_zpad, 1)].^2, 256, L_blks),1);
fInputCh6_RMS = sqrt(mean(fBlkPwrCh6));

fAllRMSs = [fInputCh0_RMS,fInputCh1_RMS,fInputCh2_RMS,fInputCh3_RMS,fInputCh4_RMS,fInputCh5_RMS,fInputCh6_RMS];

[fAverageRMS ,~] = max(fAllRMSs);

end