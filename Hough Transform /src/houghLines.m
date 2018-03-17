function [maxVoteArray] = houghLines(img)
% Plot Original Image
img = img(:,:,1);
figure();imshow(img);title('Original Image');

%Detect edge and Plot Image
edges = edge(img, 'Sobel');
figure();imshow(edges);title('Edge Image');
 
% Create Accumulator array 
[H, theta, radius] = houghAccumulator(edges); 
  
% Plot accumulator 
figure();
imshow(imadjust(mat2gray(H)),'XData',theta,'YData',radius,'InitialMagnification','fit');
title('Hough Transform');xlabel('\theta'), ylabel('Radius');
axis on,axis normal, hold on;
 
% Find Max Vote
maxVoteArray = FindVote(H);
  
% Overlay points corresponding to Max vote.
imshow(imadjust(mat2gray(H)),'XData',theta,'YData',radius,'InitialMagnification','fit');%  title('Hough Transform - Max Vote Points');
xlabel('\theta'), ylabel('Radius');
axis on, axis normal, hold on;
plot(theta(maxVoteArray(:,2)),radius(maxVoteArray(:,1)),'o','LineWidth',3,'color','green');
 
% Overlay Lines corresponding to edges
figure();imshow(img);hold on;
drawLines(img, maxVoteArray,radius,theta);
end