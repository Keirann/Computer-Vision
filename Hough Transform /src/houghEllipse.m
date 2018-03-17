function [parameters] = houghEllipse(img, min2a, minVotes)

    img = img(:,:,1);
    %figure();imshow(img);title('Original Image');

    %Detect edge and Plot Image
    edges = edge(img, 'Sobel');
    %figure();imshow(edges);title('Edge Image');
    
    [width, height] = size(edges);
     parameters = [];
     H = zeros(size(edges));
     [X,Y] = find(edges==1);
     pixelArray = [X Y];
     accumulator = zeros(max(width,height)/2);
     
     for pixel1 = 1:(length(X)-1)
         for pixel2 = length(X): -1 : pixel1 + 1
             x1 = pixelArray(pixel1,1);
             y1 = pixelArray(pixel1,2);
             x2 = pixelArray(pixel2,1);
             y2 = pixelArray(pixel2,2);
             
             distance12 = norm([x1 y1] - [x2 y2]);
             accumulator = accumulator * 0;
             if (x1 - x2) && (distance12 > min2a)
                 x0 = (x1 + x2) / 2;
                 y0 = (y1 + y2) / 2;
                 a = distance12 / 2 ;% Major Axis / 2
                 gradient= atan((y2 - y1)/(x2 - x1));
                 distance01 = norm ( [x1 y1] - [x0 y0]);
                 distance02 = norm( [x2 y2] - [x0 y0]);
                 for pixel3 = 1:length(X)
                     if(pixel3 == pixel1 && pixel3 == pixel2)
                         continue;
                     end
                     x3 = pixelArray(pixel3,1);
                     y3 = pixelArray(pixel3,2);
                     distance03 = norm([x3 y3] - [x0 y0]);
                     % Is this pixel of the same ellipse?
                     if distance03 >= a
                         continue;
                     end
                     
                     focus = norm([x3 y3] - [x2 y2]);
                     %Half - length of the minor axis
                     cos2Theta = ((a^2 + distance03^2 - focus^2) / (2 *a * distance03))^2;
                     sin2Theta = 1 - cos2Theta;
                     b = round(sqrt((a^2 * distance03^2 * sin2Theta) /(a^2 - distance03^2 * cos2Theta)));
                     %Eliminating out of bound ellipse
                     if b > 0 && b <= length(accumulator)
                         accumulator(b) = accumulator(b) + 1;
                     end
                 end
                 
                 [sv si] = max(accumulator);
                 if sv > minVotes
                     % Ellipse detected!
                     % The index si gives us the best b value.
                     parameters = [x0 y0 a si gradient];
                     return;
                 end
             end
          end
     end
     disp('No ellipse found');
    
end


