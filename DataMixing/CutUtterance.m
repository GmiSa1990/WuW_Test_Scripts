function [fCuttedLongInputAudio, iOffset] = CutUtterance(fLongInputAudio, fShortInputAudio, iOffset, iProcessedAudioLength)

    iLength = length(fShortInputAudio);

    if iProcessedAudioLength > 1+iOffset+iLength

        fCuttedLongInputAudio = fLongInputAudio(1+iOffset:iOffset+iLength);
        iOffset = iOffset + iLength;
    else
        fCuttedLongInputAudio = fLongInputAudio(1+iOffset:iProcessedAudioLength);
        iOffset = iProcessedAudioLength;
    end        

end