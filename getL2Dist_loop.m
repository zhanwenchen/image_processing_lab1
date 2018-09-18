function D2 = getL2Dist_loop(A)
    tic
    n = size(A, 2);
    D2 = zeros(n, n);
    for r = 1:n
        for c = (r+1):n
            diff = A(:,r)-A(:,c);
            D2(r,c) = sqrt(diff'*diff);
            if r == 1000 && c == 11
                fprintf('(1000, 11): diff = %s, D2(1000, 11) = %f', mat2str(diff), D2(r,c));
            end
        end
    end
    D2 = D2 + D2';
    toc
end