
function result = bilinearInterpolation(im, scale)
% 초기 변수들의 값을 정해주는 과정
h = size(im,1);
% 이미지의 높이를 변수 h에 저장
w = size(im,2);
% 이미지의 너비를 변수 w에 저장
result = zeros(h*scale,w*scale,'uint8');
% scale만큼 증가한 출력 영상을 모두 0으로 초기화한 uint8형태의 행렬을 변수 result에 저장

% 기존 im의 pixel값들을 출력 영상 행렬에 입력하는 과정
for ch=1:size(im,3)
    for y = 1:h
        for x = 1:w
            result(scale*(y-1)+1,scale*(x-1)+1,ch) = im(y,x,ch);
            % im에 있는 픽셀값들을 result을 (scale-1)개의 pixel 간격을 두고 배치한다.
        end
    end
end

%%

% result에서 im의 pixel값들이 들어간 행과 열 중, 값이 0인 pixel의 값들을 채우는 과정
for ch=1:size(result,3)
    for y = 1:h
        for x = 1:(w-1)
            for j = 1:(scale-1)
                result(scale*(y-1)+1,scale*(x-1)+1+j,ch) = im(y,x,ch)/(scale)*(scale-j) + im(y,x+1,ch)/(scale)*j;
                % im의 pixel값들이 들어간 행에 관해서 그 사이 빈 pixel을 채워주는 과정
                % 비어 있는 pixel을 기준으로, 같은 행에서 양 끝 값이 존재하는 pixel의 값에 거리에 비례해서 가까우면
                % 더 많은 가중치를 가해줘서 둘을 더한 값을 비어있는 pixel의 값을 정해준다.
            end
        end
    end
end

for ch=1:size(result,3)
    for x = 1:w
        for y = 1:(h-1)
            for i = 1:(scale-1)
                result(scale*(y-1)+1+i,scale*(x-1)+1,ch) = im(y,x,ch)/(scale)*(scale-i) + im(y+1,x,ch)/(scale)*i;
                % im의 pixel값들이 들어간 행에 관해서 그 사이 빈 pixel을 채워주는 과정
                % 비어 있는 pixel을 기준으로, 같은 행에서 양 끝 값이 존재하는 pixel의 값에 거리에 비례해서 가까우면
                % 더 많은 가중치를 가해줘서 둘을 더한 값을 비어있는 pixel의 값을 정해준다.
            end
        end
    end
end

%%
% 앞 과정 이후에 남아 있는 빈 pixel의 값을 채우는 과정 
for ch=1:size(im,3)
    for y = 1:h-1
        for x = 1:w-1
            for m = 1:(scale-1)
                for k = 1:(scale-1)
                    result(scale*(y-1)+1+m,scale*(x-1)+1+k,ch) = result(scale*(y-1)+1+m,scale*(x-1)+1,ch)/scale*(scale-k) + result(scale*(y-1)+1+m,scale*(x-1)+1+scale,ch)/scale*k;
                    % 비어 있는 pixel 중 하나를 고르고, pixel 기준으로 같은 열에 있는 가까운 두 pixel의 값을 찾는다.(vertical first)
                    % 두 pixel와 고른 빈 pixel의 거리가 가까울수록 가중치가 크도록하여 둘을 더한값을 빈 pixel의 값을 결정한다.
                end
            end
        end
    end
end

% 앞 과정 이후에 남아 있는 빈 pixel의 값을 채우는 과정 
% for ch=1:size(im,3)
%     for y = 1:h-1
%         for x = 1:w-1
%             for m = 1:(scale-1)
%                 for k = 1:(scale-1)
%                     result(scale*(y-1)+1+m,scale*(x-1)+1+k,ch) = result(scale*(y-1)+1,scale*(x-1)+1+k,ch)/scale*(scale-m) + result(scale*(y-1)+1+scale,scale*(x-1)+1+k,ch)/scale*m;
%                     % 비어 있는 pixel 중 하나를 고르고, pixel 기준으로 같은 열에 있는 가까운 두 pixel의 값을 찾는다.(Horizontal first)
%                     % 두 pixel와 고른 빈 pixel의 거리가 가까울수록 가중치가 크도록하여 둘을 더한값을 빈 pixel의 값을 결정한다.
%                 end
%             end
%         end
%     end
% end

%%
% result의 오른쪽과 아래쪽의 pixel 중 값이 없는 pixel들의 값을 결정해주는 과정 
for ch = 1:size(result,3)
    for y = 1:size(result,1)
        for x = 1:size(result,2)
            if x > scale*(w-1)+1
                result(y,x,ch) = result(y,scale*(w-1)+1,ch);
                % im의 제일 오른쪽에 있는 값이 들어간 pixel들보다 큰 x들에 대해서 
                % 같은 행의 im의 제일 오른쪽에 있는 값이 들어가도록 한다.
            end
            if y > scale*(h-1)+1
                result(y,x,ch) = result(scale*(h-1)+1,x,ch);
                % im의 제일 아래에 있는 값이 들어간 pixel들보다 큰 y들에 대해서 
                % 같은 열의 im의 제일 아래에 있는 값이 들어가도록 한다.
            end
        end
    end
end


