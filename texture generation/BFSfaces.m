% author: Jiyang Gao, from Tsinghua University,8/28/2014
% breadth-first search for neighbouring faces. 
% startface:[v1 v2 v3 neigh_v1 neigh_v2 neigh_v3 neigh_face1 neigh_face2 neigh_face3 checked seed] 
% camera_pose:camera_index_pose.mat:3*4 pose matrix
% faces_neighbourings should be initialized before calling this function
% vertexes should be initialized before calling this function.
function [faces_graph_vector,faces_neighbourings]=BFSfaces(startface,camera_pose,vertexes,faces_neighbourings,K_cam)
face_queue=startface;
face_queue_pointer=1;
face_queue_length=1;
while face_queue_length~=0
   current_face=face_queue(face_queue_pointer,:);
   face_queue_pointer=face_queue_pointer+1;
   face_queue_length=face_queue_length-1;
   for k=1:3
      neigh_vk=current_face(3+k)+1;
      neigh_fk=current_face(6+k);
      if neigh_vk==0
          continue;
      end
      X_world=[vertexes(:,neigh_vk);1];
      x_img=calculateProjection(X_world,camera_pose,K_cam);
      
      in=inFOV(x_img);
      % if this face has not been detected and the neighbouring point is projected inside FOV
      if faces_neighbourings(neigh_fk,10)==0&&in==1
          faces_neighbourings(neigh_fk,10)=1;
          face_queue=[face_queue;faces_neighbourings(neigh_fk,:)];
          face_queue_length=face_queue_length+1;
      end
   end
   %show current face's triangle for debugging
   for k=1:3
       vk=current_face(k)+1;
       X_world=[vertexes(:,vk);1];
       x_img=calculateProjection(X_world,camera_pose,K_cam);
       tri_x_img(:,k)=x_img;
   end
   hold on;
   scatter(tri_x_img(1,:),tri_x_img(2,:),'fill');
   line([tri_x_img(1,1) tri_x_img(1,2)],[tri_x_img(2,1) tri_x_img(2,2)]);
   line([tri_x_img(1,2) tri_x_img(1,3)],[tri_x_img(2,2) tri_x_img(2,3)]);
   line([tri_x_img(1,3) tri_x_img(1,1)],[tri_x_img(2,3) tri_x_img(2,1)]);
   
   if exist('faces_graph_vector','var')
        faces_graph_vector=[faces_graph_vector;current_face];
   else
       faces_graph_vector=current_face;
   end
end

end