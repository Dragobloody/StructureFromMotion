function [p, p_prime] = get_p_and_p_prime(keypoints1, keypoints2, n)
    % Select random n points
    perm = randperm(size(keypoints1,2));
    sel = perm(1:n);
    
    p = keypoints1(:,sel);
    p = [p ; ones(1,n)]';
    
    p_prime = keypoints2(:,sel);
    p_prime = [p_prime ; ones(1,n)]';
end

