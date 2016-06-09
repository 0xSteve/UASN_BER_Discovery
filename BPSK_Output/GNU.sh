#!/bin/bash
#last
# Run the receiver with different inputwav file substitutes the 2 in the below line to the number of input wave files.
mkdir logs
for y in {1..50}
do
mkdir Results$y
python2.7 BPSK_Sender-M.py 0
  for SNR in 1 5 10 15 20 25 30 35 40 45 50 80 100 500
  do
#Run The receiver with different inputs
# input of receiver is as follow SNR, inputwave_file, outputBinaryfile, delay
# leave the first delay to be 0 as shown in the following example
  c=$y$SNR
  sp="_"
  outputfile="Results$y"'/'"outputBinary$y$sp$SNR"
  inputfile= "downward_refracting-$y.wav"
  echo $outputfile
python2.7 BPSK_ReceiverPOLY.py $SNR  $inputfile $outputfile 0 & >>logs/logfileBPSKRX
  wait ${!}

#Starting Correlation and preparing inputfiles
  python2.7 RIN.py inputBinary >>logs/logfileRIN
  python2.7 ROUT.py $outputfile >>logs/logfileROUT


outputBinaryFile=$outputfile"OUT"
#Starting matlab and running Correlation
cat <<EOF | matlab -nodesktop -nosplash -nodisplay />logs/myresult.out
import java.lang.System;
A=CorrelateGnuRadio('inputBinaryIN','$outputBinaryFile')
java.lang.System.exit(0);
exit
EOF

wait ${!}

#extract the new delay
#a=$(grep 'lagDiff=\+' myresult.out | grep  -o "[^=|.]\d\+")
a=$(grep 'lagDiff=\+' logs/myresult.out | grep  -o "[-]*[0-9]\+")
echo "THIS IS THE RESULT OF CORRELATION $a"

#check if delay is negative proceed with removing the negative sign and set delay in receiver Otherwise change delay in sender
if [ $a != 0 ];
then
echo "not equal 0"
regex=^[-]
if [[ $a =~ $regex ]]; then
  #remove negative sign
   b=${a:1}
 echo "THIS IS if -ve correlation" $b
  #run same as above except now with new delay
  python2.7 BPSK_ReceiverPOLY.py $SNR  $inputfile $outputfile $b &

  wait ${!}

else
  echo "THIS is if +ve correlation" $a
  python2.7 BPSK_Sender-M.py $a &
wait ${!}
fi
fi
#calculating BER for each of the files above
python2.7 BER.py inputBinary $outputfile >>logs/logfile2 &

wait ${!}

  done
done
