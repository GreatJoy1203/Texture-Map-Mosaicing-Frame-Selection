function mask = imageRegionMask(im,threshold,DEBUG)
% function mask = imageRegionMask(im)
% Creates a mask to show the image regions

    DEBUG = 0;

    if nargin < 2
        threshold = 5;
    end

    if ndims(im) == 3
        im = rgb2gray(im);
    end

    mask = uint8(ones(size(im)));
    mask(im<threshold) = 0;
    if (DEBUG), showResults(mask,1); end

    se = strel('disk',16);
    %mask = imerode(mask,se);

    if (DEBUG), showResults(mask,2); end

    %mask = abs(imerode(abs(mask-1),se)-1);

    %if (DEBUG), showResults(mask,3); end

end

function [] = showResults(im,plotNum)
    subplot(2,2,plotNum);
    imshow_scaled(im);
end
