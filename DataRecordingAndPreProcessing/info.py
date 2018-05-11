import pyaudio

p = pyaudio.PyAudio()

sReqHostApi = "asio"
sReqDeviceNameList = ["maya44usb"]
resultDict = {}

L = p.get_device_count()

for i in range(0, L):
   deviceInfo = p.get_device_info_by_index(i)
   hostApiInfo = p.get_host_api_info_by_index(deviceInfo['hostApi'])
   hostApiName = hostApiInfo['name']
   print('### Global Index ' + str(i) + ' : ' + str(hostApiName) + ' : ' + str(deviceInfo['name']))
   if sReqHostApi.lower() in hostApiName.lower():
      for sReqName in sReqDeviceNameList:
         if sReqName.lower() in deviceInfo['name'].lower():
            if sReqName in resultDict.keys():
               lTmp = resultDict[sReqName]
               lTmp.append(i)
               resultDict[sReqName] = lTmp
            else:
               resultDict[sReqName] = [i]

print(str(resultDict))            
    
    



