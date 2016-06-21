
function [delayspread,variance]= PA(size)


ARRFIL=cell(size:1);
for i=1:size
 ARRFIL{i}=strcat('goff_random_20pc_5km_E_no',int2str(i),'.arr');
 %disp(ARRFIL)
end
max=0;
for i=1:size
[ Arr(i), Pos(i) ] = read_arrivals_asc( char(ARRFIL(i)), 100 );  % read the arrivals file
% Finds the max number of arrivals in the arrival files read
nmax=Arr(i).Narr;
  if max<nmax
    max= nmax;
  end 
end 

% initialize a 2d array that has size number of rows i.e a row for each
% arrival file and size max columns  for each arrival.
A=zeros(size,max);

%fill the array with data from arrival files
for i=1:size
  for j=1:Arr(i).Narr
    A(i,j)=Arr(i).delay(j);
  end
end

A=sort(A,2);
%create an array of size delay spreads and fill it
delayspread=[];
 for i=1:size
    delayspread(i)=A(i,max)-A(i,max-Arr(i).Narr+1);    
 end

 for i=2:size
  L=delayspread(1:i);   
  variance(i)=var(L); 
 end

plot(variance);
 xlabel('Number of Files') % x-axis label
ylabel('Variance of Delay Spread')
savefig('VarDelay');
figure
stem(delayspread);
savefig('DelaySpread');

end





