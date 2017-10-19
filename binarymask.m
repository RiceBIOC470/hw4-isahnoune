% 3. Write  a function which automatically determines a threshold  and
% thresholds an image to make a binary mask. Apply this to your output
% image from 2. 

function mask = binarymask(smbgsub)

mask = smbgsub > 1000;
imshow(mask)
end