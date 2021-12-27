function SIFT = extractSIFT(im, fx_operator, fy_operator, corner, Gaussian_sigma)
%%
im = double(rgb2gray(im)); %im을 rgb에서 gray scale로 바꾸고 
                           %정확한 값을 구하기 위해 uint8에서 double로 변환
fx = zeros(size(im)); fy = zeros(size(im));

% x방향과 y방향에 대한 derivatives를 각각 구하고 이를 행렬로 표현함
for y=1:size(im,1)
    for x=1:size(im,2)
        a = x+1;
        b = y+1;
        if a>size(im,2); a=x;end
        if b>size(im,1); b=y;end
        fx(y,x) = im(y,x)*fx_operator(1,1)+im(y,a)*fx_operator(1,2);
        fy(y,x) = im(y,x)*fy_operator(1,1)+im(b,x)*fy_operator(2,1);
    end
end

%%
M = zeros(size(im));
direction = zeros(size(im));
% gradient의 magnitude와 direction을 계산함
% gradient의 direction의 경우에는 atan가 -pi/2부터 pi/2까지 표현 가능하므로 
% 그 밖의 범위에 대해서는 pi를 더해주거 뺴주었다.
for y=1:size(im,1)
    for x=1:size(im,2)
        M(y,x) = sqrt(fx(y,x)^2+fy(y,x)^2);
        if fx(y,x)<0 && fy(y,x)>0
            direction(y,x) = atan(fy(y,x)/fx(y,x))+pi;
        elseif fx(y,x)<0 && fy(y,x)<0
            direction(y,x) = atan(fy(y,x)/fx(y,x))-pi;
        elseif fx(y,x)==0 && fy(y,x)<0
            direction(y,x) = -pi/2;
        elseif fx(y,x)==0 && fy(y,x)>0
            direction(y,x) = pi/2;
        elseif fx(y,x)<0 && fy(y,x)==0
            direction(y,x) = pi;
        elseif fx(y,x)>0 && fy(y,x)==0
            direction(y,x) = pi/2;
        else 
            direction(y,x) = atan(fy(y,x)/fx(y,x));
        end
    end
end
%%

%Gaussian filter 생성
filterSize = 16;

halfFs = (filterSize)/2;
% 필터의 최하단, 오른쪽 좌표값을 구해서 필터의 크기를 구한다.

weight = zeros(filterSize, filterSize);
% 0으로 구성된 gaussian filter를 weight라는 행렬로 선언

for y = -halfFs+1 : halfFs 
    for x = -halfFs+1 : halfFs 
        weight(y+halfFs,x+halfFs) = 1/(2*pi*Gaussian_sigma^2) * ...
            exp(-((y-0.5)^2+(x-0.5)^2) / (2*Gaussian_sigma^2));
        % 행렬 weight의 각 행과 열에 값을 입력해줌으로써 weight값이 입력된 gaussian filter 구성
    end
end
weight = weight / sum(weight, 'all');

%%

filterSize = 16; halfFs = filterSize/2;
crop_M  =zeros(16,16); crop_direction = zeros(16,16);
hist = zeros(128,size(corner,1));new_hist = zeros(128,size(corner,1));
% SIFT의 최종결과 128-D vector를 생성하기 위한 for문
for y = 1:size(corner,1)
    for s = -halfFs+1:halfFs % 필터의 높이 범위 설정
        for t = -halfFs+1:halfFs % 필터의 너비 범위 설정
            ys = corner(y,2)+s;
            xt = corner(y,1)+t;
            % 필터의 가운데 값을 기준으로 필터의 각 좌표에 대응되는 im에서의 좌표를 ys, xt로 나타냄
            if ys <1; ys = 1; end; if xt <1; xt = 1; end
            if ys > size(im,1); ys = size(im,1); end; if xt > size(im,2); xt = size(im,2); end
            %magnitute와 direction에 대해서 16*16의 patch로 crop한다.
            crop_M(s+halfFs,t+halfFs) = M(ys,xt);
            crop_direction(s+halfFs,t+halfFs) = direction(ys,xt);
        end
    end
    % Crop한 magnitute patch에 Gaussian function을 적용하엿다.
    Gaussian_crop_M = crop_M.*weight;
    count = 1;
    for y_crop = 1:4
        for x_crop = 1:4
            for y_dir = 1:4
                for x_dir = 1:4
                    for dir = 1 : 8
                        % 16+16 patch르 4의 영역으로 분류하여 각 영역에서의 방향에 대응하는 방향의
                        % 크기를 histogram에 저장한다.
                        if (crop_direction(y_dir+4*(y_crop-1), x_dir+4*(x_crop-1)) >= -pi+2*pi/8*(dir-1)) ...
                                &&(crop_direction(y_dir+4*(y_crop-1),x_dir+4*(x_crop-1))<-pi+2*pi/8*(dir))
                            hist(dir+8*(count-1),y) = hist(dir+8*(count-1),y) +...
                                Gaussian_crop_M(y_dir+4*(y_crop-1), x_dir+4*(x_crop-1));
                        end
                    end
                end
            end
            count = count + 1;        
        end 
    end
    for idx = 1:size(hist,2)
        hist_sum = 0;
        for d = 1:size(hist,1)
            % 128-D vector를 정규화 하기 위해 합을 구해준다.
            hist_sum = hist_sum + hist(d,idx)^2;
        end
        for d = 1:size(hist,1)
            new_hist(d,idx) = hist(d,idx) / sqrt(hist_sum); % 128-D vector 정규화
            if new_hist(d,idx)<0.2 % 0.2보다 작은 값은 0으로 만들어준다. 
                new_hist(d,idx)=0;
            end
        end
        for d = 1:size(hist,1)
            % 128-D vector를 다시 정규화 하기 위해 합을 구해준다.
            hist_sum = hist_sum + hist(d,idx)^2;
        end
        for d = 1:size(hist,1)
            % 128-D vector 다시 정규화
            new_hist(d,idx) = hist(d,idx) / sqrt(hist_sum);
        end
    end
end
SIFT = new_hist;%최종 생성한 128-D histogram 출력
end    