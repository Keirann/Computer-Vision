function [gradientMag,gradientDir] = sobel(imagefile)
    z = imread(imagefile);
    X = double(z);
    h = size(X, 1);
    w = size(X, 2); 
    color= size(X, 3);
    figure; subplot(2,4,1) ;
    imshow(uint8(X));title('Original');
    gradientMag = zeros(size(X));
    gradientDir = zeros(size(X));
    Gx = [-1 0 +1; -2 0 +2; -1 0 +1];
    Gy = [+1 +2 +1; 0 0 0;-1 -2 -1];
    %Kernel taken from http://homepages.inf.ed.ac.uk/rbf/HIPR2/sobel.htm

    for i = 2 : h-1
        for j = 2 : w-1  
               for k = 1 : color
                   temp= X(i - 1 : i + 1, j - 1 : j + 1, k);
                   a=sum(Gx .* temp);
                   x = sum(sum(a));
                   b= (sum(Gy.* temp));
                   y = sum(sum(b));
                   pixel =sqrt(x^2+ y^2);
                   gradientMag(i, j, k) = (pixel);
                   gradientDir(i,j,k) = atand(y/x);
                   
               end 
        end   
    end
    gradientMag = uint8(gradientMag);
    gradientDir = uint8(gradientDir);
    subplot(3,3,2) ;imshow(gradientMag);title('Gradient Magnitude');
    subplot(3,3,3) ;imshow(gradientDir);title('Gradient Direction');
    
    %Threshold the value based on observing histogram
    %Grayscale will be much better to visualize 
    
    subplot(3,3,5) ;histogram(gradientMag);title('Histogram for Gradient Magnitude');
    subplot(3,3,6) ;histogram(gradientDir);title('Histogram for Gradient Direction');
    gradientMag = rgb2gray(gradientMag);
    gradientDir = rgb2gray(gradientDir);
    gradientMag(gradientMag>= 230) = 255;
    gradientMag(gradientMag < 230) = 0;
    gradientDir(gradientDir >= 10) = 255;
    gradientDir(gradientDir < 10) =0;
    subplot(3,3,8) ;imshow(gradientMag);title('Threshold Gradient Magnitude');
    subplot(3,3,9) ;imshow(gradientDir);title('Threshold Gradient Direction');
    imwrite(gradientMag,'blackwhite.png');
end



