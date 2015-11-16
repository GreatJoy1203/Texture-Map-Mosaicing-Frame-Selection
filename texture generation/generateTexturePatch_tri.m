% author: Jiyang Gao, from Tsinghua University,8/28/2014
%generate texture patch from given img
function [texture_patch, patch_mask]=generateTexturePatch_tri(faces_graph_vector,camera_pose,K_cam,img,vertexes,uvmaps,texture_size)
[M,N]=size(faces_graph_vector);
%texture_size=1024;
texture_patch=uint8(zeros(texture_size,texture_size));
patch_mask=uint8(zeros(texture_size,texture_size));
for m=1:M
    current_face=faces_graph_vector(m,:);
    for k=1:3
       vk=current_face(k)+1;
       X_world=[vertexes(:,vk);1];
       x_img=calculateProjection(X_world,camera_pose,K_cam);
       tri_x_img(:,k)=x_img;    
       tri_uv(:,k)=texture_size*uvmaps(:,vk);
    end
    tform = fitgeotrans(tri_x_img',tri_uv','Affine');
    [original_patch, RB] = imwarp(img,tform);
   [triangle_patch, triangle_mask]=extractTrianglePatch(texture_size,original_patch,tri_uv,RB);
   texture_patch=triangle_patch+texture_patch;
%     figure;
%     imshow(texture_patch);
   patch_mask=patch_mask+triangle_mask;
 %show original patch and the triangle  
%    figure;
%     imshow(original_patch,RB);
%     hold on;
%    scatter(tri_uv(1,:),tri_uv(2,:),'fill');
%    line([tri_uv(1,1) tri_uv(1,2)],[tri_uv(2,1) tri_uv(2,2)]);
%    line([tri_uv(1,2) tri_uv(1,3)],[tri_uv(2,2) tri_uv(2,3)]);
%    line([tri_uv(1,3) tri_uv(1,1)],[tri_uv(2,3) tri_uv(2,1)]);
% 
%  %show triangle patch and the triangle    
%    figure
%    imshow(triangle_patch);
%     hold on;
%    scatter(tri_uv(1,:),tri_uv(2,:),'fill');
%    line([tri_uv(1,1) tri_uv(1,2)],[tri_uv(2,1) tri_uv(2,2)]);
%    line([tri_uv(1,2) tri_uv(1,3)],[tri_uv(2,2) tri_uv(2,3)]);
%    line([tri_uv(1,3) tri_uv(1,1)],[tri_uv(2,3) tri_uv(2,1)]);
end
end