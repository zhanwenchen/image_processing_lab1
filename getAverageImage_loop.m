function average_image = getAverageImage_loop(original_image)
    % Convert to double
    original_image_float = double(original_image);
    % Get sizes
    [num_rows, num_cols, num_bands] = size(original_image_float);
    % Allocate a zeros image
    average_image = zeros(num_rows, num_cols, num_bands);

    % Do the same thing on each band.
    tic
    for band = 1:num_bands
        % for all points in 2D, average 9-blocks. No edge cases.
        for row = 2:num_rows-1
           for col = 2:num_cols-1
                average_image(row, col, band) = (original_image_float(row-1, col-1, band) + original_image_float(row-1, col, band) + original_image_float(row-1, col+1, band) ...
                                           + original_image_float(row, col-1, band) + original_image_float(row, col, band) + original_image_float(row, col+1, band) ...
                                           + original_image_float(row+1, col-1, band) + original_image_float(row+1, col, band) + original_image_float(row+1, col+1, band)) / 9.0;
           end
        end
    end
    toc
    average_image = uint8(average_image);
end