
A=zeros(11,100);
for i=1:100
file=strcat('goff_random_20pc_5km_E_no',int2str(i),'/filters64POLY/BER');
s1=csvread(file);
%disp(s1(:,1));
A(:,i)=s1(:,1);
end
disp(A)
disp(mean(A,2))