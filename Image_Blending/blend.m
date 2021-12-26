function result = blend(im1,im2,alpha)

result = zeros(size(im1),'uint8');
%im1과 im2의 size가 같은걸 확인한 후, result를 im1의 size와 같은 zero로 이루어진 행렬로 정의했다.
%zeros()함수를 사용하면 double 확장자로 정의되므로 uint8 형태로 정의될 수 있도록 정의한다.
for ch = 1:size(im1,3)
    %im1에 size()함수를 사용해서 변수ch가 1부터 im1의 channel값까지의 정수값으로 변하도록 for문을 구성했다. 
    for y = 1:size(im1,1)
        %im1에 size()함수를 사용해서 변수y가 1부터 im1의 hight값까지의 정수값으로 변하도록 for문을 구성했다. 
        for x = 1:size(im1,2)
            %im1에 size()함수를 사용해서 변수x가 1부터 im1의 width값까지의 정수값으로 변하도록 for문을 구성했다.
            
            result(y,x,ch) = alpha*im1(y,x,ch)+(1-alpha)*im2(y,x,ch);
            %행렬 result과 좌표와 channel이 동일한 im1과 im2의 값에 각각 alpha,
            %(1-alpha)만큼의 가중치를 줘서 행렬 result의 좌표에 값으로 대입하여 행렬 result를 완성하였다.
            %행렬 result의 각 행렬에 입력되는 값이 255가 넘어가지 않도록 
            %각각의 영상에 alpha와 (1-alpha)값을 곱해줘서 최대값이 255이 넘어가지 않도록 한다.
        end
    end
end
end
