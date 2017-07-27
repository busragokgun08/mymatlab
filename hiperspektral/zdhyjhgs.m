% Read the Indian Pine hyperspectral data
clc;
clear all;
close all;
load('Indian_pines_corrected'); %Read the Indian Pine data
hyper_data = indian_pines_corrected;
hyper_data =( hyper_data-(min(min(min(hyper_data)))))/(max(max(max(hyper_data))))-min(min(min(hyper_data)));
[spat1,spat2,spec] = size(hyper_data);

hyper_vector = zeros(spec,spat1*spat2);

for b = 1:1:spec
hyper_vector(b,:) = reshape(hyper_data(:,:,b),1,spat1*spat2);
end
% PCA

temp = hyper_vector;
[M,N] = size(temp);
temp = temp - repmat(mean(temp,2),1,N);
covariance = (1/(N-1))*(temp*temp');
[cov_eigvec , cov_eigval] = eig(covariance);
cov_eigval = diag(cov_eigval);
[junk, rindices] = sort(-1*cov_eigval);
cov_eigval = cov_eigval(rindices);
cov_eigvec = cov_eigvec(:,rindices);
final = cov_eigvec' * temp;
disp('PCA completed');
for b = 1:1:spec
pca_data(:,:,b) = reshape(final(b,:),spat1,spat2);
end
% Original bands and PCA
figure;
for i = 1:1:spec
hold on; imshow(hyper_data(:,:,i),[]);
title(['Original band, number ' num2str(i)]);
pause(0.01);
end
%PCA
figure; subplot(1,3,1); imshow(hyper_data(:,:,[1 2 3]));
subplot(1,3,2); imshow(hyper_data(:,:,[30 20 12]));
subplot(1,3,3); imshow(pca_data(:,:,[1 2 3]));
% Plot the proportion of variance:
figure;
axis([0 200 0 1]);
for l=1:1:length(cov_eigval)
Proportion_of_variance=sum(cov_eigval(1:l))/sum(cov_eigval);
hold on; plot(l,Proportion_of_variance,'*-');
end