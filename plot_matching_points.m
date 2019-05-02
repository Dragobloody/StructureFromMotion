function plot_matching_points(image1,image2,keypoints1,keypoints2, point_nr)
    % Concatenate the 2 images in order to connect the keypoints
    pair = [image1, image2];
    size_img1 = size(image1);
    
    % The X axis coordinates of image2 are shifted to the right in the
    % concatenated image so we need to add the image1 width value to them
    keypoints2_shifted_coordinates = keypoints2;
    keypoints2_shifted_coordinates(1,:) = keypoints2_shifted_coordinates(1,:) + size_img1(2);
    imshow(pair);
    
    % Choose X random pairs of keypoints
    perm = randperm(size(keypoints1,2)) ;
    sel = perm(1:point_nr) ;
    
    % Plot the the keypoints regions and connect them with lines
    hold on;
    scatter(keypoints1(1,sel),keypoints1(2,sel),60,'r','filled');
    scatter(keypoints2_shifted_coordinates(1,sel),keypoints2_shifted_coordinates(2,sel),60,'r','filled');  
    for i = 1:length(sel)
        l = line([keypoints1(1,sel(i)),keypoints2_shifted_coordinates(1,sel(i))],[keypoints1(2,sel(i)),keypoints2_shifted_coordinates(2,sel(i))])
        l.LineWidth = 3;
        l.Color = rand(1,3);
    end 
  
end

