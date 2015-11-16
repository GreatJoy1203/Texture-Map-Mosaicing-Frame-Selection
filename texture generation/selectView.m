% author: Jiyang Gao, from Tsinghua University,8/28/2014
%face_vertexes: 4*3 matrix each column is a vertex's 3d coordinate(homo),4d vector represent 3d vertex
%poses: 1*N struct poses(k).index is view's index; poses(k).mat is pose matrix
%K_cam: 3*3 calibrate matrix
%find the best view using local optimization
function view_index=selectView(face_vertexes, poses,K_cam,image_size)
if ~exist('image_size','var')
    image_size=1024;
end
%calculate normal
face_normal_z_max=0;
view_index=-1;
for k=1:length(poses)
    outlier=0;
    %coordinate frame tranformation
    face_vertexes_cameraview=poses(k).mat()*face_vertexes;
    %projection calculation, eliminate the outliers
    face_vertexes_img=zeros(2,3);
    normaldis=zeros(1,3);
    for p=1:3
        face_vertexes_img(:,p)=calculateProjection(face_vertexes(:,p),poses(k).mat,K_cam);
        disp=sqrt((face_vertexes_img(1,p)-image_size/2)^2+(face_vertexes_img(2,p)-image_size/2)^2);
        normaldis(p)=disp/image_size;
        % detect if the projection is in FOV
        in=inFOV(face_vertexes_img(:,p));
        if in==0
            outlier=1;
            break;
        end
    end
    if outlier==1
        continue;
    end
    
    %represent if it is at central part
    center_distance=sum(normaldis);
    
    %normal calculation
    a=face_vertexes_cameraview(:,1)-face_vertexes_cameraview(:,2);
    b=face_vertexes_cameraview(:,1)-face_vertexes_cameraview(:,3);
    c=cross(a,b);
    face_normal=c/norm(c);
    face_normal_z=abs(face_normal(3));
    
    %select the most perpendicular one
    if face_normal_z>face_normal_z_max
        face_normal_z_max=face_normal_z;
        view_index=poses(k).index;
    end
    
    
end

end
    
   