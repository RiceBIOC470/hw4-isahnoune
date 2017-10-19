% 3. Write a function that takes the image from (1) and the binary mask
% from (2) and returns a vector of mean intensities of each circle (hint: use regionprops).

function mean_intensity = mi(img,img_mask)

vector = regionprops(img_mask,img, 'MeanIntensity');
measures = struct2dataset(vector);
mean_intensity = double(measures);
end