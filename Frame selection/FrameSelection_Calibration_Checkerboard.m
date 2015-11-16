%=====================================================================
% File: FrameSelectionPlatform2_checkerboard.m 
% Original code written by Jiyang Gao
% Last Revised: 07/28/2014 by Jiyang Gao
%===================================================================== 


clear all 
close all
disp('Start to Select the Frames');
% step 1: parameters initialization
path='./Checkerboard/';
imgNum = 600;
maxPtsNum = 10;
currentFrame=1;
CPBD_threshold=0;
Tracking_threshold=30;
squareSide = 25; % (millimeters)
% step 2: preprocessing for the 1st image
Files = dir(strcat(path,'*.png'));
img_initial = imread(strcat(path,Files(1).name));
[M N C] = size(img_initial);
img1 = im2double(img_initial);
if C == 3, img1 = rgb2gray(img_initial); end 

% step 3: corner detection 
[Y1 X1] = corner_ST(img1(230:800,230:800),maxPtsNum);
X1=X1+230;
Y1=Y1+230;
Xseq = zeros(length(X1),imgNum);
Yseq = zeros(length(X1),imgNum);
Xseq(:,1) = X1;
Yseq(:,1) = Y1;
imglast=img1;

n_selectedImg=0;
% step 4: corner tracking 
for p = 2:imgNum
    disp(sprintf('Process No.%d frame...',p));
    Files(p).name
    img_original=imread(strcat(path,Files(p).name));
    
   % CPBD(p)=CPBD_compute(img_original);
   % if(CPBD(p)<CPBD_threshold)
   %    disp(sprintf('Frame %d is too blurred ...ignored',p));  
   %     continue;
   % end
    img1 = im2double(img_original);
	if C == 3, img1 = rgb2gray(img1); end  
    
    [Xseq(:,p), Yseq(:,p)] = LKTrackPyr(imglast,img1,...
                                        Xseq(:,p-1),Yseq(:,p-1));
    delta_X=Xseq(:,p)-Xseq(:,currentFrame);
    delta_Y=Yseq(:,p)-Yseq(:,currentFrame);
    meandX=mean(delta_X);
    meandY=mean(delta_Y);
    distance=sqrt(meandX*meandX+meandY*meandY);
    if(distance>Tracking_threshold)
        currentFrame=p;
        [Y1,X1] = corner_ST(img1(230:800,230:800),maxPtsNum);
        X1=X1+230;
        Y1=Y1+230;
        X1
        Y1
        Xseq(:,p) = X1;
        Yseq(:,p) = Y1;
        selection(p)=1;
        disp(sprintf('Save No.%d frame to: selection/%08d.jpg ...done',p,n_selectedImg));
        imwrite(img_original,strcat(path,sprintf('selection/%08d.jpg',n_selectedImg)));
         imageFileName = sprintf('%08d.jpg', n_selectedImg);
        imageFileNames{n_selectedImg+1} = fullfile('./Checkerboard/selection', imageFileName);
        n_selectedImg=n_selectedImg+1;
    else
        selection(p)=0;
        disp(sprintf('Skip No.%d frame',p));
    end
    
   imglast=img1;
    
end
 
disp('Start to Calibrate the Camera');
[imagePoints, boardSize] = detectCheckerboardPoints(imageFileNames);
worldPoints = generateCheckerboardPoints(boardSize, squareSide);

params = estimateCameraParameters(imagePoints, worldPoints);
figure; showExtrinsics(params);
      
disp('Start to Save Files');      
n_selectedImg=0;
 fid=fopen(strcat(path,'selection/images.txt'),'w');
 for p=1:imgNum
     if selection(p)==1
         fprintf(fid,'%08d.jpg is frame %08d \n',n_selectedImg,p);
         n_selectedImg=n_selectedImg+1;
     end
 end
  fclose(fid);
  fid=fopen(strcat(path,'selection/params.txt'),'w');
  fprintf(fid,'%f %f %f \n',params.IntrinsicMatrix(1,1),params.IntrinsicMatrix(1,2),params.IntrinsicMatrix(1,3));
  fprintf(fid,'%f %f %f \n',params.IntrinsicMatrix(2,1),params.IntrinsicMatrix(2,2),params.IntrinsicMatrix(2,3));
  fprintf(fid,'%f %f %f \n',params.IntrinsicMatrix(3,1),params.IntrinsicMatrix(3,2),params.IntrinsicMatrix(3,3));
  if size(params.RadialDistortion)==2
    fprintf(fid,'%f %f \n',params.RadialDistortion(1),params.RadialDistortion(2));
  elseif size(params.RadialDistortion)==3
    fprintf(fid,'%f %f \n',params.RadialDistortion(1),params.RadialDistortion(2),params.RadialDistortion(3));
  elseif size(params.RadialDistortion)==4
    fprintf(fid,'%f %f \n',params.RadialDistortion(1),params.RadialDistortion(2),params.RadialDistortion(3),params.RadialDistortion(4));
  end
 
  disp(sprintf('All Done!'));