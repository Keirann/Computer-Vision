function [H, theta, radius] = houghAccumulator(Image)
    % Returns the accumulator array for Given Image
    
    % Input Parameter:
    % Image : Image containing Edge pixel
    
    % Outputparameter:
    % H : Map with row value = radius and column value = theta
    % theta: the theta array used for rotating around each point
    % radius: radius array used for voting 0,0 to RightMax,rightMax

    % Initializing Polar Coordinates
    diagonalRightMax = sqrt((size(Image,1) - 1) ^ 2 + (size(Image,2) - 1) ^ 2);
    numRadius = 2 * ceil(diagonalRightMax) + 1;
    
    theta = linspace(-90, 89, 180);
    NTheta = length(theta);
    
    %Initialize hough accumulator
    H = zeros(numRadius, NTheta);
    radius = -diagonalRightMax : diagonalRightMax;
    
    for i = 1 : size(Image,1)
        for j = 1 : size(Image,2)
            if (Image(i, j))
                for k = 1 : NTheta
                    temp = j * cos(theta(k) * pi / 180) + i * sin(theta(k) * pi / 180);
                    rowIndex = round((temp + diagonalRightMax)) + 1;
                    H(rowIndex, k) = H(rowIndex, k) + 1;                   
                end
            end            
        end
    end   
    
end
