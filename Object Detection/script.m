%% Find threshold for a given input image
% output = Thresholded image.(Also written as 'reg3_thresh.jpg' and 'reg4_thresh.jpg' to file)
I = imread('reg3.jpg');

figure();subplot(1,3,1);imshow(I);title('Original image');
I = FindThreshold(I);
bwImage = imread('reg3_thresh.jpg');
subplot(1,3,2);imshow(bwImage);title('Thresholded reg3');

% object detection
[labelledImage,RGBImage] = rasterScanObjectDetect(im2bw(bwImage));
subplot(1,3,3);imshow(RGBImage);title('Labelled Image(Reg3)');

% Display object statistics in ./Results/Statistics
disp("==========================");
disp("STATS FOR IMAGE (REG4)");
disp("==========================");
filename = './Results/Statistics';
if (exist(filename))
    delete(filename);
end
getStatistics(labelledImage,filename);

%% Example 2 : FOR IMAGE reg4.jpg

% output = Thresholded image.(Also written as 'reg3_thresh.jpg' and 'reg4_thresh.jpg' to file)

disp("==========================");
disp("STATS FOR IMAGE (REG4)");
disp("==========================");
I = imread('reg4.jpg');
figure();subplot(1,3,1);imshow(I);title('Original image');

I = FindThreshold(I);
bwImage = imread('reg4_thresh.jpg');
subplot(1,3,2);imshow(bwImage);title('Thresholded reg4');

% object detection
[labelledImage,RGBImage] = rasterScanObjectDetect(im2bw(bwImage));
subplot(1,3,3);imshow(RGBImage);title('Labelled Image(Reg 4)');

% find object statistics
getStatistics(labelledImage,filename);