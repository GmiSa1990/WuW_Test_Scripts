function fMixedAudio = LoopInterferenceWithWuW(fWuWAudio, fInterAudio)

%--------------------------------------------------------------------------
% Currently, only consider situation when Interference Length < WuW length
%--------------------------------------------------------------------------

iWuWLen = length(fWuWAudio);
iInterLen = length(fInterAudio);

iRepNum = floor(iWuWLen./iInterLen);
iPatNum = rem(iWuWLen,iInterLen);

fLoopedInterAudio = repmat(fInterAudio, iRepNum, 1);
fLoopedInterAudio = [fLoopedInterAudio; fInterAudio(1:iPatNum)];

fMixedAudio = fWuWAudio + fLoopedInterAudio;

end