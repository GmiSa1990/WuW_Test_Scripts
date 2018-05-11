clear all;
clc;

sOriginalFolder = 'C:\NuanceSSE\RD\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_Recordings\SH_RoomWuTaiShan\';
sDesireFolder = 'C:\NuanceSSE\RD\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_Recordings_LSilence\SH_RoomWuTaiShan\';

lFilenameList = getAllFiles(sOriginalFolder);
iLengthFileList = length(lFilenameList);

for i = 1:iLengthFileList
    sSrcFilename = char(lFilenameList(i));
    
    disp(sSrcFilename)
    
    sDstFilename = strrep(sSrcFilename,sOriginalFolder,sDesireFolder);
    [fSrcAuduio,fs] = audioread(sSrcFilename);
    fAudioSilence = fSrcAuduio(1000:5999);
    fDstAudio = [fSrcAuduio(1:999);repmat(fAudioSilence,12,1);fSrcAuduio(1000:end)];
    audiowrite(sDstFilename, fDstAudio, fs);

end