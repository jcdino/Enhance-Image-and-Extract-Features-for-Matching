
function result = SobelEdge(im)

im_double = im2double(im);
% 입력 영상의 pixel값들을 uint8형에서 double형으로 바꿔준다.
h = size(im_double,1);
% 입력 영상의 높이를 h 변수에 저장
w = size(im_double,2);
% 입력 영상의 너비를 w 변수에 저장
gy = zeros(size(im_double,1),size(im_double,2));
% y방향의 gradient를 구한 결과를 저장할 변수 gy를 모두 0이 되도록 선언
gx = zeros(size(im_double,1),size(im_double,2));
% x방향의 gradient를 구한 결과를 저장할 변수 gx를 모두 0이 되도록 선언
result = zeros(size(im_double,1),size(im_double,2));
% 최종 결과값을 저장할 변수 result의 값이 모두 0이 되도록 선언

% filter에 대한 값 설정
gy_filter = [1,2,1;0,0,0;-1,-2,-1];
% gy를 결정함에 있어 사용되는 필터의 값들을 결정해준다.
gx_filter = [1,0,-1;2,0,-2;1,0,-1];
% gx를 결정함에 있어 사용되는 필터의 값들을 결정해준다.
halfFs = 1;
% gx_filter와 gy_filter의 크기의 반값을 설정해준다.

% y축에 관한 gradient를 저장한 gy, x축에 관한 gradient를 저장한 gx의 값 결정
for ch = 1:size(im,3) % im_double, gx, gy의 channel의 범위 설정
    for y = 1:h % im_double, gx, gy의 높이 범위 설정
        for x = 1:w % im_double, gx, gy의 너비 범위 설정
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
                    gy(y,x,ch) = gy(y,x,ch)+gy_filter(s+halfFs+1,t+halfFs+1)*im_double(ys,xt,ch);
                    gx(y,x,ch) = gx(y,x,ch)+gx_filter(s+halfFs+1,t+halfFs+1)*im_double(ys,xt,ch);
                    % filter의 값과 filter가 위치에 대응하는 입력 영상의 pixel값들을 컨볼루젼 해주고 그
                    % 값들을 더한 값을 filter의 (1,1) 위치에 대응하는 gy와 gx의 pixel 각각에 저장해준다. 
                end
            end
        end
    end
end

% 최종 출력 영상을 결정하는 과정 
for ch = 1:size(im,3) % result, gx, gy의 channel의 범위 설정
    for y = 1:h % result, gx, gy의 높이 범위 설정
        for x = 1:w % result, gx, gy의 너비 범위 설정
            result(y,x,ch) = sqrt(gy(y,x,ch)^2+gx(y,x,ch)^2);
            % edge magnitude를 구하는 공식을 사용해서 gy와 gx와 동일한 위치의 pixel에 해당하는
            % 최종 출력 영상 result의 각 pixel들의 값을 결정한다.
        end
    end
end
