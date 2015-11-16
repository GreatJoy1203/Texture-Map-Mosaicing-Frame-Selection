% author: Jiyang Gao, from Tsinghua University,8/28/2014
%texture_size* texture_size is the area of texture
%original_patch: result of imwarp
%tri_uv: texture domain triangle 2*3 matrix
%RB imref2d
function [triangle_patch, triangle_mask]=extractTrianglePatch(texture_size,original_patch,tri_uv,RB)
triangle_patch=uint8(zeros(texture_size,texture_size));
triangle_mask=uint8(zeros(texture_size,texture_size));
[M,N]=size(original_patch);
minM=9999;
minN=9999;
maxN=0;
maxM=0;
for k=1:3
[tri_uv_intrinsic(1,k), tri_uv_intrinsic(2,k)]=worldToIntrinsic(RB,tri_uv(1,k),tri_uv(2,k));
if tri_uv_intrinsic(1,k)<minN
    minN=uint32(tri_uv_intrinsic(1,k));
end
if tri_uv_intrinsic(1,k)>maxN
    maxN=uint32(tri_uv_intrinsic(1,k));
end
if tri_uv_intrinsic(2,k)<minM
    minM=uint32(tri_uv_intrinsic(2,k));
end
if tri_uv_intrinsic(2,k)>maxM
    maxM=uint32(tri_uv_intrinsic(2,k));
end
end

for m=minM:maxM
    for n=minN:maxN
        % n is x; m is y
        [x_world,y_world]=intrinsicToWorld(RB,n,m);
        inTriangle=pointInTriangle(tri_uv(1,1),tri_uv(2,1), tri_uv(1,2), tri_uv(2,2),tri_uv(1,3), tri_uv(2,3), double(x_world), double(y_world));
        if inTriangle==1
            triangle_patch(uint32(y_world),uint32(x_world))=original_patch(m,n);
            triangle_mask(uint32(y_world),uint32(x_world))=1;
        end
    end
end
end