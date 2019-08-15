function out = unravel_spatial_coords(data)
% Transforms 3D data into 2D data in which the first two co-ords of the
% original data have been combined into a single vector.

dims = size(data);

assert(length(dims) == 3); % check input is 3D

out = zeros(dims(1)*dims(2), dims(3));

% force 2D shape
data_slice = zeros(dims(1), dims(2));

for i = 1:dims(3)
    data_slice(:, :) = data(:, :, i); % keep 2D shape
    out(:, i) = data_slice(:);
end