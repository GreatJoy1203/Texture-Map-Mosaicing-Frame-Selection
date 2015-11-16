% author: Jiyang Gao, from Tsinghua University,8/28/2014
%this script read all the useful data from files
clear all;
addpath(genpath('D:\Program Files\MATLAB\workspace\matlabmesh'));
[faces,vertexes]=readFacesfromOFF('./set4/model_segmented-20-100-0.75-sort.off');
faces_neighbourings=analyzeFaceNeighbouring(faces);
[M,N]=size(faces_neighbourings);
faces_neighbourings=[faces_neighbourings,zeros(M,2)];
views_info=readViewsInfo('./set4/model_views-20-100-0.75-sort.txt');
[M,N]=size(vertexes);
normals=readNormals('./set4/model_segmented-20-100-0.75-normal.xyz', N);
facesformesh=faces+1;
mesh=makeMesh(vertexes',facesformesh,normals');
original_uvmaps=transpose(embedDNCP(mesh));
uvmaps=adjustUVMap(original_uvmaps);
imagelist=readImageList('images.txt');
K_cam=[575.703148,0,469;0,575.703148,589;0,0,1];
poses=readCameraPose('model-2-cams.txt');
%  texture_size=1024;
%  texture=uint8(zeros(texture_size,texture_size));
% [M,N]=size(faces_neighbourings);
% count=0;
% for m=100:M
%     for k=4:6
%         if faces_neighbourings(m,k)~=-1
%              [view_index,pts,uvs]=findCommonView(faces_neighbourings(m,1)+1,faces_neighbourings(m,2)+1,faces_neighbourings(m,3)+1,faces_neighbourings(m,k)+1,views_info,uvmaps,texture_size);
%              if view_index~=-1
%                  count=count+1;
%             %     img=imread(imagelist{1}{view_index});
%                  common4point(count,:,:)=[uvs,pts,[view_index;view_index;view_index]];
%            %      texture_patch=generateTexturePatch(img,pts,uvs);
%            %      texture=texture+texture_patch;
%            %      figure;
%            %      imshow(texture);
%              end
%         end
%     end
% end
% min=1;
% index=-1;
% for k=1:count
%     u_avg=(common4point(k,1,1)+common4point(k,1,2)+common4point(k,1,3)+common4point(k,1,4))/4/texture_size;
%     v_avg=(common4point(k,2,1)+common4point(k,2,2)+common4point(k,2,3)+common4point(k,2,4))/4/texture_size;
%     distance=(u_avg-0.5)*(u_avg-0.5)+(v_avg-0.5)*(v_avg-0.5);
%     distance=sqrt(distance);
%     if(distance<min)
%         min=distance;
%         index=k;
%     end
%     center(k,:)=[u_avg,v_avg];
% end
% 
% uvs(:,:)=common4point(index,:,1:4);
% pts(:,:)=common4point(index,:,5:8);
% view_index=common4point(index,1,9);
% img=imread(imagelist{1}{view_index});
% texture_patch=generateTexturePatch(img,pts,uvs);
%     

