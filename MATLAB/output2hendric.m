function [y1,y2] = output2hendric(X,prefix,outdir,win,n)

disp('')
dis = corr(X);
dis(eye(size(X,2))>0)= -1;
[ix,~] = c3nl_assignment(dis,'rows','max');
idx = randi(size(X,1)-win,1);
tmp = X(idx:idx+win,ix(1:n));
fmt = repmat({'%4.3f '},1,n);
fmt = [fmt{:}];fmt(end:end+2)=';\n';
fid = fopen(sprintf('%s%s%s_frequencies.txt',outdir,filesep,prefix),'w');
y1 =  zeros(win+1,n);
y2 =  zeros(win+1,n);
for ii=1:n
y1(:,ii) = c3nl_scale(tmp(:,ii),'col',(ii-1)*100,ii*100) ;
end
%figure();plot(y);hold on
fprintf(fid,fmt,y1');
fclose(fid);
fid = fopen(sprintf('%s%s%s_amplitudes.txt',outdir,filesep,prefix),'w');
for ii=1:n
y2(:,ii) = c3nl_scale(tmp(:,ii),'col',1/(ii+1),1/(ii)) ;
end
fprintf(fid,fmt,y2');
fclose(fid);


end