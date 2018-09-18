function J = DivIbyConstNoLoops(I,c)
    tic
    J=uint8(double(I)/c);
    toc
end
