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

% Centre the data
means_by_wavenumber = sum(data)/(m1 * m2);
means_matrix = ones(m1 * m2, 1) * means_by_wavenumber;
data = data - means_matrix;

% Use this estimate to whiten the noise
[F, data_whitened] = whiten_noise(data, N);


% Get principal components from data with whitened noise
[~, ~, V] = svd(data_whitened);

% Transform back into original co-ordinates
W = F * V;

% Reduce our space
A = W(:, 1:k);

% Project onto reduced set of vectors
proj = data * ((F * F')\A);
reconst = proj * A' + means_matrix;









