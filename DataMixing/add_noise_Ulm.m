function add_noise(ori_audio_location,SNR)
    
    ori_speech_location = [ori_audio_location,'clean\'];
    ori_noise_location = [ori_audio_location,'noise\'];
    ori_noisy_location = [ori_audio_location,'noisy\'];

    file_name_noise_ch0 = [ori_noise_location,'channel0.pcm'];
    file_name_noise_ch1 = [ori_noise_location,'channel1.pcm'];

    
    ori_speech_location_ch0 = [ori_speech_location,'ch0\'];
    ori_speech_location_ch1 = [ori_speech_location,'ch1\'];

    speech_list_ch0 = getAllFiles(ori_speech_location_ch0);
    speech_list_ch1 = getAllFiles(ori_speech_location_ch1);

    count = size(speech_list_ch0,1); 
    
    h_noise_ch0 = fopen(file_name_noise_ch0,'r');
    h_noise_ch1 = fopen(file_name_noise_ch1,'r');
    
    noise_raw_ch0 = fread(h_noise_ch0,'int16','l');
    noise_raw_ch1 = fread(h_noise_ch1,'int16','l');

    l_noise = length(noise_raw_ch0);
    
%     rng(10); % make results reproducible
    
    for i = 1:count
        % i
        speech_location_ch0 = char(speech_list_ch0(i));
        speech_location_ch1 = char(speech_list_ch1(i));
        slash_index = strfind(speech_location_ch0,'\');
        
        noisy_location_ch0 = [ori_noisy_location, speech_location_ch0(slash_index(end-2)+1:end-12),int2str(SNR),'dB_channel0.pcm'];
        noisy_location_ch1 = [ori_noisy_location, speech_location_ch1(slash_index(end-2)+1:end-12),int2str(SNR),'dB_channel1.pcm'];
        
        
        
        h_src0 = fopen(speech_location_ch0,'r');
        h_src1 = fopen(speech_location_ch1,'r');
        raw_data_ch0 = fread(h_src0,'int16','l');
        raw_data_ch1 = fread(h_src1,'int16','l');
        
        l_raw = length(raw_data_ch0);
    
        if l_raw ~= 0
            % rand_index = unidrnd(l_noise - l_raw);
            rand_index = 1 + floor(rand*(l_noise - l_raw));          

            selected_noise_channel0 = floor(noise_raw_ch0(rand_index:rand_index+l_raw-1));
            selected_noise_channel1 = floor(noise_raw_ch1(rand_index:rand_index+l_raw-1));
            
            if ~isempty(SNR)

                %------------------------------------------------------
                % use simple voice activity detection and average
                % only over blocks where we actually have speech power
                %------------------------------------------------------
                L_zpad = mod(length(raw_data_ch0), 256);
                L_blks = length(raw_data_ch0) / 256;
                blk_pwr_ch0 = mean(reshape([raw_data_ch0 zeros(L_zpad, 1)].^2, 256, L_blks),1);                
                raw_data_ch0_RMS = sqrt(mean(blk_pwr_ch0(find(blk_pwr_ch0 > 2500))));
                blk_pwr_ch1 = mean(reshape([raw_data_ch1 zeros(L_zpad, 1)].^2, 256, L_blks),1);                
                raw_data_ch1_RMS = sqrt(mean(blk_pwr_ch1(find(blk_pwr_ch1 > 2500))));
                raw_data_RMS = max(raw_data_ch0_RMS, raw_data_ch1_RMS);

                %-----------------------------------------------
                % calculate mean noise power over entire signal
                %-----------------------------------------------
                noise_raw_ch0_RMS = sqrt(mean(selected_noise_channel0.^2));
                noise_raw_ch1_RMS = sqrt(mean(selected_noise_channel1.^2));
                noise_raw_RMS = 0.5*(noise_raw_ch0_RMS+noise_raw_ch1_RMS);
                
                %-----------------------------------------
                % calculate one weight for both channels!
                %-----------------------------------------
                isSNR = raw_data_RMS / noise_raw_RMS;
                targetSNR = 10^(SNR/20);
                weight = isSNR / targetSNR;
                
                %----------------------------
                % mix data with given weight
                %----------------------------
                noise_data_ch0 = round(selected_noise_channel0.*weight);
                noise_data_ch1 = round(selected_noise_channel1.*weight);
                
                noisy_data_ch0 = raw_data_ch0 + noise_data_ch0;
                noisy_data_ch1 = raw_data_ch1 + noise_data_ch1;
                
            else
                noisy_data_ch0 = raw_data_ch0 + selected_noise_channel0;
                noisy_data_ch1 = raw_data_ch1 + selected_noise_channel1;
            end

            
        else
            noisy_data_ch0 = [];
            noisy_data_ch1 = [];
        end

        h_arch_ch0 = fopen(noisy_location_ch0,'w+');
        h_arch_ch1 = fopen(noisy_location_ch1,'w+');
        
        fwrite(h_arch_ch0,noisy_data_ch0,'int16','l');        
        fwrite(h_arch_ch1,noisy_data_ch1,'int16','l');
        
        fclose(h_src0);
        fclose(h_src1);
        fclose(h_arch_ch0);
        fclose(h_arch_ch1);
        
    end
    
    fclose(h_noise_ch0);
    fclose(h_noise_ch1);

end