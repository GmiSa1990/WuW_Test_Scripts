function SSEProcess(stVfile)
    % srcPath should be given to WuW_XATX_Interfered\SH_RoomWuTaiShan\SNR1dB\2m_180D300D
    % full destPath will be
    % WuW_XATX_Processed\SH_RoomWuTaiShan\scdName_Short\SNR1dB\2m_180D300D_RockMusic_Sax_WuWxatx_00_1dBSNR\sse_out1.wav
    % destPath should be given to WuW_XATX_Processed\SH_RoomWuTaiShan\
    
    switch stVfile.source
        case 'interfered'
            AudioLocationList = getAllFiles(stVfile.srcPath);
            AudioLocationList = AudioLocationList(1:7:end);
            count = numel(AudioLocationList);
        case 'clean'
            AudioLocationList = dir(stVfile.srcPath);
            AudioLocationList = AudioLocationList(3:end);
            count = numel(AudioLocationList);
    end
    
    cd(stVfile.runssePath);

    for i = 1:count
        vfilename = [stVfile.runssePath, 'prg.v'];
        f = fopen(vfilename,'w+');

        switch stVfile.source
            case 'interfered'
                sFullInputFileLocation = char(AudioLocationList(i));
                iLocationIndex = find(sFullInputFileLocation == '\');
                sFullInputLocation = sFullInputFileLocation(1:iLocationIndex(end));
                sOutputSubLocation = [stVfile.destPath,'Interfered\'];
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
            case 'clean'
                sFullInputLocation = [stVfile.srcPath, AudioLocationList(i).name,'\']; 
                sOutputSubLocation = stVfile.destPath;
                mkdir(sOutputSubLocation);
                sOutputSubSubLocation = [sOutputSubLocation, 'Clean\'];
                mkdir(sOutputSubSubLocation);
                iLocationIndex = find(sFullInputLocation == '\');
                sSubFullInputLocation = sFullInputLocation(iLocationIndex(end-2)+1:end-1);
                sSubFullInputFolder = strrep(sSubFullInputLocation,'\','_');
                sFullOutputLocation = [sOutputSubSubLocation, sSubFullInputFolder,'\'];
                mkdir(sFullOutputLocation);
                ch0_file_name = [sFullInputLocation,'WuWRescaled_ch0.wav'];
                ch1_file_name = [sFullInputLocation,'WuWRescaled_ch1.wav'];        
                ch2_file_name = [sFullInputLocation,'WuWRescaled_ch2.wav'];
                ch3_file_name = [sFullInputLocation,'WuWRescaled_ch3.wav'];
                ch4_file_name = [sFullInputLocation,'WuWRescaled_ch4.wav'];
                ch5_file_name = [sFullInputLocation,'WuWRescaled_ch5.wav'];
                ch6_file_name = [sFullInputLocation,'WuWRescaled_ch6.wav'];
        end

        fprintf (f,'input bsd[0]   = "%s" \r\n',stVfile.scdName);
        fprintf (f,' \r\n');
        fprintf (f,'input micin[0] = "%s" \r\n',ch0_file_name);
        fprintf (f,'input micin[1] = "%s" \r\n',ch1_file_name);
        fprintf (f,'input micin[2] = "%s" \r\n',ch2_file_name);
        fprintf (f,'input micin[3] = "%s" \r\n',ch3_file_name);
        fprintf (f,'input micin[4] = "%s" \r\n',ch4_file_name);
        fprintf (f,'input micin[5] = "%s" \r\n',ch5_file_name);
        fprintf (f,'input micin[6] = "%s" \r\n',ch6_file_name);
        fprintf (f,' \r\n');

        switch stVfile.beamNum
            case 'dual_beam'
                fprintf(f,'output micout[0] = "%ssse_out1.wav" \r\n',sFullOutputLocation);
                fprintf(f,'output micout[1] = "%ssse_out2.wav" \r\n',sFullOutputLocation);
            case 'single_beam'
                fprintf(f,'output micout[0] = "%ssse_out1.wav" \r\n',sFullOutputLocation);
            otherwise
                disp('beam number is not determined!');
        end

        fprintf (f,' \r\n');
        fprintf (f,'sse_FrameShift = 256 \r\n');
        fprintf (f,'sse_SampleRate = 16000 \r\n');
        fprintf (f,' \r\n');
        fprintf (f,'begin \r\n');
        fprintf (f,' \r\n');
        fprintf (f,'end \r\n');
        fprintf (f,' \r\n');

        fclose(f);
        
        process_sse_cmd = ['runsse.exe -p prg.v -l ' stVfile.sseDLL];
        system(process_sse_cmd);

        disp([int2str(i),'th of ', int2str(count), ' audio file analyzed']);

    end

     disp('SSE Process Done');

end