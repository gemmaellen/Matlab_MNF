function [reconst, A] = mnf(data, m1, m2, k)
% Finds the first k components of Minimum Noise Fraction transformation on 
% 3D (e.g. hyperspectral) data, and uses them to reconstruct the data
%
% Reference:
% Lee, James B., A. Stephen Woodyatt, and Mark Berman. "Enhancement of
%     high spectral resolution remote-sensing data by a noise-adjusted
%     principal components transform." Geoscience and Remote Sensing, IEEE
%     Transactions on 28.3 (1990): 295-304.
%
% Input: data  -- A 2D array of data. The first dimension is of length
%                 m1*m2 and contains spatial data. The second dimension
%                 contains spectral data of length n.
%        m1,m2 -- dimensions of the original spatial data
%        k     -- number of required components
%
% Output: reconst -- reconstructed data
%        A -- n x k matrix for transforming data


% Estimate the noise
N = noise_estimate(data, m1, m2);


% Use this estimate to whiten the noise
data_whitened = whiten_noise(data, N);


% Get k principal components from data with whitened noise
[~, ~, A] = svds(data_whitened, k);


% Reconstitute original data using those k principal components
reconst = data * (A * A');









