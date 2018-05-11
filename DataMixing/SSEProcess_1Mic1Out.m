function SSEProcess_1Mic1Out(audio_location, result_location, sse_work_dir, SCDName)
    % audio_location should be given to WuW_XATX_Interfered\SH_RoomWuTaiShan\SNR1dB\2m_180D300D
    % full result_location will be
    % WuW_XATX_Processed\SH_RoomWuTaiShan\SCDName_Short\SNR1dB\2m_180D300D_RockMusic_Sax_WuWxatx_00_1dBSNR\sse_out1.wav
    % result_location should be given to WuW_XATX_Processed\SH_RoomWuTaiShan\
    
    SCDName_Short = '1Mic1Out';
    
    AudioLocationList = getAllFiles(audio_location);
    AudioLocationList = AudioLocationList(1:14:end);
    count = length(AudioLocationList);
    
    vfilename = [sse_work_dir, 'prg_1Mic_1Out.v'];
    
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
        
        ch6_file_name = [sFullInputLocation,'ch6.wav'];

        f = fopen(vfilename,'w+');
        
        fprintf (f,'input bsd[0]   = "%s" \r\n',SCDName);
        fprintf (f,' \r\n');
        fprintf (f,'input micin[0] = "%s" \r\n',ch6_file_name);
        fprintf (f,' \r\n');
        fprintf (f,'output micout[0] = "%ssse_out1.wav" \r\n',sFullOutputLocation);
        fprintf (f,' \r\n');
        fprintf (f,'sse_FrameShift = 256 \r\n');
        fprintf (f,'sse_SampleRate = 16000 \r\n');
        fprintf (f,' \r\n');
        fprintf (f,'begin \r\n');
        fprintf (f,' \r\n');
        fprintf (f,'end \r\n');
        fprintf (f,' \r\n');

        fclose(f);
        
        process_sse_cmd = 'runsse_intern_x86.exe -l sse_411_release_x86.dll -p prg_1Mic_1Out.v';
        system(process_sse_cmd);

        disp([int2str(i),'th of ', int2str(count), ' audio file analyzed']);

    end

     disp('SSE Process Done');

end