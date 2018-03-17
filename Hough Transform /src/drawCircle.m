function drawCircle(img, centers, radii)
    % For a given mapped array of centres vs radius in hough space draw
    % circle in xy space
    
    % Input Parameters:
    % img: Image on top of which to draw lines
    % centers: each row of centers represents the center point of a
    % circle(Point with highest vote)
    % radii: each row of radii represents the corresponding radius for the circle center
    
    figure();
    imshow(img);
    hold on;
    for i = 1 : size(centers, 1)
        r = radii(i);
        %Coordinates of center in ab(hough) space
        centerX= centers(i, 2);
        centerY = centers(i, 1);
        theta = linspace(0, 2 * pi, 360);
        %Coordinates of Circle (Brightest point corresponds to a circle in original space)
        if i>3
            xArray = centerX + r * cos(theta);
            yArray = centerY + r * sin(theta);
            plot(xArray,yArray,'g', 'LineWidth', 2);
        end
    end
end
