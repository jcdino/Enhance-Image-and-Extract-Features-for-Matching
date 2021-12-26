
function result = histEq(im, n)

%histogram 생성
[H, W] = size(im);
hist = zeros(n,1); %column vector
new_im = zeros(size(im));
for h=1:H
    for w = 1:W
        new_im(h,w) = im(h,w);
        % 뒤에 게산에서 num이 255가 넘어가도 그 값을 유지하기 위해
        % uint8형태의 im를 double형태의 값들을 담은 행렬로 다시 정의함
    end
end
m = (255/n);
for h=1:H
    for w = 1:W
        num = round(new_im(h,w)/m);
        % 0~255까지 존재하는 im의 각 pixel 값들을 255로 나누고 n으로 곱해서 
        % pixel 값들이 0~n level로 분류가 되도록 함
        hist(num+1) = hist(num+1)+1; 
        % histogram의 각각의 num번째 bin에 num 값들의 빈도수를 저장
    end
end
figure; bar(0:n-1,hist);
% histogram figure1 생성

% Equalizaton
prob = hist / (H*W);
% normalized된 histogram 생성
figure; plot(0:n-1, prob);
% normalized된 histogram의 figure2 생성


cum_prob = zeros(n,1);
cum_prob(1) = prob(1);
for k=2:n
    cum_prob(k) = cum_prob(k-1)+prob(k);
    % normalized된 histogram에 대한 cumulative histogram 생성
end
figure; plot(cum_prob)
% cumulative histogram의 figure3 생성

target = (n-1)*cum_prob;
% normailized된 cumulative histogram 값들을 histogram의 level 값에 맞도록 (n-1)을 곱함
figure; plot(target, '*-')
% target에 대한 figure4 생성

target_round = round(target); 
% level값들은 모두 정수이므로 target값도 정수로 반올림
figure; plot(target_round, '*-');
% target_round에 대한 figure5 생성

new_target_round = zeros(256,1);
for i= 1:n
    for p = round((255/n)*(i-1)):round((255/n)*i)
        new_target_round(p+1) = target_round(i)*m;
        % 출력 영상의 pixel값들의 범위와 히스토그램의 level 범위기가 0~255가 되도록 해야하므로 
        %level와 행렬 값들의 범위가 0~255인 행렬 new_target_round()을 새로 정의함
    end
end
figure; plot(new_target_round,'*-');
% new_target_round()에 대한 figure6 생성

result = zeros(size(im), 'uint8');
for h = 1:H
    for w = 1:W
        result(h,w) = new_target_round(im(h,w));
        %result의 각 pixel에 histogram equalizaiton이된 값을 저장한다.
    end
end





