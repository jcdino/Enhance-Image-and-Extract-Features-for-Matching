function result = MarrHildrethEdge(im, sigma, threshold)

% Laplacian of Gaussian filter의 weight값 설정
filterSize = 2*ceil(3*sigma);
%sigma를 이용해서 Laplacian of Gaussian filter의 size를 구함
halfFs = floor(filterSize/2);
% Laplacian of Gaussian filter의 size의 반 크기를 구함

weight = zeros(filterSize,filterSize);
% Laplacian of Gaussian filter를 영행렬로 선언
for y = -halfFs:-halfFs+filterSize-1
    for x = -halfFs:-halfFs+filterSize-1
        weight(y+halfFs+1,x+halfFs+1) = ((y^2+x^2-2*sigma^2) / (sigma^4)) * (1/(2*pi*sigma^2) * exp(-(y^2+x^2) / (2*sigma^2)));
        % x와 y에 대해서 2차 편미분한 값을 나타내기 위해 gaussian funciton에
        % (y^2+x^2-2*sigma^2) / (sigma^4)를 곱한 값으로 각 좌표의 값을 결정한다.
    end
end

weight_avg = mean(weight, 'all');
% filter의 weight값들의 평균을 구함

for y = 1:size(weight,1)
    for x = 1:size(weight,2)
        weight(y,x) = weight(y,x) - weight_avg;
        % weight의 모든 값들의 합이 0이 되기 위해서, 모든 값에 평균만큼 빼줌
    end
end



conv_result = zeros(size(im));
% Laplacian of Gaussian filter와 입력영상을 convolution한 값을 
% 저장할 변수 conv_result를 영행렬로 선언
for ch = 1:size(im,3) 
    for y = 1:size(im,1) 
        for x = 1:size(im,2)
            for s = -halfFs:-halfFs+filterSize-1 
                for t = -halfFs:-halfFs+filterSize-1 
                    ys = y-s;
                    xt = x-t;
                    % 필터의 가운데 값을 기준으로 필터의 각 좌표에 대응되는 im에서의 좌표를 ys, xt로 나타냄
                    if ys <1; ys = 1; end
                    if xt <1; xt = 1; end
                    if ys > size(im,1); ys = size(im,1); end
                    if xt > size(im,2); xt = size(im,2); end
                    % replicate padding 방식을 적용한 코드
                    % 필터가 y 가 0보다 작거나 size(im,1)보다 큰 좌표의 값이나
                    % x가 0보다 작거나 size(im,2)보다 큰 좌표의 값을 사용해서 계산하려고 할때
                    % replicate padding을 통해서 가장 가까운 pixel의 값을 사용하도록 코딩하였음
                    
                    conv_result(y,x,ch) = conv_result(y,x,ch)+weight(s+halfFs+1,t+halfFs+1)*im(ys,xt,ch);
                    % Laplacian of Gaussian filter와 입력영상을 convolution한 값을
                    % conv_result의 해당 좌표에 저장
                end
            end
        end
    end
end


% threshold 구하기
max = 0;
% conv_result의 값 중 제일 큰 값을 저장할 변수 max을 0으로 선언
for ch = 1:size(conv_result,3) 
    for y = 1:size(conv_result,1) 
        for x = 1:size(conv_result,2)
            if conv_result(y,x,ch) > max; max=conv_result(y,x,ch);end
            % conv_result의 모든 값을 하나씩 확인해서 변수 max보다 크면 변수 max의 값을 해당 값으로 바꿔주어
            % 변수 max에 제일 큰 값이 들어가도록 해준다.
        end
    end
end
new_threshold = threshold * max;
% threshold값을 앞써 구한 conv_result의 값 중 제일 큰 값과 변수로 받은 threshold의 값을 곱해서 구한다.



result = zeros(size(im));
% 출력 영상 result를 영행렬로 선언
bounded = zeros(3,3,size(im,3));
% zero-crossing을 판단하는데 필요한 좌표들의 범위에 들어가는 크기를 설정

for ch = 1:size(conv_result,3) 
    for y = 1:size(conv_result,1) 
        for x = 1:size(conv_result,2)
            for s = -1:1
                for t = -1:1
                    ys = y+s;
                    xt = x+t;
                    % 필터의 가운데 값을 기준으로 필터의 각 좌표에 대응되는 conv_result에서의 좌표를 
                    %ys, xt로 나타냄
                    if ys <1; ys = 1; end
                    if xt <1; xt = 1; end
                    if ys > size(conv_result,1); ys = size(conv_result,1); end
                    if xt > size(conv_result,2); xt = size(conv_result,2); end
                    % replicate padding 방식을 적용한 코드
                    % 필터가 y 가 0보다 작거나 size(conv_result,1)보다 큰 좌표의 값이나
                    % x가 0보다 작거나 size(conv_result,2)보다 큰 좌표의 값을 사용해서 계산하려고 할때
                    % replicate padding을 통해서 가장 가까운 pixel의 값을 사용하도록 코딩하였음
                    
                    bounded(s+1+1,t+1+1,ch) = conv_result(ys,xt,ch);
                    % 해당 pixel의 값을 결정함에 있어 zero-crossing을 판단하기 위해 필요한 값들들을
                    % 행렬 bounded에 저장
                end
            end
            count = 0;
            % 해당 pixel에서 zero-crossing이 이루어진 갯수를 counting하기 위한 변수 선언
            if (median([bounded(2,1,ch),0,bounded(2,3,ch)]) == 0) && ...
                    (abs(bounded(2,1,ch)-bounded(2,3,ch))>new_threshold); count=count+1;end
            % 해당 pixel 기준으로 위, 아래 pixel 값이 부호가 반대이고 두 값을 뺸 값의 절대값이 
            % threshold보다 크면 zero-crossing이라고 판단하여 count를 1만큼 늘린다.
            if (median([bounded(1,2,ch),0,bounded(3,2,ch)]) == 0) && ...
                    (abs(bounded(1,2,ch)-conv_result(3,2,ch))>new_threshold);count=count+1;end
            % 해당 pixel 기준으로 좌우 pixel 값이 부호가 반대이고 두 값을 뺸 값의 절대값이 
            % threshold보다 크면 zero-crossing이라고 판단하여 count를 1만큼 늘린다.
            if (median([bounded(1,1,ch),0,bounded(3,3,ch)]) == 0) && ...
                    (abs(bounded(1,1,ch)-bounded(3,3,ch))>new_threshold);count=count+1;end
            % 해당 pixel 기준으로 왼쪽 위, 오른쪽 아래 pixel 값이 부호가 반대이고 두 값을 뺸 값의 절대값이 
            % threshold보다 크면 zero-crossing이라고 판단하여 count를 1만큼 늘린다.
            if (median([bounded(1,3,ch),0,bounded(3,1,ch)]) == 0) && ...
                    (abs(bounded(1,3,ch)-bounded(3,1,ch))>new_threshold);count=count+1;end
            % 해당 pixel 기준으로 오른쪽 위, 왼쪽 아래 pixel 값이 부호가 반대이고 두 값을 뺸 값의 절대값이 
            % threshold보다 크면 zero-crossing이라고 판단하여 count를 1만큼 늘린다.
            if count >=2; result(y,x,ch) =1;end
            % count가 2보다 크면 2개 이상 일 때, zero-crossing이 2개 이상이므로 edge라고 판단하여
            % 출력영상의 해당 좌표값을 1로 저장해준다.
        end
    end
end





