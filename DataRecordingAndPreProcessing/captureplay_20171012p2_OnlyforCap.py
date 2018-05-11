#! python2

import pyaudio
import numpy as np
import time
import math
import soundfile as sf
import os


class cCapturePlay:
    def __init__(self, iCaptureDeviceIndex, iPlaybackDeviceIndex, bDebug=False):
        self.sName = 'cCapturePlay'
        self.bDebug = bDebug
        self.p = pyaudio.PyAudio()
        self.iCaptureDeviceIndex = iCaptureDeviceIndex
        self.iPlaybackDeviceIndex = iPlaybackDeviceIndex
        self.fPollFinishTimeSec = 0.1
        self.reset()

    def __del__(self):
        self.p.terminate()

    def reset(self):
        self.hStream = 0
        self.iChannels = -1
        self.iSamplerate = -1
        self.iFramesize = -1
        self.bCapture = False
        self.bPlayback = True
        self.fTimeSecPerCallback = 0.0
        self.iCaptureChannels = None
        self.iCaptureData = None
        self.iCallbackCount = 0
        self.bCaptureFinishFlag = False
        self.iPlayData = None
        self.iPlaySamplerate = None
        self.iPlayNumSamples = 0
        self.iPlaySampleIndex = 0
        self.iPlayNumChannels = 0
        self.iPlaybackCallbackCount = 0
        self.iPlaySeconds = 0
        self.fCaptureLeadSeconds = 0
        self.iCaptureLeadCallbackCount = 0
        self.fCaptureTrailSeconds = 0
        self.iPlayZeroChunk = None
        self.iPlayAppendChunk = None

    def callback(self, in_data, frame_count, time_info, status):
        self.iCallbackCount = self.iCallbackCount + 1
        # Capture
        if self.bCapture == True:
            if self.bCaptureFinishFlag == False:
                int16Data = np.fromstring(in_data, dtype=np.int16)
                int16DataCh = int16Data.reshape(self.iFramesize, self.iChannels)
                #import pdb;pdb.set_trace()
                self.writeCaptureData(int16DataCh[:, 0:self.iCaptureChannels])
                # self.iCaptureData = np.append(self.iCaptureData, int16DataCh[:, 0:self.iCaptureChannels], axis=0)
                if self.iCallbackCount >= self.iOverallBuffers:
                    self.bCaptureFinishFlag = True
        # Playback
        if self.bPlayback == False:
            out_data = None  #
        else:
            if self.iCallbackCount < self.iCaptureLeadCallbackCount or self.iCallbackCount > self.iCaptureLeadCallbackCount + self.iPlaybackCallbackCount - 1:
                # print "Play zero"
                out_data = self.iPlayZeroChunkInterleaved.tostring()
            else:
                # print "Play data, Sample Index {}".format(self.iPlaySampleIndex)
                iIdxB = self.iPlaySampleIndex
                iIdxE = self.iPlaySampleIndex + self.iFramesize
                self.iPlaySampleIndex = self.iPlaySampleIndex + self.iFramesize
                # import pdb; pdb.set_trace()
                # iPlayChunk = self.iPlayData[iIdxB:iIdxE,:] # Note: Large end index is allowed and only available data is returned
                iPlayChunk = self.iPlayData[iIdxB:iIdxE]
                # Extend zero samples if less data samples from file are available
                L = iPlayChunk.shape[0]
                if L < self.iFramesize:
                    iPlayChunkExtend = np.zeros([self.iFramesize - L, self.iPlayNumChannels], dtype='int16')
                    iPlayChunk = np.append(iPlayChunk, iPlayChunkExtend, axis=0)
                    self.debugText("Extend audio data: {}".format(iPlayChunkExtend.shape))
                    # print "Extend playback samples"
                # print iPlayChunk.shape
                if self.iPlayAppendChunk.size > 1:
                    # Extend channels (zero data) if less channel from file are available
                    iPlayChunk = np.append(iPlayChunk, self.iPlayAppendChunk, axis=1)
                #
                iPlayChunkInterleaved = iPlayChunk.reshape(1, self.iFramesize * self.iChannels)
                out_data = iPlayChunkInterleaved.tostring()
        #
        return (out_data, pyaudio.paContinue)

    def errorText(self, sText):
        print "Error : " + self.sName + " : " + sText

    def infoText(self, sText):
        print "Info : " + self.sName + " : " + sText

    def debugText(self, sText):
        if self.bDebug == True:
            print "Debug : " + self.sName + " : " + sText

    def open(self, iCaptureChannels, iSamplerate, iFramesize):

        if self.bCapture == True:
            i = self.iCaptureDeviceIndex
            deviceInfo = self.p.get_device_info_by_index(i)
            hostApiInfo = self.p.get_host_api_info_by_index(deviceInfo['hostApi'])
            hostApiName = hostApiInfo['name']
            self.infoText(
                'Input  : Global Index ' + str(i) + ' : ' + unicode(hostApiName) + ' : ' + unicode(deviceInfo['name']))
        if self.bPlayback == True:
            i = self.iPlaybackDeviceIndex
            deviceInfo = self.p.get_device_info_by_index(i)
            hostApiInfo = self.p.get_host_api_info_by_index(deviceInfo['hostApi'])
            hostApiName = hostApiInfo['name']
            self.infoText(
                'Output : Global Index ' + str(i) + ' : ' + unicode(hostApiName) + ' : ' + unicode(deviceInfo['name']))
        #
        #import pdb; pdb.set_trace()
        if self.iPlayData is None and self.bPlayback == True:
            self.infoText("Forcing to capture-only because no playback audio file was loaded")
            self.bPlayback = False  # force no playback if no file was loaded
        #
        if self.bPlayback == True:
            if iSamplerate != self.iPlaySamplerate:
                self.errorText("Playback file has a different sample rate as the audio device!")
                return True
        #
        self.iCaptureChannels = iCaptureChannels
        self.iCaptureData = np.empty([0, self.iCaptureChannels])
        self.iChannels = max(self.iCaptureChannels, self.iPlayNumChannels)
        self.iSamplerate = iSamplerate
        self.iFramesize = iFramesize

        self.fTimeSecPerCallback = float(self.iFramesize) / float(self.iSamplerate)
        self.iPlaySeconds = float(self.iPlayNumSamples) / float(self.iSamplerate)

        if self.bPlayback == True:
            iOverallSeconds = self.fCaptureLeadSeconds + self.iPlaySeconds + self.fCaptureTrailSeconds
        else:
            iOverallSeconds = self.fCaptureLeadSeconds + self.fCaptureTimeSeconds + self.fCaptureTrailSeconds

        self.iPlaybackCallbackCount = int(math.ceil(self.iPlaySeconds / self.fTimeSecPerCallback))
        self.iCaptureLeadCallbackCount = int(math.ceil(self.fCaptureLeadSeconds / self.fTimeSecPerCallback))

        self.iPlayZeroChunk = np.zeros([self.iFramesize, self.iChannels], dtype='int16')
        self.iPlayZeroChunkInterleaved = self.iPlayZeroChunk.reshape(1, self.iFramesize * self.iChannels)

        if (self.iChannels > self.iPlayNumChannels):
            self.iPlayAppendChunk = np.zeros([self.iFramesize, self.iChannels - self.iPlayNumChannels], dtype='int16')
        else:
            self.iPlayAppendChunk = None

        self.iOverallBuffers = int(math.ceil(iOverallSeconds / self.fTimeSecPerCallback))
        self.infoText("Overall capture time: {} s".format(iOverallSeconds))

        #
        sampleFormat = pyaudio.paInt16
        self.hStream = self.p.open(format=sampleFormat,
                                   channels=self.iChannels,
                                   rate=self.iSamplerate,
                                   input=self.bCapture,
                                   input_device_index=self.iCaptureDeviceIndex,
                                   output=self.bPlayback,
                                   output_device_index=self.iPlaybackDeviceIndex,
                                   frames_per_buffer=self.iFramesize,
                                   start=False,
                                   stream_callback=self.callback)

        return False

    def start(self):
        self.hStream.start_stream()

    def stop(self):
        self.hStream.stop_stream()

    def close(self):
        self.hStream.stop_stream()
        self.hStream.close()

    def waitUntilFinished(self):
        cInterrupt = None
        bFinish = False
        print "Enter Any Charactor to Interrupt recording:"
        while bFinish == False:
            cInterrupt = raw_input()
            if cInterrupt != None:
                bFinish = True
            else:
                time.sleep(self.fPollFinishTimeSec)
                if self.getCallbackCount() > self.iOverallBuffers:
                    bFinish = True

    def save(self, sFile):
        sf.write(sFile, self.iCaptureData / 32768, self.iSamplerate)
        self.infoText("Captured audio data saved to: {}".format(sFile))

    def setupWriteFileHandle(self, file, iCaptureChannels, iSamplerate, subtype=None, endian=None, format=None,
                             closefd=True):
        self.captureFileHandle = sf.SoundFile(file, 'w', iSamplerate, iCaptureChannels, subtype, endian,
                                              format, closefd)

    def closeWriteFileHandle(self, file):
        self.captureFileHandle.close()
        self.infoText("Captured audio data saved to: {}".format(file))

    def writeCaptureData(self, data):
        self.captureFileHandle.write(data)

    def setupCapture(self, fCaptureTimeSeconds, fCaptureLeadSeconds=0.0, fCaptureTrailSeconds=0.0):
        self.bCapture = True
        self.bPlayback = False
        self.fCaptureLeadSeconds = fCaptureLeadSeconds
        self.fCaptureTimeSeconds = fCaptureTimeSeconds
        self.fCaptureTrailSeconds = fCaptureTrailSeconds
        self.iPlayData = None

    def setupPlayCapture(self, sFile, fCaptureLeadSeconds=0.0, fCaptureTrailSeconds=0.0):
        self.bCapture = True
        self.bPlayback = True
        self.fCaptureLeadSeconds = fCaptureLeadSeconds
        self.fCaptureTrailSeconds = fCaptureTrailSeconds
        if sFile != None:
            # load wav file
            self.iPlayData, self.iPlaySamplerate = sf.read(sFile, dtype='int16')
            self.iPlayNumSamples = self.iPlayData.shape[0]
            if len(self.iPlayData.shape) == 1:
                self.iPlayNumChannels = 1
            else:
                self.iPlayNumChannels = self.iPlayData.shape[1]

    def getFinishFlag(self):
        return self.bCaptureFinishFlag

    def getCallbackCount(self):
        return self.iCallbackCount

    def go(self, iCaptureChannels, iSamplerate, iFramesize, sCaptureFile):
        self.setupWriteFileHandle(sCaptureFile, iCaptureChannels, iSamplerate)
        bError = self.open(iCaptureChannels, iSamplerate, iFramesize)
        if bError == False:
            self.start()
            self.waitUntilFinished()
            self.stop()
            self.close()
            # self.save(sCaptureFile)
        self.closeWriteFileHandle(sCaptureFile)
        self.reset()


# ===============================================

sOriginalFolder = r'C:\NuanceSSE\RD\CapturePlay_for_SEC_20171011\speech_exclude_car_ForCalibration'
sDesireFolder = r'C:\NuanceSSE\RD\CapturePlay_for_SEC_20171011\speech_exclude_car_ForCalibrationTrial'


sSrcFilenames = None
sDstFilenames = None
sFolder = None
sCurrentFolder = None

iCaptureDeviceIndex = 44
iPlaybackDeviceIndex = 44
iSamplerate = 44100
iFramesize = 1024
iCaptureChannels = 7

### Global Index 0 : MME : Microsoft Sound Mapper - Input
### Global Index 1 : MME : Jack Mic (Realtek Audio)
### Global Index 2 : MME : Microphone Array (Realtek Audio
### Global Index 3 : MME : Microsoft Sound Mapper - Output
### Global Index 4 : MME : Speakers / Headphones (Realtek
### Global Index 5 : MME : C24F390 (Intel(R) Display Audio
# iCaptureDeviceIndex = 0
# iPlaybackDeviceIndex = 3
# iCaptureChannels = 2
fCaptureLeadSeconds = 1.0
fCaptureTrailSeconds = 1.0

a00 = cCapturePlay(iCaptureDeviceIndex, iPlaybackDeviceIndex)
#
#if os.path.exists(sDesireFolder) == False:
#    os.mkdir(sDesireFolder)
#
#for root, dirs, files in os.walk(sOriginalFolder):
#
#    for SrcFilenames in files:
#        sSrcFilenames = os.path.join(root, SrcFilenames)
#        sDstFilenames = sSrcFilenames.replace(sOriginalFolder, sDesireFolder)
#        sCurrentSubFolder = sDstFilenames.replace(sDesireFolder, '')
#        sCurrentSubFolder = sCurrentSubFolder.replace(SrcFilenames, '')
#
#        sCurrentFolder = sDesireFolder
#        for sFolders in sCurrentSubFolder.split('\\'):
#            sCurrentFolder = os.path.join(sCurrentFolder, sFolders)
#            if os.path.exists(sCurrentFolder) == False:
#                os.mkdir(sCurrentFolder)
#
#        a00.setupPlayCapture(sSrcFilenames, fCaptureLeadSeconds, fCaptureTrailSeconds)
#        a00.go(iCaptureChannels, iSamplerate, iFramesize, sDstFilenames)
#        print(sSrcFilenames.replace(sOriginalFolder, '') + ' done')


# def walk(self, dir, meth):
#     """ walks a directory, and executes a callback on each file """
#     dir = os.path.abspath(dir)
#     for file in [file for file in os.listdir(dir) if not file in [".", ".."]]:
#         nfile = os.path.join(dir, file)
#         meth(nfile)
#         if os.path.isdir(nfile):
#             self.walk(nfile, meth)
#
# == == == == == == == == == == == == == == == == == == == == == == == =
#
# # use info.py to get the required device indices
# iCaptureDeviceIndex = 44
# iPlaybackDeviceIndex = 44
#
# # --------------
# iSamplerate = 48000
# iFramesize = 1024
# iCaptureChannels = 2
#
# fCaptureLeadSeconds = 1.0
# fCaptureTrailSeconds = 1.0
#
# a00 = cCapturePlay(iCaptureDeviceIndex, iPlaybackDeviceIndex)
#
# print "Test 001: Capture 2 channels, play 2 channels"
# try:
#     sPlaybackFile = "2ch_sine330hz_48000.wav"
#     sCaptureFile = "capture001.wav"
#     a00.setupPlayCapture(sPlaybackFile, fCaptureLeadSeconds, fCaptureTrailSeconds)
#     a00.go(iCaptureChannels, iSamplerate, iFramesize, sCaptureFile)
#     print "Test 001 --> OK"
# except:
#     print "Test 001 --> FAILED"
# print ""
#
# print "Test 002: Capture 2 channels, play 2 channels, Audio File 16000 Hz sample rate --> Test must fail with error message"
# try:
#     sPlaybackFile = "2ch_sine330hz_16000.wav"
#     sCaptureFile = "capture002.wav"
#     a00.setupPlayCapture(sPlaybackFile, fCaptureLeadSeconds, fCaptureTrailSeconds)
#     a00.go(iCaptureChannels, iSamplerate, iFramesize, sCaptureFile)
#     print "Test 002 --> OK"
# except:
#     print "Test 002 --> FAILED"
# print ""
#
# print "Test 003: Capture 2 channels, play 2 channels @ 16000 Hz sample rate"
# try:
#     sPlaybackFile = "2ch_sine330hz_16000.wav"
#     sCaptureFile = "capture003.wav"
#     a00.setupPlayCapture(sPlaybackFile, fCaptureLeadSeconds, fCaptureTrailSeconds)
#     a00.go(iCaptureChannels, 16000, iFramesize, sCaptureFile)
#     print "Test 003 --> OK"
# except:
#     print "Test 003 --> FAILED (For ASIO a failed test is most likely due to a different sample rate of the audio device (ASIO does not automatic sample rate conversion!)"
# print ""
#
print "Test 004: Capture 7 channels"
sCaptureFile = "Inteference_60D_Music_Rock.wav"
fCaptureSeconds = 1200.0
a00.setupCapture(fCaptureSeconds)
a00.go(iCaptureChannels, iSamplerate, iFramesize, sCaptureFile)
print "Test 004 --> OK"
print ""
#
# print "Test 005: Capture 5 channels, play 2 channels"
# try:
#     sPlaybackFile = "2ch_sine330hz_48000.wav"
#     sCaptureFile = "capture005.wav"
#     a00.setupPlayCapture(sPlaybackFile, fCaptureLeadSeconds, fCaptureTrailSeconds)
#     a00.go(4, iSamplerate, iFramesize, sCaptureFile)
#     print "Test 005 --> OK"
# except:
#     print "Test 005 --> FAILED"
# print ""
