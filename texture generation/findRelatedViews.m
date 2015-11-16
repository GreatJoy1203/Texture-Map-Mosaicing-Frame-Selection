% author: Jiyang Gao, from Tsinghua University,8/28/2014
%face 1*10 vector
% views_info 1*N cell array
%poses 1*N struct array
function poses_subset=findRelatedViews(face,views_info,poses)
for k=1:3
    %v3d's vertex is 0-based, matlab is 1-based. face(1,2,3) is vertex's index, so add 1
    point_info=views_info{face(k)+1};
    point_info=point_info';
    [mm,nn]=size(point_info);
    for m=1:mm
        %v3d's view(imagelist) is 0-based, matlab is 1-based. point_info(m,1) is view's index, so add 1
        view_index=point_info(m,1)+1;
        % when reading camera's pose, the indexes are transformed to 1-based
        posemat=getPoseMat(poses,view_index);
        pose.index=view_index;
        pose.mat=posemat;
        if exist('poses_subset_initial','var')
             poses_subset_initial=[poses_subset_initial,pose];
        else
            poses_subset_initial=pose;
        end
    end
end

% delete repeat
poses_subset=poses_subset_initial(1);
for k=2:length(poses_subset_initial)
    repeat=0;
    for p=1:length(poses_subset)
        if(poses_subset(p).index==poses_subset_initial(k).index)
            repeat=1;
            break;
        end
    end
    if repeat==1
        continue;
    else
        poses_subset=[poses_subset,poses_subset_initial(k)];
    end
end
    

end