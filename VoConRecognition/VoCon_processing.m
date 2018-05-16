% parameters to be modified for each test
clear;clc;
global count sFileListLocation
count = 1 ;
sFileListLocation    = 'C:\sse\iot_test\asr_result\4p2_rc4\file_list\';
sVoConResultLocation = 'C:\sse\iot_test\asr_result\4p2_rc4\vocon_result\';
sRootDir = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessedCutted\Round2_forRelease';
templateForRegExp    = ...
['Found wakeup in file C:\\sse\\iot_test\\7MicUCACArray_SSE4pxTesting_ASRTest\\WuW_XATX_InterferedProcessedCutted\\SH_RoomWuTaiShan2\\',...
 '(\w*)\\(\w*)\\(\w*)\\(\w*)\\(\w*.wav), start at (\w*ms), end at (\w*ms), hypo conf = \w*, tag conf = (\w*), \w*'...
];


% collect the path of all the audio files to be recognized.
%saveFileList(sRootDir);

% run VoCon
runVoCon(sVoConResultLocation);

% convert result
convertResult(sVoConResultLocation, templateForRegExp);

% read result
readResults([resultDir,'proc\']);

function count = saveFileList(audioFolder)
    global count 
    global sFileListLocation
    subFold = dir(audioFolder); subFold = subFold(3:end);
    
    if (numel(subFold) == 540)
        fileID = fopen([sFileListLocation,num2str(count),'.txt'],'w+');
        count = count + 1;
        for i = 1 : 540
            fprintf(fileID,'%s\n',[subFold(i).folder,'\',subFold(i).name]);
        end
    	fclose(fileID); 
    else
        for i = 1 : numel(subFold)
            saveFileList([subFold(i).folder,'\',subFold(i).name]);
        end
    end
end


function runVoCon(resultDir)
    global sFileListLocation
    sProcFile = dir(sFileListLocation);sProcFile = sProcFile(3:end);
    sVoConLocation = 'C:\Nuance\VoConWuwGateRecTest_v2\sample\';
    cd(sVoConLocation);

    for i = 1 : numel(sProcFile)
       sListName = [sProcDir , sProcFile(i).name];
       sLogName  = [resultDir, sProcFile(i).name];
       process_cmd = ['VoConWuwGateRecTest.exe --log=',sLogName,' --wavelist=',sListName,' --config=cfg.txt'];
       system(process_cmd);
       fprintf('%d / %d is done',i,length(sProcFile));
    end
end


function convertResult(resultDir, templateForRegExp)
    mkdir([resultDir,'proc\']);
    fileList = dir([resultDir,'*.txt']);
        for i = 1 : numel(fileList)
            writeID = fopen([resultDir,'proc\',fileList(i).name],'w+');
            readID  = fopen([resultDir,fileList(i).name],'r');
            cline = fgetl(readID);
            while( ischar(cline))
                clinecell = regexp(cline, templateForRegExp,'tokens');
                if (~isempty(clinecell))
                    fprintf(writeID, '%s/%s/%s/%s/%s, %s, %s, %s,\n',clinecell{1}{1},clinecell{1}{2},clinecell{1}{3},clinecell{1}{4},clinecell{1}{5},clinecell{1}{6},clinecell{1}{7},clinecell{1}{8});
                end
                cline = fgetl(readID);
            end
            fclose(writeID);
            fclose(readID);
        end
end