close all; clear all; clc;

im = imread('Unequalized_Hawkes_Bay_NZ.jpg');
n = 256;

result = histEq(im, n);
imwrite(result, 'result_histEq.png');
