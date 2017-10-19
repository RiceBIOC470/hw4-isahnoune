function img = imagegenerated
x = randi ([0 255], 1024, 1024);
x = uint8(x);
imwrite(x, 'rand8bit.tif');
img = x;
imshow(x)
end
