function fAverageRMS = CalculateRMS_Speech_7ch(InputFolder)

iSmoothWin = 10;
iNoiseTol = 10;

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
fSmBlkPwrCh0 = smoothdata(fBlkPwrCh0,'movmean',iSmoothWin);
[fLowLimBlkPerCh0,~] = min(fSmBlkPwrCh0);
iSpeechIndexBlkPwrCh0 = find(fSmBlkPwrCh0 >= fLowLimBlkPerCh0.*iNoiseTol);
%fInputCh0_RMS = sqrt(mean(fBlkPwrCh0(iSpeechIndexBlkPwrCh0)));

fBlkPwrCh1 = mean(reshape([fInputAudioCh1;zeros(L_zpad, 1)].^2, 256, L_blks),1);
fSmBlkPwrCh1 = smoothdata(fBlkPwrCh1,'movmean',iSmoothWin);
[fLowLimBlkPerCh1,~] = min(fSmBlkPwrCh1);
iSpeechIndexBlkPwrCh1 = find(fSmBlkPwrCh1 >= fLowLimBlkPerCh1.*iNoiseTol);
%fInputCh1_RMS = sqrt(mean(fBlkPwrCh1(iSpeechIndexBlkPwrCh1)));
iSpeechIndexBlkPwr = union(iSpeechIndexBlkPwrCh0,iSpeechIndexBlkPwrCh1);

fBlkPwrCh2 = mean(reshape([fInputAudioCh2;zeros(L_zpad, 1)].^2, 256, L_blks),1);
fSmBlkPwrCh2 = smoothdata(fBlkPwrCh2,'movmean',iSmoothWin);
[fLowLimBlkPerCh2,~] = min(fSmBlkPwrCh2);
iSpeechIndexBlkPwrCh2 = find(fSmBlkPwrCh2 >= fLowLimBlkPerCh2.*iNoiseTol);
%fInputCh2_RMS = sqrt(mean(fBlkPwrCh2(iSpeechIndexBlkPwrCh2)));
iSpeechIndexBlkPwr = union(iSpeechIndexBlkPwr,iSpeechIndexBlkPwrCh2);

fBlkPwrCh3 = mean(reshape([fInputAudioCh3;zeros(L_zpad, 1)].^2, 256, L_blks),1);
fSmBlkPwrCh3 = smoothdata(fBlkPwrCh3,'movmean',iSmoothWin);
[fLowLimBlkPerCh3,~] = min(fSmBlkPwrCh3);
iSpeechIndexBlkPwrCh3 = find(fSmBlkPwrCh3 >= fLowLimBlkPerCh3.*iNoiseTol);
%fInputCh3_RMS = sqrt(mean(fBlkPwrCh3(iSpeechIndexBlkPwrCh3)));
iSpeechIndexBlkPwr = union(iSpeechIndexBlkPwr,iSpeechIndexBlkPwrCh3);


fBlkPwrCh4 = mean(reshape([fInputAudioCh4;zeros(L_zpad, 1)].^2, 256, L_blks),1);
fSmBlkPwrCh4 = smoothdata(fBlkPwrCh4,'movmean',iSmoothWin);
[fLowLimBlkPerCh4,~] = min(fSmBlkPwrCh4);
iSpeechIndexBlkPwrCh4 = find(fSmBlkPwrCh4 >= fLowLimBlkPerCh4.*iNoiseTol);
%fInputCh4_RMS = sqrt(mean(fBlkPwrCh4(iSpeechIndexBlkPwrCh4)));
iSpeechIndexBlkPwr = union(iSpeechIndexBlkPwr,iSpeechIndexBlkPwrCh4);


fBlkPwrCh5 = mean(reshape([fInputAudioCh5;zeros(L_zpad, 1)].^2, 256, L_blks),1);
fSmBlkPwrCh5 = smoothdata(fBlkPwrCh5,'movmean',iSmoothWin);
[fLowLimBlkPerCh5,~] = min(fSmBlkPwrCh5);
iSpeechIndexBlkPwrCh5 = find(fSmBlkPwrCh5 >= fLowLimBlkPerCh5.*iNoiseTol);
%fInputCh5_RMS = sqrt(mean(fBlkPwrCh5(iSpeechIndexBlkPwrCh5)));
iSpeechIndexBlkPwr = union(iSpeechIndexBlkPwr,iSpeechIndexBlkPwrCh5);


fBlkPwrCh6 = mean(reshape([fInputAudioCh6;zeros(L_zpad, 1)].^2, 256, L_blks),1);
fSmBlkPwrCh6 = smoothdata(fBlkPwrCh6,'movmean',iSmoothWin);
[fLowLimBlkPerCh6,~] = min(fSmBlkPwrCh6);
iSpeechIndexBlkPwrCh6 = find(fSmBlkPwrCh6 >= fLowLimBlkPerCh6.*iNoiseTol);
%fInputCh6_RMS = sqrt(mean(fBlkPwrCh6(iSpeechIndexBlkPwrCh6)));
iSpeechIndexBlkPwr = union(iSpeechIndexBlkPwr,iSpeechIndexBlkPwrCh6);

fInputCh0_RMS = sqrt(mean(fBlkPwrCh0(iSpeechIndexBlkPwr)));
fInputCh1_RMS = sqrt(mean(fBlkPwrCh1(iSpeechIndexBlkPwr)));
fInputCh2_RMS = sqrt(mean(fBlkPwrCh2(iSpeechIndexBlkPwr)));
fInputCh3_RMS = sqrt(mean(fBlkPwrCh3(iSpeechIndexBlkPwr)));
fInputCh4_RMS = sqrt(mean(fBlkPwrCh4(iSpeechIndexBlkPwr)));
fInputCh5_RMS = sqrt(mean(fBlkPwrCh5(iSpeechIndexBlkPwr)));
fInputCh6_RMS = sqrt(mean(fBlkPwrCh6(iSpeechIndexBlkPwr)));

fAllRMSs = [fInputCh0_RMS,fInputCh1_RMS,fInputCh2_RMS,fInputCh3_RMS,fInputCh4_RMS,fInputCh5_RMS,fInputCh6_RMS];

[fAverageRMS ,~] = max(fAllRMSs);

end