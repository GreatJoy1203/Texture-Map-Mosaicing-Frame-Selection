% author: Jiyang Gao, from Tsinghua University,8/28/2014
% this script mosaic the texture.
% faces_neighbourings M*11 [v1 v2 v3 neigh_v1 neigh_v2 neigh_v3 neigh_face1 neigh_face2 neigh_face3 checked seed] 
% seed represents if the face has been tried as a seed:-1 cannot be a seed; 0: has not beed tried 1-n: the size of face graph
texture_size=1024;
texture_final=uint8(zeros(texture_size,texture_size));

faces_neighbourings_forBFS=faces_neighbourings;
vertexes_forBFS=vertexes;
normals_forBFS=normals;
uvmaps_forBFS=uvmaps;

%stage 1: generate large texture patches; stage 2:generate small texture
%patches; stage 3: search for all views not just related views. stage 4:
%segment large faces into small faces and retry
threshold_forDiff=100;
large_patch_size=10;
small_patch_size=1;
 stage=1;
 round=1;
 patch_size_threshold=large_patch_size;

 % To reduce computation time, use face seed strategy.Do not search for every view to get the best,because it needs too much time
 % It is very easy to implement the strategy which search every view. But I don't have that copy(I didn't save it when make changes). 
while 1
    fprintf('Stage %d, Round %d\n',stage,round);
    %search for a propor seed, use 4 stage not 2 stage for implementation consideration
    while 1
        if stage==4 
            [updated_vertexes,updated_normals,updated_uvmaps,updated_faces_neighbourings]=refineTooLargeFaces(vertexes_forBFS,normals_forBFS,uvmaps_forBFS,faces_neighbourings_forBFS);
            vertexes_forBFS=updated_vertexes;
            normals_forBFS=updated_normals;
            uvmaps_forBFS=updated_uvmaps;
            faces_neighbourings_forBFS=updated_faces_neighbourings;
        end
        %get a face seed
        if round==1
            startface_index=1;%255;
            startface=faces_neighbourings_forBFS(startface_index,:);
           % faces_neighbourings_forBFS(startface_index,10)=1;
        else
            %stage 1: generate large texture patch; stage 2: generate small texture patch(after stage 1)
            %use face seed for performence consideration
            [startface,startface_index]=getFaceSeed(faces_neighbourings_forBFS,stage);
            %current stage is 1 and algorithm can't find a startface_index => stage 1 is end => stage 2 start
            if startface_index==-1&&stage==1
                patch_size_threshold=small_patch_size;
                stage=2;
                continue;
            end
            %current stage is 2 and algorithm can't find a startface_index => stage 2 is end => stage 3 start
            if startface_index==-1&&stage==2
                stage=3;
                continue;
            end   
            if startface_index==-1&&stage==3
                stage=4;
                continue;
            end 
            if startface_index==-1&&stage==4
                stage=0;
                break;
            end 
        end
        

        % find all related views for current face
        face_vertexes=ones(4,3);
        face_vertexes(1:3,:)=[vertexes_forBFS(:,faces_neighbourings_forBFS(startface_index,1)+1),vertexes_forBFS(:,faces_neighbourings_forBFS(startface_index,2)+1),vertexes_forBFS(:,faces_neighbourings_forBFS(startface_index,3)+1)];        
        % select one best view to generate texture patch
        if stage==1||stage==2
            poses_subset=findRelatedViews(startface,views_info,poses);
            view_index=selectView(face_vertexes,poses_subset,K_cam,texture_size);
        else
            view_index=selectView(face_vertexes,poses,K_cam,texture_size);
        end
        %view_index=-1 means no proper view for current face seed
        if view_index==-1
            faces_neighbourings_forBFS(startface_index,11)=-1;
            if stage==3
                faces_neighbourings_forBFS(startface_index,11)=-2;
            end
            continue;
        end
        % read and show selected view
        img=imread(imagelist{1}{view_index});
        figure;
        imshow(img);
        camera_pose=getPoseMat(poses,view_index);

        % BFS to get a face graph
        % set the startface detected
        faces_neighbourings_forBFS(startface_index,10)=1;
        [faces_graph_vector,updated_faces_neighbourings]=BFSfaces(startface,camera_pose,vertexes_forBFS,faces_neighbourings_forBFS,K_cam);
        [M,N]=size(faces_graph_vector);
        faces_neighbourings_forBFS(startface_index,11)=M;
        updated_faces_neighbourings(startface_index,11)=M;
        % when face graph is large enough,  select this view and this face
        if M>=patch_size_threshold
            break;
        end
        % set the startface undetected
        faces_neighbourings_forBFS(startface_index,10)=0;
    end
    % check if end
    if stage==0
        break;
    end
    
    % update faces_neighbourings to record detected faces for next round    
    faces_neighbourings_forBFS=updated_faces_neighbourings;
    faces_neighbourings_forBFS(startface_index,10)=1;
    % generate texture patch using faces_graph_vector and view_index
    [texture_patch,patch_mask]=generateTexturePatch_tri(faces_graph_vector,camera_pose,K_cam,img,vertexes_forBFS,uvmaps_forBFS,texture_size);

    texture_patch_info_set(round).texture_patch=texture_patch;
    texture_patch_info_set(round).patch_mask=patch_mask;
    
    % combine together 
    diffsum=calculateDifference(texture_patch,texture_final);
    if diffsum>threshold_forDiff
        continue;
    end
    texture_final=texture_final+texture_patch;
    
    
    %write to file
    imwrite(texture_final,sprintf('./textures2/stage%d_round%d.png',stage,round));
    figure;
    imshow(texture_final);

    %after 1 round stage 4, retry stage 3
    if stage==4
        stage=3;
    end
    round=round+1;
end

