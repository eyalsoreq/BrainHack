function [y1,y2] = output2hendric(X,Y,env,prefix,outdir,win,n)
fmt = repmat({'%4.3f '},1,n);
    fmt = [fmt{:}];fmt(end:end+2)=';\n';
    fid = fopen(sprintf('%s%s%s_frequencies.txt',outdir,filesep,prefix),'w');
disp('')
if ~isempty(win)
    dis = corr(X);
    dis(eye(size(X,2))>0)= -1;
    [ix,~] = c3nl_assignment(dis,'rows','max');
    idx = randi(size(X,1)-win,1);
    tmp = X(idx:idx+win,ix(1:n));    
    y1 =  zeros(win+1,n);
    y2 =  zeros(win+1,n);
else 
    tmp1 = X;
    tmp2 = Y;
    y1 =  zeros(size(X));
    y2 =  zeros(size(X));
end
for ii=1:n
    y1(:,ii) = c3nl_scale(tmp1(:,ii),'col',(ii-1)*100,ii*100) ;
end
%figure();plot(y);hold on

ix = find(tmp1(:,1) == 0);
%y1(ix,:) = 0;
fprintf(fid,fmt,y1');
fclose(fid);
fid = fopen(sprintf('%s%s%s_amplitudes.txt',outdir,filesep,prefix),'w');
if isempty(env)
    for ii=1:n
    y2(:,ii) = c3nl_scale(tmp2(:,ii),'col',1/(ii+1),1/(ii)) ;
    end
else
    y2 = tmp2.*env;
end

y2(ix,:) = 0;
fprintf(fid,fmt,y2');
fclose(fid);
% s = 7;
% tt = repmat(cos(-s*pi:s*pi/(size(tmp2,1)/2):s*pi),30,1);
% tt1 = repmat(sin(-s*pi:s*pi/15:s*pi),size(tmp2,1),1);
% 
% clf;imagesc(tt(:,1:end-1)'.*tt1(:,1:end-1))
% plot(c3nl_scale(tt(:,1:end-1)'.*y2))
% clf
end