function [M, S] = structure_from_motion(D)
% input D: matrix where every 2 rows are 1 frame (x & y) and every column
% is a point

% Normalize
D = D - mean(D')' ;

% Apply SVD
[U, W, V] = svd(D) ;

% Reduce to rank 3
W_3 = W(1:3, 1:3) ;
U_3 = U(:,1:3) ;
V_3 = V(:, 1:3) ;

% Decomposition of Motion and Structure (M and S)that minimizes abs((D-MS)^2)
M = U_3 * sqrtm(W_3) ;
S = sqrtm(W_3) * V_3' ;

end

