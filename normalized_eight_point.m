function F = normalized_eight_point(p, p_prime, n)    
    % Normalize p and p_prime
    [p, T, p_prime, T_prime] = normalize_p_and_p_prime(p, p_prime);
    
    % Apply eight-point algorithm on normalized p and p_prime and
    % denormalize F
    F = eight_point(p, p_prime, n);
    F = T_prime'*F*T;
end

