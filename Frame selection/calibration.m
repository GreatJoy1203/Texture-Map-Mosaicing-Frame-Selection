clear all; 
close all;

for i = 1:17
      imageFileName = sprintf('%08d.jpg', i);
      imageFileNames{i} = fullfile('./Checkerboard/selection', imageFileName);
 end
    
  [imagePoints, boardSize] = detectCheckerboardPoints(imageFileNames);
  
   squareSide = 25; % (millimeters)
    worldPoints = generateCheckerboardPoints(boardSize, squareSide);
    
      params = estimateCameraParameters(imagePoints, worldPoints);
      figure; showExtrinsics(params);