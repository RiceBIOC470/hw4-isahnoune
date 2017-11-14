%HW4
%% 
% Problem 1. 
%GB comments:
1a 100
1b 100
1c 100
1d 50 Plots are correct, but please add axis labels to correctly convey the data you are displaying (did not take points off for this). In the future, because these graphs have different values along the Y axis, you can use the subplot function to display both graphs at the same time. If I run this section of code, the second plot will overwrite the first plot. This can appear to look as though only one plot was generated within the question ( I did NOT take points off for this). I did take half the points off because the second half of the question was not addressed where you were asked to explain the output of the plots. 
2a 75 There is no saved file as the question asks. Also it is not clear what you are concatenating. Two files? Two channels? To get a max intensity of each channel (2 channels being used in the question), all that needs to be done following the Z-projection is to convert the image from a greyscale image to a composite.  This can be accomplished using the channel tool by clicking Image/Color/Channel Tool. Change the pulldown menu from greyscale to composite. 
2b. 75 Need to iterate over Z direction. Currently the script is normalizing to the max intensity across 1 Z plane image. It needs to grab the max intensity across all Z sections (6 Z sections/ time point) for each time point.  
3a. 50 Same issue as in 2b. I had to take off more points here because the entire point of the question is to ensure the student understands the concept of Z-space and how to manipulate the data. 
3b 100
3c 100
3d 100
3e 100
4a. 100
4b. 100
 Overall = 88

% 1. Write a function to generate an 8-bit image of size 1024x1024 with a random value 
% of the intensity in each pixel. Call your image rand8bit.tif. 

img = imagegenerated;

% 2. Write a function that takes an integer value as input and outputs a
% 1024x1024 binary image mask containing 20 circles of that size in random
% locations

img_mask = circles(20);

% 3. Write a function that takes the image from (1) and the binary mask
% from (2) and returns a vector of mean intensities of each circle (hint: use regionprops).

mean_intensity = mi(img,img_mask);

% 4. Plot the mean and standard deviation of the values in your output
% vector as a function of circle size. Explain your results. 

for m = 1:100
    mask = circles(m);
    mean_intensity = mi(img, mask);
    stdmi(m) = std(mean_intensity);
    meanmi(m) = mean(mean_intensity);
end

plot(1:100, stdmi(1:100));
plot(1:100, meanmi(1:100));

%%

%Problem 2. Here is some data showing an NFKB reporter in ovarian cancer
%cells. 
%https://www.dropbox.com/sh/2dnyzq8800npke8/AABoG3TI6v7yTcL_bOnKTzyja?dl=0
%There are two files, each of which have multiple timepoints, z
%slices and channels. One channel marks the cell nuclei and the other
%contains the reporter which moves into the nucleus when the pathway is
%active. 
%
%Part 1. Use Fiji to import both data files, take maximum intensity
%projections in the z direction, concatentate the files, display both
%channels together with appropriate look up tables, and save the result as
%a movie in .avi format. Put comments in this file explaining the commands
%you used and save your .avi file in your repository (low quality ok for
%space). 

%Image to Stacks to Z-project for each individual file
%Image to Stacks to Tools to Concatenate

%Part 2. Perform the same operations as in part 1 but use MATLAB code. You don't
%need to save the result in your repository, just the code that produ
%it. 

file1 = 'nfkb_movie1.tif';
reader1 = bfGetReader(file1);

file2 = 'nfkb_movie2.tif';
reader2 = bfGetReader(file2);

for i = 1:19
    iplane = reader1.getIndex(6-1,1-1,i-1)+1;
    img11 = bfGetPlane(reader1,iplane);
    img11_d = im2double(img11);
    imgbright = uint16((2^16-1)*(img11_d./max(max(img11_d))));
    
    iplane = reader1.getIndex(6-1,2-1,i-1)+1;
    img21 = bfGetPlane(reader1,iplane);
    img21_d = im2double(img21);
    imgbright2 = uint16((2^16-1)*(img21_d./max(max(img21_d))));
    
    img2show = cat(3,imgbright,imgbright2,zeros(size(img11_d)));
    
    imwrite(img2show,'cells.tif','WriteMode','append')
end

%Notes from Dr. W
%loop over time points in first file
%for each time point, take the max intensity in each channel and then use cat to put the channels together, this is similar to what is done in your code but the images are different channels from the same file, not the two different files. 
%write the resulting image to a file. For every point after the first one, use append mode
% loop over the time points in the second file
%same as above but use append mode every time now so they all get put in the same file as the first.


%%

% Problem 3. 
% Continue with the data from part 2
% 
% 1. Use your MATLAB code from Problem 2, Part 2  to generate a maximum
% intensity projection image of the first channel of the first time point
% of movie 1. 

file1 = 'nfkb_movie1.tif';
reader1 = bfGetReader(file1);

file2 = 'nfkb_movie2.tif';
reader2 = bfGetReader(file2);

iplane = reader1.getIndex(6-1,1-1,1-1)+1;
img31 = bfGetPlane(reader1, iplane);

img31_d = im2double(img31);
imgbright3 = uint16((2^16-1)*(img31_d./max(max(img31_d))));
imshow(imgbright3)


% 2. Write a function which performs smoothing and background subtraction
% on an image and apply it to the image from (1). Any necessary parameters
% (e.g. smoothing radius) should be inputs to the function. Choose them
% appropriately when calling the function.

smbgsub = smoothingbackground(imgbright3, radius, sigma);

% 3. Write  a function which automatically determines a threshold  and
% thresholds an image to make a binary mask. Apply this to your output
% image from 2. 

mask = binarymask(smbgsub);

% 4. Write a function that "cleans up" this binary mask - i.e. no small
% dots, or holes in nuclei. It should line up as closely as possible with
% what you perceive to be the nuclei in your image.

cleaned = cleanedmask(mask, radius);

% 5. Write a function that uses your image from (2) and your mask from 
% (4) to get a. the number of cells in the image. b. the mean area of the
% cells, and c. the mean intensity of the cells in channel 1. 

[cell_number, mean_area, mean_intensity] = numberareaintensity(smbgsub,cleaned);

% 6. Apply your function from (2) to make a smoothed, background subtracted
% image from channel 2 that corresponds to the image we have been using
% from channel 1 (that is the max intensity projection from the same time point). Apply your
% function from 5 to get the mean intensity of the cells in this channel. 

file4 = 'nfkb_movie1.tif';
reader4 = bfGetReader(file4);
iplane = reader1.getIndex(6-1,2-1,i-1)+1;
img41 = bfGetPlane(reader1,iplane);
img41_d = im2double(img41);
imgbright4 = uint16((2^16-1)*(img41_d./max(max(img41_d))));
smbgsub = smoothingbackground(imgbright4, 4, 2);
mask = binarymask(smbgsub);
cleaned = cleanedmask(mask, 3);
[cell_number, mean_area, mean_intensity] = numberareaintensity(smbgsub,cleanedmask);

%%
% Problem 4. 

% 1. Write a loop that calls your functions from Problem 3 to produce binary masks
% for every time point in the two movies. Save a movie of the binary masks.

file5 = 'nfkb_movie1.tif';
reader5 = bfGetReader(file5);

file6 = 'nfkb_movie2.tif';
reader6 = bfGetReader(file6);

vw = VideoWriter('binarymasks.avi');
open(vw);

for i = 1:19
    iplane = reader5.getIndex(6-1, 1-1, i-1)+1;
    img51 = bfGetPlane(reader5, iplane);
    img51_d =im2double(img51);
    imgbright5 = uint16((2^16-1)*(img51_d./max(max(img51_d))));
    smbgsub1 = smoothingbackground(imgbright5, 4, 2);
    mask = binarymask(smbgsub1);
    cleaned = cleanedmask(mask, 3);
    img51_dt = im2double(cleaned);
    writeVideo(vw, img51_dt);
end
close(vw);

% 2. Use a loop to call your function from problem 3, part 5 on each one of
% these masks and the corresponding images and 
% get the number of cells and the mean intensities in both
% channels as a function of time. Make plots of these with time on the
% x-axis and either number of cells or intensity on the y-axis. 

file7 = 'nfkb_movie1.tif';
reader7 = bfGetReader('nfkb_movie1.tif');

file8 = 'nfkb_movie2.tif';
reader8 = bfGetReader('nfkb_movie2.tif');

s = 1;
for t = 1:19
    iplane = reader7.getIndex(1-1, 1-1, t-1)+1; %channel 1
    img71 = bfGetPlane(reader7, iplane);
    img71_d =im2double(img71);
    imgbright7 = uint16((2^16-1)*(img71_d./max(max(img71_d))));
    smbgsub1 = smoothingbackground(imgbright7, 4, 2);
    mask = binarymask(smbgsub1);
    cleaned = cleanedmask(mask, 3);
    [cell_number, mean_area, mean_intensity] = numberareaintensity(smbgsub1,cleanedmask);
    
    iplane = reader7.getIndex(1-1, 2-1, t-1)+1; %channel 2
    img72 = bfGetPlane(reader7, iplane);
    img72_d =im2double(img72);
    imgbright7 = uint16((2^16-1)*(img72_d./max(max(img72_d))));
    smbgsub1 = smoothingbackground(imgbright7, 4, 2);
    mask = binarymask(smbgsub1);
    cleaned = cleanedmask(mask, 3);
    [cell_number, mean_area, mean_intensity] = numberareaintensity(smbgsub1,cleanedmask);
end

for t = 1:19
    iplane = reader8.getIndex(1-1, 1-1, t-1)+1; %channel 1
    img81 = bfGetPlane(reader8, iplane);
    img81_d =im2double(img81);
    imgbright8 = uint16((2^16-1)*(img81_d./max(max(img81_d))));
    smbgsub1 = smoothingbackground(imgbright8, 4, 2);
    mask = binarymask(smbgsub1);
    cleaned = cleanedmask(mask, 3);
    [cell_number, mean_area, mean_intensity] = numberareaintensity(smbgsub1,cleanedmask);
    
    iplane = reader8.getIndex(1-1, 2-1, t-1)+1; %channel 2
    img82 = bfGetPlane(reader8, iplane);
    img82_d =im2double(img82);
    imgbright8 = uint16((2^16-1)*(img82_d./max(max(img82_d))));
    smbgsub1 = smoothingbackground(imgbright8, 4, 2);
    mask = binarymask(smbgsub1);
    cleaned = cleanedmask(mask, 3);
    [cell_number, mean_area, mean_intensity] = numberareaintensity(smbgsub1,cleanedmask);
end

%Number of Cells
figure; 
xlabel('Time');
ylabel('Number of Cells');

scatter(1:18,cell_number, 'filled'); %x = time, y = cells

%Mean Intensity

figure;
xlabel('Time');
ylabel('Mean Intensity');

scatter(1:18, mean_intensity, 'filled'); %x = time, y = mean intensity






