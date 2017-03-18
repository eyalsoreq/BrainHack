%%

clearvars
close all

%%

dataDIR = '../DATA/';
fs = 600;


x=dlmread('../DATA/matrixFile.txt');
    
L   = length(x);

t   = (0:(L-1)) ./ fs;

nPartials = 30;

%%


%plot(t,x(:,5:10))


%%

startIND = 50;

tmp = x(:,startIND:startIND+nPartials-1);

tmp = tmp/max(max(tmp));

for i=1:nPartials
    y(:,i) = 130*i +smooth(tmp(:,i),500)*i*100;
end

plot(y)

fid = fopen('../DATA/frequencies_2.txt','w');
fprintf(fid,'%6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f;\n',y');
fclose(fid);

 
%%

figure 

startIND = 30;

y = x(:,startIND:startIND+nPartials-1);

y = y/max(max(y));
    
for i=1:nPartials
    y(:,i) =  0.2+(1    /(1*i)) + (0.2*smooth(y(:,i),100)/(0.05*i));
end

plot(y)

fid = fopen('../DATA/amplitudes_2.txt','w');
fprintf(fid,'%6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f;\n',y');
fclose(fid);

 