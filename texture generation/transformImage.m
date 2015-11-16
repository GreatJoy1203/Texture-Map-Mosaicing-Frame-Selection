function output=transformImage(H,input, source_quadrangle)

    % map all pixel in input image, [input_image], size MxN to temporary matrix, [tmp],  size 2 x M*N
    [M,N,D] = size(input);
    tmp = zeros(2,M*N);
    for i = 1:M
        for j = 1:N
            tmp(1,(N*(i-1))+j) = i;
            tmp(2,(N*(i-1))+j) = j;        
        end
    end

    % convert [tmp] size 2 x M*N  to be [tmp]  size 3 x M*N by pad [1] size 1xM*N at the 3rd row
    % apply X2 = H.X1
    X2 = H * [ tmp ; ones(1,M*N) ];
     mapped=X2;
    % normalize [X2]
    X2 = mapped(1:2,:) ./ repmat(mapped(3,:),2,1);



    % map [X2] size DxM*N back to [output] size MxNxD
    output = zeros(M,N,D);

    for i = 1:M
        for j = 1:N
            row = round(X2(1,(N*(i-1))+j));
            col = round(X2(2,(N*(i-1))+j));

            if 0 < row && row < M && 0 < col && col < N %&& pointInQuadrangle(source_quadrangle, j, i)
             %   disp( 'in range' )
            
                for d=1:D
                    output(row,col,d) = input(i,j,d);
                end
            else
              %  disp('out range')
            end
        end
    end
    output=uint8(output);
    disp('finish')
end