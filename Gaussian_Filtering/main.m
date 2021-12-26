close all; clear all; clc;

im = imread('Lenna_salt_pepper.png');
% input image 'Lenna_sat_pepper.png'의 픽셀 값들을를 im라은 변수에 저장
im = im2double(im);
% im의 값들을 uint8에서 double형으로 변형
sigma = 5;
% sigma 값을 10으로 지정

result = gaussianFiltering(im, sigma);
% im을 gaussian filtering한 결과를 result에 저장

imwrite(result, 'result_GaussianFilter.png'); 
% result의 값들을 'result_GaussianFilter.png'에 저장
