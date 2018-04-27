
%% Performs adaptive thresholding 
%input 'grayscale image'
%output 'binary image applying threshold'
function [result] = FindThreshold(image)
    %I = imread(image);
    %imshow(I);
    I = uint32(image);
    [row,col] = size(I);
    
    % Divide image into 8 parts : See reference [1]
    S = row / 8 ;
    halfSize= S / 2;
    threshold = 20;

    integral_image = zeros(size(I));
    % Find integral image
    for col = 1 : size(I,2)%column
             for row = 1 : size(I,1)%row               
                integral_image(col,row) = sum(sum(I(1:row,1:col)));
             end
    end   

    % Find resulting image
    result = zeros(size(I));
    for col=1:size(I,2)%column
        for row= 1:size(I,1) %row
            
            y0 = max(row-halfSize,1);
            y1 = min(row+halfSize,size(I,1));
            x0 = max(col-halfSize,1);
            x1 = min(col+halfSize,size(I,2));

            count = (y1 - y0) * (x1 - x0);

            Sum = integral_image(y1,x1) - integral_image(y0,x1)-integral_image(y1,x0)+integral_image(y0,x0);
            if I(row,col) * count < (Sum * (100 - threshold) / 100)
                result(row,col) = 0;
            else
                result(row,col) = 255;
            end
        end
    end
    %figure;
    %imshow(result);
    %imwrite(result,'reg3_thresh.jpg');
end