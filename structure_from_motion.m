function [M, S] = structure_from_motion(D)
% input D: matrix where every 2 rows are 1 frame (x & y) and every column
% is a point

% Normalize
D = D - mean(D,2) ;

% Apply SVD
[U, W, V] = svd(D) ;


% Reduce to rank 3
W_3 = W(1:3, 1:3) ;
U_3 = U(:,1:3) ;
V_3 = V(:,1:3) ;
norm(D-U*W*V')
norm(D-U_3*W_3*V_3')
% Decomposition of Motion and Structure (M and S)that minimizes abs((D-MS)^2)
M = U_3 * sqrt(W_3) ;
S = sqrt(W_3) * V_3' ;
norm(D-M*S)

% Eliminate affine ambiguity
% A_i * L * A_i = Id
% L = C * C'
% M = M * C
% S = inv(C) * S

L = pinv(M)*pinv(M)' ;
C = chol(L);

M = M*C;
S = inv(C)*S;
norm(D-M*S)
end

