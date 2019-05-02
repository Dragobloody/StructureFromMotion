%% Keypoint Matching
run('C:/Program Files/MATLAB/R2018b/vlfeat-0.9.21-bin/toolbox/vl_setup')

image1 = imread('Data/House/frame00000001.png');
image2 = imread('Data/House/frame00000049.png');
[keypoints1, keypoints2, scores] = keypoint_matching(image1, image2, 5);

%% Plot 10 random matching keypoints
plot_matching_points(image1,image2,keypoints1,keypoints2, 10);

%% Get p and p_prime
n = 15;
[p, p_prime] = get_p_and_p_prime(keypoints1, keypoints2, n);
plot_matching_points(image1,image2,p(:,1:2)',p_prime(:,1:2)', 10);
%% Eight-point algorithm
F_8 = eight_point(p, p_prime, n);
draw_epipolar_lines(p, p_prime, F_8, image1, image2);

%% Normlized Eight-point algorithm
F_8_normalized = normalized_eight_point(p, p_prime, n);
draw_epipolar_lines(p, p_prime, F_8_normalized, image1, image2);

%% RANSAC Normalized Eight-point algorithm
%n = 50
%[p, p_prime] = get_p_and_p_prime(keypoints1, keypoints2, n);

ransac_iter_nr = 1000;
inliers_threshold = 1e-3;

F_8_normalized_RANSAC = RANSAC_normalized_eight_point(p, p_prime, ransac_iter_nr, inliers_threshold);
draw_epipolar_lines(p, p_prime, F_8_normalized_RANSAC, image1, image2);

