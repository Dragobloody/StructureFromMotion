function PointViewMatrix = chaining(images, path)
    % images = dir(strcat(path, '/' , '*.png')) ;
    % images is a struct 
    img1_name = images(1).name ;
    img1 = imread(strcat(path, '/', img1_name)) ;
    bg_threshold = 100 ;
    f_row = 1 ;
    %f = waitbar(length(images), 'Progress...')
    
    for k = 2:length(images) %images(2:end)
        img2_name = images(k).name ;
        img2 = imread(strcat(path, '/', img2_name)) ;
        [keypoints1, keypoints2, scores] = keypoint_matching(img1, img2, bg_threshold) ; % what value to threshold?
        
        %[scores_sorted, scores_order] = sort(scores) ;
        %keypoints1 = keypoints1(:,scores_order) ;
        %keypoints2 = keypoints2(:,scores_order) ;
        
        %N = 20 ;
        %keypoints1 = keypoints1(:,1:N) ;
        %keypoints2 = keypoints2(:,1:N) ;
        
        if f_row == 1
            PVM(f_row:f_row+1,:) = keypoints1 ;
            PVM(f_row+2:f_row+3,:) = keypoints2 ;
            f_row = f_row + 2; % first time we'll jump 4 rows for this counter
            
        else
            [C, i_PVM, i_kp] = intersect(PVM(f_row-2:f_row-1, :)', keypoints1', 'rows') ;
            
            % Introduce points that were already in columns
            PVM(f_row:f_row+1, i_PVM) = keypoints2(:, i_kp) ;
            
            % add points to new points to new columns from previous and frames:
            not_matched_idx = setdiff(1:size(keypoints1, 2), i_kp) ;
         
            % Initialize columns for unmatched point pairs
            new_columns = zeros(f_row+1, length(not_matched_idx)) ;

            % fill values for new points
            new_columns(f_row-2:f_row-1,:) = keypoints1(:, not_matched_idx) ;
            new_columns(f_row:f_row+1,:) = keypoints2(:, not_matched_idx) ;
            
            % concatenate with the point view matrix
            PVM = [PVM new_columns] ;

        end
        size(PVM) ;
        f_row = f_row + 2 ; % each iteration jump 2 rows
    end
    PointViewMatrix = PVM;
end