clear all;
close all;
clc;
load('Indian_pines_corrected'); 
hyper_data = indian_pines_corrected;

hyper_data =( hyper_data-(min(min(min(hyper_data)))))/(max(max(max(hyper_data))))-min(min(min(hyper_data)));
figure; imshow(hyper_data(:,:,30),[]); 
[spat1,spat2,spec] = size(hyper_data);
hyper_vector = zeros(spec,spat1*spat2);
for b = 1:1:spec
                        hyper_vector(b,:) = reshape(hyper_data(:,:,b),1,spat1*spat2);
end

k = input('The number of clusters?: '); 
start_locs = randsrc(1,k,1:spat1*spat2); 
cluster_center = zeros(spec,k);
for c = 1:1:k 
                        cluster_center(:,c) = hyper_vector(:,start_locs(c)); 
end
label = zeros(1,spat1*spat2); 
old_label = ones(1,spat1*spat2);
iter = 1; 
figure;

while (iter < 100)&& (sum(sum(old_label == label))~= spat1*spat2) 
                        disp(['Iteration: ' num2str(iter)]) 
                        dis = zeros(k,spat1*spat2); 
                        old_label = label;
                        for p = 1:1:spat1*spat2
                                                for c = 1:1:k 
                                                                        dis(c,p) = sqrt(sum((hyper_vector(:,p) - cluster_center(:,c)).^2)); 
                                                end
                                                [minval,min_index] = min(dis(:,p)); 
                                                label(p) = min_index;
                        end
                        imagesc(reshape(label,spat1,spat2));

cluster_center = zeros(spec,k); 
for p = 1:1:spat1*spat2 
                        cluster_center(:,label(p)) = cluster_center(:,label(p)) + hyper_vector(:,p); 
end
for c = 1:1:k 
                        cluster_center(:,c) = cluster_center(:,c) / sum(label == c);
end
iter = iter + 1; 
end