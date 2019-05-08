%% Use the provided PointViewMatrix.txt
D = importdata('Data/PointViewMatrix.txt') ;
% construct the motion and structure matrices from datapoints D
[M, S] = structure_from_motion(D) ;

%% Create our own D matrix with consecutive chaining 
IMAGES = dir('Data/House/*.png') ;
path = 'Data/House' ;
bg_threshold = 50 ;
% round to the nearest "5" the point coordinates of matching
rounding = 10 ; 
D = chaining(IMAGES, path, bg_threshold, rounding) ; % Function for part 4
% visualize PVM
spy(D)
% derive the structure and motion matrices from datapoints D
[M, S] = structure_from_motion(D) ;

%% Iterative procedure: section 5.4
f = waitbar(0, 'progress') ;

n_stitching = 3 ;
bg_threshold = 10 ;
rounding = 1 ;
path = 'Data/House' ;
IMAGES = dir(strcat(path, '/*.png')) ;
S = [] ;

for j = 1:length(IMAGES)-n_stitching
    waitbar(j/length(IMAGES)) ;
    
    % Get the n_stitching images from which to create the Point View Matrix (3 or 4)
    images = IMAGES(j:j+3) ; 
    D = chaining(images, path, bg_threshold, rounding) ;
    [M_new, S_new] = structure_from_motion(D) ;
    
    if j == 1
        S = S_new ;
        S_last = S_new ;
    else
        % apply padding to the smallest matrix and calculate the
        % transformation from the last set of points. Not all "historical"
        % points are used bc the algorithm gets very slow otherwise
        if size(S_last,2) > size(S_new, 2)
            dif = size(S_last,2) - size(S_new, 2) ;
            S_new_pad = [S_new zeros(3, dif)] ;
            [d, S_new_trans, tr] = procrustes(S_last, S_new_pad) ;
        else size(S_last,2) <= size(S_new, 2) 
            dif = size(S_new, 2)-size(S_last,2) ;
            S_last_pad = [S_last zeros(3, dif)] ;
            [d, S_new_trans, tr] = procrustes(S_last_pad, S_new) ;
        end
        % Append new points from the n_stitching 
        S = [S S_new_trans] ;
        S_last = S_new_trans ;
    end
end
close(f)

%% Plotting results for the reconstruction

X = S(1,:) ;
Y = S(2,:) ;
Z = S(3,:) ;

figure(1)
scatter3(X, Y, Z)

t = MyCrustOpen(S') ;
figure(2)
trisurf(t, X, Y, Z)


