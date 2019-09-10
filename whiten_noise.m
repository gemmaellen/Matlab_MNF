function data_whitened = whiten_noise(data, N)
% Uses a noise estimate N to whiten the noise in data.
% Input: data  -- A 2D array of data. The first dimension is of length
%                 m1*m2 and contains spatial data. The second dimension
%                 contains spectral data of length n.
%        N     -- A matrix of noise estimates in each data point.

% Matrix of noise estimates should be the same size as our data.
assert(all(size(data) == size(N)))

% Calculate SVD of noise.
[~, Sn, Vn] = svd(N, 'econ');

Sn = sparse(Sn); % so MATLAB will know it's diagonal

% noise whitening matrix
F = (Vn / Sn) * Vn' ; % use right divide to compute inverse

data_whitened = data*F;