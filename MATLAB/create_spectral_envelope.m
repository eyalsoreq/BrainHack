function [ spectral_envelope ] = create_spectral_envelope( formants, plotbool )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

if nargin<2 || isempty(plotbool)
    plotbool=false;
end

assert(all(size(formants)==[5*60*50,3]),'Input must be 5 min at 50 Hz with three features!');

% Standardize:
formants = bsxfun(@minus, formants, mean(formants,1));
formants = bsxfun(@times, formants,1./var(formants,1))*0.1;

formant_freq = [0 0.25 0.5 0.75 1]*4;
formant_amp =  [0.5 1 0.5 1 0.1];
freqs = linspace(0,4);
nsamples = 5*60*5;

spectral_envelope = zeros(nsamples, length(freqs));

for n=1:nsamples
    current_envelope = interp1(formant_freq+[0 formants(n,:) 0], formant_amp, freqs);
    spectral_envelope(n, :) = current_envelope;
end

if plotbool
    figure;surf(linspace(0,nsamples/50,nsamples), freqs, spectral_envelope');
    shading interp;
end

end

