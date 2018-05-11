clear all;
clc;

src_folder = 'D:\SpeechOcean_HeadsetRecording_XiaoAiTongXue\xatx\';
dst_folder_00 = 'D:\SpeechOcean_HeadsetRecording_XiaoAiTongXue\xatx_300_forCalibration\';
dst_folder_01 = 'D:\xatx_1000_01\';

FileList = dir(src_folder);
FileList = FileList(3:end);
count_src = length(FileList);

for i = 1:7
    rand_index = 1 + floor(rand*count_src);
    srcFileName = [src_folder FileList(rand_index).name];
    dstFileName = [dst_folder_00 FileList(rand_index).name];
    process_cmd = ['copy ' srcFileName ' ' dstFileName];
    system(process_cmd);
end

% FileList = dir(dst_folder_00);
% FileList = FileList(3:end);
% count_src = length(FileList);
% 
% for i = 1:25
%     rand_index = 1 + floor(rand*count_src);
%     srcFileName = [dst_folder_00 FileList(rand_index).name];
%     dstFileName = [dst_folder_01 FileList(rand_index).name];
%     process_cmd = ['copy ' srcFileName ' ' dstFileName];
%     system(process_cmd);
%     process_cmd = ['del ' srcFileName];
%     system(process_cmd);
% end
% 
% disp('Move Done')


