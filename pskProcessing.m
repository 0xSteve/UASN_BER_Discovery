%recordTime in sec 
function PSKprocessing(numberOffiles,recordTime,TypeOfModulation)
format long e
factor = 1000;
for i=1:numberOffiles

    
impulseResponse = strcat('isovelocity-',int2str(i),'.arr');
%Reads The PSK.wav file into s1
%[s1,Fs]=audioread('QPSK_output.wav')

%Upsamples s1 and create s2  because delay and sum will downsample this by 2
%s2=upsample(s1,2)

%Writing the upsampled signal to a .wav file
%audiowrite('inputSig.wav',s2,96000,'BitsPerSample',16)
travelDistTime=i/1.5
AdjustedrecordTime=recordTime+travelDistTime
%calling the delayandsum- impulseResponse is a string with the name of .arr
%file  for example impulseResponse='goff_random_20pc_2km_E_no1.arr'
[rts,sample_rate]=delayandsum(impulseResponse,AdjustedrecordTime,TypeOfModulation);

%normalize rts 
%normalized=(rts-min(rts))/(max(rts)-min(rts)); %only works for positive
%numbers.
%time=[0:size(rts)-1]*1/sample_rate;
%plot(time,normalized);
%savefig('normalized.fig');p

%plot(time,rts);
%savefig('original.fig');
%writing the output signal of delayandsum into a wav file to be processed
%by gnuradio
if TypeOfModulation =='QPSK'
    output=strcat('QPSK_Output/isovelocity-',int2str(i),'.wav');
elseif TypeOfModulation =='BPSK'
        output=strcat('BPSK_Output/','isovelocity-',int2str(i),'.wav');
end

audiowrite(output,rts*factor,sample_rate,'BitsPerSample',16)

end

disp('Done!')