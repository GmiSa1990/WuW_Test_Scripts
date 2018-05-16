clear; clc; warning('OFF');
sCurrentPath  = pwd;

iSNR        = [8, 5, 1];
iDistance   = [2, 3, 4];
sAngleLable = {'_300D';'_180D300D'};
sseDLL        = {'sse_411_release_x86.dll','sse_4.2.0_RC2.dll','sse_4.2.0_RC4.dll'};
outBeam       = {'single_beam','dual_beam'};
sSource       = {'interfered','clean'};

stVfile = struct();
stVfile.srcPath    = '';
stVfile.destPath   = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessed\Round2_forRelease\';
stVfile.runssePath = 'C:\sse\iot_test\scripts\SSEProcessingForWuWTest\';
stVfile.scdName    = 'iot_sse41_7mic_0ref_2out_asl_abf_spf_sdr.scd';
stVfile.sseDLL     = sseDLL{3};
stVfile.beamNum    = outBeam{2};
stVfile.source     = sSource{1};


%% Process Interfered WuW Recordings
% tmp
if 1
    for i_iSNR = 1  %SNR = 8dB.

        for i_iDistance = 1 : length(iDistance)
            
            for i_AngleLable = 2 % : numel(sAngleLable)
                cd(sCurrentPath);
                disp(['SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable}, ' Processing']);
                
                stVfile.srcPath = ...
                    ['C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_Interfered\SH_RoomWuTaiShan\SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable},'\'];
                
                SSEProcess(stVfile);
                
                disp(['SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable}, ' Done']);
                disp(' ');disp(' ');
            end
        end
    end
end


%% Process Clean WuW Recordings
% Test: Compare sse4p11 and sse4p2 on dual beam
% dataset: 1. rescaled clean WuW in 3 distances(2m,3m,4m) and only alternating
% angle considered; 2. interfered WuW in 3 distances, only alternating
% angle, interference noises: rock music, soft music and speech.
if 0
    for i_iDistance = 1 : length(iDistance)
        for i_AngleLable = 1    %sAngleLable = '_300D'.
            cd(sCurrentPath);

            disp([int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable}, ' Processing']);
            audio_location = ...
                ['C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_Recordings_LSilence\SH_RoomWuTaiShan\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable},'\'];
            result_location = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessed\SH_RoomWuTaiShan2\';
            sse_work_dir = 'C:\sse\iot_test\scripts\SSEProcessingForWuWTest\';


            mkdir(result_location);
            SCDName_7Mic1Out = 'iot_sse41_7mic_0ref_1out_abf_spf_sdr.scd';
            SSEProcess_7Mic1Out_Clean(audio_location, result_location, sse_work_dir, SCDName_7Mic1Out);
            
            %cd(sCurrentPath);
            %SSEProcess_7Mic1Out_Clean_forSSE4p2(audio_location, result_location, sse_work_dir, SCDName_7Mic1Out);
            
            disp([int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable}, ' Done']);
            disp(' ');disp(' ');
        end
    end    
end

% Test 2: Single Beam vs Dual Beam
% a. #5d on all data
% b. #6d on all data
if 0
    for i_iDistance = 1 : length(iDistance)
        for i_AngleLable = 1:length(sAngleLable)
            cd(sCurrentPath);

            disp([int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable}, ' Processing']);
            audio_location = ...
                ['C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_Recordings_LSilence\SH_RoomWuTaiShan\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable},'\'];
            result_location = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessed\SH_RoomWuTaiShan\';
            sse_work_dir = 'C:\sse\iot_test\scripts\SSEProcessingForWuWTest\';


            mkdir(result_location);
            SCDName_7Mic2Out = 'iot_sse41_7mic_0ref_2out_6d.scd';
            SSEProcess_7Mic2Out_Clean(audio_location, result_location, sse_work_dir, SCDName_7Mic2Out);
            
            cd(sCurrentPath);
            SCDName_7Mic1Out = 'iot_sse41_7mic_0ref_1out_5d.scd';
            SSEProcess_7Mic1Out_Clean(audio_location, result_location, sse_work_dir, SCDName_7Mic1Out);
            
            disp([int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable}, ' Done']);
            disp(' ');disp(' ');
        end
    end    
end

