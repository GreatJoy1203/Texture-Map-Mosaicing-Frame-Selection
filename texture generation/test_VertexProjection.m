close all;
k=200;
clear point_info
X_world=[vertexes(:,k);1];

point_info=views_info{k};
point_info=point_info';
[mm,nn]=size(point_info);
for m=1:mm
    view_index=point_info(m,1)+1;
    img=imread(imagelist{1}{view_index});
    figure;
    imshow(img);
    hold on;
    scatter(point_info(m,3),point_info(m,4));
    pose=getPoseMat(poses,view_index);
    %I0=[eye(3),zeros(3,1)];
    x_img=K_cam*pose*X_world;
    hold on;
     scatter(x_img(1)/x_img(3),x_img(2)/x_img(3));
    
end