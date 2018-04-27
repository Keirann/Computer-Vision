%% Performs Raster scan to detect white object against black background  
%  Main operation => X(k)= (X(k-1) or B ) and I 
%  until X(K)== X(k - 1)
%  where B is a 3x3 square kernel with all 1's used to identify
%  I is the initial image . 
%  
%  connectivity.
%  input : BW Image
%  output : Labelled Image - An image whose pixels are marked as 1,2,3, and so on for each
%           identified objects
%           RGBImage - A nicer representation of each detected object with
%           random colors.

function [LabelledImage,RGBImage] = rasterScanObjectDetect(image)
%I = imread(image);
%I = im2bw(I);

%Flipping black object of interest to white:and algorithm is applied 
I = imcomplement(image);

B=strel('square',3);
A=I;

%Find first non zero element
p=find(A==1);

p=p(1);

LabelledImage=zeros([size(A,1) size(A,2)]);
N=0;

while(~isempty(p))
    N=N+1;
    p=p(1);
    X=false([size(A,1) size(A,2)]);
    X(p)=1;

    Y=A&imdilate(X,B);
    while(~isequal(X,Y))
        X=Y;
        Y=A&imdilate(X,B);
    end

    Pos=find(Y==1);
    A(Pos)=0;
    
    %Label each component
    LabelledImage(Pos)=N;
    p=find(A==1);
end

%Coloring each component
RGBImage=zeros([size(LabelledImage,1) size(LabelledImage,2) 3]);
R=zeros([size(LabelledImage,1) size(LabelledImage,2)]);
G=zeros([size(LabelledImage,1) size(LabelledImage,2)]);
B=zeros([size(LabelledImage,1) size(LabelledImage,2)]);
U=64;
V=255;
W=128;
for i=1:N
    Pos=find(LabelledImage==i);
    R(Pos)=mod(i,2)*V;
    G(Pos)=mod(i,5)*U;
    B(Pos)=mod(i,3)*W;
end

RGBImage(:,:,1)=R;
RGBImage(:,:,2)=G;
RGBImage(:,:,3)=B;
RGBImage=uint8(RGBImage);
end