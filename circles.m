% 2. Write a function that takes an integer value as input and outputs a
% 1024x1024 binary image mask containing 20 circles of that size in random
% locations

function img_mask = circles(N)

img = false(1024);
imgmask1(1, 1:20) = randi([1 1024], 1, 20);
imgmask2(2, 1:20) = randi([1 1024], 1, 20);

for i = 1:20
    img(imgmask1(1,i), imgmask2(2,i)) = true;
end

img_dilate = imdilate(img, strel('disk', N));

img_mask = img_dilate;

end