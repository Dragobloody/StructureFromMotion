function [L,L_prime] = draw_epipolar_lines(p, p_prime, F, image1, image2)
   
    L_prime = epipolarLine(F, p(:,1:2));
    L = epipolarLine(F', p_prime(:,1:2));    
    points_prime = lineToBorderPoints(L_prime,size(image2));
    points = lineToBorderPoints(L,size(image1));    
    
    imshow(image1)
    hold on
    line(points(:,[1,3])',points(:,[2,4])');
    hold on
    plot(p(:,1),p(:,2),'go')
    
    figure
    
    imshow(image2)
    hold on
    line(points_prime(:,[1,3])',points_prime(:,[2,4])');
    hold on
    plot(p_prime(:,1),p_prime(:,2),'ro')   
    
    
end

