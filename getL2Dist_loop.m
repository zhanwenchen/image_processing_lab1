function D2 = getL2Dist_loop(A)
    tic
    n = size(A, 2);
    D2 = zeros(n, n);
    for r = 1:n
        for c = (r+1):n
%             fprintf('r = %d, c= %d. ', r, c);
            diff = A(:,r)-A(:,c);
            D2(r,c) = sqrt(diff'*diff);
            if r == 1000 && c == 11
                fprintf('(1000, 11): diff = %s, D2(1000, 11) = %f', mat2str(diff), D2(r,c));
            end
%             fprintf('D2(%d,%d) = %d\n', r, c, D2(r,c));
        end
    end
    D2 = D2 + D2';
    toc
end

for i = 1:1000
    for j = 1:1000
        if D_vec(i,j) ~= D_pdist(i,j)
            fprintf('D_vec(%d,%d) = %d. D_pdist(%d,%d) = %d.\n', i, j, D_vec(i,j), i, j, D_pdist(i,j))
        end
    end
end