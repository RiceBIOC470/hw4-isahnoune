% 4. Write a function that "cleans up" this binary mask - i.e. no small
% dots, or holes in nuclei. It should line up as closely as possible with
% what you perceive to be the nuclei in your image.

function cleaned = cleanedmask(mask, radius)
filled = imfill(mask, 'holes');
cleaned = imclose(filled, strel('disk',radius));
imshow(cleaned);
end
