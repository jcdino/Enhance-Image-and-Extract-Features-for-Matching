
function result = medianFiltering(im, filterSize)

filterNums = zeros(filterSize(1)*filterSize(2),1,'uint8');
% zeros으로 구성된'uint8'형 행렬 medianNums 구성
% filter의 크기 안에 있는 숫자들을 모아 놓기 위한 행렬
result = zeros(size(im),'uint8');
% 입력영상과 크키가 같은 'uint8'형 행렬 result 구성
halfH = round((filterSize(1)-1)/2);
% 중앙값이 (0,0)일 때 다른 픽셀들의 좌표를 편하게 구하기 위해서 
% filter 높이의 반에 대한 하는 변수 halfH 정의
halfW = round((filterSize(2)-1)/2);
% 중앙값이 (0,0)일 때 다른 픽셀들의 좌표를 편하게 구하기 위해서 
% filter 너비의 반에 대한 하는 변수 halfW 정의

for ch = 1: size(im,3)  % im과 result의 channel의 범위 설정
    for y = 1:size(im,1)  % im과 result의 높이 범위 설정
        for x = 1:size(im,2)  % im과 result의 너비 범위 설정
            count = 1;  
            % filterNums의 y좌표값으로, 필터의 범위 내의 값들을 모두 filterNums에 저장되면 
            % 새로운 필터 값들을 저장하기 위해 변수 count의 값을 1로 초기화하여 다시 저장하기 시작
            for s = -halfH : halfH  % 필터의 높이 범위 설정
                for t = -halfW : halfW  % 필터의 너비 범위 설정
                    ys = y+s;  % 필터의 위치에 대응하는 입력 영상에서의 높이 좌표값
                    xt = x+t;  % 필터의 위치에 대응하는 입력 영상에서의 너비 좌표값
                    if ys <1; ys = 1; end
                    if xt <1; xt = 1; end
                    if ys > size(im,1); ys = size(im,1); end
                    if xt > size(im,2); xt = size(im,2); end
                    % replicate padding 방식을 적용한 코드
                    % 필터가 y 가 0보다 작거나 size(im,1)보다 큰 좌표의 값 또는
                    % x가 0보다 작거나 size(im,2)보다 큰 좌표의 값을 사용해서 계산하려고 할때
                    % replicate padding을 통해서 가장 아까운 pixel의 값을 사용하도록 코딩하였음
                    
                    filterNums(count,1,ch) = im(ys,xt,ch);
                    % filter 범위 안에 있는 입력 영상의 값들을 행렬 filterNums에 모두 넣어줌 
                    count = count+1;
                    % filterNums에 filter에 범위 안에 있는 값들이 모두 들어갈 수 있도록 filterNums의 y좌표를 1씩 늘려준다.
                    medianNum = median(filterNums);
                    % filterNums에 있는 값들 중 순서대로 나열했을 때 중간에 있는 값을 선택해서 변수
                    % medianNum의 값으로 저장
                    result(y,x,ch) = medianNum;
                    % 변수 medianNum의 값을 행렬 result의 (y,x,ch)에 저장
                end
            end
        end
    end
end
end
