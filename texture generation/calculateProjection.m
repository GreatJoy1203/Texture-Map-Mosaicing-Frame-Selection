% author: Jiyang Gao, from Tsinghua University,8/28/2014
%X_world: 4*1 vector
%pose_mat:3*4 pose matrix [R,t]
%K_cam: 3*3 camera calibration matrix
%x_img 2*1 vector
function x_img=calculateProjection(X_world,pose_mat,K_cam)
 x_img_homo=K_cam*pose_mat*X_world;
 x_img=[x_img_homo(1)/x_img_homo(3);x_img_homo(2)/x_img_homo(3)];
end