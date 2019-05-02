function [p_inliers,p_prime_inliers] = get_inliers(p, p_prime, F_prime, threshold)
    % Compute the numerator
    num = (p_prime*F_prime).*p;
    num = sum(num,2).^2;
    
    % Compute the denominator
    aux1 = F_prime*p';
    aux2 = F_prime'*p_prime';  
    den = (aux1(1,:)).^2 + (aux1(2,:)).^2 + (aux2(1,:)).^2 + (aux2(2,:)).^2;
    den = den';
    
    % Compute Sampson distance
    d = num./den; 
    
    % Get the inliers
    inliers = (d <= threshold);    
    p_inliers = p(inliers,:);
    p_prime_inliers = p_prime(inliers,:);
    
end

