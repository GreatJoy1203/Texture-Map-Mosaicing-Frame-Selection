% author: Jiyang Gao, from Tsinghua University,8/28/2014
%give 3 face, select the one that contains v_index1 and v_index2
%neigh_face_index:3*1 vector
function [f_index,v_index]=judgeNeigubouringFace(v_index1,v_index2,neigh_face_index,faces_neighbourings)
v_index=-1;
f_index=-1;
for k=1:3
    neigh_face(k,:)=faces_neighbourings(neigh_face_index(k),:);
    count=0;
    for p=1:3
        if neigh_face(k,p)==v_index1||neigh_face(k,p)==v_index2
            count=count+1;
        end
        if neigh_face(k,p)~=v_index1&&neigh_face(k,p)~=v_index2
            v_index=neigh_face(k,p);
        end
    end
    if count==2
        f_index=neigh_face_index(k);
        return;
    end
end
end
        
        