function H = houghAccumulatorCircle(image, radius)
    % Compute Hough accumulator array for finding circles.
   
    %For every edge pixel (x,y) :
      %For each possible radius value r:
        % For each possible gradient direction ?:    
    H = zeros(size(image));
    for x = 1 : size(image, 2)
        for y = 1 : size(image, 1)
            if (image(y,x))
                for theta = linspace(0, 2 * pi, 360)
                    %a, b defines the points on circle formed in Hough space
                    %with x and y as centers(point in original space)
                    a = round(x + radius * cos(theta));                
                    b = round(y + radius * sin(theta));
                    if (a > 0 && a <= size(H, 2) && b > 0 && b <= size(H,1))
                        H(b,a) = H(b,a) + 1;
                    end
                end
            end
        end
    end
end
