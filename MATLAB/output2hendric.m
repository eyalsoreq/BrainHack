function output2hendric(X,prefix,outdir,win,n)

disp('')
dis = corr(X);
dis(eye(size(X,2))>0)= -1;
[ix,~] = c3nl_assignment(dis,'rows','max');
idx = randi(size(X,1)-win,1);
tmp = X(idx:idx+win,ix(1:n));
fmt = repmat({'%6.6f '},1,n);
fmt = [fmt{:}];fmt(end:end+2)=';\n';
fid = fopen(sprintf('%s%s%s_frequencies.txt',outdir,filesep,prefix),'w');
y =  zeros(win+1,n);
for ii=1:n
y(:,ii) = c3nl_scale(tmp(:,ii),'col',(ii-1)*100,ii*100) ;
end
fprintf(fid,fmt,y');
fclose(fid);
fid = fopen(sprintf('%s%s%s_amplitudes.txt',outdir,filesep,prefix),'w');
for ii=1:n
y(:,ii) = c3nl_scale(tmp(:,ii),'col',2/(ii+1),2/(ii)) ;
end

y = tmp .* repmat([(1:n)*100],size(tmp,1),1);
fprintf(fid,fmt,y');
fclose(fid);


end