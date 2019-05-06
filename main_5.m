% find dense block
path = 'Data/House' ;

D = chaining(path) ;
%%

% Read PointViewMatrix.txt into D
D = importdata('Data/PointViewMatrix.txt') ;


%%
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

%%
X = S(1,:) ;
Y = S(2,:) ;
Z = S(3,:) ;

figure(1)
scatter3(X, Y, Z)

t = MyCrustOpen(S') ;
figure(2)
trisurf(t, X, Y, Z)


