I = imread('flower.png');
%size(I,1)
%Example code to demonstrate median filter for 3x3, 5x5 and 15x15 kernel
figure,imshow(I);
medFilter(I,3);
medFilter(I,5);
medFilter(I,15);

%%Median Filter
% This code takes two input 
% A -> The input image in RGB format
% kSize -> the Size for Median Filter 
% The program displays the image after the filter has been applied. 

function medFilter(A,kSize)
     A = im2double(A);
     [m , n, d] = size(A);
     
     extendedA=zeros(m + (kSize -1),n + (kSize -1), d);
     [m1,n1,d1] = size(extendedA);
     beginRow = ceil(kSize / 2);
     endRow = m1 - floor(kSize / 2);
     beginCol = ceil(kSize / 2);
     endCol = n1 - floor(kSize / 2);
    
     
     extendedA(beginRow:endRow,beginCol:endCol, 1:3) = A;
     %imshow(extendedA);

       for i=beginRow:endRow
           for j=beginCol:endCol
                   kernelBeginR = i - floor(kSize / 2);
                   kernelEndR = i + floor(kSize / 2);
                   kernelBeginC = j -floor(kSize / 2);
                   kernelEndC = j + floor(kSize / 2);
                   filterMedR = extendedA(kernelBeginR:kernelEndR, kernelBeginC:kernelEndC,1);
                   filterMedG = extendedA(kernelBeginR:kernelEndR, kernelBeginC:kernelEndC,2);
                   filterMedB = extendedA(kernelBeginR:kernelEndR, kernelBeginC:kernelEndC,3);
                 

                   %size(A(i - floor(kSize /2),j - floor(kSize / 2)))
                   A(i - floor(kSize /2),j - floor(kSize / 2),:) = [median(filterMedR(:)),median(filterMedG(:)),median(filterMedB(:))];
           end
       end 
      figure,imshow(A);
 end

