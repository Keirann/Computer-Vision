function drawLines(img, voteArray, radius, theta)
    % Draw lines found on top of original image 
    
    for i = 1 : size(voteArray,1)
       radius_i = radius(voteArray(i,1));
       theta_i = theta(voteArray(i,2)) * pi / 180;
       if theta_i == 0
           x1 = radius_i;
           x2 = radius_i;
           if radius_i > 0
               y1 = 1;
               y2 = size(img,1);
               plot([x1,x2],[y1,y2],'g','LineWidth',3); 
           end           
       else
           x1 = 1;
           x2 = size(img, 2);
           y1 = (radius_i - x1 * cos(theta_i)) / sin(theta_i);
           y2 = (radius_i - x2 * cos(theta_i)) / sin(theta_i);
           plot([x1,x2],[y1,y2],'g','LineWidth',3); 
       end
             
    end
end
