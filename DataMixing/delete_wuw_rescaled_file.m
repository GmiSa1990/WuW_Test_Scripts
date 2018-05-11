clear;clc;

sRootDir = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_Interfered\SH_RoomWuTaiShan\SNR1dB';
sRootFolder = dir(sRootDir);
sRootFolder = sRootFolder(3:end);

for i = 1 : length(sRootFolder)
        sSubFold = dir([sRootFolder(i).folder,'\',sRootFolder(i).name]);
        sSubFold = sSubFold(3:end);
        for j = 1 : length(sSubFold)
            sSub2Fold = dir([sSubFold(j).folder,'\',sSubFold(j).name]);
            sSub2Fold = sSub2Fold(3:end);
            for k = 1 : length(sSub2Fold)
                sSub3Fold = dir([sSub2Fold(k).folder,'\',sSub2Fold(k).name]);
                sSub3Fold = sSub3Fold(3:end);
                for l = 1 : length(sSub3Fold)
                    sSub4Fold = [sSub3Fold(l).folder,'\',sSub3Fold(l).name,'\WuWRescaled_ch*'];    
                    delete(sSub4Fold)
                end
            end
        end
end
