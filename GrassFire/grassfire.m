
%% Performs GrassFire transform to find the skeletal image
%  Parameters: image: input image (Can be RGB or grayscale)
%              method: 'external' - performs external grassfire to find
%                       inter object distance and skeletal features
%                       'internal' - performs internal grassfire transform
%                       to find the median skeletal image.
%              thresholdfactor: 0 if object of interest is black,1 if white
%              skeletal_visibility: determines the visibility of the most
%              prominent skeleton (Preferred 1). Can take integer values.

%  Example : 2 object: grassfire('circle.jpg','external',0,1);
%                      grassfire('circle.jpg','internal',0,1);
%  Example : 1 object: grassfire('grassfirePlus.jpg','external',0,5);
%                      grassfire('grassfirePlus.jpg','internal',0,5);
%                       
%  Example : Multi object:
%                       grassfire('pedestrian.jpg','internal',0,5);
%                       grassfire('pedestrian.jpg','external',0,5);
%
%
function [gray_image] = grassfire(image,method,thresholdfactor,skeletal_visibility)
    image = imread(image);
    
    % Handling color image
    if size(image,3)==3
        I = rgb2gray(image);
        I = im2bw(I)*255;
    else 
        I = im2bw(image)*255;
    end
    
    
    figure;
    subplot(1,2,1);imshow(uint8(image));%imshow(uint8(image));
     
    gray_image = ones(size(I)+2)*255;
    gray_image(2:end-1,2:end-1) = I;
    threshold = thresholdfactor * 255;
    if strcmp(method,'external')
       gray_image = external(I,threshold,gray_image,skeletal_visibility)
    else
       gray_image = internal(I,threshold,gray_image,skeletal_visibility) 
    end

    
 
    subplot(1,2,2);imshow(uint8(gray_image( 2: end - 1,2: end - 1)));
    % Code to show the skeleton
    % B = gray_image >= 0.75 * max(max(gray_image(2:end-1,2:end-1)));
    % subplot(1,3,3);imshow(B);
end

function [gray_image] =  external(I, threshold,gray_image,skeletal_visibility)
 %Pass 1 : Forward raster scan
     for i=1:size(I, 1) 
         for j=1:size(I, 2)
             indexX = i+1;
             indexY = j+1;
             if I(i,j) ~= threshold  
                 gray_image(indexX,indexY) = min([gray_image(indexX,indexY-1), gray_image(indexX-1,indexY), gray_image(indexX-1,indexY-1), gray_image(indexX-1,indexY+1)]) +1*skeletal_visibility;
             
             else
                 gray_image(indexX,indexY) = 0;
             end
         end
     end     
      %Pass 2 : Reverse raster scan
     for i=size(I, 1) :-1:1
          for j=size(I, 2) :-1:1
              indexX = i+1;
              indexY = j+1;
              if  I(i,j) ~= threshold
                  gray_image(indexX, indexY) = min(gray_image(indexX, indexY), min([gray_image(indexX, indexY+1), gray_image(indexX+1, indexY), gray_image(indexX+1, indexY-1), gray_image(indexX+1, indexY+1)]) + 1*skeletal_visibility);
              else
                  gray_image(indexX,indexY) = 0;
              end
              
          end
     end
end


function [gray_image] =  internal(I, threshold,gray_image,skeletal_visibility)
 %Pass 1 : Forward raster scan
     for i=1:size(I, 1) 
         for j=1:size(I, 2)
             indexX = i+1;
             indexY = j+1;
             if I(i,j) == threshold  
                 gray_image(indexX,indexY) = min([gray_image(indexX,indexY-1), gray_image(indexX-1,indexY), gray_image(indexX-1,indexY-1), gray_image(indexX-1,indexY+1)]) +1*skeletal_visibility;
             
             else
                 gray_image(indexX,indexY) = 0;
             end
         end
     end     
      %Pass 2 : Reverse raster scan
     for i=size(I, 1) :-1:1
          for j=size(I, 2) :-1:1
              indexX = i+1;
              indexY = j+1;
              if  I(i,j) == threshold
                  gray_image(indexX, indexY) = min(gray_image(indexX, indexY), min([gray_image(indexX, indexY+1), gray_image(indexX+1, indexY), gray_image(indexX+1, indexY-1), gray_image(indexX+1, indexY+1)]) + 1*skeletal_visibility);
              else
                  gray_image(indexX,indexY) = 0;
              end
              
          end
     end
end