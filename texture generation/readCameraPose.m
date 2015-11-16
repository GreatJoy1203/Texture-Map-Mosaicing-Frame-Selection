% author: Jiyang Gao, from Tsinghua University,8/28/2014
function poses=readCameraPose(filename)
fileId=fopen(filename);
num = fscanf(fileId, '%d',1);
for k=1:num
    poses(k).index = fscanf(fileId, '%d',1);
    %v3d's index is 0-based, but matlab is 1 based;
    poses(k).index = poses(k).index +1;
    poses(k).mat = transpose(fscanf(fileId, '%f',[4,3]));
end


end
