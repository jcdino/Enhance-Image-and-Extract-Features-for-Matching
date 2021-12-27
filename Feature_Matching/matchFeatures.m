
function matching = matchFeatures(SIFT1, SIFT2)

matching = []; %실제 matching이 이루어진 점들을 저장할 행렬

% SIFT1에서의 각 interest point에 대해서 SIFT2에서 유사한 interets point 찾는 과정
for corners_1 = 1:size(SIFT1,2)
    NN1 = inf; NN2 = inf; NN1_idx = 0;
    for corners_2 = 1:size(SIFT2,2)
        distance = 0;
        for D = 1:128
            distance = distance + (SIFT1(D,corners_1) - SIFT2(D,corners_2))^2;
            % SIFT1의 한 점에 대한 128개의 점과 그에 대응하는 SIFT2의 128개의 점의 차를 제곱하여
            %이를 distance로 저장한다.
        end
        % 가장 유사한 점의 distance를 NN1, 두번째로 유사한 점의 distance를 NN2에 저장한다
        if distance<=NN1
            NN1 = distance;
            NN1_idx = corners_2;
        elseif distance<NN2 && distance>NN1
            NN2 = distance;
        else
            continue;
        end
    end
    % matching 행렬에 distance가 가장 가까운 SIFT2의 index와 radio distance를 저장
    matching = [matching; [NN1_idx NN1/NN2]];
end
            
                    