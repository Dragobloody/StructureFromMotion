% Read PointViewMatrix.txt into D
D = importdata('Data/PointViewMatrix.txt') ;
[M, S] = structure_from_motion(D) ;

%%
IMAGES = dir('Data/House/*.png') ;
path = 'Data/House' ;
D = chaining(IMAGES, path) ;


%%

path = 'Data/House' ;
IMAGES = dir(strcat(path, '/*.png')) ;
n_stitching = 3 ;
S = [] ;
f = waitbar(0, 'progress') ;

for j = 1:length(IMAGES)-n_stitching
    waitbar(j/length(IMAGES)) ;
    
    images = IMAGES(j:j+3) ;
    D = chaining(images, path) ;
    [M_new, S_new] = structure_from_motion(D) ;
    
    
    if j == 1
        S = S_new ;
        S_last = S_new ;
    else
        if size(S_last,2) > size(S_new, 2)
            S_new_pad = padarray(S_new, size(S_last), 0) ;
            [d, S_new_trans, tr] = procrustes(S_last, S_new) ;
        else size(S_last,2) <= size(S_new, 2)
            S_last_pad = padarray(S_last, size(S_new), 0) ;
            [d, S_new_trans, tr] = procrustes(S_last, S_new) ;
        end
        S = [S S_new_trans] ;
        S_last = S_new_trans ;
    end
    
end
close(f)

%%
X = S(1,:) ;
Y = S(2,:) ;
Z = S(3,:) ;

figure(1)
scatter3(X, Y, Z)

t = MyCrustOpen(S') ;
figure(2)
trisurf(t, X, Y, Z)


