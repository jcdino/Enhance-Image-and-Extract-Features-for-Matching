close all; clear all; clc;

im1 = imread('imageA.png');
im2 = imread('imageB.png');
alpha = 0.5;

result = blend(im1, im2, alpha);

imwrite(result, 'result_blend.png');
