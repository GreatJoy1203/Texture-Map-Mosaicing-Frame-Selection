% author: Jiyang Gao, from Tsinghua University,8/28/2014
function pose=getPoseMat(poses,index)
for k=1:length(poses)
    if poses(k).index==index
        pose=poses(k).mat;
        return;
    end
end

end