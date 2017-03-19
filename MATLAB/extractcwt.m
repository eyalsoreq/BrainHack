function [m,p] = extractcwt(sfs,tfs,X,bins,scale) 
    [wt,f] = cwt(X,'amor',sfs);
    fid = arrayfun(@(x) find(bins<=x,1,'last'),f,'un',0);
    fid = [fid{:}];
    fidd= dummyvar(fid);
    tt = fidd'*wt;
    m = zeros(size(X,2),numel(bins));
    p = zeros(size(X,2),numel(bins));
    if scale
        for ii=1:size(tt,1)
            m(:,ii) = c3nl_scale(abs(tt(ii,:)));
            p(:,ii) = c3nl_scale(atan2(c3nl_scale(imag(tt(ii,:))),c3nl_scale(real(tt(ii,:)))));
        end
        m = resample(m,tfs,sfs);
        p = resample(p,tfs,sfs);
    else
      for ii=1:size(tt,1)
        m(:,ii) = abs(tt(ii,:));
      end
      m = sum(c3nl_scale(m,'full',0,1));
    end

    
    
    
end
    

