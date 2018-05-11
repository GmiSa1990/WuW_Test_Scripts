%%
if 1
    clear;clc;
    sFileListLocation = 'C:\sse\iot_test\asr_result\clean_4p1\file_list\';
    sVoConResultLocation = 'C:\sse\iot_test\asr_result\clean_4p1\vocon_result';


    sRootDir = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessedCutted\SH_RoomWuTaiShan2';
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
                        sSub4Fold = [sSub3Fold(l).folder,'\',sSub3Fold(l).name];    
                        sFileListName = [sRootFolder(i).name,'_',sSubFold(j).name,'_',sSub2Fold(k).name,'_',sSub3Fold(l).name,'.txt'];
                        save_fileList(sSub4Fold, sFileListLocation, sFileListName);
                    end
                end
            end
    end
end

if 0
    clear;clc;
    sFileListLocation = 'C:\sse\iot_test\asr_result\compare_4p1_4p2\file_list\';
    sVoConResultLocation = 'C:\sse\iot_test\asr_result\compare_4p1_4p2\vocon_result';


    sRootDir = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessedCutted\SH_RoomWuTaiShan';
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
                        sSub4Fold = [sSub3Fold(l).folder,'\',sSub3Fold(l).name];    
                        sFileListName = [sRootFolder(i).name,'_',sSubFold(j).name,'_',sSub2Fold(k).name,'_',sSub3Fold(l).name,'.txt'];
                        save_fileList(sSub4Fold, sFileListLocation, sFileListName);
                    end
                end
            end
    end
end

%%
clear;clc;
sProcDir = 'C:\sse\iot_test\asr_result\clean_4p1\file_list\';
sProcFile = dir(sProcDir);sProcFile = sProcFile(3:end);
sSaveDir = 'C:\sse\iot_test\asr_result\clean_4p1\vocon_result\';
sVoConLocation = 'C:\Nuance\VoConWuwGateRecTest_v2\sample\';
cd(sVoConLocation);

for i = 1 : length(sProcFile)
   sListName = [sProcDir, sProcFile(i).name];
   sLogName  = [sSaveDir, sProcFile(i).name];
   process_cmd = ['VoConWuwGateRecTest.exe --log=',sLogName,' --wavelist=',sListName,' --config=cfg.txt'];
   system(process_cmd);
   fprintf('%d / %d is done',i,length(sProcFile));
end