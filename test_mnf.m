% Test mnf files as I make them.

% Try a matrix of random data

m1 = 3;
m2 = 4;
n = 5;

A = rand(m1*m2, n);

N = noise_estimate(A, m1, m2);

% Test to see that the reshaping works as planned

ints = 1:5;
B = ones(m1*m2,1)*ints;

should_be_0 = noise_estimate(B, m1, m2);

new_B = reshape(B, m1, m2, []);
same_as_B = unravel_spatial_coords(new_B);

% test that the mnf function runs

[Y, T] = mnf(A, m1, m2, n);

% Test the noise whitening procedure:
% make a function that has the same signal with different levels of noise:


%pic = ones(m1* m2, 1); % boring flat picture

pic = [-1 0 1]' * [1 1 1 1];
pic = pic(:);

C = zeros(m1*m2, n); % preallocate

noise_fractions = 0.1*rand(1, n); % keep noise small

for i = 1:n
    C(:, i) = pic + noise_fractions(i)*randn(m1*m2, 1);
end

N = noise_estimate(C, m1, m2);

[reconst, A1] = mnf(C, m1, m2, 1);

figure
plot(C)
title('data with noise')

figure
plot(reconst)
title('denoised with mnf')

%% Try on some larger files

m1 = 180;
m2 = 50;
n = 100;

vec = (1:m1) * 2 / m1;
pic = vec' * ones(1, m2);
pic = pic(:);

data = zeros(m1*m2, n);

noise_fractions = 0.1*rand(1, n); % amount of noise in each band
%noise_fractions = 0.1*ones(1, n); % white noise

for i = 1:n
    data(:, i) = (pic + noise_fractions(i)*randn(m1*m2, 1))*i/n;
end

[reconst, A1] = mnf(data, m1, m2, 2);


figure
plot(data(:,3))
title('picture with noise')

figure
plot(reconst(:,3))
title('picture denoised with mnf')


figure
plot(data(3,:))
title('spectrum with noise')

figure
plot(reconst(3,:))
title('spectrum denoised with mnf')

