%=====================================================================
% File: video2frames.m 
% Original code written by Jiyang Gao
% Last Revised: 07/22/2014 by Jiyang Gao
%===================================================================== 
function video2frames(videoname,outputpath,start,endd)
video=VideoReader(videoname);
disp('Open video ... done');
nFrames = video.NumberOfFrames;
startFrame=round(start*nFrames);
endFrame=round(endd*nFrames);
disp(sprintf('start frame: %d',startFrame));
disp(sprintf('end frame: %d',endFrame));
mov= read(video, [startFrame,endFrame]);
[w,h,d,m]=size(mov);
for k=1:m
    disp(sprintf('Write images: selection/%08d.jpg ...done',k));
    imwrite(mov(:,:,:,k),strcat(outputpath,sprintf('%08d.jpg',k)));
end
