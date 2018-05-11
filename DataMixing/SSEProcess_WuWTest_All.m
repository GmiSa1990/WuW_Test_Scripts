clear; clc;
warning('OFF');
iSNR        = [8, 5, 1];
iDistance   = [2, 3, 4];
sAngleLable = {'_300D';'_180D300D'};
sAngleLable_1 = '_300D';
sAngleLable_2 = '_180D300D';
sCurrentPath  = pwd;
%% Process Interfered WuW Recordings
% Test: Compare sse4p11 and sse4p2 on single beam
% dataset: 1. rescaled clean WuW in 3 distances(2m,3m,4m) and only alternating
% angle considered; 2. interfered WuW in 3 distances, only alternating
% angle, interference noises: rock music, soft music and speech.
if 0
    for i_iSNR = 1  %SNR = 8dB.

        for i_iDistance = 1 : length(iDistance)
            
            for i_AngleLable = 1    %sAngleLable = '_300D'.
                cd(sCurrentPath);
                disp(['SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable}, ' Processing']);
                audio_location = ...
                    ['C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_Interfered\SH_RoomWuTaiShan\SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable},'\'];
                result_location = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessed\SH_RoomWuTaiShan2\';
                sse_work_dir = 'C:\sse\iot_test\scripts\SSEProcessingForWuWTest\';
                SCDName_7Mic1Out = 'iot_sse41_7mic_0ref_1out_abf_spf_sdr.scd';
                
                SSEProcess_7Mic1Out(audio_location, result_location, sse_work_dir, SCDName_7Mic1Out);
                
                cd(sCurrentPath);
                SSEProcess_7Mic1Out_forSSE4p2(audio_location, result_location, sse_work_dir, SCDName_7Mic1Out);

                disp(['SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable}, ' Done']);
                disp(' ');disp(' ');
            end
        end
    end
end
% Test: Compare sse4p11 and sse4p2 on dual beam
% dataset: 1. rescaled clean WuW in 3 distances(2m,3m,4m) and only alternating
% angle considered; 2. interfered WuW in 3 distances, only alternating
% angle, interference noises: rock music, soft music and speech.
if 0
    for i_iSNR = 1  %SNR = 8dB.

        for i_iDistance = 1 : length(iDistance)
            
            for i_AngleLable = 2    %sAngleLable = '_180D300D'.
                cd(sCurrentPath);
                disp(['SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable}, ' Processing']);
                audio_location = ...
                    ['C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_Interfered\SH_RoomWuTaiShan\SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable},'\'];
                result_location = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessed\SH_RoomWuTaiShan\';
                sse_work_dir = 'C:\sse\iot_test\scripts\SSEProcessingForWuWTest\';
                SCDName_7Mic2Out = 'iot_sse41_7mic_0ref_2out_asl_abf_spf_sdr.scd';
                
                SSEProcess_7Mic2Out(audio_location, result_location, sse_work_dir, SCDName_7Mic2Out);
                
                cd(sCurrentPath);
                SSEProcess_7Mic2Out_forSSE4p2(audio_location, result_location, sse_work_dir, SCDName_7Mic2Out);

                disp(['SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable}, ' Done']);
                disp(' ');disp(' ');
            end
        end
    end
end

% Test 2: Single Beam vs Dual Beam
% a. #5d on all data
% b. #6d on all data
if 0
    for i_iSNR = 1 : length(iSNR)

        for i_iDistance = 1 : length(iDistance)
            
            for i_AngleLable = 1 : length(sAngleLable)
                cd(sCurrentPath);
                disp(['SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable}, ' Processing']);
                audio_location = ...
                    ['C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_Interfered\SH_RoomWuTaiShan\SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable},'\'];
                result_location = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessed\SH_RoomWuTaiShan\';
                sse_work_dir = 'C:\sse\iot_test\scripts\SSEProcessingForWuWTest\';
                
                SCDName_7Mic2Out = 'iot_sse41_7mic_0ref_2out_6d.scd';
                SSEProcess_7Mic2Out(audio_location, result_location, sse_work_dir, SCDName_7Mic2Out);
                
                cd(sCurrentPath);
                SCDName_7Mic1Out = 'iot_sse41_7mic_0ref_1out_5d.scd';
                SSEProcess_7Mic1Out(audio_location, result_location, sse_work_dir, SCDName_7Mic1Out);

                disp(['SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable}, ' Done']);
                disp(' ');disp(' ');
            end
        end
    end
end

if 0
    for i_iSNR = 1 : length(iSNR)

        for i_iDistance = 1 : length(iDistance)

            cd(pwd);

            disp(['SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable_2, ' Processing']);
            audio_location = ...
                ['C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_Interfered\SH_RoomWuTaiShan\SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable_2,'\'];
            result_location = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessed\SH_RoomWuTaiShan\';
            sse_work_dir = 'C:\sse\iot_test\scripts\SSEProcessingForWuWTest\';
            SCDName_7Mic2Out = 'iot_sse41_7mic_0ref_2out_asl_abf_spf_sdr.scd';

            SSEProcess_7Mic2Out(audio_location, result_location, sse_work_dir, SCDName_7Mic2Out);
            disp(['SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable_2, ' Done']);
            disp(' ');
            disp(' ');
        end
    end

    for i_iSNR = 1 : length(iSNR)

        for i_iDistance = 1 : length(iDistance)

            cd(pwd);

            disp(['SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable_1, ' Processing']);
            audio_location = ...
                ['C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_Interfered\SH_RoomWuTaiShan\SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable_1,'\'];
            result_location = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessed\SH_RoomWuTaiShan\';
            sse_work_dir = 'C:\sse\iot_test\scripts\SSEProcessingForWuWTest\';
            SCDName_7Mic1Out = 'iot_sse41_7mic_0ref_1out_abf_spf_sdr.scd';

            SSEProcess_7Mic1Out(audio_location, result_location, sse_work_dir, SCDName_7Mic1Out);
            disp(['SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable_1, ' Done']);
            disp(' ');
            disp(' ');
        end
    end

    for i_iSNR = 1 : length(iSNR)

        for i_iDistance = 1 : length(iDistance)

            cd(pwd);

            disp(['SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable_2, ' Processing']);
            audio_location = ...
                ['C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_Interfered\SH_RoomWuTaiShan\SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable_2,'\'];
            result_location = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessed\SH_RoomWuTaiShan\';
            sse_work_dir = 'C:\sse\iot_test\scripts\SSEProcessingForWuWTest\';
            SCDName_1Mic1Out = 'iot_sse41_1mic_0ref_1out_nr_sdr.scd';

            SSEProcess_1Mic1Out(audio_location, result_location, sse_work_dir, SCDName_1Mic1Out);
            disp(['SNR', int2str(iSNR(i_iSNR)), 'dB\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable_2, ' Done']);
            disp(' ');
            disp(' ');
        end
    end
end

%% Process Clean WuW Recordings
% Test: Compare sse4p11 and sse4p2 on dual beam
% dataset: 1. rescaled clean WuW in 3 distances(2m,3m,4m) and only alternating
% angle considered; 2. interfered WuW in 3 distances, only alternating
% angle, interference noises: rock music, soft music and speech.
if 1
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

if 0
    for i_iDistance = 1 : length(iDistance)

        cd(pwd);

        disp([int2str(iDistance(i_iDistance)), 'm' ,sAngleLable_2, ' Processing']);
        audio_location = ...
            ['C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_Recordings_LSilence\SH_RoomWuTaiShan\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable_2,'\'];
        result_location = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessed\SH_RoomWuTaiShan\';
        sse_work_dir = 'C:\sse\iot_test\scripts\SSEProcessingForWuWTest\';
        SCDName_7Mic2Out = 'iot_sse41_7mic_0ref_2out_asl_abf_spf_sdr.scd';

        mkdir(result_location);

        SSEProcess_7Mic2Out_Clean(audio_location, result_location, sse_work_dir, SCDName_7Mic2Out);
        disp([int2str(iDistance(i_iDistance)), 'm' ,sAngleLable_2, ' Done']);
        disp(' ');
        disp(' ');
    end

    for i_iDistance = 1 : length(iDistance)

        cd(pwd);

        disp([int2str(iDistance(i_iDistance)), 'm' ,sAngleLable_1, ' Processing']);
        audio_location = ...
            ['C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_Recordings_LSilence\SH_RoomWuTaiShan\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable_1,'\'];
        result_location = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessed\SH_RoomWuTaiShan\';
        sse_work_dir = 'C:\sse\iot_test\scripts\SSEProcessingForWuWTest\';
        SCDName_7Mic1Out = 'iot_sse41_7mic_0ref_1out_abf_spf_sdr.scd';

        mkdir(result_location);

        SSEProcess_7Mic1Out_Clean(audio_location, result_location, sse_work_dir, SCDName_7Mic1Out);
        disp([int2str(iDistance(i_iDistance)), 'm' ,sAngleLable_1, ' Done']);
        disp(' ');
        disp(' ');
    end

    for i_iDistance = 1 : length(iDistance)

        cd(pwd);

        disp([int2str(iDistance(i_iDistance)), 'm' ,sAngleLable_2, ' Processing']);
        audio_location = ...
            ['C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_Recordings_LSilence\SH_RoomWuTaiShan\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable_2,'\'];
        result_location = 'C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_InterferedProcessed\SH_RoomWuTaiShan\';
        sse_work_dir = 'C:\sse\iot_test\scripts\SSEProcessingForWuWTest\';
        SCDName_1Mic1Out = 'iot_sse41_1mic_0ref_1out_nr_sdr.scd';

        mkdir(result_location);

        SSEProcess_1Mic1Out_Clean(audio_location, result_location, sse_work_dir, SCDName_1Mic1Out);
        disp([int2str(iDistance(i_iDistance)), 'm' ,sAngleLable_2, ' Done']);
        disp(' ');
        disp(' ');
    end
end