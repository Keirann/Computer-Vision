%%Prints Statistics Details like Minimum Bounding 
% 1.Rectangle 
% 2.Centroid 
% 3.Area of identified shapes(without holes)
% 4.Number of Holes
% 5.Area of Holes
% 6. Perimeter of identified Shapes
% 7. Elongation
% Input - Labelled Image.
% Output - Prints Statistics.

function [] = getStatistics(image,filename)
    % image: provide the labelled image after raster scan
    Im = image;
    
    diary(filename);diary on

    [minX,minY,maxX,maxY] = computeMBR(Im);
    computeCentroid(Im);
    Area=computeArea(Im,1);
    computeHolesAndHoleArea(Im);
    Perimeter = computePerimeter(Im);
    computeElongation(Im,Area,Perimeter);
    diary off
end

function [elongation] = computeElongation(Im,Area,Perimeter)
    N = max(max(Im));
    elongation = [];
    for i = 1:N
        elongation(i) = Perimeter(i)^2 /  Area(i);
    end
    item = [1:N]';
    elongation = elongation';
    disp('Elongation Statistics');  
    table(item,elongation)
end



function [a] = computeCentroid(Im)
    N = max(max(Im));
    centroid = [];
    
    for i = 1:N
        B=zeros([size(Im,1) size(Im,2)]);  
        ele=find(Im==i);
        B(ele)=i;
        %imshow(B);
        [y, x] = ndgrid(1:size(B, 1), 1:size(B, 2));
        centroid{i} =  mat2str((mean([x(logical(B)), y(logical(B))])));

    end
    item = [1:N]';
    centroid = [centroid'];
    disp('Centroid Statistics');  
    table(item,centroid)
end

function [area]=computeArea(Im,flag)
    N = max(max(Im));
    area = [];
    for i = 1:N
        B=zeros([size(Im,1) size(Im,2)]);  
        ele=find(Im==i);
        B(ele)=i;
        %imshow(B);
        area(i) = sum (B(:));
    end
    
    item = [1:N]';
    area = area';
    if(flag == 1)% Flag - to control displaying holes vs objects.
        disp('Area of Objects(In pixels)');  
        table(item,area)
    end
end


function [perimeter]=computePerimeter(Im)
    N = max(max(Im));
    perimeter = [];
        for i = 1:N
            B=zeros([size(Im,1) size(Im,2)]);  
            ele=find(Im==i);
            B(ele)=1;
            %imshow(B);
            perimeter(i) = sum(sum(bwperim(B)));
        end
    item = [1:N]';
    perimeter = perimeter';    
    disp('Perimeter of Objects(In pixels)');  
    table(item,perimeter)
end


function [area]=computeHolesAndHoleArea(Im)
N = max(max(Im));
area = [];
holes = 0;
for i = 1:N
    B=zeros([size(Im,1) size(Im,2)]);  
    ele=find(Im==i);
    B(ele)=1;
    %imshow(B);
    C = grow(B);
    %imshow(C);
    C = im2bw(C);
    p=find(C==0);
    if ~isempty(p)
        [LImage,colouredImage] = rasterScanObjectDetect(C);
        area = [area;computeArea(LImage,0)];
        N = max(max(LImage));
        holes = holes + N;       
    end
    p = [];
end

disp('Number of holes =');disp(holes);

item = [1:holes]';

disp('Area of Holes(In pixels)');  
table(item,area)
end

%%Grows the background pixels as same as image pixels.
% The resulting image has only holes.
function [C] = grow(B)
    C = B;
    % Forward pass to fill the background with intensity 1 pixel
    for i = 1:size(C,1)
        for j = 1:size(C,2)
            if C(i,j) ~= 1
                C(i,j) = 1;
            else
                break;
            end
        end
    end
    
    % Reverse pass to fill the background with intensity 1 pixel
    for i = size(C,1):-1:1
        for j = size(C,2):-1:1
            if C(i,j)~=1
                C(i,j) = 1;
            else
                break;
            end
        end
    end
    
end

function [minx,miny,maxx,maxy]=computeMBR(Im)
%Extracting the components

    minx = [];
    miny = [];
    maxx = [];
    maxy = [];
    N = max(max(Im));
    for i = 1:N
        B=zeros([size(Im,1) size(Im,2)]);  
        ele=find(Im==i);
        B(ele)=i;
        %imshow(B);

        minx(i) = size(B,1);
        miny(i) = size(B,2);

        maxx(i) = 1;
        maxy(i) = 1;

        for row = 1 : size(B,1)
                 for col = 1 : size(B,2)

                    if (B(row,col) == i) && (row < minx(i))
                        minx(i) = row;
                    end
                    if (B(row,col) == i) && (row > maxx(i))
                        maxx(i) = row;
                    end
                    if (B(row,col) == i) && (col < miny(i))
                        miny(i) = col;
                    end
                    if (B(row,col) == i) && (col > maxy(i))
                        maxy(i) = col;
                    end

                 end
        end 

   end

  minx = minx';
  miny = miny';
  maxx = maxx';
  maxy = maxy';
 
  disp('MBR Statistics');  
  table(minx, miny, maxx, maxy)
end
