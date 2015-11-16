% show the usage of LKTrackWrapper
clear all
close all

%% image sequences
%{,

%fn =  'PigBladder/%08d.jpg';
% fn = 'data\\hotel\\hotel.seq%d.png';
%path='./Checkerboard/'
%path='./PigBladderTest2/';
path='./PigBladderTest3/'
Files = dir(strcat('./PigBladderTest3/*.png'));
imgNum = 20;
img = imread(strcat(path,Files(1).name));
[M N C] = size(img);
imgseq = zeros(M,N,imgNum);
'preprocessing'
for p = 1:imgNum
	%img1 = im2double(imread(sprintf(fn,p)));
    img1 = im2double(imread(strcat(path,Files(p).name)));
    img1=localnormalize(mat2gray(img1),90,90);
    img1=mat2gray(img1);
	if C == 3, img1 = rgb2gray(img1); end
	imgseq(:,:,p) = img1;
    p
    
end
LKTrackWrapper(imgseq);
%}

%% video
%{
obj = VideoReader('.\ch1_video_01.mpg');
vid = obj.read;
[M N C imgNum] = size(vid);
imgNum = min(imgNum,80);
imgseq = zeros(M,N,imgNum);
for p = 1:imgNum
	img1 = im2double(vid(:,:,:,p));
	if C == 3, img1 = rgb2gray(img1); end
	imgseq(:,:,p) = img1;
end

LKTrackWrapper(imgseq);
%}

