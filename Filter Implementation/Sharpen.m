I = imread('flower.png');

%%Example code to demonstrate Sharpening the Image
%Edge kernel
edgefilter = [[-1,-1,-1];[-1,8,-1];[-1,-1,-1]];
%Sharp kernel
sharpfilter = [[-1,-1,-1];[-1,9,-1];[-1,-1,-1]];
figure,imshow(I);

%Applying Sharpen twice with edge filter followedby sharp filter 
% has the effect of identifying the edge and superimposing this edge
% against the image itself to make it look sharp
output1 = sharpen(I,edgefilter);
C = sharpen(output1,sharpfilter);
figure,imshow(C);


%% Sharpen takes an image A and filter as argument
%returns an image applying a filter as a convolution 
function [output] = sharpen(A,filter)
     A = im2double(A);
     [m , n, d] = size(A);
     kSize = size(filter,1);
     
     extendedA=zeros(m + (kSize -1),n + (kSize -1), d);
     [m1,n1,d1] = size(extendedA);
     beginRow = ceil(kSize / 2);
     endRow = m1 - floor(kSize / 2);
     beginCol = ceil(kSize / 2);
     endCol = n1 - floor(kSize / 2);
    
     
     extendedA(beginRow:endRow,beginCol:endCol, 1:3) = A;
     %imshow(extendedA);

       for i=beginRow:endRow:kSize
           for j=beginCol:endCol:kSize
                   kernelBeginR = i - floor(kSize / 2);
                   kernelEndR = i + floor(kSize / 2);
                   kernelBeginC = j -floor(kSize / 2);
                   kernelEndC = j + floor(kSize / 2);
                   filterMeanR = extendedA(kernelBeginR:kernelEndR, kernelBeginC:kernelEndC,1);
                   filterMeanG = extendedA(kernelBeginR:kernelEndR, kernelBeginC:kernelEndC,2);
                   filterMeanB = extendedA(kernelBeginR:kernelEndR, kernelBeginC:kernelEndC,3);
                 
                   
                   
                   %A(i - floor(kSize /2),j - floor(kSize / 2),1)
                   extendedA(kernelBeginR:kernelEndR,kernelBeginC:kernelEndC,1) = filterMeanR * filter;
                   extendedA(kernelBeginR:kernelEndR,kernelBeginC:kernelEndC,2) = filterMeanG * filter;
                   extendedA(kernelBeginR:kernelEndR,kernelBeginC:kernelEndC,3) = filterMeanB * filter;
           end
       end 
       output = extendedA(beginRow:endRow,beginCol:endCol,1:3);  
 end