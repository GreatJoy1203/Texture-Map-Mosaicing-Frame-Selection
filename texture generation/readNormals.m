% author: Jiyang Gao, from Tsinghua University,8/28/2014
function normals=readNormals(filename,pointNum)
fileId=fopen(filename);
vertex_normal= fscanf(fileId, '%f', [6,pointNum]);
normals=vertex_normal(4:6,:);
end