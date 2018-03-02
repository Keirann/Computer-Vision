function [gradientMag,gradientDir]=robert(Y)
    z = imread(Y);
    I = double(z);
    h = size(I, 1);
    w = size(I, 2); 
    color= size(I, 3);
    figure; subplot(3,3,1);imshow(uint8(I));title('Original');

    %figure;
    gradientMag = zeros(size(I));
    gradientDir = zeros(size(I));
    Gx = [0 0 0;0 1 0;0 0 -1];
    Gy = [0 0 1;0 -1 0;0 0 0];
    %Kernel idea from  http://homepages.inf.ed.ac.uk/rbf/HIPR2/roberts.htm

    for i = 2 : h-1
        for j = 2 : w-1  
               for k = 1 : color
                   temp= I(i - 1 : i +1 , j-1 : j + 1, k);
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
    subplot(3,3,2) ;imshow(gradientMag);
    subplot(3,3,3) ;imshow(gradientDir);
    
    %Threshold the value based on observing histogram
    %Grayscale will be much better to visualize 
    
    subplot(3,3,5) ;histogram(gradientMag);title('Histogram for Gradient Magnitude');
    subplot(3,3,6) ;histogram(gradientDir);title('Histogram for Gradient Direction');
    gradientMag = rgb2gray(gradientMag);
    gradientDir = rgb2gray(gradientDir);
    gradientMag(gradientMag>= 30) = 255;
    gradientMag(gradientMag < 30) = 0;
    gradientDir(gradientDir >= 10) = 255;
    gradientDir(gradientDir < 10) =0;
    subplot(3,3,8) ;imshow(gradientMag);title('Threshold Gradient Magnitude');
    subplot(3,3,9) ;imshow(gradientDir);title('Threshold Gradient Direction');

end