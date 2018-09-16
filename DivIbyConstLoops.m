function divved = DivIbyConstLoops(image, constant)
    tic
    nrows = size(image, 1);
    ncols = size(image, 2);
    for c = 1:ncols
        for r = 1:nrows
            image(r, c) = image(r, c)/constant;
        end
    end
    toc
    divved = image;
end