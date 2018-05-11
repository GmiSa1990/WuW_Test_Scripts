function score = readResults_chris2
% Read result files of WuW recognition tests and plot the results


resultfolder = 'C:\sse\iot_test\asr_result\compare_4p1_4p2\vocon_result\proc';

% parse the output files
result = parseFiles( resultfolder );

% load result data of first test.
result_1sttest = load('result_1sttest.mat');
aaa.xSNR8dB = result_1sttest.result.x7Mic1Out.xSNR8dB;
aaa.xClean  = result_1sttest.result.x7Mic1Out.xClean;
result.x7Mic1Out_SSE4p1 = aaa;
% fuse the results 
fusefnct = @( x, y ) max( x, y );
fusedData = fuseresults( result, fusefnct );

% apply threshold
threshold = 4500;
score = applyThreshold( fusedData, threshold );

% plot results
algos = {'7Mic2Out_SSE4p1', '7Mic2Out_SSE4p2','7Mic1Out_SSE4p1'};
distances = {'2m', '3m', '4m' };
interference = {'RockMusic_Sax', 'SoftMusic_MyHeartWillGoOn', 'SoftMusic_Memory', 'Speech_TeBieDeZuoYe', 'Clean'};

resulttable = nan( numel(algos), numel(distances), numel(interference) );
for k=1:numel(algos)
    
    allresults = score.(['x' algos{k}]).xSNR8dB; % use 8dB only
    
    fnames = fieldnames( allresults );
    
    for l = 1:numel(distances)
        for m = 1:(numel( interference ) - 1)
           resulttable(k, l, m ) =  allresults.( fnames{  contains( fnames, distances{l} ) & contains( fnames, interference{m} ) } );
        end
    end
    
end

for k=1:numel(algos)
    
    %allresults = score.(['x' algos{k}]).xSNR8dB; % use 8dB only
    allresults = score.(['x' algos{k}]).xClean;
    fnames = fieldnames( allresults );
    
    for l = 1:numel(distances)
        for m = numel( interference )
           resulttable(k, l, m ) =  allresults.( fnames{  contains( fnames, distances{l} ) } );
        end
    end
    
end


figure
for k = 1:numel( distances )
    subplot( numel( distances ), 1, k );
    temp = squeeze( resulttable(:,k,:));
    temp = -diff(temp);
    temp = temp(1,:);
    bar( 1:numel(interference), temp' );
    %bar( 1:numel(interference), squeeze( resulttable(:,k,:) )' );
    set( gca, 'XTick', 1:numel(interference), 'XTickLabel', interference, 'TickLabelInterpreter', 'none' );
    %legend({'SSE4p11','SSE4p2','Ideal BF'},'Location','northeastoutside');
    ylim( [-5 10] );
    if k == 1
    title( {"SSE4p2's decrease in WuW error rate compared to SSE4p1", distances{k}} );
    else
       title( distances{k} );
    end
    grid on;
    ylabel( 'Relative Deletion [%]' );
end


figure(2);
for k = 1:numel( distances )
    subplot( numel( distances ), 1, k );
    bar( 1:numel(interference), squeeze( resulttable(:,k,:) )' );
    set( gca, 'XTick', 1:numel(interference), 'XTickLabel', interference, 'TickLabelInterpreter', 'none' );
    %legend({'SSE4p11','SSE4p2','Ideal BF'},'Location','northeastoutside');
    ylim( [-10 10] );
    title( distances{k} );
    grid on;
    ylabel( 'Relative Deletion of  [%]' );
end


end

function result = parseFiles( resultfolder )

    files = dir( [resultfolder '\*.txt'] );

    result = struct();

    % parse txt output files and store the results in a struct
    for k = 1:numel(files)

        fhndl = fopen( [resultfolder '\' files(k).name ] );

        cline = fgetl( fhndl );

        while( ischar( cline ) )

           % line example:          7Mic2Out/SNR5dB/4m_180D300D_RockMusic_Sax/sse_out2/106252693.wav, 610ms, 1430ms, 4869,
           clinecell = regexp( cline, '(\w*)/(\w*)/(\w*)/(\w*)/(\w*).wav, (\w*)ms, (\w*)ms, (\w*),', 'tokens' );

           if( strcmp( clinecell{1}{4}, 'sse_out1' ) )
              sseoutindx = 1;
           else
              sseoutindx = 2;
           end

           curval = cellfun( @str2num, clinecell{1}( 6:8 ) );

           % result example:  result.x7Mic2Out.xSNR5dB.x4m_180D300D_RockMusic_Sax/x106252693.wav(2,:) = [610, 1430, 4869]
           result.( ['x' clinecell{1}{1}] ).( ['x' clinecell{1}{2}] ).( ['x' clinecell{1}{3}] ).( ['x' clinecell{1}{5}] )( sseoutindx, : ) = curval;


           cline = fgetl( fhndl );
        end

        fclose( fhndl );

    end
end

function result = fuseresults( evldata, fusefnct )
%recursively step through the nested struct

   if( isstruct( evldata ) )
       % still not the lowest level

       fnames = fieldnames( evldata );
       
       % recursively fuse the results of the next level
       tmp = fuseresults( evldata.( fnames{1} ), fusefnct );
       
       if( isnumeric( tmp ) && isscalar( tmp ) )
          % next level is the lowest one => concatenate the results to a vector
          result = zeros( numel(fnames), 1 );
          result(1) = tmp;
          
          for k = 2:numel( fnames )
              result( k ) = fuseresults( evldata.( fnames{k} ), fusefnct );
          end
       else
           % next level is not the lowest one => store the results in a struct
           result = struct();
           
           result.( fnames{1} ) = tmp;
           
           for k = 2:numel( fnames )
              result.( fnames{k} ) = fuseresults( evldata.( fnames{k} ), fusefnct );
           end
       end
       
   else
       % this is the lowest level => apply fusion function to the data and
       % return a scalar result
       if( size( evldata, 1 ) == 2 )
          result = fusefnct( evldata(1,3), evldata(2,3) ) ;
       else
          result = fusefnct( evldata(1,3), 0 ) ;
       end
   end
end


function result = applyThreshold( fusedData, threshold )

   if( isstruct( fusedData ) )

       fnames = fieldnames( fusedData );
       
       for k = 1:numel( fnames )
          result.( fnames{k} ) = applyThreshold( fusedData.( fnames{k} ), threshold );
       end
       
   else
      
       result = 100 - sum( fusedData > threshold ) / 540 * 100; % calculate percentage
       
   end

end