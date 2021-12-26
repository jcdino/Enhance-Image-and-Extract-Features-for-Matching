close all; clear all; clc;
im = imread('Lenna_salt_pepper.png');
result_medianFilter.png
filterSize = [3,3];
% filter의 size를 3x3 filter로 설정

result = medianFiltering(im, filterSize);
% im을 median filtering한 결과를 result에 저장
imwrite(result, 'result_medianFilter.png'); 
% result의 값들을 'result_medianFilter.png'에 저장
