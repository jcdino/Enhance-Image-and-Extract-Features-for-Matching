function result = gaussianFiltering(im, sigma)
%%
%Gaussian Filter 생성
filterSize = 2*round(sigma*2)+1; 
% 홀수인 filterSize 생성
halfFs = (filterSize-1)/2;
% 필터의 최하단, 오른쪽 좌표값을 구해서 필터의 크기를 구한다.

weight = zeros(filterSize, filterSize);
% 0으로 구성된 gaussian filter를 weight라는 행렬로 선언

for y = -halfFs : halfFs %-2 ~ 2
    for x = -halfFs : halfFs %-2 ~ 2
        weight(y+halfFs+1,x+halfFs+1) = 1/(2*pi*sigma^2) * exp(-(y^2+x^2) / (2*sigma^2));
        % 행렬 weight의 각 행과 열에 값을 입력해줌으로써 weight값이 입력된 gaussian filter 구성
    end
end
weight = weight / sum(weight, 'all');
% gaussian filter를 전체 weight들의 합으로 나눠줘서 최종 gaussian filter 완성
%%

%Gaussian filtering 적용
result = zeros(size(im));
% 행렬 result를 image와 크기가 같은 영행렬로 구성함

for ch = 1:size(im,3) % im과 result의 channel의 범위 설정
    for y = 1:size(im,1) % im과 result의 높이 범위 설정
        for x = 1:size(im,2)
            % im과 result의 너비 범위 설정
            for s = -halfFs:halfFs % 필터의 높이 범위 설정
                for t = -halfFs:halfFs % 필터의 너비 범위 설정
                    ys = y-s;
                    xt = x-t;
                    % 필터의 가운데 값을 기준으로 필터의 각 좌표에 대응되는
                    % im에서의 좌표를 ys, xt로 나타냄
                    if ys <1; ys = 1; end
                    if xt <1; xt = 1; end
                    if ys > size(im,1); ys = size(im,1); end
                    if xt > size(im,2); xt = size(im,2); end
                    % replicate padding 방식을 적용한 코드
                    % 필터가 y 가 0보다 작거나 size(im,1)보다 큰 좌표의 값이나
                    % x가 0보다 작거나 size(im,2)보다 큰 좌표의 값을 사용해서 계산하려고 할때
                    % replicate padding을 통해서 가장 아까운 pixel의 값을 사용하도록 코딩하였음

                    result(y,x,ch) = result(y,x,ch) + weight(s+halfFs+1,t+halfFs+1)*im(ys,xt,ch);
                    % 각 result의 좌표에 weight가 가해진 im의 값들을 더해줘서
                    % gaussian filtering이 적용된 최종 영상을 완성한다.
                end
            end
       end
    end
end
end
