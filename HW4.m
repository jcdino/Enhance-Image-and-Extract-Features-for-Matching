
close all; clear all; clc;

im = imread('Lenna_salt_pepper.png');
im = im2double(im);

sigma = 3;
threshold = 0.2;

result = MarrHildrethEdge(im, sigma, threshold);
imwrite(result, 'result_ MarrHildrethEdge.png'); 



