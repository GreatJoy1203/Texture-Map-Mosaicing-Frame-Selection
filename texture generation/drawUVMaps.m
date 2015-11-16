% author: Jiyang Gao, from Tsinghua University,8/28/2014
%draw all the uvmaps on texture_size*texture_size square.
function drawUVMaps(faces_neighbourings,uvmaps,texture_size)
[M,N]=size(faces_neighbourings);
for k=1:M
    if faces_neighbourings(k,10)==1
    v1=texture_size*uvmaps(:,faces_neighbourings(k,1)+1);
    v2=texture_size*uvmaps(:,faces_neighbourings(k,2)+1);
    v3=texture_size*uvmaps(:,faces_neighbourings(k,3)+1);
    hold on;
    line([v1(1) v2(1)],[v1(2) v2(2)],'LineWidth',2);
    line([v2(1) v3(1)],[v2(2) v3(2)],'LineWidth',2);
    line([v3(1) v1(1)],[v3(2) v1(2)],'LineWidth',2);
    end
end
end