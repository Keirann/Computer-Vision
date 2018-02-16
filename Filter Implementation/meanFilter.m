I = imread('flower.png');
figure,imshow(I);
%Example code to demonstrate mean filter for 5x5 kernel
meanFilt(I,5);

%%Mean Filter
% This code takes two input 
% A -> The input image in RGB format
% kSize -> the Size for Median Filter 
% The program displays the image after the mean filter has been applied. 

function meanFilt(A,kSize)
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
                   filterMeanR = extendedA(kernelBeginR:kernelEndR, kernelBeginC:kernelEndC,1);
                   filterMeanG = extendedA(kernelBeginR:kernelEndR, kernelBeginC:kernelEndC,2);
                   filterMeanB = extendedA(kernelBeginR:kernelEndR, kernelBeginC:kernelEndC,3);
                 

                   %size(A(i - floor(kSize /2),j - floor(kSize / 2)))
                   A(i - floor(kSize /2),j - floor(kSize / 2),:) = [mean(filterMeanR(:)),mean(filterMeanG(:)),mean(filterMeanB(:))];
           end
       end 
      figure,imshow(A);
 end