function [processed_source, W, E] = PCA(source, toNormalize)
%% PCA
if nargin < 2
toNormalize = true;
end

% Centering
processed_source = source - (mean(source')')*ones(1, size(source, 2));

% Variance normalization
if toNormalize
    variance = (sqrt(var(processed_source'))') * ones(1, size(source, 2));
    processed_source = processed_source ./ variance;
end

% Correlation
Cov = processed_source * processed_source';

% Eigen
[V, D] = eig(Cov);
[B I] = sort(sum(D), 'descend');

% Construct W
W = zeros(size(V));
E = zeros(size(D));
for i = 1 : size(V, 1)
    W(:, i) = V(:, I(i));
    E(:, i) = D(:, I(i));
end


