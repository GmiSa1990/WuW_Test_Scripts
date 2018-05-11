%function status = convertResult(resultFolder)
resultFolder = 'C:\sse\iot_test\asr_result\clean_4p1\vocon_result\';
mkdir([resultFolder,'\proc\']);
fileList = dir([resultFolder,'*.txt']);
tempPath = 'Found wakeup in file C:\\sse\\iot_test\\7MicUCACArray_SSE4pxTesting_ASRTest\\WuW_XATX_InterferedProcessedCutted\\SH_RoomWuTaiShan2\\';
    for i = 1 : numel(fileList)
        writeID = fopen([resultFolder,'\proc\',fileList(i).name],'w+');
        readID  = fopen([resultFolder,fileList(i).name],'r');
        cline = fgetl(readID);
        while( ischar(cline))
            clinecell = regexp(cline, [tempPath, '(\w*)\\(\w*)\\(\w*)\\(\w*)\\(\w*.wav), start at (\w*ms), end at (\w*ms), hypo conf = \w*, tag conf = (\w*), \w*'],'tokens');
            if (~isempty(clinecell))
                fprintf(writeID, '%s/%s/%s/%s/%s, %s, %s, %s,\n',clinecell{1}{1},clinecell{1}{2},clinecell{1}{3},clinecell{1}{4},clinecell{1}{5},clinecell{1}{6},clinecell{1}{7},clinecell{1}{8});
            end
            cline = fgetl(readID);
        end
        fclose(writeID);
        fclose(readID);
    end
%end