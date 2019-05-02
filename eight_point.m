function F = eight_point(p, p_prime, n)  
    A = [];   
    % Construct matrix A
    A = [A , p(:,1).*p_prime];
    A = [A , p(:,2).*p_prime];
    A = [A , p(:,3).*p_prime];
    
    % Find SVD of A
    [U,S,V] = svd(A);
    
    % Compute F
    if n == 8
        F = reshape(V(:,8),[3,3]);
    else
        F = reshape(V(:,9),[3,3]);
    end
    
    % Find SVD of F
    [Uf,Sf,Vf] = svd(F);
    
    % Recompute F
    Sf(end,end) = 0;
    F = Uf*Sf*(Vf)';    
    
end

