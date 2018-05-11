function res = save_fileList(path, sFileListLocation, sFileListName)
fileList = getAllFiles(path);
fileID = fopen([sFileListLocation,sFileListName],'w+');
for i = 1 : length(fileList)
    fprintf(fileID,'%s\n',fileList{i});
end
res = fclose(fileID);
end