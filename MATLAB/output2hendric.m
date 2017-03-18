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

y = tmp .* repmat([(1:n)*100],size(tmp,1),1);
fprintf(fid,fmt,y');
fclose(fid);
y = 0.2*tmp ./ repmat([(1:n)*.05],size(tmp,1),1);
fid = fopen(sprintf('%s%s%s_amplitudes.txt',outdir,filesep,prefix),'w');
y = tmp .* repmat([(1:n)*100],size(tmp,1),1);
fprintf(fid,fmt,y');
fclose(fid);


end