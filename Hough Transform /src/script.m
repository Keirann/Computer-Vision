% Load image
  img = imread('line1.jpg'); 
  [parametersLines] = houghLines(img);
  
  disp("parameters for Lines(r,theta) = ");
  parametersLines;

 % Find Circles (Use hough transform for circles)
  img = imread('ellipse1.jpg');
  parametersCircle = houghCircle(img);
  parametersCircle

% img = imread('ellipse1.jpg');
% parametersEllipse = houghEllipse(img, 10, 10);
% parametersEllipse
