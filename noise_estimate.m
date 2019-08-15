function N = noise_estimate(data, m1, m2)
% Estimate the noise in the data for the MNF transform.
%
% We will use a comparison with a spatial neighbour to do this.
%
% Input: data  -- A 2D array of data. The first dimension is of length
%                 m1*m2 and contains spatial data. The second dimension
%                 contains spectral data of length n.
%        m1,m2 -- dimensions of the original spatial data
%
% Output: N -- A 2D array that is the same size as data, containing noise
%              estimates.


% reshape the data so nearest neighbours can be seen
data_3D = reshape(data, m1, m2, []);

N = zeros(size(data_3D));

% for all but the final row, compare with left neighbour
N(:, 1:(end-1), :) = data_3D(:, 1:(end-1), :) - data_3D(:, 2:end, :);

% for the final row, compare with right neighbour
N(:, end, :) = N(:, end-1, :);

% return to original shape
N = unravel_spatial_coords(N);



