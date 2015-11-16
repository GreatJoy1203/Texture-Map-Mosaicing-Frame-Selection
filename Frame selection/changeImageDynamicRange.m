function imDR = changeImageDynamicRange(im,mappingPercentages,mask)
% function imDR = changeDynamicRange(im,mappingPercentages)
% Changes dynamic range of an image to maximize (or minimize) dynamic range
% im = input image
% mappingPercentages = [percentage of pixels set to minVal, percentage of pixels
% set to maxVal]
% mask = pixels to ignore when setting dynamic range
% imDR = output image
%
% TODO: This function naively increases dynamic range of all channels
% equally but this will change appearance of RGB images...should fix this

if nargin < 3
    mask = ones(size(im));
    if nargin < 2
        mappingPercentages = [0.05 0.95];
    end
end


if ndims(im) == 3
    for n = 1:3
        imDR(:,:,n) = updateDynamicRange(im(:,:,n),mappingPercentages,mask);
    end
else
    imDR = updateDynamicRange(im,mappingPercentages,mask);

end

end

function imDR = updateDynamicRange(im,mappingPct,mask)

    ind = find(mask==1);
    
	imDR = double(im);
    
    cutoffVals = quantile(imDR(ind),mappingPct);
    
    imDR = imDR-cutoffVals(1);
    imDR = imDR/(cutoffVals(2)-cutoffVals(1));
    
    imDR(imDR<0) = 0;
    imDR(imDR>1) = 1;
    
    imDR = uint8(imDR*255);
    
end