% author: Jiyang Gao, from Tsinghua University,8/28/2014
%poses:struct array. poses(k).index; poses(k).mat:3*4 pose matrix
%normal: 3*1 vertor
function index_pose=findParallelCamera(normal,poses)
max=0;
index_pose.index=-1;
%normalize
normal=normal/norm(normal);
for k=1:length(poses)
    normal_cameraview=poses(k).mat(:,1:3)*normal;
    if normal_cameraview(3)>max
        max=normal_cameraview(3);
        index_pose=poses(k);
    end
end

end

