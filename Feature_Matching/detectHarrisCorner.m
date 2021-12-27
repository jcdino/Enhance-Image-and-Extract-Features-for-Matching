function [corner, C]=detectHarrisCorner(im, fx_operator, fy_operator, Gaussian_sigma, alpha, C_thres, NMS_ws)
%%
im = double(rgb2gray(im)); %im를 rgb에서 gray scale로 변환
fx = zeros(size(im)); %x축에 대한 gradient를 나타내는 이미지 
fy = zeros(size(im)); %x축에 대한 gradient를 나타내는 이미지 

for y=1:size(im,1)
    for x=1:size(im,2)
        a = x+1; %x축에 대해서 오른쪽으로 다음 x좌표 위치
        b = y+1; %y축에 대해서 아래쪽으로 다음 y좌표 위치
        if a>size(im,2); a=x;end %im의 범위를 넘어서면 근처에 있는 pixel의 값으로 padding
        if b>size(im,1); b=y;end %im의 범위를 넘어서면 근처에 있는 pixel의 값으로 padding
        fx(y,x) = im(y,x)*fx_operator(1,1)+im(y,a)*fx_operator(1,2);
        %x축 방향(오늘쪽)으로 derivatives를 계산하여 둘의 차이를 저장한다.
        fy(y,x) = im(y,x)*fy_operator(1,1)+im(b,x)*fy_operator(2,1);
        %y축 방향(아래쪽)으로 derivatives를 계산하여 둘의 차이를 저장한다.
    end
end
fx2 = fx.*fx;
fy2 = fy.*fy;
fxfy = fx.*fy;
%fx의 제곱, fy의 제곱, fx와 fy의 곱에 대한 값을 먼저 계산해준다.

%%
%Gaussian filter 생성
filterSize = 2*round(2*Gaussian_sigma)+1;
halfFs = (filterSize-1)/2;
% 필터의 최하단, 오른쪽 좌표값을 구해서 필터의 크기를 구한다.
weight = zeros(filterSize, filterSize);
% 0으로 구성된 gaussian filter를 weight라는 행렬로 선언
for y = -halfFs : halfFs 
    for x = -halfFs : halfFs 
        weight(y+halfFs+1,x+halfFs+1) = 1/(2*pi*Gaussian_sigma^2) * ...
            exp(-(y^2+x^2) / (2*Gaussian_sigma^2));
        % 행렬 weight의 각 행과 열에 값을 입력해줌으로써 weight값이 입력된 gaussian filter 구성
    end
end
weight = weight / sum(weight, 'all'); %weight들이 포함된 gaussian filter를 생성

%%
%Gaussian filter 적용
Gaussian_fx2 = zeros(size(fx2));
Gaussian_fy2 = zeros(size(fy2));
Gaussian_fxfy = zeros(size(fxfy));

%fx의 제곱, fy의 제곱, fx와 fy의 곱 값에 gaussian filter를 적용해 주는 과정
for y = 1:size(im,1) % im과 result의 높이 범위 설정
    for x = 1:size(im,2)
        % im과 result의 너비 범위 설정
        for s = -halfFs:halfFs % 필터의 높이 범위 설정
            for t = -halfFs:halfFs % 필터의 너비 범위 설정
                ys = y-s;
                xt = x-t;
                % 필터의 가운데 값을 기준으로 필터의 각 좌표에 대응되는
                % im에서의 좌표를 ys, xt로 나타냄
                if ys <1; ys = 1; end; if xt <1; xt = 1; end
                if ys > size(im,1); ys = size(im,1); end;if xt > size(im,2); xt = size(im,2); end
                % replicate padding 방식을 적용한 코드
                % 필터가 y 가 0보다 작거나 size(im,1)보다 큰 좌표의 값이나
                % x가 0보다 작거나 size(im,2)보다 큰 좌표의 값을 사용해서 계산하려고 할때
                % replicate padding을 통해서 가장 아까운 pixel의 값을 사용하도록 코딩하였음

                Gaussian_fx2(y,x) = Gaussian_fx2(y,x) + weight(s+halfFs+1,t+halfFs+1)*fx2(ys,xt);
                Gaussian_fy2(y,x) = Gaussian_fy2(y,x) + weight(s+halfFs+1,t+halfFs+1)*fy2(ys,xt);
                Gaussian_fxfy(y,x) = Gaussian_fxfy(y,x) + weight(s+halfFs+1,t+halfFs+1)*fxfy(ys,xt);
            end
        end
   end
end
%%
%cornerness score
cornerness = zeros(size(im)); %cornerness score map을 계산해 준다.
for y = 1:size(im,1)
    for x = 1:size(im,2)
        cornerness(y,x) = Gaussian_fx2(y,x)*Gaussian_fy2(y,x) - Gaussian_fxfy(y,x)^2 ...
            -alpha*(Gaussian_fx2(y,x)+Gaussian_fy2(y,x))^2;
    end
end
C = cornerness; %계산한 cornerness score map을 C 변수에 저장
threshold = C_thres*max(cornerness,[],'all');
win = zeros(NMS_ws,NMS_ws);
halfFs = (NMS_ws-1)/2;
corner=[]; %interest point의 x,y좌표를 포함할 corner라는 행렬 선언
% 각 pixel 주변으로 7*7 size를 갖는 window를 생성하고 이 값들에 대해서 값을 결정하는 과정
for y = 1:size(im,1)
    for x = 1:size(im,2)
        for s = -halfFs:halfFs % 필터의 높이 범위 설정
            for t = -halfFs:halfFs % 필터의 너비 범위 설정
                ys = y-s;
                xt = x-t;
                % 필터의 가운데 값을 기준으로 필터의 각 좌표에 대응되는
                % im에서의 좌표를 ys, xt로 나타냄
                if ys <1; ys = 1; end; if xt <1; xt = 1; end
                if ys > size(im,1); ys = size(im,1); end; if xt > size(im,2); xt = size(im,2); end
                win(s+halfFs+1,t+halfFs+1) = cornerness(ys,xt);
            end
        end
        % 해당 pixel이 threshold보다 크고 주변으로 생성된 7*7 window 내에서
        % 가장 큰 값일 때, interest point(corner)로 간주하여 x,y 좌표 저장
        if cornerness(y,x) > threshold
            if cornerness(y,x) == max(win,[],'all')
                corner = [corner; [x y]];
                % 생성된 interest point(corner)를 차례대로 저장한다.
            end
        end
    end
end
end
        