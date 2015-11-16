% author: Jiyang Gao, from Tsinghua University,8/28/2014
%faces_neighbourings M*11 matrix [v1 v2 v3 neigh_v1 neigh_v2 neigh_v3 neigh_face1 neigh_face2 neigh_face3 checked seed] 
function [face,face_index]=getFaceSeed(faces_neighbourings,stage)
[M,N]=size(faces_neighbourings);
face_index=-1;
face=zeros(1,11);
if stage==1
    for m=1:M
        % has not been detected && has not been tried as a face seed
        if faces_neighbourings(m,10)==0&&faces_neighbourings(m,11)==0
            face=faces_neighbourings(m,:);
            face(10)=1;
            face_index=m;
            return;
        end
    end
elseif stage==2
    for m=1:M
        % has not been detected && has valid view 
        if faces_neighbourings(m,10)==0&&faces_neighbourings(m,11)~=-1
            face=faces_neighbourings(m,:);
            face(10)=1;
            face_index=m;
            return;
        end
    end
elseif stage==3
     for m=1:M
        % has not been detected && has valid view 
        if faces_neighbourings(m,10)==0&&faces_neighbourings(m,11)~=-2
            face=faces_neighbourings(m,:);
            face(10)=1;
            face_index=m;
            return;
        end
     end
elseif stage==4
     for m=1:M
        % has not been detected && has valid view 
        if faces_neighbourings(m,10)==0&&faces_neighbourings(m,11)==0
            face=faces_neighbourings(m,:);
            face(10)=1;
            face_index=m;
            return;
        end
     end
else
    return;
end

end