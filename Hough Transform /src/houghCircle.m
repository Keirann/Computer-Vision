function[centers,radii] =  houghCircle(img)
    img = img(:,:,1);
    figure();imshow(img);title('Original Image');

    %Detect edge and Plot Image
    edges = edge(img, 'Canny');
    figure();imshow(edges);title('Edge Image');
    
    %Begin rowMajor 
    minRadius = 60;
    maxRadius = 65;
    rowNum = 0;
    for r = linspace(minRadius, maxRadius, 1)
        H = houghAccumulatorCircle(edges, r);
        figure();
        imshow(imadjust(mat2gray(H)));
        temp_centers = FindVoteCircle(H);
        temp_centers
        if (size(temp_centers,1) > 0)
            row_num_new = rowNum + size(temp_centers,1);
            centers(rowNum + 1:row_num_new,:) = temp_centers;
            radii(rowNum + 1:row_num_new) = r;
            rowNum = row_num_new;       
        end
    end

    drawCircle(img, centers, radii);

end