% 5. Write a function that uses your image from (2) and your mask from 
% (4) to get a. the number of cells in the image. b. the mean area of the
% cells, and c. the mean intensity of the cells in channel 1. 

function [cell_number, mean_area, mean_intensity] = numberareaintensity(smbgsub,cleaned)
parameters = regionprops(cleaned, smbgsub, 'FilledArea', 'MeanIntensity');
cell_number = length(parameters);
meana(1:cell_number) = parameters(1:cell_number).FilledArea;
mean_area = mean(meana);
meani(1:cell_number)= parameters(1:cell_number).MeanIntensity;
mean_intensity = mean(meani);
end 