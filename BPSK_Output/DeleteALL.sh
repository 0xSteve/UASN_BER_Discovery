#!/bin/bash
for ((c=1; c<=100; c++))
 do
#rm goff_random_20pc_5km_E_no$c/outputBinary*
  rm goff_random_80pc_5km_E_no$c/filters32POLY/BER
rm goff_random_80pc_5km_E_no$c/filters64POLY/BER

# rm -r logs
done
