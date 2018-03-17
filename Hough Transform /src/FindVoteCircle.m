function voteArray = FindVoteCircle(H)
    % Finds point with maximum vote on accumulator Array
    
    % Input Parameter
    % H : Accumulator Array
    % voteArray: Points (r, theta) which has maximum vote (Threshold hardcoded) 
    
    maxEdges = 1000;
    
    %Setting threshold to 50% of Max intensity
    threshold = 0.25 * max(H(:));
 
    
    voteArray = zeros(maxEdges, 2);
    num = 0;
    
    
    % Loop terminates either found Maximum number of edges or there is 
    % no point above the threshold that can be called a distinctive edge.
    while(num < maxEdges)
        currMaxH = max(H(:));
        if (currMaxH >= threshold)
            num = num + 1;
            [r,c] = find(H==currMaxH);
            voteArray(num,:) = [r(1),c(1)];
            H(r,c) = 0;
            
%              for i = beginRow : endRow
%                 for j = endCol : beginCol
%                     H(i,j) = 0;
%                 end
%              end   
             
        else
            break;          
        end
    end
    voteArray = voteArray(1:num, :);            
end
