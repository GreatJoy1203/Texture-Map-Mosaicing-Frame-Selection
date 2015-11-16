%=====================================================================
% File: FrameSelectionPlatform.m 
% Original code written by Jiyang Gao
% Last Revised: 07/22/2014 by Jiyang Gao
%===================================================================== 


clear all 
close all

% step 1:  Initialize parameters
frameType=1;% 1 represents checkerboard; 0 for bladders
if(frameType==0)
    path='./PigBladderTest2/';
    CPBD_threshold=0.00;
else
    path='./Checkerboard/'
    CPBD_threshold=0.08;
end
Rotation_threshold=2.0;
Translation_threshold=5.0;
Scale_threshold_small=0.9;
Scale_threshold_large=1.1;
Tracking_distance_threshold=8;
Files = dir(strcat(path,'*.png'));
imgNum = 10;
img = imread(strcat(path,Files(1).name));
[M N C] = size(img);
imgseq = zeros(M,N,imgNum);

% Step 2: Read images(if the input is video, please use video2frame to transform the video to images)
disp('Read files and preprocess images');

img_index=1;
for p = 1:imgNum
    img_original=imread(strcat(path,Files(p).name));
    CPBD(p)=CPBD_compute(img_original);
    if(CPBD(p)<CPBD_threshold)
        disp(sprintf('frame %d is too blurred ...ignored',p));  
        continue;
    end
    img1 = im2double(img_original);
    if(frameType==0) %only preprocess bladder frames
        img1 = changeImageDynamicRange(img1);
        img1= localnormalize(mat2gray(img1),90,90);
    end
    img1=mat2gray(img1);
	if C == 3, img1 = rgb2gray(img1); end  
	imgseq(:,:,img_index) = img1;
    IDseq(img_index)=p;
    disp(sprintf('frame %d ...done',p));  
    img_index=img_index+1;
end

[ww,hh,m]=size(imgseq);
imgNum=m;

% Step 3 Frame selection and write image files.

if(frameType==0)
    selection=selectFrames(imgseq,1,Tracking_distance_threshold);
    imgpreselection=imgseq(:,:,1:imgNum);
    imgselection=imgpreselection(:,:,logical(selection));
    IDselection=IDseq(logical(selection));
    [w,h,m]=size(imgselection);
    for k=1:m
        disp(sprintf('Write images: selection/%08d.jpg ...done',k));
        imwrite(imgselection(:,:,k),strcat(path,sprintf('selection/%08d.jpg',k)));
    end
else
    %step 1 pre-select using KL-tracker
   % preselection=selectFrames(imgseq,0,5);
    %imgpreselection=imgseq(:,:,1:imgNum);
   % imgpreselection=imgpreselection(:,:,logical(preselection));
    %step 2 select frames based on dissimilarity of the trapizoids
    last=1;
    for k=1:imgNum
        disp(sprintf('analysis frame %d ...',k));
      [imagePoints, boardSize] = detectCheckerboardPoints(imgseq(:,:,k));
      if boardSize(1)~=11||boardSize(2)~=12
          selection(k)=0;
          continue;
      end
       vertexes=getCheckerboardVertexes(imagePoints, boardSize);
      attributes(k)=analyseTrapezoid(vertexes);
      if k>1
          movement=analyseMovement(attributes(min(last,k-1)),attributes(k));
          if movement.rotation>Rotation_threshold||norm(movement.translation)>Translation_threshold||movement.scale>Scale_threshold_large||movement.scale<Scale_threshold_small
             selection(k)=1;
             last=k;
          else
              selection(k)=0;
          end
      else
          selection(1)=1;
      end
      
    end
    
    imgpreselection=imgseq(:,:,1:imgNum);
    imgselection=imgpreselection(:,:,logical(selection));
    IDselection=IDseq(logical(selection));
    [w,h,m]=size(imgselection);
    for k=1:m
        disp(sprintf('Write images: selection/%08d.jpg ...done',k));
        imwrite(imgselection(:,:,k),strcat(path,sprintf('selection/%08d.jpg',k)));
    end
    
    fid=fopen(strcat(path,'selection/images.txt'),'w');
    for k=1:length(IDselection)
      fprintf(fid,'%08d.jpg is frame %08d \n',k,IDselection(k));
    end
    fclose(fid);
end
      