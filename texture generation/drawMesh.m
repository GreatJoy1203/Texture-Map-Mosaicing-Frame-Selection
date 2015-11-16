% author: Jiyang Gao, from Tsinghua University,8/28/2014
%draw all mesh in 3D space
function drawMesh(faces_neighbourings,vertexes)
[M,N]=size(faces_neighbourings);
for k=1:M
    v1=vertexes(:,faces_neighbourings(k,1)+1);
    v2=vertexes(:,faces_neighbourings(k,2)+1);
    v3=vertexes(:,faces_neighbourings(k,3)+1);
    line([v1(1) v2(1)],[v1(2) v2(2)],[v1(3) v2(3)]);
    line([v2(1) v3(1)],[v2(2) v3(2)],[v2(3) v3(3)]);
    line([v1(1) v3(1)],[v1(2) v3(2)],[v1(3) v3(3)]);
end
    