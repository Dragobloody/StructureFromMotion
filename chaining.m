function PointViewMatrix = chaining(path)
    images = dir(strcat(path, '/' , '*.png'));
    
    img1_name = images(1).name ;
    img1 = imread(strcat(path, '/', img1_name)) ;
    bg_threshold = 0.1 ;
    for image = images(2:end)
        img2_name = image.name ;
        img2 = imread(strcat(path, '/', img2_name)) ;
        [keypoints1, keypoints2, scores] = keypoint_matching(img1, img2, bg_threshold) ; % what value to threshold?
        
        keypoints1(:,1:5)
        keypoints2(:,1:5)
        
        %for j = 1:length(keypoints1')
            
        
        
        
    end
    PointViewMatrix = 0;
end