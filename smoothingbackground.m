% 2. Write a function which performs smoothing and background subtraction
% on an image and apply it to the image from (1). Any necessary parameters
% (e.g. smoothing radius) should be inputs to the function. Choose them
% appropriately when calling the function.

function smbgsub = smoothingbackground(img, radius, sigma)

img_sm = imfilter(img, fspecial('gaussian',radius,sigma));
img_bg = imopen(img_sm, strel('disk', 100));
smbgsub = imsubtract(img_sm, img_bg);
end