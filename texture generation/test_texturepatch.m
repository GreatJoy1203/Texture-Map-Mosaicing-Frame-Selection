close all;
k=106;
 clear point_info;
point_info(:,:)=views_info{k};
point_info=point_info';
[mm,nn]=size(point_info);
for m=1:mm
    view_index=point_info(m,1)+1;
    img=imread(imagelist{1}{view_index});
    figure;
    imshow(img);
    hold on;
    scatter(point_info(m,3),point_info(m,4));
end