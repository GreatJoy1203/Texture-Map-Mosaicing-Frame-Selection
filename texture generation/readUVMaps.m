% author: Jiyang Gao, from Tsinghua University,8/28/2014
function uvmaps=readUVMaps(filename,pointNum)
fileId=fopen(filename);
uvmaps_vertex= fscanf(fileId, '%f', [5,pointNum]);
uvmaps=uvmaps_vertex(1:2,:);
end