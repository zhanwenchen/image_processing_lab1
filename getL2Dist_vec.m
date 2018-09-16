function D2 = getL2Dist_vec(A)
    tic
    D2 = sqrt(bsxfun(@plus,sum(A.^2)',bsxfun(@plus,sum(A.^2),-2*(A'*A))));
    toc
end