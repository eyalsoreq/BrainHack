function [ entropy_time_series ] = moving_entropy( data, window, overlap , fs, nbins)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% To cpmpute a time-series of entropy...

if numel(data)>length(data)
    % Make matrix in form nsamples x nchannels
%     if size(data,1)<size(data,2)
%         data = data';
%     end
else
    data = data(:);
end

win_size =  floor(window*fs);
overlap_size = fix(win_size*overlap);
hop_size = win_size - overlap_size;

ncols = ceil((length(data)-win_size)/hop_size)+1;

% Padding
% data = padarray(data, floor(win_size/2),0, 'both');

entropy_time_series = zeros(ncols, size(data,2));
for k=1:ncols
    fprintf(1, 'Progress: %.2f %%\n', k/ncols*100);
    [entr, ~] = entropyx(data(1+(k-1)*hop_size:(k-1)*hop_size+win_size,:),nbins);
%     fprintf(1,'mean bins %d min %d max %d\n', median(bins),min(bins),max(bins));
    entropy_time_series(k,:) = entr;
end

end

