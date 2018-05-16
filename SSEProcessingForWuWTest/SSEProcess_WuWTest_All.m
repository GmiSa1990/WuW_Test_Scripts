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
if 0
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

stVfile.source     = sSource{2};
if 1
    for i_iDistance = 1 : length(iDistance)
        for i_AngleLable = 2
            cd(sCurrentPath);
            disp([int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable}, ' Processing']);
            
            stVfile.srcPath = ...
                ['C:\sse\iot_test\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_XATX_Recordings_LSilence\SH_RoomWuTaiShan\', int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable},'\'];

            SSEProcess(stVfile);
            
            disp([int2str(iDistance(i_iDistance)), 'm' ,sAngleLable{i_AngleLable}, ' Done']);
            disp(' ');disp(' ');
        end
    end    
end

