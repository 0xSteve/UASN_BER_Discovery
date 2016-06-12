#!/bin/bash
#create a directory for the log files
mkdir logs
mkdir logs/resultsfilters64POLY
#run BPSK-Sender to generate outputBinary file (this is performed only once) MAKE SURE BPSK-Sender and BPSK_ReceiverPOLY.py have the same interpolation rate.
arrivalFilename="goff_random_80pc_5km_E_no"
NoF=100
for ((y=1; y<=$NoF; y++))
do
#do the below for each arrival file
for ((SNR=-20; SNR<=30; SNR=SNR+5))
do
# input of receiver is as follow inputwave_file, outputBinaryfile
sp="_"
outputfile="$arrivalFilename$y"'/filters64POLY/'"outputBinary$y$sp$SNR"
inputfile="$arrivalFilename$y/$arrivalFilename$y"'SNR'"$SNR.wav"
#Starting Correlation and preparing inputfiles
python2.7 RIN.py inputBinary >>logs/logfileRIN
python2.7 ROUT.py $outputfile >>logs/logfileROUT
done
wait ${!}
done
wait ${!}



#y is the number of arrival files you are trying to process
for ((y=1; y<=$NoF; y++))
do
#do the below for each arrival file
for ((SNR=-20; SNR<=30; SNR=SNR+5))
do
# input of receiver is as follow inputwave_file, outputBinaryfile
sp="_"
outputfile="$arrivalFilename$y"'/filters64POLY/'"outputBinary$y$sp$SNR"
inputfile="$arrivalFilename$y/$arrivalFilename$y"'SNR'"$SNR.wav"

outputBinaryFile=$outputfile"OUT"
#Starting matlab and running Correlation
cat <<EOF | matlab -nodesktop -nosplash -nodisplay />logs/resultsfilters64POLY/myresult$y$SNR.out
import java.lang.System;
A=CorrelateGnuRadio('inputBinaryIN','$outputBinaryFile')
java.lang.System.exit(0);
exit
EOF
wait ${!}
done
done



