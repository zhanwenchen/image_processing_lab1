function average_image = getAverageImage_vec(I)
    % Convert to double
    I = double(I);
    
    % Get sizes
    [R, C, B] = size(I);
    
%     down = [zeros(1,C,B); I(1:R-1,:,:)];
%     up = [I(2:R,:,:); zeros(1,C,B)];
%     right = [zeros(R,1,B) I(:,1:C-1,:)];
%     left = [I(:,2:C,:) zeros(R,1,B)];
%     down_right = [zeros(R, 1, B) [zeros(1,C-1,B); I(1:R-1,1:C-1,:)]];
%     down_left = [[zeros(1,C-1,B); I(1:R-1,2:C,:)] zeros(R, 1, B)];
%     up_right = [zeros(R, 1, B) [I(2:R,1:C-1,:); zeros(1,C-1,B)]];
%     up_left = [[I(2:R,2:C,:); zeros(1,C-1,B)] zeros(R, 1, B)];

%     average_image = (I + down + up_ + right + left + down_right + down_left + up_right + up_left) / 9.0;
    average_image = zeros(R, C, B);
    tic
%     I = padarray(I(2:R-1, 2:C-1, :), [1 1])
    average_image = (I + ... % TODO: instead of I, do I without the edge
                    [zeros(1,C,B); I(1:R-1,:,:)] + ... % down
                    [I(2:R,:,:); zeros(1,C,B)] + ... % up
                    [zeros(R,1,B) I(:,1:C-1,:)] + ... % right
                    [I(:,2:C,:) zeros(R,1,B)] + ... % left
                    [zeros(R, 1, B) [zeros(1,C-1,B); I(1:R-1,1:C-1,:)]] + ... % down_right
                    [[zeros(1,C-1,B); I(1:R-1,2:C,:)] zeros(R, 1, B)] + ... % down_left
                    [zeros(R, 1, B) [I(2:R,1:C-1,:); zeros(1,C-1,B)]] + ... % up_right
                    [[I(2:R,2:C,:); zeros(1,C-1,B)] zeros(R, 1, B)]) / 9.0; % up_left
                    average_image([1, R], :, :) = 0;
                    average_image(:, [1, C], :) = 0;
    toc
    average_image = uint8(average_image);
end