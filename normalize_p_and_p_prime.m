function [p, T, p_prime, T_prime] = normalize_p_and_p_prime(p, p_prime)
    % Normalize p
    mx = mean(p(:,1));
    my = mean(p(:,2));
    d = mean(sqrt((p(:,1) - mx).^2 + (p(:,2) - my).^2));
    T = [sqrt(2)/d, 0, -mx*sqrt(2)/d;
         0, sqrt(2)/d, -my*sqrt(2)/d;
         0, 0 , 1];
    p = (T*p')';    
    
    % Normalize p_prime
    mx = mean(p_prime(:,1));
    my = mean(p_prime(:,2));
    d = mean(sqrt((p_prime(:,1) - mx).^2 + (p_prime(:,2) - my).^2));
    T_prime = [sqrt(2)/d, 0, -mx*sqrt(2)/d;
         0, sqrt(2)/d, -my*sqrt(2)/d;
         0, 0 , 1];
    p_prime = (T_prime*p_prime')';    
    
end

