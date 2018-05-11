clear all;
clc;
warning('OFF');

raw_audio_location = 'C:\NuanceSSE\RD\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_HelloDragon_Seperated\';
interference_audio_location = 'C:\NuanceSSE\RD\7MicUCACArray_SSE4pxTesting_ASRTest\TVNoise_Seperated\Sce1\InterferenceFrom90Degree\';
interfered_audio_location = 'C:\NuanceSSE\RD\7MicUCACArray_SSE4pxTesting_ASRTest\WuW_HelloDragon_Interfered\Sce1\InterferenceFrom90Degree_rescaled0dB\';

SNRratio_dB = 0;
smooth_window = 10;
noise_tolerate = 10;

MicInFileLocationList = dir(raw_audio_location);
MicInFileLocationList = MicInFileLocationList(3:end);
count_micin = length(MicInFileLocationList);

InterfereFileLocationList = dir(interference_audio_location);
InterfereFileLocationList = InterfereFileLocationList(3:end);
count_interfere = length(InterfereFileLocationList);

for j = 1:count_interfere
    for i = 1:count_micin %count_micin
        speech_location = [raw_audio_location, char(MicInFileLocationList(i).name),'\'];
        interference_location = [interference_audio_location, char(InterfereFileLocationList(j).name),'\'];

%         [interfered_ch0,interfered_ch1,interfered_ch2,interfered_ch3,interfered_ch4,interfered_ch5,interfered_ch6,SIR] = ...
%             add_interference_improved_7ch(speech_location,interference_location,SNRratio_dB, smooth_window, noise_tolerate);
% 
%         
%         srcdir_slash_index = strfind(raw_audio_location,'\');
%         slash_length = length(srcdir_slash_index);
%         result_location = ...
%             [interfered_audio_location, char(InterfereFileLocationList(j).name),'\',char(MicInFileLocationList(i).name),'_SIR',num2str(SIR),'dB\'];

        [interfered_ch0,interfered_ch1,interfered_ch2,interfered_ch3,interfered_ch4,interfered_ch5,interfered_ch6] = ...
            add_interference_rescaled_7ch(speech_location,interference_location,SNRratio_dB, smooth_window, noise_tolerate);

        
        srcdir_slash_index = strfind(raw_audio_location,'\');
        slash_length = length(srcdir_slash_index);
        result_location = ...
            [interfered_audio_location, char(InterfereFileLocationList(j).name),'\',char(MicInFileLocationList(i).name),'_SNR',num2str(SNRratio_dB),'dB\'];

        dst_slash_index = strfind(result_location,'\');

        for k = 2 : length(dst_slash_index)
            folder = result_location(1:dst_slash_index(k)-1);
            mkdir(folder);
        end
        
        interferedoutput_name_ch0 = [result_location, 'ch0.wav'];
        interferedoutput_name_ch1 = [result_location, 'ch1.wav'];
        interferedoutput_name_ch2 = [result_location, 'ch2.wav'];
        interferedoutput_name_ch3 = [result_location, 'ch3.wav'];
        interferedoutput_name_ch4 = [result_location, 'ch4.wav'];
        interferedoutput_name_ch5 = [result_location, 'ch5.wav'];
        interferedoutput_name_ch6 = [result_location, 'ch6.wav'];

        audiowrite(interferedoutput_name_ch0,interfered_ch0,16000);
        audiowrite(interferedoutput_name_ch1,interfered_ch1,16000);
        audiowrite(interferedoutput_name_ch2,interfered_ch2,16000);
        audiowrite(interferedoutput_name_ch3,interfered_ch3,16000);
        audiowrite(interferedoutput_name_ch4,interfered_ch4,16000);
        audiowrite(interferedoutput_name_ch5,interfered_ch5,16000);
        audiowrite(interferedoutput_name_ch6,interfered_ch6,16000);


        disp([char(MicInFileLocationList(i).name),' of ', char(InterfereFileLocationList(j).name),' is done!']);


    end
end
 disp('Process Done');
