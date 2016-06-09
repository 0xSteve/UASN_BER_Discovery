#! python
from sys import argv
import numpy
import re
import scipy
from bitstring import BitArray
numpy.set_printoptions(threshold='nan')
#print "Hello, Python below is your file"
#filename= raw_input('ENTER YOUR  FIRST Filename: ')
script, filename1, filename2= argv
print(filename2)
A1 = scipy.fromfile(open(filename1), dtype=scipy.uint8)
#filename2= raw_input('ENTER YOUR  SECOND Filename: ')
A2 = scipy.fromfile(open(filename2), dtype=scipy.uint8)
print("A1 in file STARTS HERE")
print(A1)
print("A2 out file STARTS HERE")
print(A2)
if A2.__len__()!=A1.__len__():
	print("NOT EQUAL LENGTH")
print( "length of in =" +str(A1.__len__()))
print( "length of out =" +str(A2.__len__()))
count=0;
if(A2.__len__()>A1.__len__()):
    end=A1.__len__()
else: end=A2.__len__()
index=0
for i in range(100,end):
 if A1[i]!=A2[i]:
    count+=1
    index=i
print("count ="+str(count)+ " index="+ str(index))
print(str(float(count)/float(end-100)) + "    this is end=" +str(end))
po= re.findall("\w+[/]",filename2)
result=str(po[0])+"BER"
f=open(result,'a')
SNR=re.findall('\d+',filename2)
print("THIS is SNR from BER "+ str(SNR))
data=str(float(count)/(end-150))+ ","+ str(SNR[2])
f.write(data+ "\n")
f.close()
#a= BitArray(float=0.34, length=32)
#a.bin=f
#print(a.float)
