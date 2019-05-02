function F = RANSAC_normalized_eight_point(p, p_prime, ransac_iter_nr, inliers_threshold)    
    % Normalize p and p_prime
    [p, T, p_prime, T_prime] = normalize_p_and_p_prime(p, p_prime);
    
    max_inliers = 0;
    for i = 1:ransac_iter_nr    
        % Pick 8 random point pairs from p and p_prime
        perm = randperm(size(p,1));
        sel = perm(1:8);
        p_8 = p(sel,:);
        p_prime_8 = p_prime(sel,:);

        % Calculate fundamental matrix F_prime_8 for the 8 randomly selected
        % points
        F_prime_8 = eight_point(p_8, p_prime_8, 8);

        % Get the inliers
        [p_inliers,p_prime_inliers] = get_inliers(p, p_prime, F_prime_8, inliers_threshold);
        nr_inliers = size(p_inliers);
        nr_inliers = nr_inliers(1);
        % Save the largets set of inliers
        if max_inliers < nr_inliers
            p_final = p_inliers;
            p_prime_final = p_prime_inliers;
            max_inliers = nr_inliers;
        end
    end
    % Compute F on the largest set of inliers
    F = eight_point(p_final, p_prime_final, max_inliers); 
    F = T_prime'*F*T;
    
end

