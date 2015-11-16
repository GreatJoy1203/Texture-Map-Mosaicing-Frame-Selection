close all;
texture_size=500;
figure
img=imread('test.png');
%imshow(img);
hold on;
scatter(uvmaps(1,:)*texture_size,texture_size-uvmaps(2,:)*texture_size);
k=400;

%tri=[uvmaps(:,faces_neighbourings(k,1)),uvmaps(:,faces_neighbourings(k,2)),uvmaps(:,faces_neighbourings(k,3))];
tri=[uvmaps(:,faces_neighbourings(k,1)+1),uvmaps(:,faces_neighbourings(k,2)+1),uvmaps(:,faces_neighbourings(k,3)+1)];
scatter(texture_size*tri(1,:),texture_size-texture_size*tri(2,:),'fill');
n1=faces_neighbourings(k,7);
n2=faces_neighbourings(k,8);
n3=faces_neighbourings(k,9);
neigh1=[uvmaps(:,faces_neighbourings(n1,1)+1),uvmaps(:,faces_neighbourings(n1,2)+1),uvmaps(:,faces_neighbourings(n1,3)+1)];
%neigh1=[uvmaps(:,faces_neighbourings(n1,1)-1),uvmaps(:,faces_neighbourings(n1,2)-1),uvmaps(:,faces_neighbourings(n1,3)-1)];
neigh2=[uvmaps(:,faces_neighbourings(n2,1)+1),uvmaps(:,faces_neighbourings(n2,2)+1),uvmaps(:,faces_neighbourings(n2,3)+1)];
%neigh2=[uvmaps(:,faces_neighbourings(n2,1)),uvmaps(:,faces_neighbourings(n2,2)),uvmaps(:,faces_neighbourings(n2,3))];
neigh3=[uvmaps(:,faces_neighbourings(n3,1)+1),uvmaps(:,faces_neighbourings(n3,2)+1),uvmaps(:,faces_neighbourings(n3,3)+1)];
%neigh3=[uvmaps(:,faces_neighbourings(n3,1)),uvmaps(:,faces_neighbourings(n3,2)),uvmaps(:,faces_neighbourings(n3,3))];

figure
%imshow(img);
hold on;
scatter(uvmaps(1,:)*texture_size,texture_size-uvmaps(2,:)*texture_size);
scatter(neigh1(1,:)*texture_size,texture_size-neigh1(2,:)*texture_size,'y','fill');

figure
%imshow(img);
hold on;
scatter(uvmaps(1,:)*texture_size,texture_size-uvmaps(2,:)*texture_size);
scatter(neigh2(1,:)*texture_size,texture_size-neigh2(2,:)*texture_size,'r','fill');

figure
%imshow(img);
hold on;
scatter(uvmaps(1,:)*texture_size,texture_size-uvmaps(2,:)*texture_size);
scatter(neigh3(1,:)*texture_size,texture_size-neigh3(2,:)*texture_size,'b','fill');