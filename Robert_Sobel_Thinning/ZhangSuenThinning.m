
function ZhangSuenThinning(image)
    z = imread(image);
    I = double(z)
    [rows, columns] = size(I);
    imageThinned = I;
    toDelete = ones(rows, columns);
    toDelete = double(toDelete);
    changing = 1;
    
    while changing
        changing = 0;
        % Pixel form
        % P9 P2 P3
        % P8 P1 P4
        % P7 P6 P5
        for i= 2:rows-1
            for j = 2:columns - 1
                
                %%% Parse 1 %%%
                % P = [P1 P2 P3 P4 P5 P6 P7 P8 P9 P2]
                P = [imageThinned(i,j) imageThinned(i-1,j) imageThinned(i-1,j+1) imageThinned(i,j+1) imageThinned(i+1,j+1) imageThinned(i+1,j) imageThinned(i+1,j-1) imageThinned(i,j-1) imageThinned(i-1,j-1) imageThinned(i-1,j)]; % P1, P2, P3, ... , P8, P9, P2
                % Checking for Parse 1 conditions
                % 1. P1 is black
                % 2. Number of nonZero pixel neighbours of P1 is between 2
                % and 6
                % 3. Number of 0 to 1 transition in [P2...P9,P2] is measured by count. 
                % 4. P2*P4*P6 = 0?
                % 5. P4*P6*P8 = 0?
              
                if (imageThinned(i,j) == 1 &&  sum(P(2:end-1))<=6 && sum(P(2:end-1)) >=2 && P(2)*P(4)*P(6)==0 && P(4)*P(6)*P(8)==0)   
                    count = 0;
                    for k = 2:size(P,2)-1  
                        if P(k) == 0 && P(k+1)==1
                            count = count+1;
                        end
                    end
                    if (count==1)
                        toDelete(i,j)=0;
                        changing = 1;
                    end
                end
            end
        end
        imageThinned = imageThinned.*toDelete;  % Now actually deleting the pixel
        %%% Parse 2 %%%
        
        % Checking for Parse 2 conditions
                % 1. P1 is black
                % 2. Number of nonZero pixel neighbours of P1 is between 2
                % and 6
                % 3. Number of 0 to 1 transition in [P2...P9,P2] is measured by count. 
                % 4. P2*P4*P8 = 0?
                % 5. P2*P6*P8 = 0?
              
        for i=2:rows-1
            for j = 2:columns-1
                P = [imageThinned(i,j) imageThinned(i-1,j) imageThinned(i-1,j+1) imageThinned(i,j+1) imageThinned(i+1,j+1) imageThinned(i+1,j) imageThinned(i+1,j-1) imageThinned(i,j-1) imageThinned(i-1,j-1) imageThinned(i-1,j)];
                if (imageThinned(i,j) == 1 && sum(P(2:end-1))<=6 && sum(P(2:end-1)) >=2 && P(2)*P(4)*P(8)==0 && P(2)*P(6)*P(8)==0)   % conditions
                    count = 0;
                    for k = 2:size(P,2)-1
                        if P(k) == 0 && P(k+1)==1
                            count = count+1;
                        end
                    end
                    if (count==1)
                        toDelete(i,j)=0;
                        changing = 1;
                    end
                end
            end
        end
        imageThinned = imageThinned.*toDelete;      % Now actually deleting the pixel
  
    figure; subplot(1,2,1);imshow(image);
    subplot(1,2,2);imshow(imageThinned);
    end

end