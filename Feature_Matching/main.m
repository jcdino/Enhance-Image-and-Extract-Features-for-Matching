 close all; clear all; clc;

im1 = imread('Notre_Dame_1.png');
im2 = imread('Notre_Dame_2.png');

%% Harris Corner Detector

fx_operator = [1,-1]; % vector for derivative
fy_operator = [1;-1]; % vector for derivative
Gaussian_sigma = 3; % standard deviation for Gaussian filtering
alpha = 0.05; % alpha for C
C_thres = 0.05; % relative threshold for C
NMS_ws = 7; % window size for non-maximum suppression

[corner1, C1] = detectHarrisCorner(im1, fx_operator, fy_operator, ...
    Gaussian_sigma, alpha, C_thres, NMS_ws);
[corner2, C2] = detectHarrisCorner(im2, fx_operator, fy_operator, ...
    Gaussian_sigma, alpha, C_thres, NMS_ws);

C1 = C1/max(C1,[],'all');
C2 = C2/max(C2,[],'all');

imwrite(C1, 'Cornerness_1.jpg');
imwrite(C2, 'Cornerness_2.jpg');

corner1 = [corner1, 3*ones(size(corner1,1),1)];
corner2 = [corner2, 3*ones(size(corner2,1),1)];

im1_corner = insertShape(im1, 'Circle',  corner1, 'LineWidth', 2, 'Color', 'green');
im2_corner = insertShape(im2, 'Circle',  corner2, 'LineWidth', 2, 'Color', 'green');

imwrite(im1_corner, 'CornerDetection_1.jpg');
imwrite(im2_corner, 'CornerDetection_2.jpg');


%% 

%%SIFT Descriptor

Gaussian_sigma = 4;

SIFT1 = extractSIFT(im1, fx_operator, fy_operator, corner1, Gaussian_sigma);
SIFT2 = extractSIFT(im2, fx_operator, fy_operator, corner2, Gaussian_sigma);

%% Feature Matching using Distance Ratio

distance_ratio_thres = 0.5;
matching = matchFeatures(SIFT1, SIFT2);

colorPalette = floor(255*colormap('lines')); 
im_result = [im1,im2];
corner2(:,1) = corner2(:,1) + size(im1,2);

for idx = 1:size(matching,1)
    if matching(idx, 2) < distance_ratio_thres
        im_result = insertShape(im_result, 'Circle',  corner1(idx,:), 'LineWidth', 2, 'Color', colorPalette(rem(idx,255),:));
        im_result = insertShape(im_result, 'Circle',  corner2(matching(idx, 1),:), 'LineWidth', 2, 'Color', colorPalette(rem(idx,255),:));
        im_result = insertShape(im_result, 'Line',  [corner1(idx,1:2),corner2(matching(idx, 1),1:2)], 'LineWidth', 2, 'Color', colorPalette(rem(idx,255),:));
    end
end

imwrite(im_result, 'FeatureMatching.jpg');






