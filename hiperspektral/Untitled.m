
clc;
clear all;
img= load('C:\Users\büşra\Desktop\Matlab1\hiperspektral\Indian_pines.mat'); 

hyper_data = indian_pines_corrected;

img=(img-min(min(min(img))))/(max(max(max(img)))-min(min(min(img))));

[spat1,spat2,spec] = size(img);

for i = 1:1:spec
hold on; imshow(img(:,:,i),[]);
title(['Original band, number ' num2str(i)]);
pause(0.5);
end