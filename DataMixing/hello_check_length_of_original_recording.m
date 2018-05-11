clear;clc;
path = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\xatx_WuTaiShan_WuWRecordings_20180227\';

stRootFolder = dir(path);
stRootFolderList = stRootFolder(3:end);
iRootFolder = length(stRootFolderList);

stWuwFolder = dir([path,stRootFolderList(1).name,'\']);
stWuwFolderList = stWuwFolder(3:end);
iWuW = length(stWuwFolderList);
iAudioSamples = zeros(iRootFolder,iWuW);
for i = 1 : iWuW
    for j = 1 : iRootFolder
        file_path = [path,stRootFolderList(j).name,'\',stWuwFolderList(i).name,'\ch0.wav'];
        [audio,~] = audioread(file_path);
        iAudioSamples(j,i) = length(audio);
    end
end

iAudioSamples = iAudioSamples';
cnt = 0;
for i = 1 : iWuW
    if length(find(iAudioSamples(1,:) == iAudioSamples(1,1))) == length(iAudioSamples(1,:))
        cnt = cnt + 1;
    else
        disp('the %d th is not the same');
    end
end