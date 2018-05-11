function SSEProcess_7Mic2Out_forSSE4p2(audio_location, result_location, sse_work_dir, SCDName)
    % audio_location should be given to WuW_XATX_Interfered\SH_RoomWuTaiShan\SNR1dB\2m_180D300D
    % full result_location will be
    % WuW_XATX_Processed\SH_RoomWuTaiShan\SCDName_Short\SNR1dB\2m_180D300D_RockMusic_Sax_WuWxatx_00_1dBSNR\sse_out1.wav
    % result_location should be given to WuW_XATX_Processed\SH_RoomWuTaiShan\
    
    SCDName_Short = '7Mic2Out_SSE4p2';
    
    AudioLocationList = getAllFiles(audio_location);
    AudioLocationList = AudioLocationList(1:14:end);
    count = length(AudioLocationList);
    
    vfilename = [sse_work_dir, 'prg_7MicUCAC_2Out.v'];
    
    cd(sse_work_dir);
    for i = 1:count
        sFullInputFileLocation = char(AudioLocationList(i));
        iLocationIndex = find(sFullInputFileLocation == '\');
        sFullInputLocation = sFullInputFileLocation(1:iLocationIndex(end));
        
        sOutputSubLocation = [result_location,SCDName_Short,'\'];
        mkdir(sOutputSubLocation);
        iLocationIndex = find(sFullInputLocation == '\');
        sSubSubOutputLocation = sFullInputLocation(iLocationIndex(6)+1:iLocationIndex(7));
        sSubSubFullOutputLocation = [sOutputSubLocation,sSubSubOutputLocation];
        mkdir(sSubSubFullOutputLocation);
        sSubFullInputLocation = sFullInputLocation(iLocationIndex(7)+1:end-1);
        sSubFullInputFolder = strrep(sSubFullInputLocation,'\','_');
        sFullOutputLocation = [sSubSubFullOutputLocation,sSubFullInputFolder,'\'];
        mkdir(sFullOutputLocation);
        
        ch0_file_name = [sFullInputLocation,'ch0.wav'];
        ch1_file_name = [sFullInputLocation,'ch1.wav'];        
        ch2_file_name = [sFullInputLocation,'ch2.wav'];
        ch3_file_name = [sFullInputLocation,'ch3.wav'];
        ch4_file_name = [sFullInputLocation,'ch4.wav'];
        ch5_file_name = [sFullInputLocation,'ch5.wav'];
        ch6_file_name = [sFullInputLocation,'ch6.wav'];

        f = fopen(vfilename,'w+');
        
        fprintf (f,'input bsd[0]   = "%s" \r\n',SCDName);
        fprintf (f,' \r\n');
        fprintf (f,'input micin[0] = "%s" \r\n',ch0_file_name);
        fprintf (f,'input micin[1] = "%s" \r\n',ch1_file_name);
        fprintf (f,'input micin[2] = "%s" \r\n',ch2_file_name);
        fprintf (f,'input micin[3] = "%s" \r\n',ch3_file_name);
        fprintf (f,'input micin[4] = "%s" \r\n',ch4_file_name);
        fprintf (f,'input micin[5] = "%s" \r\n',ch5_file_name);
        fprintf (f,'input micin[6] = "%s" \r\n',ch6_file_name);
        fprintf (f,' \r\n');
        fprintf (f,'output micout[0] = "%ssse_out1.wav" \r\n',sFullOutputLocation);
        fprintf (f,'output micout[1] = "%ssse_out2.wav" \r\n',sFullOutputLocation);
        fprintf (f,' \r\n');
        fprintf (f,'sse_FrameShift = 256 \r\n');
        fprintf (f,'sse_SampleRate = 16000 \r\n');
        fprintf (f,' \r\n');
        fprintf (f,'begin \r\n');
        fprintf (f,' \r\n');
        fprintf (f,'end \r\n');
        fprintf (f,' \r\n');

        fclose(f);
        
        process_sse_cmd = 'runsse.exe -l sse_4.2.0_RC2.dll -p prg_7MicUCAC_2Out.v';
        system(process_sse_cmd);

        disp([int2str(i),'th of ', int2str(count), ' audio file analyzed']);

    end

     disp('SSE Process Done');

end