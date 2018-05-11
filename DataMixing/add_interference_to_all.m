clear all;
clc;
warning('OFF');

raw_audio_location = 'C:\NuanceSSE\IoT_Projects\2017-IoT-Xiaomi\05_APQMReportsNRecordings\chengdu_mico_8ch_seprated\';
interference_audio_location = 'C:\NuanceSSE\IoT_Projects\2017-IoT-Xiaomi\05_APQMReportsNRecordings\Xiaomi_InterferenceRecording_20171226_0Degree_Splitted_Detrend\';
interfered_audio_location = 'C:\NuanceSSE\IoT_Projects\2017-IoT-Xiaomi\05_APQMReportsNRecordings\chengdu_mico_8ch_interfered\';


MicInFileLocationList = dir(raw_audio_location);
MicInFileLocationList = MicInFileLocationList(3:end);
count_micin = length(MicInFileLocationList);

InterfereFileLocationList = dir(interference_audio_location);
InterfereFileLocationList = InterfereFileLocationList(3:end);
count_interfere = length(InterfereFileLocationList);

for j = 1:count_interfere
    for i = 1:50 %count_micin
        speech_location = [raw_audio_location, char(MicInFileLocationList(i).name),'\'];
        interference_location = [interference_audio_location, char(InterfereFileLocationList(j).name),'\'];

        [interfered_ch0,interfered_ch1,interfered_ch2,interfered_ch3,interfered_ch4,interfered_ch5,SIR] = ...
            add_interference(speech_location,interference_location,1);

        
        srcdir_slash_index = strfind(raw_audio_location,'\');
        slash_length = length(srcdir_slash_index);
        result_location = ...
            [interfered_audio_location, char(InterfereFileLocationList(j).name),'\',char(MicInFileLocationList(i).name),'_SIR',num2str(SIR),'dB\'];

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

        audiowrite(interferedoutput_name_ch0,interfered_ch0,16000);
        audiowrite(interferedoutput_name_ch1,interfered_ch1,16000);
        audiowrite(interferedoutput_name_ch2,interfered_ch2,16000);
        audiowrite(interferedoutput_name_ch3,interfered_ch3,16000);
        audiowrite(interferedoutput_name_ch4,interfered_ch4,16000);
        audiowrite(interferedoutput_name_ch5,interfered_ch5,16000);


        disp([char(MicInFileLocationList(i).name),' of ', char(InterfereFileLocationList(j).name),' is done!']);


    end
end
 disp('Process Done');
