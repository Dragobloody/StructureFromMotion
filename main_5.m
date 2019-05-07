% find dense block
path = 'Data/House' ;

D = chaining(path) ;
%%

% Read PointViewMatrix.txt into D
%D = importdata('Data/PointViewMatrix.txt') ;


%%
j = 0 ;
IMAGES = dir('Data/House/*.png') ;
n_stitching = 3 ;
M = [] ;
S = [] ;

for j = 1:length(IMAGES)-n_stitching
    images = IMAGES(j:j+3) ;
    D = chaining(images) ;
    [M_last, S_last] = structure_from_motion(D) ;
    if j > 1
        [d,Z,tr] = procrustes(S, S_last) ;
        S = [S S_last] ;
    end
end
%%
X = S(1,:) ;
Y = S(2,:) ;
Z = S(3,:) ;

figure(1)
scatter3(X, Y, Z)

t = MyCrustOpen(S') ;
figure(2)
trisurf(t, X, Y, Z)


