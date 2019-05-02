function [keypoints1, keypoints2, scores] = keypoint_matching(image1, image2, bg_threshold)
    % Refference: http://www.vlfeat.org/overview/sift.html    
    
    % The vl_sift command requires a single precision gray scale image so we
    % convert the input images to single precision    
    single_img1 = single(image1);
    single_img2 = single(image2);

    % Compute the keypoints(frames) and descriptors
    [f1, d1] = vl_sift(single_img1) ;
    [f2, d2] = vl_sift(single_img2) ;
    
    % Get the matching keypoint pairs
    [matches, scores] = vl_ubcmatch(d1, d2, bg_threshold) ;
    
    % Aproximate the center of the circle to the nearest integer to get the
    % center pixel from frames
    f1(1:2,:) = round(f1(1:2,:));
    f2(1:2,:) = round(f2(1:2,:));
    
    % Return only the matching keypoints coordonates X and Y
    keypoints1 = f1(1:2,matches(1,:));
    keypoints2 = f2(1:2,matches(2,:));
    
end

    