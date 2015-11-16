% author: Jiyang Gao, from Tsinghua University,8/28/2014
%find the faces can not be textured, and segment it.
function [updated_vertexes,updated_normals,updated_uvmaps,updated_faces_neighbourings]=refineTooLargeFaces(vertexes,normals,uvmaps,faces_neighbourings)
[M,N]=size(faces_neighbourings);
too_large_face_index=-1;
for k=1:M
    %has not been detected and no propor view and has 3 adjacent faces
    if faces_neighbourings(k,10)==0&&faces_neighbourings(k,11)==-2&&faces_neighbourings(k,7)~=-1&&faces_neighbourings(k,8)~=-1&&faces_neighbourings(k,9)~=-1
        %all its adjacent faces has been detected
        if faces_neighbourings(faces_neighbourings(k,7),10)==1&&faces_neighbourings(faces_neighbourings(k,8),10)==1&&faces_neighbourings(faces_neighbourings(k,9),10)==1
            too_large_face_index=k;
            break;
        end       
    end
end
if too_large_face_index~=-1
    for p=1:3
        v_index(p)=faces_neighbourings(k,p);
        neigh_v_index(p)=faces_neighbourings(k,p+3)+1;
        neigh_face_index(p)=faces_neighbourings(k,p+6);
        face_uv(:,p)=uvmaps(:,v_index(p)+1);
        face_normal(:,p)=normals(:,v_index(p)+1);
        face_vertex(:,p)=vertexes(:,v_index(p)+1);
    end
    if 1 %some condition like area or distance between vertexes
        vertex_added(:,1)= (face_vertex(:,1)+face_vertex(:,2))/2;
        vertex_added(:,2)= (face_vertex(:,2)+face_vertex(:,3))/2;
        vertex_added(:,3)= (face_vertex(:,3)+face_vertex(:,1))/2;
        uv_added(:,1)= (face_uv(:,1)+face_uv(:,2))/2;
        uv_added(:,2)= (face_uv(:,2)+face_uv(:,3))/2;
        uv_added(:,3)= (face_uv(:,3)+face_uv(:,1))/2;
        normal_added(:,1)= (face_normal(:,1)+face_normal(:,2))/2;
        normal_added(:,2)= (face_normal(:,2)+face_normal(:,3))/2;
        normal_added(:,3)= (face_normal(:,3)+face_normal(:,1))/2;
        [Mv,Nv]=size(vertexes);
        updated_vertexes=[vertexes,vertex_added];
        updated_normals=[normals,normal_added];
        updated_uvmaps=[uvmaps,uv_added];
        % vertex-index in faces_neighbourings is 0-based.
        v_index_added(1)=Nv;
        v_index_added(2)=Nv+1;
        v_index_added(3)=Nv+2;
        updated_faces_neighbourings=faces_neighbourings;
        for q=1:3
            k1=q;
            k2=q+1;
            if k2==4
                k2=1;
            end
            [face_tobedeleted_index,thevertex]=judgeNeigubouringFace(v_index(k1),v_index(k2),neigh_face_index,faces_neighbourings);
            newface1=[v_index_added(k1),thevertex,v_index(k1),-1,-1,-1,-1,-1,-1,1,0];
            newface2=[v_index_added(k1),thevertex,v_index(k2),-1,-1,-1,-1,-1,-1,1,0];
            updated_faces_neighbourings(face_tobedeleted_index,:)=newface1;
            updated_faces_neighbourings=[updated_faces_neighbourings;newface2];
        end
        [Mf,Nf]=size(updated_faces_neighbourings);
        newface1_center=[v_index_added(1),v_index_added(2),v_index_added(3),v_index(1),v_index(2),v_index(3),Mf+1,Mf+2,Mf+3,0,0];
        %adjacent faces(except newface1_center) should be some face that
        %detected. very tricky
        newface2_center=[v_index_added(1),v_index_added(3),v_index(1),v_index_added(2),-1,-1,too_large_face_index,Mf,Mf,0,0];
        newface3_center=[v_index_added(1),v_index_added(2),v_index(2),v_index_added(3),-1,-1,too_large_face_index,Mf,Mf,0,0];
        newface4_center=[v_index_added(2),v_index_added(3),v_index(3),v_index_added(1),-1,-1,too_large_face_index,Mf,Mf,0,0];
        updated_faces_neighbourings(too_large_face_index,:)=newface1_center;
        updated_faces_neighbourings=[updated_faces_neighbourings;newface2_center;newface3_center;newface4_center];
        
        
        
    end
end
        
            
                
                
                