
close all; clear all; clc;

im = imread('Lenna.png');
% im변수에 'Lenna.png'의 pixel값들을 불러온다.
scale = 2;
% 입력 영상 기준으로 늘어나는 pixel의 배수의 값을 scale변수에 저장해준다.

result = bilinearInterpolation(im, scale);
% im과 scale을 parameter로 한 함수 bilinearInterpolation()을 실행한 결과를 변수 result에
% 저장해준다,
imwrite(result, 'result_bilinearInterpolation.png'); 
% result의 결과를 'result_bilnearInterpolation.png'라는 파일명으로 파일을 생성한다.

%%

close all; clear all; clc;

im = imread('Lenna_salt_pepper.png');
% im변수에 'Lenna_salt_pepper.png'의 pixel값들을 불러온다.

result = SobelEdge(im);
% im을 parameter로 한 함수 SobelEdge()을 실행한 결과를 변수 result에 저장해준다,
imwrite(result, 'result_SobelEdge.png'); 
% result의 결과를 'result_SobelEdge.png'라는 파일명으로 파일을 생성한다.

im = medfilt2(im);
% 입력 영상을 median filter로 먼저 noise 제거를 해주었다.
result = SobelEdge(im);
% im을 parameter로 한 함수 SobelEdge()을 실행한 결과를 변수 result에 저장해준다,
imwrite(result, 'result_SobelEdge_medianFilter.png'); 
% result의 결과를 'result_SobelEdge_medianFilter.png'라는 파일명으로 파일을 생성한다.
