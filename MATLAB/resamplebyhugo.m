% Filter low pass
ideal_fr = [1 1 0 0];
fs = length(entropy_lsd)/(5*60);
freq_req = [0 6 8 fs/2]/fs*2;
b = firls(3*round(fs/6), freq_req, ideal_fr);
entropy_lsd_filtered = filtfilt(b, 1, entropy_lsd);
% Resample:
entr_lsd = resample(entropy_lsd_filtered, 50, floor(fs));
entr_lsd = entr_lsd(1:50*5*60,:);

% Same for placebo
fs = length(entropy_placebo)/(5*60);
freq_req = [0 6 8 fs/2]/fs*2;
b = firls(3*round(fs/6), freq_req, ideal_fr);
entropy_pcb_filtered = filtfilt(b, 1, entropy_lsd);
% Resample:
entr_placebo = resample(entropy_pcb_filtered, 50, floor(fs));
entr_placebo = entr_placebo(1:50*5*60,:);

% clean
clear entropy_pcb_filtered entropy_lsd_filtered

