function [interfered_ch0,interfered_ch1,interfered_ch2,interfered_ch3,interfered_ch4,interfered_ch5,interfered_ch6] = add_interference_rescaled_7ch(raw_micinput_location,raw_interinput_location,SNRratio_dB,smooth_window,noise_tolerate)

    micinput_file_ch0 = [raw_micinput_location,'ch0.wav'];
    micinput_file_ch1 = [raw_micinput_location,'ch1.wav'];
    micinput_file_ch2 = [raw_micinput_location,'ch2.wav'];
    micinput_file_ch3 = [raw_micinput_location,'ch3.wav'];
    micinput_file_ch4 = [raw_micinput_location,'ch4.wav'];
    micinput_file_ch5 = [raw_micinput_location,'ch5.wav'];
    micinput_file_ch6 = [raw_micinput_location,'ch6.wav'];
    
    interinput_file_ch0 = [raw_interinput_location,'ch0.wav'];
    interinput_file_ch1 = [raw_interinput_location,'ch1.wav'];
    interinput_file_ch2 = [raw_interinput_location,'ch2.wav'];
    interinput_file_ch3 = [raw_interinput_location,'ch3.wav'];
    interinput_file_ch4 = [raw_interinput_location,'ch4.wav'];
    interinput_file_ch5 = [raw_interinput_location,'ch5.wav'];
    interinput_file_ch6 = [raw_interinput_location,'ch6.wav'];

    [micinput_ch0,~] = audioread(micinput_file_ch0);
    [micinput_ch1,~] = audioread(micinput_file_ch1);
    [micinput_ch2,~] = audioread(micinput_file_ch2);
    [micinput_ch3,~] = audioread(micinput_file_ch3);
    [micinput_ch4,~] = audioread(micinput_file_ch4);
    [micinput_ch5,~] = audioread(micinput_file_ch5);
    [micinput_ch6,~] = audioread(micinput_file_ch6);
    
    [interinput_ch0,~] = audioread(interinput_file_ch0);
    [interinput_ch1,~] = audioread(interinput_file_ch1);
    [interinput_ch2,~] = audioread(interinput_file_ch2);
    [interinput_ch3,~] = audioread(interinput_file_ch3);
    [interinput_ch4,~] = audioread(interinput_file_ch4);
    [interinput_ch5,~] = audioread(interinput_file_ch5);
    [interinput_ch6,~] = audioread(interinput_file_ch6);
    
    l_mic = length(micinput_ch0);
    l_inter = length(interinput_ch0);

    if l_mic ~= 0
        rand_index = 1 + floor(rand*(l_inter - l_mic));          

        selected_inter_ch0 = interinput_ch0(rand_index:rand_index+l_mic-1);
        selected_inter_ch1 = interinput_ch1(rand_index:rand_index+l_mic-1);
        selected_inter_ch2 = interinput_ch2(rand_index:rand_index+l_mic-1);
        selected_inter_ch3 = interinput_ch3(rand_index:rand_index+l_mic-1);
        selected_inter_ch4 = interinput_ch4(rand_index:rand_index+l_mic-1);
        selected_inter_ch5 = interinput_ch5(rand_index:rand_index+l_mic-1);
        selected_inter_ch6 = interinput_ch6(rand_index:rand_index+l_mic-1);

        if ~isempty(SNRratio_dB)

            %------------------------------------------------------
            % use simple voice activity detection and average
            % only over blocks where we actually have speech power
            %------------------------------------------------------
            L_blks = ceil(length(micinput_ch0) / 256);
            L_zpad = L_blks * 256 - length(micinput_ch0);
            
            
            blk_pwr_ch0 = mean(reshape([micinput_ch0;zeros(L_zpad, 1)].^2, 256, L_blks),1);
            s_blk_pwr_ch0 = smoothdata(blk_pwr_ch0,'movmean',smooth_window);
            [LowLimit_blk_per_ch0,~] = min(s_blk_pwr_ch0);
            noise_index_blk_pwr_ch0 = find(s_blk_pwr_ch0 >= LowLimit_blk_per_ch0.*noise_tolerate);
            micinput_ch0_RMS = sqrt(mean(blk_pwr_ch0(noise_index_blk_pwr_ch0)));
            
            blk_pwr_ch1 = mean(reshape([micinput_ch1;zeros(L_zpad, 1)].^2, 256, L_blks),1);                
            s_blk_pwr_ch1 = smoothdata(blk_pwr_ch1,'movmean',smooth_window);
            [LowLimit_blk_per_ch1,~] = min(s_blk_pwr_ch1);
            noise_index_blk_pwr_ch1 = find(s_blk_pwr_ch1 >= LowLimit_blk_per_ch1.*noise_tolerate);
            micinput_ch1_RMS = sqrt(mean(blk_pwr_ch1(noise_index_blk_pwr_ch1)));
            
            blk_pwr_ch2 = mean(reshape([micinput_ch2;zeros(L_zpad, 1)].^2, 256, L_blks),1);                
            s_blk_pwr_ch2 = smoothdata(blk_pwr_ch2,'movmean',smooth_window);
            [LowLimit_blk_per_ch2,~] = min(s_blk_pwr_ch2);
            noise_index_blk_pwr_ch2 = find(s_blk_pwr_ch2 >= LowLimit_blk_per_ch2.*noise_tolerate);
            micinput_ch2_RMS = sqrt(mean(blk_pwr_ch2(noise_index_blk_pwr_ch2)));
            
            blk_pwr_ch3 = mean(reshape([micinput_ch3;zeros(L_zpad, 1)].^2, 256, L_blks),1);                
            s_blk_pwr_ch3 = smoothdata(blk_pwr_ch3,'movmean',smooth_window);
            [LowLimit_blk_per_ch3,~] = min(s_blk_pwr_ch3);
            noise_index_blk_pwr_ch3 = find(s_blk_pwr_ch3 >= LowLimit_blk_per_ch3.*noise_tolerate);
            micinput_ch3_RMS = sqrt(mean(blk_pwr_ch3(noise_index_blk_pwr_ch3)));
            
            blk_pwr_ch4 = mean(reshape([micinput_ch4;zeros(L_zpad, 1)].^2, 256, L_blks),1);                
            s_blk_pwr_ch4 = smoothdata(blk_pwr_ch4,'movmean',smooth_window);
            [LowLimit_blk_per_ch4,~] = min(s_blk_pwr_ch4);
            noise_index_blk_pwr_ch4 = find(s_blk_pwr_ch4 >= LowLimit_blk_per_ch4.*noise_tolerate);
            micinput_ch4_RMS = sqrt(mean(blk_pwr_ch4(noise_index_blk_pwr_ch4)));
            
            blk_pwr_ch5 = mean(reshape([micinput_ch5;zeros(L_zpad, 1)].^2, 256, L_blks),1);                
            s_blk_pwr_ch5 = smoothdata(blk_pwr_ch5,'movmean',smooth_window);
            [LowLimit_blk_per_ch5,~] = min(s_blk_pwr_ch5);
            noise_index_blk_pwr_ch5 = find(s_blk_pwr_ch5 >= LowLimit_blk_per_ch5.*noise_tolerate);
            micinput_ch5_RMS = sqrt(mean(blk_pwr_ch5(noise_index_blk_pwr_ch5)));
            
            blk_pwr_ch6 = mean(reshape([micinput_ch6;zeros(L_zpad, 1)].^2, 256, L_blks),1);                
            s_blk_pwr_ch6 = smoothdata(blk_pwr_ch6,'movmean',smooth_window);
            [LowLimit_blk_per_ch6,~] = min(s_blk_pwr_ch6);
            noise_index_blk_pwr_ch6 = find(s_blk_pwr_ch6 >= LowLimit_blk_per_ch6.*noise_tolerate);
            micinput_ch6_RMS = sqrt(mean(blk_pwr_ch6(noise_index_blk_pwr_ch6)));
            
            micinput_allRMS = [micinput_ch0_RMS, micinput_ch1_RMS, micinput_ch2_RMS, micinput_ch3_RMS, micinput_ch4_RMS, micinput_ch5_RMS,micinput_ch6_RMS];
            
            [micinput_RMS,~] = max(micinput_allRMS);

            %-----------------------------------------------
            % calculate mean interference power over entire signal
            %-----------------------------------------------
            selectinter_ch0_RMS = sqrt(mean(selected_inter_ch0.^2));
            selectinter_ch1_RMS = sqrt(mean(selected_inter_ch1.^2));
            selectinter_ch2_RMS = sqrt(mean(selected_inter_ch2.^2));
            selectinter_ch3_RMS = sqrt(mean(selected_inter_ch3.^2));
            selectinter_ch4_RMS = sqrt(mean(selected_inter_ch4.^2));
            selectinter_ch5_RMS = sqrt(mean(selected_inter_ch5.^2));
            selectinter_ch6_RMS = sqrt(mean(selected_inter_ch6.^2));
            selectinter_allRMS = [selectinter_ch0_RMS, selectinter_ch1_RMS, selectinter_ch2_RMS, selectinter_ch3_RMS, selectinter_ch4_RMS, selectinter_ch5_RMS, selectinter_ch6_RMS];
            selectinter_RMS = mean(selectinter_allRMS);


            %----------------------------
            % change ratio in dB to Linear
            %----------------------------
            ratio_Linear = 10.^(SNRratio_dB./20);
            mixinter_ratio = micinput_RMS./selectinter_RMS./ratio_Linear;
            
            %----------------------------
            % mix data with given weight
            %----------------------------
            weightedinter_ch0 = selected_inter_ch0.*mixinter_ratio;
            weightedinter_ch1 = selected_inter_ch1.*mixinter_ratio;
            weightedinter_ch2 = selected_inter_ch2.*mixinter_ratio;
            weightedinter_ch3 = selected_inter_ch3.*mixinter_ratio;
            weightedinter_ch4 = selected_inter_ch4.*mixinter_ratio;
            weightedinter_ch5 = selected_inter_ch5.*mixinter_ratio;
            weightedinter_ch6 = selected_inter_ch6.*mixinter_ratio;

            interfered_ch0 = micinput_ch0 + weightedinter_ch0;
            interfered_ch1 = micinput_ch1 + weightedinter_ch1;
            interfered_ch2 = micinput_ch2 + weightedinter_ch2;
            interfered_ch3 = micinput_ch3 + weightedinter_ch3;
            interfered_ch4 = micinput_ch4 + weightedinter_ch4;
            interfered_ch5 = micinput_ch5 + weightedinter_ch5;
            interfered_ch6 = micinput_ch6 + weightedinter_ch6;

%             %-----------------------------------------------
%             % calculate mean interference power over entire signal
%             %-----------------------------------------------
%             selectinter_ch0_RMS = sqrt(mean(weightedinter_ch0.^2));
%             selectinter_ch1_RMS = sqrt(mean(weightedinter_ch1.^2));
%             selectinter_ch2_RMS = sqrt(mean(weightedinter_ch2.^2));
%             selectinter_ch3_RMS = sqrt(mean(weightedinter_ch3.^2));
%             selectinter_ch4_RMS = sqrt(mean(weightedinter_ch4.^2));
%             selectinter_ch5_RMS = sqrt(mean(weightedinter_ch5.^2));
%             selectinter_ch6_RMS = sqrt(mean(weightedinter_ch6.^2));
%             selectinter_allRMS = [selectinter_ch0_RMS, selectinter_ch1_RMS, selectinter_ch2_RMS, selectinter_ch3_RMS, selectinter_ch4_RMS, selectinter_ch5_RMS, selectinter_ch6_RMS];
%             selectinter_RMS = mean(selectinter_allRMS);
%             
%             %-----------------------------------------
%             % calculate SIR!
%             %-----------------------------------------
%             SIR = round(20.*log10(micinput_RMS ./ selectinter_RMS));  
            
        else
            interfered_ch0 = micinput_ch0 + selected_inter_ch0;
            interfered_ch1 = micinput_ch1 + selected_inter_ch1;
            interfered_ch2 = micinput_ch2 + selected_inter_ch2;
            interfered_ch3 = micinput_ch3 + selected_inter_ch3;
            interfered_ch4 = micinput_ch4 + selected_inter_ch4;
            interfered_ch5 = micinput_ch5 + selected_inter_ch5;
            interfered_ch6 = micinput_ch6 + selected_inter_ch6;
            

%             %-----------------------------------------------
%             % calculate mean interference power over entire signal
%             %-----------------------------------------------
%             selectinter_ch0_RMS = sqrt(mean(selected_inter_ch0.^2));
%             selectinter_ch1_RMS = sqrt(mean(selected_inter_ch1.^2));
%             selectinter_ch2_RMS = sqrt(mean(selected_inter_ch2.^2));
%             selectinter_ch3_RMS = sqrt(mean(selected_inter_ch3.^2));
%             selectinter_ch4_RMS = sqrt(mean(selected_inter_ch4.^2));
%             selectinter_ch5_RMS = sqrt(mean(selected_inter_ch5.^2));
%             selectinter_ch6_RMS = sqrt(mean(selected_inter_ch6.^2));
%             selectinter_allRMS = [selectinter_ch0_RMS, selectinter_ch1_RMS, selectinter_ch2_RMS, selectinter_ch3_RMS, selectinter_ch4_RMS, selectinter_ch5_RMS, selectinter_ch6_RMS];
%             selectinter_RMS = mean(selectinter_allRMS);
%             
%             %-----------------------------------------
%             % calculate SIR!
%             %-----------------------------------------
%             SIR = round(20.*log10(micinput_RMS ./ selectinter_RMS));              
            
        end


        
        
    end



end