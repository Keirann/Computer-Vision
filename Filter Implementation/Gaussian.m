I = imread('flower.png');
A = double(I);
sd = 1.8;
gaussian(A,sd);
function [output] = gaussian(A, sd)

    kernelSize = 4;
    [x,y]=meshgrid(-kernelSize:kernelSize,-kernelSize:kernelSize);

    M = size(x,1)-1;
    N = size(y,1)-1;
    Exp = -(x.^2+y.^2)/(2*sd*sd);
    Kernel= exp(Exp)/(2*pi*sd*sd);
    
    output=zeros(size(A));
    size(A)
    A = padarray(A,[kernelSize kernelSize]);
    size(A)

%Convolution
for i = 1:size(A,1)-M
    for j =1:size(A,2)-N
        Temp = A(i:i+M,j:j+M).*Kernel;
        output(i,j)=sum(Temp(:));
    end
end
%Image without Noise after Gaussian blur
output = uint8(output);
figure,imshow(output);


end