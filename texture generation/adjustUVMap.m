% author: Jiyang Gao, from Tsinghua University,8/28/2014
% transform the original uvmaps to a  normalized one [0,1]*[0,1]
%original_uvmaps 2*N matrix 
%uvmaps: 2*N matrix max<=1 min>=0
function uvmaps=adjustUVMap(original_uvmaps)
umin=1;
vmin=1;
umax=0;
vmax=0;

[M,N]=size(original_uvmaps);
for n=1:N
    if original_uvmaps(1,n)>umax
        umax=original_uvmaps(1,n);
    end
    if original_uvmaps(1,n)<umin
        umin=original_uvmaps(1,n);
    end
    
    if original_uvmaps(2,n)>vmax
        vmax=original_uvmaps(2,n);
    end
    if original_uvmaps(2,n)<vmin
        vmin=original_uvmaps(2,n);
    end 

end

delta_u=0-umin;
scale_u=umax-umin;
delta_v=0-vmin;
scale_v=vmax-vmin;

% translation
uvmaps(1,:)=original_uvmaps(1,:)+delta_u;
uvmaps(2,:)=original_uvmaps(2,:)+delta_v;

%equal proportion, to keep the length-width ratio
if scale_u>scale_v
    uvmaps(1,:)=uvmaps(1,:)/scale_u;
    uvmaps(2,:)=uvmaps(2,:)/scale_u;
else
    uvmaps(1,:)=uvmaps(1,:)/scale_v;
    uvmaps(2,:)=uvmaps(2,:)/scale_v;
end

end