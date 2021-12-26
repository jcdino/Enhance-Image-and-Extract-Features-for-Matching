close all; clear all; clc;

im1 = imread('imageA.png');
im2 = imread('imageB.png');
alpha = 0.5;

result = blend(im1, im2, alpha);

imwrite(result, 'result_blend.png');

%%
close all; clear all; clc;

im = imread('Unequalized_Hawkes_Bay_NZ.jpg');
n = 256;

result = histEq(im, n);
imwrite(result, 'result_histEq.png');
