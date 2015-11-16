addpath(genpath('D:\Program Files\MATLAB\workspace\matlabmesh'));
facesformesh=faces+1;
mesh=makeMesh(vertexes',facesformesh,normals');
uv=embedDNCP(mesh);