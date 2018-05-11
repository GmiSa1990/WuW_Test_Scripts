
//input bsd[0]   = "iot_sse41_7mic_0ref_2out_asl_abf_spf_sdr.scd"
//input bsd[0]   = "iot_sse41_7mic_0ref_1out_abf_spf_sdr.scd"
input bsd[0]   = "iot_sse42_test.scd"




input micin[0] = ".\signals\ch0.wav"
input micin[1] = ".\signals\ch1.wav"
input micin[2] = ".\signals\ch2.wav"
input micin[3] = ".\signals\ch3.wav"
input micin[4] = ".\signals\ch4.wav"
input micin[5] = ".\signals\ch5.wav"
input micin[6] = ".\signals\ch6.wav"

//input micin[0] = ".\signals\mic_7.wav"

output micout[0] 	= ".\proc\sse_out1.wav"
output micout[1] 	= ".\proc\sse_out2.wav"




sse_FrameShift = 256
sse_SampleRate = 16000


begin

end

