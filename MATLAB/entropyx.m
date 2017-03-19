function [entropy, fd_bins] = entropyx(x,fd_bins)
% ENTROPYX   Compute entropy
%  
%   Inputs:
%       x       :  data matrix
%
%   Optional inputs:
%       bins    :  number of bins to use for distribution discretization
%
%   Outputs:
%       entropy :  entropy of x, y, and joint
%       nbins   :  number of bins used for discretization
%                  (based on Freedman-Diaconis rule)
%

%% determine the optimal number of bins for each variable

% vectorize in the case of matrices
% x=x(:);
if length(x)==numel(x)
    x = x(:);
end

if nargin<2 || isempty(fd_bins)
    n            = length(x);
    maxmin_range = max(x)-min(x);
    fd_bins      = ceil(maxmin_range./(2.0*iqr(x).*n^(-1/3))); % Freedman-Diaconis
else
    if numel(fd_bins)<size(x,2)
        fd_bins = fd_bins*ones(size(x,2),1);
    end
end

%% bin data

% edges = linspace(min(x),max(x),fd_bins+1);
% [nPerBin1,bins1] = histc(x,edges);

%% compute entropies

% recompute entropy with optimal bins for comparison
entropy = zeros(size(x,2),1);
for ch=1:size(x,2)
    hdat1 = hist(x(:,ch),fd_bins(ch));
    hdat1 = hdat1./sum(hdat1);

    % convert histograms to probability values
    entropy(ch) = -sum(hdat1.*log2(hdat1+eps));
end
%%



